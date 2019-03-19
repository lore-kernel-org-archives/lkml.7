Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B92C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7CA2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553036288;
	bh=frbxgX44HwW1V4xvkQr2kMm6uiempE47LkcqP7+l1Lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VFyyTalMn5A6cUokDn+sfB9fjFd745NUrO4cPN+E6lE3xcpE0Vf/dHk437CstDK4B
	 XAeQNMAZhx+WXvAtz2t1HHJS48naCz/g7o9rNLZpLSivSsne5vfovzFxlsl0G0Eim8
	 1yx8MENOt6f7spSnLNfrY7Mod2ckt5X/R1NVoEOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCSW6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:58:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCSW6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:58:06 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0C383DB9;
        Tue, 19 Mar 2019 22:58:05 +0000 (UTC)
Date:   Tue, 19 Mar 2019 15:58:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andrei Vagin <avagin@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RESEND PATCH] ptrace: take into account saved_sigmask in
 PTRACE_{GET,SET}SIGMASK
Message-Id: <20190319155804.277fec5dba6a93ad2ab3edbc@linux-foundation.org>
In-Reply-To: <20190319223252.GA19424@altlinux.org>
References: <20190319191957.27156-1-avagin@gmail.com>
        <20190319223252.GA19424@altlinux.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 01:32:53 +0300 "Dmitry V. Levin" <ldv@altlinux.org> wrote:

> On Tue, Mar 19, 2019 at 12:19:57PM -0700, Andrei Vagin wrote:
> > There are a few system calls (pselect, ppoll, etc) which replace a task
> > sigmask while they are running in a kernel-space
> > 
> > When a task calls one of these syscalls, the kernel saves a current
> > sigmask in task->saved_sigmask and sets a syscall sigmask.
> > 
> > On syscall-exit-stop, ptrace traps a task before restoring the
> > saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
> > PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
> > saved_sigmask, when the task returns to user-space.
> > 
> > This patch fixes this problem.  PTRACE_GET_SIGMASK returns saved_sigmask
> > is it's set.  PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.
> 
> If it's not too late, could somebody tweak the commit message so that
> PTRACE_GET_SIGMASK becomes PTRACE_GETSIGMASK and "is it's set" is changed
> to "if it's set", please?

I made those changes to my copy.
