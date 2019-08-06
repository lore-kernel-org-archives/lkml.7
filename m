Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A47C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7418F20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GCxLTieL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbfHFJMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:12:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34383 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbfHFJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:12:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so46828050edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gweiDhMg6x5h0CBZ9jEDz6URqbWss8jEmW6jlx4p8f0=;
        b=GCxLTieL7d6KfUVsHIEdGc0As9m3p3dsxF9Gcd9022xSDJawvrogHQPmLC8Wdjw3Mq
         5CYeO1EPD2O2hjacMZYPrdmy6Ha5m++jwq6Lk8tGxd5pRwfNkjQ4cjhy95koffSlaHNI
         V6PyMvygx/X8N2QhwWZduT1vU6MomGLNCQo0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gweiDhMg6x5h0CBZ9jEDz6URqbWss8jEmW6jlx4p8f0=;
        b=Rn1gZM5n51dMauqYulHsSA7TPK9iLBTo6lmnw4La79s0MhKL0ZnGDcXPIoMuKut+kC
         IHsiYtQleGKuzf9mt68GF2el50YZtP4cVjsPNmUH56o+ZDwmJmAyRv5QKlqPbRJS2h4r
         ElgXcUh9DpaoAfnxH2bReoyGAnqSZvs5vyZjI14NARzlROfFVHIz2rcrVgL6PEaw65TI
         GfBATApNfhKQYdnS3QIPapUzu+iuKjhHgr6ypxk3mB6vZ08IeXlZ2qwWEe2b6cYlcF6o
         cKD15eSUGrZyO4+sEyR9r+8fi6HQoyMGiiXd7RlcU457w6PGqCs6ZrX5t1PW+eal9O6p
         iU+A==
X-Gm-Message-State: APjAAAUsHpox7mCDTX+VDDldlWsYSy9vPGX0NURSagVeiZiIs2qbdBgr
        kVBknoDVlcKhT3XkSZjhFNkllA==
X-Google-Smtp-Source: APXvYqzTkx3LOwAEvQrFcZg1vYWUztsJ2Sfgpt18YDAtvphTslGMzOOb94QCCcg0ktrAbmscCK/Kgw==
X-Received: by 2002:a17:906:a3cb:: with SMTP id ca11mr2167641ejb.79.1565082756015;
        Tue, 06 Aug 2019 02:12:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k5sm14343811eja.41.2019.08.06.02.12.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 02:12:35 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:12:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/crc-debugfs: Add notes about CRC<->commit
 interactions
Message-ID: <20190806091233.GX7444@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <Brian.Starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190802140910.GN7444@phenom.ffwll.local>
 <20190805151143.12317-1-brian.starkey@arm.com>
 <20190805162417.GS7444@phenom.ffwll.local>
 <20190805165414.nzlru7iiqiaepuuu@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805165414.nzlru7iiqiaepuuu@DESKTOP-E1NTVVP.localdomain>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 04:54:15PM +0000, Brian Starkey wrote:
> On Mon, Aug 05, 2019 at 06:24:17PM +0200, Daniel Vetter wrote:
> > On Mon, Aug 05, 2019 at 04:11:43PM +0100, Brian Starkey wrote:
> > > CRC generation can be impacted by commits coming from userspace, and
> > > enabling CRC generation may itself trigger a commit. Add notes about
> > > this to the kerneldoc.
> > >
> > > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> > > ---
> > >
> > > I might have got the wrong end of the stick, but this is what I
> > > understood from what you said.
> > >
> > > Cheers,
> > > -Brian
> > >
> > >  drivers/gpu/drm/drm_debugfs_crc.c | 15 +++++++++++----
> > >  include/drm/drm_crtc.h            |  3 +++
> > >  2 files changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> > > index 7ca486d750e9..1dff956bcc74 100644
> > > --- a/drivers/gpu/drm/drm_debugfs_crc.c
> > > +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> > > @@ -65,10 +65,17 @@
> > >   * it submits. In this general case, the maximum userspace can do is to compare
> > >   * the reported CRCs of frames that should have the same contents.
> > >   *
> > > - * On the driver side the implementation effort is minimal, drivers only need to
> > > - * implement &drm_crtc_funcs.set_crc_source. The debugfs files are automatically
> > > - * set up if that vfunc is set. CRC samples need to be captured in the driver by
> > > - * calling drm_crtc_add_crc_entry().
> > > + * On the driver side the implementation effort is minimal, drivers only need
> > > + * to implement &drm_crtc_funcs.set_crc_source. The debugfs files are
> > > + * automatically set up if that vfunc is set. CRC samples need to be captured
> > > + * in the driver by calling drm_crtc_add_crc_entry(). Depending on the driver
> > > + * and HW requirements, &drm_crtc_funcs.set_crc_source may result in a commit
> > > + * (even a full modeset).
> > > + *
> > > + * It's also possible that a "normal" commit via DRM_IOCTL_MODE_ATOMIC or the
> > > + * legacy paths may interfere with CRC generation. So, in the general case,
> > > + * userspace can't rely on the values in crtc-N/crc/data being valid
> > > + * across a commit.
> >
> > It's not just the values, but the generation itself might get disabled
> > (e.g. on i915 if you select "auto" on some chips you get the DP port
> > sampling point, but for HDMI mode you get a different sampling ploint, and
> > if you get the wrong one there won't be any crc for you). Also it's not
> > just any atomic commit, only the ones with ALLOW_MODESET.
> 
> Is the meaning of ALLOW_MODESET actually defined somewhere then? I
> thought it was broadly speaking "anything that would cause a flicker
> on the output" - but that needn't be the same set of things that break
> CRC generation.

It's the inverse, I think we should require that crc keeps working for
non-ALLOW_MODESET. Otherwise crc are essentially useless for validating
stuff. And yeah allow_modeset is "could flicker and/or take enormous
amounts of time".
-Daniel

> > Maybe something like the below text:
> >
> > "Please note that an atomic modeset commit with the
> > DRM_MODE_ATOMIC_ALLOW_MODESET, or a call to the legacy SETCRTR ioctl
> > (which amounts to the same), can destry the CRC setup due to hardware
> > requirements. This results in inconsistent CRC values or not even any CRC
> > values generated. Generic userspace therefore needs to re-setup the CRC
> > after each such modeset."
> >
> > >
> > >  static int crc_control_show(struct seq_file *m, void *data)
> > > diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> > > index 128d8b210621..0f7ea094a900 100644
> > > --- a/include/drm/drm_crtc.h
> > > +++ b/include/drm/drm_crtc.h
> > > @@ -756,6 +756,8 @@ struct drm_crtc_funcs {
> > >   * provided from the configured source. Drivers must accept an "auto"
> > >   * source name that will select a default source for this CRTC.
> > >   *
> > > + * This may trigger a commit if necessary, to enable CRC generation.
> >
> > I'd clarify this as "atomic modeset commit" just to be sure.
> 
> Ack.
> 
> Thanks,
> -Brian
> 
> >
> > With these two comments addressed somehow:
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> >
> > > + *
> > >   * Note that "auto" can depend upon the current modeset configuration,
> > >   * e.g. it could pick an encoder or output specific CRC sampling point.
> > >   *
> > > @@ -767,6 +769,7 @@ struct drm_crtc_funcs {
> > >   * 0 on success or a negative error code on failure.
> > >   */
> > >  int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
> > > +
> > >  /**
> > >   * @verify_crc_source:
> > >   *
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
