Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416C4C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174AF2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOMsmIgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfGHIgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:36:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40705 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbfGHIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:36:36 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so25112304iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KXyzOyddJPSYupMaPtJc3n1+Qs9tx3Gcb2Q7zVo0M8=;
        b=cOMsmIgo9no2UIxYQtl0IEhs9cOfaY/6hH+TSNYWkEVjYrtyDyiSG+Pawi7rst84iL
         aYMFDkhVgQ713ZWq/WNdEtQUY3srXzZzw6MniZc45HgtCzqilWOYA4acWuiVnXpt6yCn
         dYF7IAD/K7goEhoSST/5CMrxkxRbHqybP9YsubSqGJ+1GueL5Ta2hGjNUlxXwFCc1BEO
         WZ1+QrX+fsuoq8p3EohEENriAsyZrotv0Lh+a/HQbO5y1KeHvr9lhZOUp8qSZZ5AaeL4
         HN3Qosc6+tKtmoIL0erNdz9FKdlU/HmzbGtDN9Tbcxr+J5fBiL5lJMyfjeWH2F/YDbOz
         ajKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KXyzOyddJPSYupMaPtJc3n1+Qs9tx3Gcb2Q7zVo0M8=;
        b=UiAj3z2gw+2WCH8ux/rSxqHqqEy6IeDQW0pftyII0fw/1uWtLZyJ+jjxWZFiLeADXd
         4sZqSaOwRWF/AnVuTHPn09f6MHY3S3Q6RVvpIRiB2Zm3JR2Wubx2wd+jfmqEo1nCVc7P
         Ajrk5gZ+fYIZBCt7FMiPnzRtfijmWspNbZxWkZn/rkz5f3WMYUiqYsuwzWj+nT/d1NP5
         0bKnrscJq3YXDBBjMz4r2bWfGOihAQMAnyU4Jy3+Jkys53Wfmh2iHoau/51zkpqlnyN2
         /r+e/JwtR4ZQM3FW3ZJSs5epBVRzUK9sKaRHtrv0Am/+5YYYtWum/QWW7nZFck54g2vU
         4C+w==
X-Gm-Message-State: APjAAAV8atoKC+/yfNmbjEPVJPHsHNRq2Q67t4gxD+wqaiKEELS7J+U6
        hRWFSKlhDTSfAyviIzGGKKvNF0KmtNniTlSL1A==
X-Google-Smtp-Source: APXvYqxjK31i5rr/fwm4g6B2ljMVmD03cvBH/BrY4xuXXtnM1WvV466gG06eq12moEwOXDBhPpeTUgO7m3jJQdXjkBs=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr13682792ioc.32.1562574994974;
 Mon, 08 Jul 2019 01:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com>
 <1562300143-11671-2-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 8 Jul 2019 16:36:23 +0800
Message-ID: <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/numa: instance all parsed numa node
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Michal Hocko <mhocko@suse.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 3:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 5 Jul 2019, Pingfan Liu wrote:
>
> > I hit a bug on an AMD machine, with kexec -l nr_cpus=4 option. nr_cpus option
> > is used to speed up kdump process, so it is not a rare case.
>
> But fundamentally wrong, really.
>
> The rest of the CPUs are in a half baken state and any broadcast event,
> e.g. MCE or a stray IPI, will result in a undiagnosable crash.
Very appreciate if you can pay more word on it? I tried to figure out
your point, but fail.

For "a half baked state", I think you concern about LAPIC state, and I
expand this point like the following:

For IPI: when capture kernel BSP is up, the rest cpus are still loop
inside crash_nmi_callback(), so there is no way to eject new IPI from
these cpu. Also we disable_local_APIC(), which effectively prevent the
LAPIC from responding to IPI, except NMI/INIT/SIPI, which will not
occur in crash case.

For MCE, I am not sure whether it can broadcast or not between cpus,
but as my understanding, it can not. Then is it a problem?

From another view point, is there any difference between nr_cpus=1 and
nr_cpus> 1 in crashing case? If stray IPI raises issue to nr_cpus>1,
it does for nr_cpus=1.

Thanks,
  Pingfan
