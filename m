Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8807FC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5409C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404252AbfFKHhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:37:17 -0400
Received: from verein.lst.de ([213.95.11.211]:48840 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404009AbfFKHhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:37:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ADA6868B02; Tue, 11 Jun 2019 09:36:48 +0200 (CEST)
Date:   Tue, 11 Jun 2019 09:36:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] binfmt_flat: remove flat_old_ram_flag
Message-ID: <20190611073648.GA21522@lst.de>
References: <20190610212015.9157-1-hch@lst.de> <20190610212015.9157-5-hch@lst.de> <b1ce6fc6-343c-7686-b4f4-35a305dc2adb@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ce6fc6-343c-7686-b4f4-35a305dc2adb@linux-m68k.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:04:39PM +1000, Greg Ungerer wrote:
>> index c0e4535dc1ec..18d82fd5f57c 100644
>> --- a/fs/binfmt_flat.c
>> +++ b/fs/binfmt_flat.c
>> @@ -488,7 +488,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>   	 * fix up the flags for the older format,  there were all kinds
>>   	 * of endian hacks,  this only works for the simple cases
>>   	 */
>> -	if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
>> +	if (IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM) &&
>> +	    rev == OLD_FLAT_VERSION)
>
> The flags are from the binary file header here, so this is going to lose
> that check for most platforms (except h8300 where it would always have
> been true).

Indeed.  The old code is:

	if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
		flags = FLAT_FLAG_RAM;

which for !h8300 evaluates to:

	if (rev == OLD_FLAT_VERSION && flags)
		flags = FLAT_FLAG_RAM;

so basically if any flag was set it was turned into FLAT_FLAG_RAM.
Was that really intentional?  I guess even if it wasn't the is no
point in changing this historic behavior now.

So I guess what we could do it something like:

	if (rev == OLD_FLAT_VERSION &&
	    (flags || IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM)))
		flags = FLAT_FLAG_RAM;
