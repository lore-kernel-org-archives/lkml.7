Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7617C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541125855
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE3Lek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:34:40 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43520 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Lek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:34:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWJKQ-0000Em-VG; Thu, 30 May 2019 05:34:39 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWJKO-0006Qe-QZ; Thu, 30 May 2019 05:34:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190530153316.60907d8f@canb.auug.org.au>
Date:   Thu, 30 May 2019 06:34:31 -0500
In-Reply-To: <20190530153316.60907d8f@canb.auug.org.au> (Stephen Rothwell's
        message of "Thu, 30 May 2019 15:33:16 +1000")
Message-ID: <87lfyoxjjs.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hWJKO-0006Qe-QZ;;;mid=<87lfyoxjjs.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hppo6812nckxwl1zXuK7D0VioxNqVA10=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next: build warning after merge of the userns tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Eric,
>
> After merging the userns tree, today's linux-next build (i386 defconfig)
> produced this warning:
>
> arch/x86/mm/fault.c: In function 'do_sigbus':
> arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk' [-Wunused-variable]
>   struct task_struct *tsk = current;
>                       ^~~
>
> Introduced by commit
>
>   351b6825b3a9 ("signal: Explicitly call force_sig_fault on current")
>
> The remaining used of "tsk" are protected by CONFIG_MEMORY_FAILURE.

Yes.  Thank you.  I will add a commit to move tsk inside
CONFIG_MEMORY_FAILURE.

Eric

