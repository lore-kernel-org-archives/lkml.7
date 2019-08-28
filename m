Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7451A217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566952230;
	bh=guXwvH65ETv/bxb6lRF99rLB1tu7BabmLyrDGcF0y+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WS2nNiTfvqxmpHPAetvMYfQQg6TUmY/YWWbKEZxU445I2vuWG49igtPgWLNAG+i5X
	 Dd+bCkbkNGCvYWpaOFp4tKjy4dlqnAKhcwZ9kyFTtoSaAqrZMtbgzev7oh4ERMaucB
	 otkEz+k+ADwVLSmo8u+8f20eHFRqzGZL+x5H74As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfH1Aa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH1Aa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:30:29 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A289722CED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566952227;
        bh=guXwvH65ETv/bxb6lRF99rLB1tu7BabmLyrDGcF0y+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xCub6oDn0iSssRBUmJzNckPGi85e2XITCkPU0HnjTmKrtlNAnwvkKEPs5JoMUBFRJ
         r+c3Qz/UyqAxkPndO0MiWjE+/Fm5US9QPuje5SfWdkdQwZywfC74ifulp6YGYAfGNv
         9xm9TKhLE0McojCIw9pSrvxxSHJ8knZpTLXIfum4=
Received: by mail-wm1-f45.google.com with SMTP id d16so905020wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:30:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXQXbnjwLyz/AMs7amrTUPyJTsPBT9lr4HuqbUxTuZEBLg2Kybp
        6pPgHLcs76g8pz52cTZcwvgH/8QQKtem/b7PFMyIUw==
X-Google-Smtp-Source: APXvYqwvVc8QhkXw+RuJoHiXgn/qJm5c5ZdWsi6Ef6hOKFT54dvCXBOyepFT/A+rJs6A/9xBZruE+SDGBn04qsSCT+k=
X-Received: by 2002:a1c:f910:: with SMTP id x16mr978886wmh.173.1566952226159;
 Tue, 27 Aug 2019 17:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190823225248.15597-1-namit@vmware.com> <20190823225248.15597-4-namit@vmware.com>
 <CALCETrXjqa6pWpAgh7v-sttOwY0V2RUqQ_Vs-JQr7nFDYvrBpQ@mail.gmail.com> <F9CA7AFA-D54B-4458-8248-CA52584C13CD@vmware.com>
In-Reply-To: <F9CA7AFA-D54B-4458-8248-CA52584C13CD@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Aug 2019 17:30:15 -0700
X-Gmail-Original-Message-ID: <CALCETrWFprNc2V1nrg_y0RDhV_PkSnx6v_p=mUHvpv9E0C5zAw@mail.gmail.com>
Message-ID: <CALCETrWFprNc2V1nrg_y0RDhV_PkSnx6v_p=mUHvpv9E0C5zAw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] x86/mm/tlb: Avoid deferring PTI flushes on shootdown
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:57 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Aug 27, 2019, at 4:07 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Aug 23, 2019 at 11:13 PM Nadav Amit <namit@vmware.com> wrote:
> >> When a shootdown is initiated, the initiating CPU has cycles to burn a=
s
> >> it waits for the responding CPUs to receive the IPI and acknowledge it=
.
> >> In these cycles it is better to flush the user page-tables using
> >> INVPCID, instead of deferring the TLB flush.
> >>
> >> The best way to figure out whether there are cycles to burn is arguabl=
y
> >> to expose from the SMP layer when an acknowledgment is received.
> >> However, this would break some abstractions.
> >>
> >> Instead, use a simpler solution: the initiating CPU of a TLB shootdown
> >> would not defer PTI flushes. It is not always a win, relatively to
> >> deferring user page-table flushes, but it prevents performance
> >> regression.
> >>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> ---
> >> arch/x86/include/asm/tlbflush.h |  1 +
> >> arch/x86/mm/tlb.c               | 10 +++++++++-
> >> 2 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tl=
bflush.h
> >> index da56aa3ccd07..066b3804f876 100644
> >> --- a/arch/x86/include/asm/tlbflush.h
> >> +++ b/arch/x86/include/asm/tlbflush.h
> >> @@ -573,6 +573,7 @@ struct flush_tlb_info {
> >>        unsigned int            initiating_cpu;
> >>        u8                      stride_shift;
> >>        u8                      freed_tables;
> >> +       u8                      shootdown;
> >
> > I find the name "shootdown" to be confusing.  How about "more_than_one_=
cpu=E2=80=9D?
>
> I think the current semantic is more of =E2=80=9Cincludes remote cpus=E2=
=80=9D. How about
> calling it =E2=80=9Clocal_only=E2=80=9D, and negating its value?

Sure.
