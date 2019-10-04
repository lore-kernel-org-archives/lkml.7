Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3A2215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nlyf245f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfJDMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:24:48 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:55982 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbfJDMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:24:48 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 8509C2E149B;
        Fri,  4 Oct 2019 15:24:44 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id H22NnS2IBM-OidWTpac;
        Fri, 04 Oct 2019 15:24:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570191884; bh=4sHSfmkLu8cAKROoqUfLI1PfxK6+ZhfZTCKtlJiHxAo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=nlyf245fK5EjgxGlzppCdVO3UNoKEUI+tjU6aABptVesQq0cvZwwFwvINHiLaJqWb
         OltyxM74KARCVR3hv5FuPuaHGiFI4W4hTviMyaQ9ItMXi+eZa8sptRZpw4W+fqNBNd
         Qb82ECXJgyjV+AeNvkDrbQd+T29Yx/E9Ydna1lIo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id O4GECBlzwv-OiHC0PEu;
        Fri, 04 Oct 2019 15:24:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <157018386639.6110.3058050375244904201.stgit@buzz>
 <20191004121017.GG32665@bombadil.infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d6388815-b664-d5f0-8e52-d96438408758@yandex-team.ru>
Date:   Fri, 4 Oct 2019 15:24:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004121017.GG32665@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2019 15.10, Matthew Wilcox wrote:
> On Fri, Oct 04, 2019 at 01:11:06PM +0300, Konstantin Khlebnikov wrote:
>> This is very slow operation. There is no reason to do it again if somebody
>> else already drained all per-cpu vectors after we waited for lock.
>> +	seq = raw_read_seqcount_latch(&seqcount);
>> +
>>   	mutex_lock(&lock);
>> +
>> +	/* Piggyback on drain done by somebody else. */
>> +	if (__read_seqcount_retry(&seqcount, seq))
>> +		goto done;
>> +
>> +	raw_write_seqcount_latch(&seqcount);
>> +
> 
> Do we really need the seqcount to do this?  Wouldn't a mutex_trylock()
> have the same effect?
> 

No, this is completely different semantics.

Operation could be safely skipped only if somebody else started and
finished drain after current task called this function.
