Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89009C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA01206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aINqLkxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNOn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:43:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfKNOn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:43:58 -0500
Received: from zn.tnic (p200300EC2F15E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94C131EC0CF9;
        Thu, 14 Nov 2019 15:43:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573742637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U6HDLgUUx0CthObylZaUC8UDe3iTuU8JW2SrhOYtrD4=;
        b=aINqLkxctOTzz6Tkug9Y7tyzmRYl2w/hGQciKxnvsA7Vl2tTZaWJIayrfRvGLWBFHd+xzl
        URzEYPc6gzF15HR6QxAG11dGr2UfY+P34h1RLBx6ZJb0xQ40qOmHWNsBlk2v/keHXApTkk
        aKWGQMJQRl+Ct+6iZBvj2d1Uam5ukpU=
Date:   Thu, 14 Nov 2019 15:43:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed
 declaration of struct kimage
Message-ID: <20191114144353.GB7222@zn.tnic>
References: <20191108090027.11082-1-lijiang@redhat.com>
 <20191108090027.11082-4-lijiang@redhat.com>
 <20191114123920.GA7222@zn.tnic>
 <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:20:42PM +0800, lijiang wrote:
> I really saw my building result, but kbuild reported the following messages:
> 
> vim +5 arch/x86/include/asm/crash.h
> 
> dd5f726076cc76 Vivek Goyal 2014-08-08   4  
> dd5f726076cc76 Vivek Goyal 2014-08-08  @5  int crash_load_segments(struct kimage *image);
> dd5f726076cc76 Vivek Goyal 2014-08-08   6  int crash_copy_backup_region(struct kimage *image);
> dd5f726076cc76 Vivek Goyal 2014-08-08   7  int crash_setup_memmap_entries(struct kimage *image,
> dd5f726076cc76 Vivek Goyal 2014-08-08   8  		struct boot_params *params);
> 89f579ce99f7e0 Yi Wang     2018-11-22   9  void crash_smp_send_stop(void);
> dd5f726076cc76 Vivek Goyal 2014-08-08  10  
> 
> :::::: The code at line 5 was first introduced by commit 
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> :::::: dd5f726076cc7639d9713b334c8c133f77c6757a kexec: support for kexec on panic using new system call
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should not take the report of a bot blindly but should always double
check it. Like every other computer system programmed by humans, it can
make mistakes.

> Would you mind giving me any suggestions about this?

I'll take care of it all and push the results out soon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
