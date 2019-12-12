Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B471C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A0206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfLLOVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:21:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729664AbfLLOVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:21:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFF16B199;
        Thu, 12 Dec 2019 14:21:17 +0000 (UTC)
Subject: Re: [BUG] Xen-ballooned memory never returned to domain after
 partial-free
To:     Nicholas Tsirakis <niko.tsirakis@gmail.com>,
        boris.ostrovsky@oracle.com
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org
References: <CAFqpmVJ90bAV4vasH1Z0DcTUjT7asCJFPeJBxtxGZwAhTVP7=w@mail.gmail.com>
 <b02d053f-1b07-bd4f-20fc-9a26106145d1@suse.com>
 <CAFqpmVLnHPUZEpvmw1-f=2LoPkfUHO67ETdwtnsPA7DsXRSRSA@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <7feb44ef-0957-3df1-3411-2a7b971d8931@suse.com>
Date:   Thu, 12 Dec 2019 15:21:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqpmVLnHPUZEpvmw1-f=2LoPkfUHO67ETdwtnsPA7DsXRSRSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.19 15:10, Nicholas Tsirakis wrote:
>> And I think this is the problem. We want here:
>>
>>      balloon_stats.target_pages = balloon_stats.current_pages +
>>                                   balloon_stats.target_unpopulated;
> 
> Ahh I knew I was missing something. Tested the patch, works great! "Reported by"
> is fine with me.

Thanks.

> 
> Do you happen to know the answer to my second question? It's not as important,
> but it does confuse me as I wouldn't expect the total memory to be
> balloon-able at
> all with the hotplugging configs disabled.

Ballooning != hotplugging memory

With memory hotplug you can add (or - in theory - remove) memory to the
kernel it didn't know about before.

With ballooning you just give some memory back to the hypervisor, but
kernel still has some knowledge about it (e.g. keeps struct page for
each ballooned memory page).

HTH, Juergen
