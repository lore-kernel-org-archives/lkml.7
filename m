Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A1C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F920861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SChbYa6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfGJIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:40:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45033 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:40:24 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so2909467iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6YmTEgTEwKg2yvsPJh1tPfsth8NlCli3K7+n36xF4o=;
        b=SChbYa6vqOPxSrVss4jvB9tAF5OwMipdIy0s56Usv1Xte2BSlygDBfiNDqi2CdjODl
         Ug0jrCu+bv0/xHwZxDoEA7p7qrHLq5Qjrg43WWGsFxU97ztP5tAdsTE07lPSBp7pi1Y/
         k0rD9Jlj6IQREds6kXolxrcTDAbr9qxnAWH0S7d5YXjySeQofztuYqTGmOJ0XyLirdOc
         B+lkGRWenHKBU0Y29efsJHEsE+DpBsrEU8ctJGCdyawBpkBc9zpIOf7DYiMV50yXoQZw
         0ydFObFgoNJFiGgjTiHlvwygdQe6YuN9Dl0LhsUPxsSfXcOfUpPaE5oV4aBKgjoQeXWe
         1x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6YmTEgTEwKg2yvsPJh1tPfsth8NlCli3K7+n36xF4o=;
        b=ksxEYGBevsJ77jSrxn72WQ8AxV1kO+sY+98Ij9J+gGU2Bf+8SA/GiAxqvvGJT3oZut
         2wETW4fXeO/Ubg1G82O1NZ4AbAluOMLvWTE/tYVD7FvvL4D7eFfh0Utwh834hAs/UBgQ
         X1nnSLPXmSlNNcbvKMMbgZkxDOyFkrwrFkAkjw7l43auOBC7s01HqrwnHf+IOzvJlHxi
         b3rvYz7r5oIpoZVp7FJtYiLBdAqhLwbl2YXpEzsf0HsgLC5rYIoUMwu0ewYJ62pbeBAD
         Pk/NCjXQhYXuCsPXYoSYjNNMrRfWnWgrle24wjON1SBX6ykAK7EYLmTu4JfG/YStMLO6
         bLhw==
X-Gm-Message-State: APjAAAXsX3lWYk6GXyWQS0nBTU4qWn6ZmVO8YelSQCGEEU8U6LrNb8ha
        0R9c/hWwVgAGhsTsCNcG5kyNOYviyMkKQKU1qA==
X-Google-Smtp-Source: APXvYqyf8ILBm+7MuZ4uDo+ul82G2IUmOV2LrKOdiouZHwiVejCLx4x6FlOy+TF5NqGRZGxV1T2S3iyyyzLIPzkC5G4=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr17062108ioa.161.1562748023178;
 Wed, 10 Jul 2019 01:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com>
 <1562300143-11671-2-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de>
 <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
 <alpine.DEB.2.21.1907081125300.3648@nanos.tec.linutronix.de>
 <CAFgQCTvAOeerLHQvgvFXy_kLs=H=CuUFjYE+UAN+vhPCG+s=pQ@mail.gmail.com>
 <alpine.DEB.2.21.1907090810490.1961@nanos.tec.linutronix.de>
 <CAFgQCTui7D6_FQ_v_ijj6k_=+TQzQ3PaGvzxd6p+XEGjQ2S6jw@mail.gmail.com> <4AF3459B-28F2-425F-8E4B-40311DEF30C6@amacapital.net>
In-Reply-To: <4AF3459B-28F2-425F-8E4B-40311DEF30C6@amacapital.net>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 10 Jul 2019 16:40:11 +0800
Message-ID: <CAFgQCTtK7G9NPQgHa_gJkr8WLzYqagBVLaqBY7-w+tirX-+w-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/numa: instance all parsed numa node
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        Barret Rhoden <brho@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 9:34 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Jul 9, 2019, at 1:24 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> >> On Tue, Jul 9, 2019 at 2:12 PM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> >>
> >>> On Tue, 9 Jul 2019, Pingfan Liu wrote:
> >>>> On Mon, Jul 8, 2019 at 5:35 PM Thomas Gleixner <tglx@linutronix.de> =
wrote:
> >>>> It can and it does.
> >>>>
> >>>> That's the whole point why we bring up all CPUs in the 'nosmt' case =
and
> >>>> shut the siblings down again after setting CR4.MCE. Actually that's =
in fact
> >>>> a 'let's hope no MCE hits before that happened' approach, but that's=
 all we
> >>>> can do.
> >>>>
> >>>> If we don't do that then the MCE broadcast can hit a CPU which has s=
ome
> >>>> firmware initialized state. The result can be a full system lockup, =
triple
> >>>> fault etc.
> >>>>
> >>>> So when the MCE hits a CPU which is still in the crashed kernel lala=
 state,
> >>>> then all hell breaks lose.
> >>> Thank you for the comprehensive explain. With your guide, now, I have
> >>> a full understanding of the issue.
> >>>
> >>> But when I tried to add something to enable CR4.MCE in
> >>> crash_nmi_callback(), I realized that it is undo-able in some case (i=
f
> >>> crashed, we will not ask an offline smt cpu to online), also it is
> >>> needless. "kexec -l/-p" takes the advantage of the cpu state in the
> >>> first kernel, where all logical cpu has CR4.MCE=3D1.
> >>>
> >>> So kexec is exempt from this bug if the first kernel already do it.
> >>
> >> No. If the MCE broadcast is handled by a CPU which is stuck in the old
> >> kernel stop loop, then it will execute on the old kernel and eventuall=
y run
> >> into the memory corruption which crashed the old one.
> >>
> > Yes, you are right. Stuck cpu may execute the old do_machine_check()
> > code. But I just found out that we have
> > do_machine_check()->__mc_check_crashing_cpu() to against this case.
> >
> > And I think the MCE issue with nr_cpus is not closely related with
> > this series, can
> > be a separated issue. I had question whether Andy will take it, if
> > not, I am glad to do it.
> >
> >
>
> Go for it. I=E2=80=99m not familiar enough with the SMP boot stuff that I=
 would be able to do it any faster than you. I=E2=80=99ll gladly help revie=
w it.
I had sent out a patch to fix maxcpus "[PATCH] smp: force all cpu to
boot once under maxcpus option"
But for the case of nrcpus, I think things will not be so easy due to
percpu area, and I think it may take a quite different way.

Thanks,
  Pingfan
