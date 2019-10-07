Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C44120867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5tS1lZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfJGXlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:41:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJGXlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NCfqgswZ/zhXGkUPpwCmmZHjXzuWHZXbpwIKFwpQfKc=; b=f5tS1lZtkVWqVk5ThkGSTwoJ3
        Xsp9rgKeWruoQGcjkvK35q72SZoXqOQ+t798OXSEcudLsSxh8R/jc68lpMFh/d/7qsYGog09xE4Oq
        Hix7kBN3OQDYBo0LCUW0OzZgXifZB7GxskczL6TxNWlYzwelsGSz7re9/nPOTkvSqsHcSnCE1jOpg
        v8mvk3G2xWzAiqPQ8od16jgueTKoSntGs1cyHVUQWzKi7Sz0jiEfgbqF4ocwGJm1mDBVfgua13gKn
        vq33qiYGgd+2N/B6fotouMLW5vxS9nN6YzCvT62TNhPG9EKbYcYguWxwJ30GvyF6n+6SLxt1BNQPx
        UHdS0YgxA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHcco-0004iH-U2; Mon, 07 Oct 2019 23:41:12 +0000
Subject: Re: Build regressions/improvements in v5.4-rc2
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
References: <20191007071829.13325-1-geert@linux-m68k.org>
 <f0250c51-a653-6cac-9e6b-affa74d8559c@infradead.org>
 <CAMuHMdWSu00nfeQbE6hX7Ok=WZveiZ=i178Uhk3sgpF3k4Ax3Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ce1ecd0-4b90-f4f6-936b-ae2d756b08d5@infradead.org>
Date:   Mon, 7 Oct 2019 16:41:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWSu00nfeQbE6hX7Ok=WZveiZ=i178Uhk3sgpF3k4Ax3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 2:04 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Mon, Oct 7, 2019 at 10:48 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 10/7/19 12:18 AM, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v5.4-rc2[1] compared to v5.3[2].
>>>
>>> Summarized:
>>>   - build errors: +10/-3
>>>   - build warnings: +152/-143
>>>
>>> JFYI, when comparing v5.4-rc2[1] to v5.4-rc1[3], the summaries are:
>>>   - build errors: +5/-10
>>>   - build warnings: +44/-133
>>>
>>> Note that there may be false regressions, as some logs are incomplete.
>>> Still, they're build errors/warnings.
>>>
>>> Happy fixing! ;-)
>>>
>>> Thanks to the linux-next team for providing the build service.
>>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/da0c9ea146cbe92b832f1b0f694840ea8eb33cce/ (233 out of 242 configs)
>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c/ (233 out of 242 configs)
>>>
>>>
>>> *** ERRORS ***
>>>
>>> 10 error regressions:
>>
>>>   + error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A
>>
>> Hi Geert,
>>
>> What arch & config is the above build error from?
> 
> That was a new one in v5.4-rc1 for sh-allmodconfig (blamed on David Daney).

so it seems arch/sh/ needs include/asm/delay.h that at least does
#include <asm-generic/delay.h>

eh?

>> Sorry to bug you about this.
> 
> Np.


-- 
~Randy
