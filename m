Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E8C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D452089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568220019;
	bh=IYlQzZjToZbYtDmhBVLvoXVdhbIE48lfVFIE1bOVOQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ODB1e7jGgkhclAEhzF3+z3golHf6STjsRVaCTAEOrEqueQZ5nbE+zZ/+rKquwmH+H
	 /5LA8yr0E4MqdtZFCQK9hKZpZcNr8l/ZfAtIVVe1Fu0qqfQpzp1eC71/GUvWmiUCrq
	 lfgKWcuY2CEM77J29bv1mLH0A1FsSv6YNUPbJT1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfIKQkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbfIKQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:40:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3014920838;
        Wed, 11 Sep 2019 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568220017;
        bh=IYlQzZjToZbYtDmhBVLvoXVdhbIE48lfVFIE1bOVOQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCJ519pKPOYYsA536PDlGELRLGoajfeziyypGF33UqFYKSFfKVwawoyiuNpwGt/A6
         aSlZT1KxY4TptGNwGrbLQWFyS42WBYjgsrzOrlSFs2nrdj24OB46VWtUV5l+tm6Pmm
         lKe27NFw4LJNUPUlhUMQxK7VaH62KDbiLzOkDtm0=
Date:   Wed, 11 Sep 2019 17:40:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        gregkh@linuxfoundation.org,
        Matthias Maennich <maennich@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] module: Fix link failure due to invalid relocation on
 namespace offset
Message-ID: <20190911164012.nalsccw6jku7gbpw@willie-the-truck>
References: <20190911122646.13838-1-will@kernel.org>
 <20190911133506.GB7837@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911133506.GB7837@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:35:06PM +0200, Jessica Yu wrote:
> +++ Will Deacon [11/09/19 13:26 +0100]:
> > Commit 8651ec01daed ("module: add support for symbol namespaces.")
> > broke linking for arm64 defconfig:
> > 
> >  | lib/crypto/arc4.o: In function `__ksymtab_arc4_setkey':
> >  | arc4.c:(___ksymtab+arc4_setkey+0x8): undefined reference to `no symbol'
> >  | lib/crypto/arc4.o: In function `__ksymtab_arc4_crypt':
> >  | arc4.c:(___ksymtab+arc4_crypt+0x8): undefined reference to `no symbol'
> > 
> > This is because the dummy initialisation of the 'namespace_offset' field
> > in 'struct kernel_symbol' when using EXPORT_SYMBOL on architectures with
> > support for PREL32 locations uses an offset from an absolute address (0)
> > in an effort to trick 'offset_to_pointer' into behaving as a NOP,
> > allowing non-namespaced symbols to be treated in the same way as those
> > belonging to a namespace.
> > 
> > Unfortunately, place-relative relocations require a symbol reference
> > rather than an absolute value and, although x86 appears to get away with
> > this due to placing the kernel text at the top of the address space, it
> > almost certainly results in a runtime failure if the kernel is relocated
> > dynamically as a result of KASLR.
> > 
> > Rework 'namespace_offset' so that a value of 0, which cannot occur for a
> > valid namespaced symbol, indicates that the corresponding symbol does
> > not belong to a namespace.
> > 
> > Cc: Matthias Maennich <maennich@google.com>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > Please note that I've not been able to test this at LPC, but it's been
> > submitted to kernelci.
> 
> Thanks for fixing this so quickly. I can confirm that this fixes the
> build for arm64 defconfig and x86 built fine for me as well. I'll wait
> a bit and apply this at the end of the day in case Matthias or anybody
> else would like to confirm/test.

FWIW, I've managed to boot arm64 Debian under QEMU and load/unload
modules successfully with this patch applied on top of modules-next.

Will
