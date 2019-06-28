Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A4A2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebi/tmZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfF1EPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:15:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39174 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfF1EPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:15:13 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so9665992iod.6;
        Thu, 27 Jun 2019 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wskEaZMaFBoycfWtxq3fq9AtJfP+IBGorvO/F2Y89ls=;
        b=ebi/tmZiTmZR58CGWM1DBvxgMSRk6yjKt8Dg4UdLy9wQ/qWCQv0CzwYY6orxTaLtLO
         Lt3Gy7QpQecCK4e7DR1bSwaOnGKjWfCUw+sqEWQWQwcgaixbPlOVqc4L2ITktT67J0tZ
         u5Cr3Vu0ZK3WMVVU2WcR96TkZH9aQOE8nUjO2fw26THNBzLo348oZKGBYpldECsT15Ba
         umWhUOkVv2xfFCOJjzSNsGSscFZaDu3rd4q8O3ExRDsb/tn8Rv4pjFaxlyizTwGhiBbP
         sWLOlThn478PtvZscYumkdcoRzCVVZLa4j+WNK6N0zhVmaYWDxP6zhrdMoW2r/q7ZExY
         e9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wskEaZMaFBoycfWtxq3fq9AtJfP+IBGorvO/F2Y89ls=;
        b=llnoLprFzbai4nU7V0Ruk/jVuTKu+cnNCLVp9ERkal1qissi0Q/A4TqbXPHUvLdBNp
         wAvUZf4HgaeWtb5FEUJum2PZoia6RkCfDN+ay3/ceI8ivqaJ43Dtr8TZ/7fBHpqCenip
         dsEyvZhq+mcX1o263VptDXBqxBGSS82a1dhMUAR+ue34PdhmMJtpS6gnz2i9HwolJ+Sk
         se4oLqROUg6Y8kJ4YYhIc2biR34CpvRvRQkwCiQUqzZGCMYpCJIBblTgTCAORkXD7dQv
         3FkzfsjFzdHhnQi9KuwKmPw34kTriSYgEb3wXEpyo3kk9xP1howIgS0F6oqGG4mMVuxo
         oeQg==
X-Gm-Message-State: APjAAAU6++QhvGr6mMICAbmdfpCbGX1Iv1drePE7T8DUX+wrjeJhnHgp
        wuw11DyPaqEhRhe0LDaDrY4GeMxaqNL4Vk2w6Mk=
X-Google-Smtp-Source: APXvYqx805jmPo8VHAsRlCrZNa/kcCKR4OCGjQGESJe53coWOq1Pl+O2jcTSmmU10SWnzcKLL42iZZHVZ6OE3UD6Fhk=
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr9167467jan.90.1561695312103;
 Thu, 27 Jun 2019 21:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
 <1560534144-13896-2-git-send-email-gkulkarni@marvell.com> <20190627100118.nfveq4oktomqybtx@willie-the-truck>
 <20190627162236.y3wb5sle6yjbwtzm@willie-the-truck>
In-Reply-To: <20190627162236.y3wb5sle6yjbwtzm@willie-the-truck>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 28 Jun 2019 09:45:00 +0530
Message-ID: <CAKTKpr59+D4NV-eN61UsHGHwgaT2ikKcpVqEMt8VaFg-DSZ4kQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: perf: Update documentation for
 ThunderX2 PMU uncore driver
To:     Will Deacon <will@kernel.org>
Cc:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>, jnair@marvell.com,
        jglauber@marvell.com, rrichter@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Thu, Jun 27, 2019 at 9:52 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jun 27, 2019 at 11:01:18AM +0100, Will Deacon wrote:
> > On Fri, Jun 14, 2019 at 05:42:45PM +0000, Ganapatrao Kulkarni wrote:
> > > From: Ganapatrao Kulkarni <ganapatrao.kulkarni@marvell.com>
> > >
> > > Add documentation for Cavium Coherent Processor Interconnect (CCPI2) PMU.
> > >
> > > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > > ---
> > >  Documentation/perf/thunderx2-pmu.txt | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
> > > index dffc57143736..62243230abc3 100644
> > > --- a/Documentation/perf/thunderx2-pmu.txt
> > > +++ b/Documentation/perf/thunderx2-pmu.txt
> > > @@ -2,24 +2,26 @@ Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
> > >  =============================================================
> > >
> > >  The ThunderX2 SoC PMU consists of independent, system-wide, per-socket
> > > -PMUs such as the Level 3 Cache (L3C) and DDR4 Memory Controller (DMC).
> > > +PMUs such as the Level 3 Cache (L3C), DDR4 Memory Controller (DMC) and
> > > +Cavium Coherent Processor Interconnect (CCPI2).
> > >
> > >  The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles.
> > >  Events are counted for the default channel (i.e. channel 0) and prorated
> > >  to the total number of channels/tiles.
> > >
> > > -The DMC and L3C support up to 4 counters. Counters are independently
> > > -programmable and can be started and stopped individually. Each counter
> > > -can be set to a different event. Counters are 32-bit and do not support
> > > -an overflow interrupt; they are read every 2 seconds.
> > > +The DMC, L3C support up to 4 counters and CCPI2 support up to 8 counters.
> >
> > The DMC and L3C support up to 4 counters, while the CCPI2 supports up to 8
> > counters.
> >
> > > +Counters are independently programmable and can be started and stopped
> > > +individually. Each counter can be set to a different event. DMC and L3C
> > > +Counters are 32-bit and do not support an overflow interrupt; they are read
> >
> > Counters -> counters
> >
> > > +every 2 seconds. CCPI2 counters are 64-bit.
> >
> > Assuming CCPI2 also doesn't support an overflow interrupt, I'd reword these
> > two sentences as:
> >
> >   None of the counters support an overflow interrupt and therefore sampling
> >   events are unsupported. The DMC and L3C counters are 32-bit and read every
> >   2 seconds. The CCPI2 counters are 64-bit and assumed not to overflow in
> >   normal operation.
>

Thanks for the comments, will update in v2.
Yes, CCPI2 is 64bit counter and there is no overflow issue.

> Mark reminded me that these are system PMUs and therefore sampling is
> unsupported irrespective of the presence of an overflow interrupt, so you
> can drop that part from the text.

sure.
>
> Sorry for the confusion,
>
> Will

Thanks,
Ganapat
