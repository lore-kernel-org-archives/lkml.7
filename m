Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447F520856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cyI0K9bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfH1BNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:13:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43703 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH1BNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:13:34 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so2397184ioe.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXhUQnfZQDKleQOklf5FuJsDb1E8hBR8PFQqMhT/jws=;
        b=cyI0K9bkR6g+jAhPEbl6uuV0FKncWBWE6TLnWHYS450ubtH0Xi4xGv/ijkZwhZlcTD
         7TRhHA24RgNvGvbBH3phisksEKudVMv8Y2R/1rLD4+8eXRgPLNV/chNAtgO9wVMeNY67
         HCuZPKR67XKQD3DpZnHBYgFaVwUPOOxB55F2Q3Mzn1mbKGyBBBl4yY57KgPe+MxfdWCL
         xdk9eVK826eiC3SMt16fPjPoYtSiRf1BG1Vg+pE3zvQIpa4NnfHncYWXPVgLHI69j2ML
         KdZOF/sMQ+3IgFKwo5Rf6WoY+0UTqDoCepxBCKJNDYSW1Fe9mVeC8nPMg7QTW3do3sUi
         VgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXhUQnfZQDKleQOklf5FuJsDb1E8hBR8PFQqMhT/jws=;
        b=BuMmw5rSjwEgi5IL7zrHri7YrzOtEWKn4OgbLLZuqpTOIJKebs19onuffuk6s/uBti
         cLxKDq6hD32um84DFHMw+NQQsqHGp39bEd9MhAD2TksNoCcxTRFNU342fjR9QxI1dFJX
         UdK64gDsW3ZgdDZ2lLF4nnASBSeUQRFD8wYXJ1K17wLN+TbXYdkOl18pitFoQXaDGcbg
         2eyg54bEWsvJctxemCRkqiF4zXoBoi2ev1u6UKMr255y4MTWL8qIfQfqe8as4eKR4lJn
         jSIzAvAbpdTrvizqjU4wXhPrRM35Sh2sM9B+GB3fmxVsfdXGGv2h4x2C40tbLFIYpOcm
         Huhw==
X-Gm-Message-State: APjAAAXOi0JdloJ8noJdUzpqpl0/3YV6BMX8zLzQVYJtX2Xl7juOQHGH
        kwH28a0HH/RRlmmUbxpQZToKVm0+5XWKEpi0Bypchw==
X-Google-Smtp-Source: APXvYqy42usK0sA9aVlheDFbqQtf6evzfcN8wANnTZqjyjI9/iPBjceViSHvUS7KuPtSr+9aZicp5tUEp3g73ooJGCE=
X-Received: by 2002:a6b:f803:: with SMTP id o3mr1409378ioh.187.1566954812678;
 Tue, 27 Aug 2019 18:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com> <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw>
In-Reply-To: <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw>
From:   Edward Chron <echron@arista.com>
Date:   Tue, 27 Aug 2019 18:13:20 -0700
Message-ID: <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 5:50 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Aug 27, 2019, at 8:23 PM, Edward Chron <echron@arista.com> wrote:
> >
> >
> >
> > On Tue, Aug 27, 2019 at 5:40 AM Qian Cai <cai@lca.pw> wrote:
> > On Mon, 2019-08-26 at 12:36 -0700, Edward Chron wrote:
> > > This patch series provides code that works as a debug option through
> > > debugfs to provide additional controls to limit how much information
> > > gets printed when an OOM event occurs and or optionally print additio=
nal
> > > information about slab usage, vmalloc allocations, user process memor=
y
> > > usage, the number of processes / tasks and some summary information
> > > about these tasks (number runable, i/o wait), system information
> > > (#CPUs, Kernel Version and other useful state of the system),
> > > ARP and ND Cache entry information.
> > >
> > > Linux OOM can optionally provide a lot of information, what's missing=
?
> > > ---------------------------------------------------------------------=
-
> > > Linux provides a variety of detailed information when an OOM event oc=
curs
> > > but has limited options to control how much output is produced. The
> > > system related information is produced unconditionally and limited pe=
r
> > > user process information is produced as a default enabled option. The
> > > per user process information may be disabled.
> > >
> > > Slab usage information was recently added and is output only if slab
> > > usage exceeds user memory usage.
> > >
> > > Many OOM events are due to user application memory usage sometimes in
> > > combination with the use of kernel resource usage that exceeds what i=
s
> > > expected memory usage. Detailed information about how memory was bein=
g
> > > used when the event occurred may be required to identify the root cau=
se
> > > of the OOM event.
> > >
> > > However, some environments are very large and printing all of the
> > > information about processes, slabs and or vmalloc allocations may
> > > not be feasible. For other environments printing as much information
> > > about these as possible may be needed to root cause OOM events.
> > >
> >
> > For more in-depth analysis of OOM events, people could use kdump to sav=
e a
> > vmcore by setting "panic_on_oom", and then use the crash utility to ana=
lysis the
> >  vmcore which contains pretty much all the information you need.
> >
> > Certainly, this is the ideal. A full system dump would give you the max=
imum amount of
> > information.
> >
> > Unfortunately some environments may lack space to store the dump,
>
> Kdump usually also support dumping to a remote target via NFS, SSH etc
>
> > let alone the time to dump the storage contents and restart the system.=
 Some
>
> There is also =E2=80=9Cmakedumpfile=E2=80=9D that could compress and filt=
er unwanted memory to reduce
> the vmcore size and speed up the dumping process by utilizing multi-threa=
ds.
>
> > systems can take many minutes to fully boot up, to reset and reinitiali=
ze all the
> > devices. So unfortunately this is not always an option, and we need an =
OOM Report.
>
> I am not sure how the system needs some minutes to reboot would be releva=
nt  for the
> discussion here. The idea is to save a vmcore and it can be analyzed offl=
ine even on
> another system as long as it having a matching =E2=80=9Cvmlinux.".
>
>

If selecting a dump on an OOM event doesn't reboot the system and if
it runs fast enough such
that it doesn't slow processing enough to appreciably effect the
system's responsiveness then
then it would be ideal solution. For some it would be over kill but
since it is an option it is a
choice to consider or not.
