Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2143C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C6D214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560034247;
	bh=RLFBR9HbCoZXjl+6UXtsjw558AVzz+Q3/8n2Pf7zvAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oGw12zjRbBsVjcinMViQvWOO/K7Xw4INRPxRxXco9j0M0Pj+zYGsA6vIg5WVm9Cor
	 tejWOSJ93NLwUKi67vAno4KfNOyNFoWW7Jghr6fOywCRp4ei1VkbwmIj21Lpfe7spn
	 ZhiVjyfRi+MLe+cjTYVEqjEbDPiK172hy1+UKUkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfFHWuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 18:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfFHWuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:50:46 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C41216C4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560034245;
        bh=RLFBR9HbCoZXjl+6UXtsjw558AVzz+Q3/8n2Pf7zvAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFbAfSy8JStAzzVb2aoLeOgdbhW5Z09kxVhBPjGPRzmofb5FNLr7h8p8s9PS5fBds
         ppHhFjkghm8nI0OMDnY4Cud1LJWeobfNER+NG2zSvgDP6mqJI4Er2RjUZuCo3tQ9QV
         LvcnuP3isSBanZaCEk1JQ25hskdzYkfC72kj0I6g=
Received: by mail-wm1-f44.google.com with SMTP id a15so5217691wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 15:50:45 -0700 (PDT)
X-Gm-Message-State: APjAAAW6Wh1moBLkjJBxd2evdBKakF4J297xiy/DmcDnGF6cmCOA5AzM
        XPM5IjmfO0akVm46ZqAIlWb5Fxdt9H2IOGncrUqyqA==
X-Google-Smtp-Source: APXvYqzwziP2FAcnedw68eenCmS+EpvWc42Cxg4jdGgVlmT6cSQ1yBkm+anSWo67AXmMWkEI08Sfs3t63Cb1mp8tDRQ=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr7754960wme.173.1560034243802;
 Sat, 08 Jun 2019 15:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com> <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 8 Jun 2019 15:50:32 -0700
X-Gmail-Original-Message-ID: <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
Message-ID: <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> C0.2 state in umwait and tpause instructions can be enabled or disabled
> on a processor through IA32_UMWAIT_CONTROL MSR register.
>
> By default, C0.2 is enabled and the user wait instructions result in
> lower power consumption with slower wakeup time.
>
> But in real time systems which require faster wakeup time although power
> savings could be smaller, the administrator needs to disable C0.2 and all
> C0.2 requests from user applications revert to C0.1.
>
> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> created to allow the administrator to control C0.2 state during run time.

This looks better than the previous version.  I think the locking is
still rather confused.  You have a mutex that you hold while changing
the value, which is entirely reasonable.  But, of the code paths that
write the MSR, only one takes the mutex.

I think you should consider making a function that just does:

wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);

and using it in all the places that update the MSR.  The only thing
that should need the lock is the sysfs code to avoid accidentally
corrupting the value, but that code should also use WRITE_ONCE to do
its update.
