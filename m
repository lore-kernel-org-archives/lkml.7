Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C6FCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1319220862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="R7XYfBum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfJaKrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:47:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfJaKru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:47:50 -0400
Received: from nazgul.tnic (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 387141EC0CD1;
        Thu, 31 Oct 2019 11:47:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572518869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hTysPbLoe/2KqpZjkjX3aRFBzExmpYnWMUSCHexYqlo=;
        b=R7XYfBumbxk3dFtMvEdSUWhepoOWP4p6T2VKlR743okyJkJ/l0fB9hWQDIuUdR5pHt+KQ9
        SK6oEoprNmbFve5Ek27jI0gRdccHPNEWGiAsSf9uoZ1adn7yNdVbUsfBrlDxk/Hvm0DqiT
        64nhCIJUt4yUqppUuhjtNdqmtoz5iHA=
Date:   Thu, 31 Oct 2019 11:47:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when
 the crashkernel option is specified
Message-ID: <20191031104748.GC21133@nazgul.tnic>
References: <20191031033517.11282-1-lijiang@redhat.com>
 <20191031033517.11282-2-lijiang@redhat.com>
 <20191031071345.GA17248@nazgul.tnic>
 <fe68b796-c483-20c4-623c-2671c52a3bf9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe68b796-c483-20c4-623c-2671c52a3bf9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 05:40:35PM +0800, lijiang wrote:
> Maybe it should be a separate patch to fix the old compile warnings as follow.
> And i should put the patch into this series.

Yes, maybe.

> commit d2091d1f4f67f1c38293b0e93fdbfefa766940cf (HEAD -> master)
> Author: Lianbo Jiang <lijiang@redhat.com>
> Date:   Thu Oct 31 15:48:02 2019 +0800
> 
>     kexec: Fix i386 build warnings that missed declaration of struct kimage
>     
>     Kbuild test robot reported some build warnings, please refer to the
>     Link below for details.

Explain here what the warnings are, why they trigger and how you're
fixing it. How a commit message should look like is also explained in
that document I pointed you at.

Refering to some link is not what we do in commit messages.

>     Add a declaration of struct kimage to fix these compile warnings.
>     
>     Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>     Reported-by: kbuild test robot <lkp@intel.com>
>     Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>     Link: https://lkml.org/lkml/2019/10/30/833

*NEVER* use lkml.org or any other external URL for refering to mail
threads but *always* use our own

lkml.kernel.org/r/<Message-ID>

redirector. See other tip commits for an example.

> > You can read
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > 
> > in the meantime, especially section
> > 
> > "9) Don't get discouraged - or impatient"
> > 
> > while waiting.
> 
> OK. Thanks.

And make sure to read that whole document and also have a look at the
process document

https://www.kernel.org/doc/html/latest/process/index.html

so that you can avoid such mistakes in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
