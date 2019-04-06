Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4EAC282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F82146F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDFBn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfDFBnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 21:43:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CEC2307E040;
        Sat,  6 Apr 2019 01:43:25 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FAA72CE64;
        Sat,  6 Apr 2019 01:43:20 +0000 (UTC)
Date:   Sat, 6 Apr 2019 09:43:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de
Cc:     kirill.shutemov@linux.intel.com, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, dyoung@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20190406014317.GX7627@MiWiFi-R3L-srv>
References: <20190312103051.18086-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312103051.18086-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 06 Apr 2019 01:43:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 at 06:30pm, Baoquan He wrote:
> This is v3 post.
> 
> The original v1 post can be found here:
> http://lkml.kernel.org/r/20180829141624.13985-1-bhe@redhat.com
> 
> Later a v1 RESEND version:
> http://lkml.kernel.org/r/20190125022817.29506-1-bhe@redhat.com
> 
> V2 post is here:
> http://lkml.kernel.org/r/20190312005004.19182-1-bhe@redhat.com
> 
> This patchset is trying to fix several issues for kexec/kdump when
> dynamic switching of paging mode is enabled in x86_64. The current
> kernel supports 5-level paging mode, and supports dynamically choosing
> paging mode during bootup according to kernel image, hardware and
> kernel parameter setting. This flexibility brings several issues for
> kexec/kdump:
> 
> Issues:
> 1)
> Dynamic switching between paging mode requires code change in target
> kernel. So we can't kexec jump from 5-level kernel to old 4-level
> kernel which lacks the code change.
> 
> 2)
> Switching from 5-level paging to 4-level paging kernel would fail, if
> kexec() put kernel image above 64TiB of memory.
> 
> 3)
> Kdump jumping has similar issue as 2). This require us to only
> reserve crashkernel below 64TB, otherwise jumping from 5-level to
> 4-level kernel will fail.
> 
> Note:
> Since we have two interfaces kexec_load() and kexec_file_load() to load
> kexec/kdump kernel, handling for them is a little different. For
> kexec_load(), most of the loading job is done in user space utility
> kexec_tools. However, for kexec_file_load(), most of the loading codes
> have moved into kernel because of kernel image verification.
> 
> Fixes:
> a) For issue 1), we need check if XLF_5LEVEL is set, otherwise error out
>    a message. 
>   -This need be done in both kernel and kexec_tools utility.
>   -Patch 2/3 is the handling of kernel part.
>   -Will post user space patch to kexec mailing list later.
> 
> b) For issue 2), we need check if both XLF_5LEVEL and XLF_5LEVEL_ENABLED
>    are set, otherwise error out a message.
>   -This only need be done in kexec_tools utility. Because for
>    kexec_file_load(), the current code searches area to put kernel from
>    bottom to up in system RAM, we usually can always find an area below
>    4 GB, no need to worry about 5-level kernel jumping to 4-level
>    kernel. While for kexec_load(), it's top down seraching area for kernel
>    loading, and implemented in user space. We need make sure that
>    5-level kernel find an area under 64 TB for a kexec-ed kernel of
>    4-level.

This paragraph is used to explain why XLF_5LEVEL_ENABLED is not checked
in kernel. I will add these information to log of patch 1/3.

>   -Will post user space patch to kexec mailing list later.
> 
> c) For issues 3), just limit kernel to reserve crashkernel below 64 TB.
>   -This only need be done in kernel.
>   -It doesn't need to check bit XLF_5LEVEL or XLF_5LEVEL_ENABLED, we
>    just simply limit it below 64 TB which should be enough. Because
>    crashernel is reserved during the 1st kernel's bootup, we don't know
>    what kernel will be loaded for kdump usage.
>   -Patch 3/3 handles this.
> 
> Concerns from reviewing comments:
> 1)
> In v1, hpa raised concern that why the paging mode checking is not done
> before kexec jumping, the discussion can be found here:
> 
> http://lkml.kernel.org/r/alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de
> 
> As tglx said, it might be not doable for kdump since kdump kernel's
> reserved crashkernel region only owns a portion of memory, may
> be above 4G; and might be not safer to do paging mode checking and
> switching thing after crash.
> 
> 2)
> In v1 RESEND post, tglx asked why only bit XLF_5LEVEL is checked, even
> though two bits XLF_5LEVEL or XLF_5LEVEL_ENABLED added. So add more
> words to explain it in *Fixes* b).
> 
> Changelog:
> v2->v3:
>   Change the constant to match the notation for the rest of defines as
>   Kirill suggested;
> v1->v2:
>   Correct the subject of patch 1 according to tglx's comment;
>   Add more information to cover-letter to address reviewers' concerns;
> 
> Baoquan He (3):
>   x86/boot: Add xloadflags bits for 5-level kernel checking
>   x86/kexec/64: Error out if try to jump to old 4-level kernel from
>     5-level kernel
>   x86/kdump/64: Change the upper limit of crashkernel reservation
> 
>  arch/x86/boot/header.S                | 12 +++++++++++-
>  arch/x86/include/uapi/asm/bootparam.h |  2 ++
>  arch/x86/kernel/kexec-bzimage64.c     |  5 +++++
>  arch/x86/kernel/setup.c               | 18 ++++++++++++++----
>  4 files changed, 32 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.2
> 
