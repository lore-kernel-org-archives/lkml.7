Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE6C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF122084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDMAe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:34:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDMAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:34:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B947B140F4ED0;
        Fri, 12 Apr 2019 17:34:58 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:34:58 -0700 (PDT)
Message-Id: <20190412.173458.2194302001630174696.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     neilb@suse.com, tgraf@suug.ch, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix rhashtable bit-locking for m68k
From:   David Miller <davem@davemloft.net>
In-Reply-To: <db89e10c-44ba-117d-2fe3-e01eb733d29a@roeck-us.net>
References: <155503371949.17793.8266195008003399968.stgit@noble.brown>
        <db89e10c-44ba-117d-2fe3-e01eb733d29a@roeck-us.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Apr 2019 17:34:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 12 Apr 2019 11:08:41 -0700

> On 4/11/19 6:52 PM, NeilBrown wrote:
>> As reported by Guenter Roeck, the new rhashtable bit-locking
>> doesn't work on m68k as it only requires 2-byte alignment, so BIT(1)
>> is addresses is not unused.
>> We current use BIT(0) to identify a NULLS marker, but that is only
>> needed in ->next pointers.  The bucket head does not need a NULLS
>> marker, so the lsb there can be used for locking.
>> the first 4 patches make some small improvements and re-arrange some
>> code.  The final patch converts to using only BIT(0) for these two
>> different special purposes.
>> I had previously suggested dropping the series until I fix it.  Given
>> that this was fairly easy, I retract that I think it best simply to
>> add these patches to fix the code.
>> 
> For the series:
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Series applied.
