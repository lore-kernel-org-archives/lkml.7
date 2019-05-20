Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFCC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D12081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCs7wcUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392189AbfETPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:32:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55240 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbfETPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jKdrdCTZgDXkXxUUja9CogRGjradAVpD3DVJ1Pki/4I=; b=aCs7wcUoxJB8THDFLmuZN/+csc
        5NGo+6Hhw0XMmUbANSxQ7NJU2gfKmJHnzo44SwBSayzJeCPWccr8FscvvREcDy1WjOGho6C2htYE+
        mIxTx79sMlV//glSG7G9LDo/4SFf6NpH9ECirOYqMWXAAgULqtthi9lseEemVvXaWNXSeTU63aDYR
        2iRbTBZQVAplgi2JJdiEiDIdxlwgGj2kC+PZckcbpRI6eWrCKo6P30LxYKl2vuiqOhkmn06iObX01
        AWPdB8eTatr1a4x0fGuHHLzgjlEt7r4TiCZqnpq9jbXFBZJOoOCCjHe9MnLEGfnuPPRrseTfLA+DU
        veo0VVig==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSkGy-0000J5-UT; Mon, 20 May 2019 15:32:21 +0000
Subject: Re: linux-next: Tree for May 20 (amdgpu)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Oded Gabbay <oded.gabbay@gmail.com>
References: <20190520115530.46cf100d@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e9c29f2-bb6e-572e-5486-7ddde2982ba0@infradead.org>
Date:   Mon, 20 May 2019 08:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520115530.46cf100d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/19 6:55 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190517:
> 
> Non-merge commits (relative to Linus' tree): 553
>  519 files changed, 11723 insertions(+), 3396 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 298 trees (counting Linus' and 69 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 

on i386, when built as loadable module:

in amdgpu_ras_sysfs_badpages_read():
ERROR: "__divdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

or when builtin:
ld: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o: in function `amdgpu_ras_sysfs_badpages_read':
amdgpu_ras.c:(.text+0x9ec): undefined reference to `__divdi3'
ld: amdgpu_ras.c:(.text+0xa0a): undefined reference to `__divdi3'



-- 
~Randy
