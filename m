Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A111AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D10F20855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554688352;
	bh=8JcEESCt91FR8p/UTzu+4A1jlGb4lcIX4Ekzn9pO5Pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wfEUzmSzPV1rzkl9/0doLpFoGHX+9iJdOxfy4VTygrKjmc7E4Cf2GspxcbSHNROl6
	 3VHdbKoztvX4RMjPoxWukt9d+AQF6PD3m46p0dHzRA9wnuw2qAx0ixdhHpjS5cL+N5
	 RfjZvlN4iT9VXBwQJ5Bf3rtWFW7Pl99gb9A/JFPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDHBwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDHBwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:52:31 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3142A208E3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 01:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554688350;
        bh=8JcEESCt91FR8p/UTzu+4A1jlGb4lcIX4Ekzn9pO5Pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RVuaPe96ANIFhWusZIlua/Sn3VUCsZwV5ccssh/U5u53Aczul69XttolMSrhHJPVR
         FOz2/8wCl5mJ0PaGJRl1BqG3pifysk+uoN21zlcnKKlKICrmRdaPy+6bEHXc1Vet0Z
         OLGMfuCsmi/LNkxKnAGkHxsYCe1Mak1jsdfww3is=
Received: by mail-wm1-f46.google.com with SMTP id h18so12875036wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 18:52:30 -0700 (PDT)
X-Gm-Message-State: APjAAAU+1e05SamPhV396Mli0Xz6APljXAtYz5NH71SzVgs4POutnsxz
        UrqsBXQJkqd4dSa+FvqjYDoagSiUyKcYdaxdk0krkA==
X-Google-Smtp-Source: APXvYqx3Gln/Lq4phSmt672XYZ0VW06Mt4GwmLTSZ2dZCKs3Fau19WL7ZF5cit7RdwWLn3BKfDHtxNQvPWTZ8CV8048=
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr15774289wme.4.1554688348784;
 Sun, 07 Apr 2019 18:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
 <CALCETrVhpqZiBe6zvK+z6HmD9AhK_O_O=2H=PYzBHid4C=SMYQ@mail.gmail.com> <c9662fea-faaf-beb3-246a-c60dad6d7420@linux.intel.com>
In-Reply-To: <c9662fea-faaf-beb3-246a-c60dad6d7420@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 7 Apr 2019 18:52:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVxkcn=R+T-9P3CNkEiRwUGmttem52vykBcYhVSYWwh8A@mail.gmail.com>
Message-ID: <CALCETrVxkcn=R+T-9P3CNkEiRwUGmttem52vykBcYhVSYWwh8A@mail.gmail.com>
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        aubrey.li@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 5:38 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2019/4/8 1:34, Andy Lutomirski wrote:
> > On Fri, Apr 5, 2019 at 12:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> On Sun, 24 Feb 2019, Aubrey Li wrote:
> >>
> >>> The architecture specific information of the running processes could
> >>> be useful to the userland. Add support to examine process architecture
> >>> specific information externally.
> >>>
> >>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Andi Kleen <ak@linux.intel.com>
> >>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >>> Cc: Dave Hansen <dave.hansen@intel.com>
> >>> Cc: Arjan van de Ven <arjan@linux.intel.com>
> >>
> >> This really lacks
> >>
> >> Cc: Linux API <linux-api@vger.kernel.org>
> >> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>
> >> Cc'ed now.
> >>
> >
> > I certainly understand why you want to expose this info, but would it
> > make more sense to instead add an arch_status file in /proc with
> > architecture-specific info?  Or maybe an x86_status field for x86
> > status, etc.
> >
>
> I tried this, but no other architecture showed interest in arch_status
> under /proc.
>

Why is that a problem?  It could exist on x86 and not exist on other
arches until needed.
