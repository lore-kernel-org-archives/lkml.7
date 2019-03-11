Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A84520643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFk+J/j+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCKHwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:52:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43916 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCKHwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:52:53 -0400
Received: by mail-io1-f67.google.com with SMTP id y6so3165222ioq.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2Rz1qmd3psHpbHdykCtGNvZwjs+zPbw/SPlnsjAMDY=;
        b=FFk+J/j+elOclk3h/Rk2jY85jvf27Eak057l+nY3RnLHH7YnRKFdweJI4nNSIl1eD4
         FoXQ3F7wOdU8hAmZbv06MZkqKcZ7LWTJpoNsLJFpDrLzK64Q1H4Iq9SlyYl7KxuLPCct
         USQBNXK2Dsc92tln9RgUBc8/PjGLP73wJyygs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2Rz1qmd3psHpbHdykCtGNvZwjs+zPbw/SPlnsjAMDY=;
        b=GVjQb9VtJG2wuEQ07tNRDSBlwWgDD33/lRtbQQdcKD33NX/NyFvnLwvU3oguMLaVnE
         rCjEpWyXOV6ooA86RzFsWEtYH0OUjIH14dqwD8PLU4ND4mD6w+svpBgZ+Q2uV4JKvyqP
         MoA/9wrxE9yFsJC+zHzEtc9HDScwlQooaaGTCSet51FexideUWzklyvaiL2p5Nz58TLH
         vH6weVRu73Ei5Tsf1LaGlcZ9//5+24CDtjBsTjqPRKT58avY97MpypGSvFvYrg5TVtHF
         fOXuAq7AIP0Wk2+z7zFHxZKJMvSoZl6SZApqed8qCuEzKebL+X69CY3MsSsLfvyZG1/t
         INHQ==
X-Gm-Message-State: APjAAAW3dixxQgsczOi/XlblqogDm2wmPA4mzcevE5iNQMzws4bgyvTN
        W3qolg84P9kX58G6spOd3auz0fDAE17g+zrs90jzRA==
X-Google-Smtp-Source: APXvYqw5dkNv19pVDGyaV7zYZk4L7mHRLfmlwf0ZnGq2MXmw6RX+3z7zlkmIPjg8Vjnlk/AuhOkU1qAh5JlMSKtW9dk=
X-Received: by 2002:a6b:7a48:: with SMTP id k8mr15407718iop.192.1552290772400;
 Mon, 11 Mar 2019 00:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com> <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com> <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
 <54d2b8e6-332b-117a-b982-77a535152246@redhat.com> <CACK8Z6GzOHJbh-M=0AxNbBoi3TqVehrs5xYsi2cUhW_dxz6vxg@mail.gmail.com>
 <3914af3f82d8aad8c22d814a20af4be654f8ad43.camel@linux.intel.com>
 <917a32a4-c806-af99-a9a3-246b28a5196a@redhat.com> <CACK8Z6GhBKKs7KVOZ50XrFQ2H3ps76uR8cpoohOHBSRkCOPsqA@mail.gmail.com>
In-Reply-To: <CACK8Z6GhBKKs7KVOZ50XrFQ2H3ps76uR8cpoohOHBSRkCOPsqA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 11 Mar 2019 00:52:41 -0700
Message-ID: <CAPUE2usgve3X+n_0=3zJM1NzjoZ=1cbYP2pazivbtOU2FnuBBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Rajat Jain <rajatja@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 11:30 AM Rajat Jain <rajatja@google.com> wrote:
>
> On Fri, Mar 8, 2019 at 12:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 08-03-19 01:04, Srinivas Pandruvada wrote:
> > > On Thu, 2019-03-07 at 15:07 -0800, Rajat Jain wrote:
> > >> Hello,
> > >>
> > >> On Thu, Mar 7, 2019 at 12:37 PM Hans de Goede <hdegoede@redhat.com>
> > >> wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> On 07-03-19 21:27, Gwendal Grignou wrote:
> > >>>> Srinivas,
> > >>>>
> > >>>> I am looking at problem on a laptop machine that suspends to
> > >>>> S01x, but
> > >>>> link_management is set to max_performance, because the machine is
> > >>>> connected to a charger.
> > >>>
> > >>> What is setting it to max_performance when charging?  I assume
> > >>> chrome-os is
> > >>> running something in userspace to do this (like TLP, but I guess
> > >>> you are not
> > >>> using TLP) ?
> > >>
> > >> Yes, we have a udev script that does this.
> > >>
> > >>>
> > >>> Have you run benchmarks with max_performance vs the default?
> > >>> I seriously doubt there will be a significant difference, esp.
> > >>> with a chrome-os style workload.
> > >>>
> > >>>> Given DVLSP must be set before the laptop suspends ["""One of the
> > >>>> requirement for modern x86 system to enter lowest power
> > >>>> mode  (SLP_S0)
> > >>>> is SATA IP block to be off."""], the machine never reaches S01x.
> > >>>> Does it make sense to change the target_lpm_policy at suspend
> > >>>> (ata_port_suspend()) to min_power and bring it back to the
> > >>>> original
> > >>>> value on resume?
> > >>>
> > >>> If userspace messes with the setting, then userspace should also
> > >>> put it back before suspending...
> > >>>
> > >>> The upstream kernel's default behavior is to have the target level
> > >>> set
> > >>> to a fixed level independent of the charging state. Could it be
> > >>> this
> > >>> fixed level is actually max-performance ? If that is the default
> > >>> the
> > >>> kernel comes up with, that would indicate a kernel bug.
> > >>
> > >> Side note: max-performance indeed can be the default forced by the
> > >> kernel for some (broken) SATA devices:
> > >>
> > >>          if (dev->horkage & ATA_HORKAGE_NOLPM) {
> > >>                  ata_dev_warn(dev, "LPM support broken, forcing
> > >> max_power\n");
> > >>                  dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
> > >>          }
> > >>
> > >> So definitely these systems won't be able to go into S0ix today.
> > >>
> > >> But Idrivers/ata/libata-core.c think the main idea that we are asking is:
> > >>
> > >> 1) Yes, we acknowledge that the userspace has set it max-performance.
> > >>
> > >> 2) However, given that the kernel already knows that:
> > >>         - while in suspend, there is no real value in retaining the
> > >> max-performance.
> > >>         - On the contrary, we know system will fail to go into lower
> > >> power mode because of max-suspend.
> > >>
> > >> 3) Does it not make sense to use this knowledge and switch to
> > >> min_power when we are actually going to suspend (even if user
> > >> specified max-performance), and restore max-performance on resume?
> > >
> > > It is all about regressions. Hence we added multiple conditions for
> > > setting default to min power.
> > > It may cause issues for some SATAs, which may not recover once enters
> > > slumber or DEVSLP. There is also case where user having issues with
> > > default LPM policy hence he changed policy to max performance. We can't
> > > detect that.
> > > So it will be much safer if user space change policy to default before
> > > calling suspend.
>
> Now I understand, and agree.
>
> >
> > Right, or simply do not mess with the setting in the first place!
Reading the kernel code further, I understand the intent to no setting
link power from user space anymore.
Before 4.16, the link was set to max_performance by the kernel; we
have script to set min_power, but that was done indiscriminately, and
breaks devices that need max_performance.
I added one similar to intel-sata-powermgmt  (at
https://github.com/rickysarraf/laptop-mode-tools/blob/lmt-upstream/usr/share/laptop-mode-tools/modules/intel-sata-powermgmt),
but that was a mistake for kernel 4.19.

For future devices, we will  make sure to not use devices with horkage
ATA_HORKAGE_NOLPM or that require max_performance (see
http://preston4tw.blogspot.com/2015/02/transcend-mts400-ssd-power-saving.html).
Thanks for your help,

Gwendal.


> >
> > I noticed you did not answer this part of my original reply:
> >
> > "Have you run benchmarks with max_performance vs the default?
> > I seriously doubt there will be a significant difference, esp.
> > with a chrome-os style workload."
> >
> > I seriously doubt the max-performance setting has a user
> > noticeable impact on performance. So I repeat has someone
> > actually measured this with real-world chrome-os workloads ?
>
> The reason we're setting it to max-performance is not really
> performance - but as a work around to a broken SATA device (Transcend
> SSD) that can't handle DEVSLP in active state (similar to what
> Srinivas said). Putting it to min_power while suspended was OK because
> it'd be in reset anyway at that time. Thanks for your explanations and
> help.
>
> Rajat
>
>
> >
> > Regards,
> >
> > Hans
> >
