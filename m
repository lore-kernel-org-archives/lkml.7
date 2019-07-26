Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF51C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657AC218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cqkkQRWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfGZQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:16:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37482 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfGZQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:15:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so55863879otp.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zLjQMqPv69uzNsh3AaN/zI02lg0PspdBjxBwg/WuEPA=;
        b=cqkkQRWdLVMNeGQZP4T91hRY0t9ARqP5neqG8r0967iy+XWfs+Q2+Ik53f4THz/+K3
         Lm95ET9bRVMWGfD9mjRijvRm1aYB1/tm8+xHORTG6VmVDWZkl6VawBNflzXcTQ8C4U5j
         FLMxIDd2lpA+Jh3KnQo9PtvCLjXeR8yaXcn0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zLjQMqPv69uzNsh3AaN/zI02lg0PspdBjxBwg/WuEPA=;
        b=sIdvjgV8ssQwNFT/vRE1mkktbkLXjFtG+HwtMVk4MeMhuWyy7eUMlFNOVPE++p6Ve2
         qnQ6aKUorjeX306SCcMWfttPanRDa5IS6JUEEPvqZ2wtM7IOZJZHb2DQ/nvNOwp/9CPx
         Z9qGgVCgm6ncX4FSn1meWg5eJkGGIq6169d1ulGUio1TQJMiNncKUersa6PehAsZv7Lc
         hjherqsBTh/Qr0pnjOVXo/xZ7SgogzpIxFCYYBsHBML2XWallvwck3TWYp0RVnAKtb1v
         x7XfoiKmRP9BdJOcCpgmLEbwlt5LkGIB25+gq+azZ4EBWAt+dahDVwYxNVulpTIFthF0
         H9QQ==
X-Gm-Message-State: APjAAAXe4ENXBw8IF9BiUc/ZoHUV6NfP/bkmRTlD4iVD2ZgwoaRljvM0
        GWiU8W+rCoU7NC66dR5wIDfS8bApFDemecr24/U=
X-Google-Smtp-Source: APXvYqy7ErQ5UZxf8oCQ0qKeGgBxXrawjKEluRZeTi3S+GgdykTVykeXzWzSMgVXwHBshilFMPcGo+PesBEgF+p+DhQ=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr65268706otk.204.1564157758389;
 Fri, 26 Jul 2019 09:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <1564128758-23553-1-git-send-email-lowry.li@arm.com>
 <20190726142356.GI15868@phenom.ffwll.local> <20190726144428.tfwoaniidijchblt@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190726144428.tfwoaniidijchblt@DESKTOP-E1NTVVP.localdomain>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 26 Jul 2019 18:15:46 +0200
Message-ID: <CAKMK7uFSK-Wx0TebrYvqD4z682gFTX69sFSj3+k_rZc+eLUpUA@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Skips the invalid writeback job
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 4:44 PM Brian Starkey <Brian.Starkey@arm.com> wrote=
:
>
> On Fri, Jul 26, 2019 at 04:23:56PM +0200, Daniel Vetter wrote:
> > On Fri, Jul 26, 2019 at 08:13:00AM +0000, Lowry Li (Arm Technology Chin=
a) wrote:
> > > Current DRM-CORE accepts the writeback_job with a empty fb, but that
> > > is an invalid job for HW, so need to skip it when commit it to HW.
> > >
> > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> >
> > Hm, this sounds a bit like an oversight in core writeback code? Not sur=
e
> > how this can even happen, setting up a writeback job without an fb soun=
ds
> > a bit like a bug to me at least ...
> >
> > If we don't have a good reason for why other hw needs to accept this, t=
hen
> > imo this needs to be rejected in shared code. For consistent behaviour
> > across all writeback supporting drivers.
> > -Daniel
>
> I think it's only this way to simplify the drm_writeback_set_fb()
> implementation in the case where the property is set more than once in
> the same commit (to something valid, and then 0).
>
> The core could indeed handle it - drm_writeback_set_fb() would check
> fb. If it's NULL and there's no writeback job, then it can just early
> return. If it's NULL and there's already a writeback job then it
> should drop the reference on the existing fb and free that job.
>
> Could lead to the job getting alloc/freed multiple times if userspace
> is insane, but meh.

Generally these consistency checks need to be in in the atomic_check
phase, not when we set properties. So either somewhere in the helpers,
or in drm_atomic_connector_check() if we want it in core, enforced for
everyone.
-Daniel

>
> -Brian
>
> >
> > > ---
> > >  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c         | 2 +-
> > >  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 9 +++++++=
+-
> > >  2 files changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > index 2fed1f6..372e99a 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > @@ -265,7 +265,7 @@ void komeda_crtc_handle_event(struct komeda_crtc =
*kcrtc,
> > >  komeda_pipeline_update(slave, old->state);
> > >
> > >  conn_st =3D wb_conn ? wb_conn->base.base.state : NULL;
> > > -if (conn_st && conn_st->writeback_job)
> > > +if (conn_st && conn_st->writeback_job && conn_st->writeback_job->fb)
> > >  drm_writeback_queue_job(&wb_conn->base, conn_st);
> > >
> > >  /* step 2: notify the HW to kickoff the update */
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > index 9787745..8e2ef63 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > @@ -52,9 +52,16 @@
> > >  struct komeda_data_flow_cfg dflow;
> > >  int err;
> > >
> > > -if (!writeback_job || !writeback_job->fb)
> > > +if (!writeback_job)
> > >  return 0;
> > >
> > > +if (!writeback_job->fb) {
> > > +if (writeback_job->out_fence)
> > > +DRM_DEBUG_ATOMIC("Out fence required on a invalid writeback job.\n")=
;
> > > +
> > > +return writeback_job->out_fence ? -EINVAL : 0;
> > > +}
> > > +
> > >  if (!crtc_st->active) {
> > >  DRM_DEBUG_ATOMIC("Cannot write the composition result out on a inact=
ive CRTC.\n");
> > >  return -EINVAL;
> > > --
> > > 1.9.1
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
