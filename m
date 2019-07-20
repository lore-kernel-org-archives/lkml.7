Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD0C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8041921849
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563631132;
	bh=SCD64j9CrpTYvqsojUDSbFVxP6L236yMwqYAy8QaeW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m5ADh0FUYaLFkdWL5e6bLEnwSiavls3hZjXsaMaZhxKBWfQa+R/GqoC0XSR3oGt5t
	 nZlLJJb2rYsXExYhHh5NT5Jjc9U3Ojjb05rlcliY4o8uqLwgtiwkP4AadsCQCOsqxt
	 z4odKir6N/bsjop84upsaVmiptglQ5Syc21j1EkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfGTN6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 09:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbfGTN6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 09:58:50 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01FB21872
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563631129;
        bh=SCD64j9CrpTYvqsojUDSbFVxP6L236yMwqYAy8QaeW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xeTd/YhiWzNPWl5bS4oPen86FfI6VUkbLehnOKufeAOMobpMPVdYk6RznYhKisdFH
         Uot/1rMgpXcWmvIpuN/KR5d0bs6JEw1GbZfJ3UB7tqfhRScm4u/PRvrytAyukbrNvP
         FCm/H1qs2T4YuTb1ZVER1jBO6ujHOXuWyzSt3Mc8=
Received: by mail-wm1-f41.google.com with SMTP id u25so21040401wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 06:58:49 -0700 (PDT)
X-Gm-Message-State: APjAAAWs3mo+5gK2ahwF1/pULZzmoKCBUIkVARcdEBx5bZTYv3+wNH8z
        dmHicHmGcUJUBEaS0h143Lfr5S16kbw46rqHwBKY4A==
X-Google-Smtp-Source: APXvYqznATjdOOzB1V8JDHeqzuHHU/8j6sd3Dg0o8GTGNRo/E46U9kytopeY9fY6bH6L+SIyXM5WnfsjQYIOLD9B54U=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr53952726wmk.79.1563631128136;
 Sat, 20 Jul 2019 06:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190719005837.4150-1-namit@vmware.com> <20190719005837.4150-6-namit@vmware.com>
 <052e9e57-8f72-d005-f0f7-4060bc665ba4@intel.com> <FCEC2890-40B8-4114-913E-7C05B021C4EA@vmware.com>
 <5c4b7bd2-ea0e-dc8d-edbb-1b1b739b963e@intel.com> <92B64D24-04DD-45A6-86A4-758CD73E0909@vmware.com>
In-Reply-To: <92B64D24-04DD-45A6-86A4-758CD73E0909@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 20 Jul 2019 06:58:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXsyktwp+Wt0=LsZvv-S2UkS-pk5j2N4ud4iYAU3VFwyA@mail.gmail.com>
Message-ID: <CALCETrXsyktwp+Wt0=LsZvv-S2UkS-pk5j2N4ud4iYAU3VFwyA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
To:     Nadav Amit <namit@vmware.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:54 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jul 19, 2019, at 11:48 AM, Dave Hansen <dave.hansen@intel.com> wrote=
:
> >
> > On 7/19/19 11:43 AM, Nadav Amit wrote:
> >> Andy said that for the lazy tlb optimizations there might soon be more
> >> shared state. If you prefer, I can move is_lazy outside of tlb_state, =
and
> >> not set it in any alternative struct.
> >
> > I just wanted to make sure that we capture these rules:
> >
> > 1. If the data is only ever accessed on the "owning" CPU via
> >   this_cpu_*(), put it in 'tlb_state'.
> > 2. If the data is read by other CPUs, put it in 'tlb_state_shared'.
> >
> > I actually like the idea of having two structs.
>
> Yes, that=E2=80=99s exactly the idea. In the (1) case, we may even be abl=
e to mark
> the struct with __thread qualifier, which IIRC would prevent memory barri=
ers
> from causing these values being reread.

I'm okay with the patch.  If we end up changing things later, we can
rearrange as needed.
