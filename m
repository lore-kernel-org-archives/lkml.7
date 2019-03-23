Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC4C218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Txa8abwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfCWCcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:32:11 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:45352 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfCWCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:32:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 06412E16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VD2jaQiIj14X for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 21:32:08 -0500 (CDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B93E1E12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:32:08 -0500 (CDT)
Received: by mail-pg1-f198.google.com with SMTP id n10so3772852pgp.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nmOgc8zFB5xKDFp7Beelwbwnhya1C2vT5/p1+e86a2Y=;
        b=Txa8abwywgSA/1yUfn0sXLF6K8N8aIh/8k65hXB9uxumdIRJuE+waGdH/BJXp4xj8S
         dcyVJT85NcwcydvInnryPo4+bjE4PvVXhKT9NFoXGYBbAyUoQ1Hbn7JkjoL4VVbNvrAM
         UTMcsotKg3W2itFFQXJQM2vuy7uBDaY+1FLFKEcMEizvagDEdLLgP1Pp2xwWrAcXa1vp
         nGmug1Y0RHfyI9RgVbtZQqZBNS2UsmoXmYvYCi5nUwPWX28mQha/CG5Aqh9czi7VWEpg
         pki9eghUck2uy+MbAQl4aFHkGR4KrfxMreMHa5q4eqMiwt+hhI70/hcFTBoyD5lHWGeL
         PmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nmOgc8zFB5xKDFp7Beelwbwnhya1C2vT5/p1+e86a2Y=;
        b=GTcKntAz0OBayOhBrL4Yo4C8NRAPNs/yc7uxlqYi7Z+1z0hx+okZ/8SHUXxNeqby1U
         b1RYhIPIKygIUeie91PXQTagQhWiyHx40tLXL3CmeFqpdQ7CxWwcrWG4lw/IHywnF6ub
         vyrK7FjtMNXHRRwW1q5l0bBHGLDZpkxOmZj5BU1SvGWgFY6TLQdjFKw4Lq6JRycqeXQk
         vXST+vTdz6XaBCjaEM2WLaW1ySgbArpIkiaOOvQwK81ajQAnSfJ/d661v4hG9WDZgWxp
         DUb+BgG3D76t+PjL+eoUSwg34b1L0BjtqgDFJmYaiCIJeUER8p5Wt/J8DDSBMNdo2LLP
         v+yQ==
X-Gm-Message-State: APjAAAUTKFiryPvKQ93nB3FnZK1qqqrL7MtJjX5fdnlmlzt63syePCn9
        WqIi51DTY+qHqVEdMynoOJRJ4BS1TSWviMzIrBetUJNRTWLyOIcN+Nyug1fnk5TQ7gSsgZP29u1
        7RK2AjMVtPmSUAr3g1EBYN8nS8tES
X-Received: by 2002:a63:e554:: with SMTP id z20mr11274798pgj.234.1553308328139;
        Fri, 22 Mar 2019 19:32:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/t3tn0Ou85jLfchwVrw4XtfbuG+RafgYj+3CPhjnQ/i9pwPDeTwn7us31JzKxwiMx71uNHA==
X-Received: by 2002:a63:e554:: with SMTP id z20mr11274781pgj.234.1553308327925;
        Fri, 22 Mar 2019 19:32:07 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id p2sm14394423pfi.95.2019.03.22.19.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 19:32:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] drm: vkms: check status of alloc_ordered_workqueue
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190309043628.6078-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 21:32:07 -0500
Cc:     pakki001@umn.edu, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E681935-0B8D-4157-AED7-A851FA265BC7@umn.edu>
References: <20190309043628.6078-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2019, at 10:36 PM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> alloc_ordered_workqueue may fail and return NULL.
> The fix returns ENOMEM when it fails to avoid potential NULL
> pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c =
b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 8a9aeb0a9ea8..bb66dbcd5e3f 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -219,6 +219,8 @@ int vkms_crtc_init(struct drm_device *dev, struct =
drm_crtc *crtc,
> 	spin_lock_init(&vkms_out->state_lock);
>=20
> 	vkms_out->crc_workq =3D =
alloc_ordered_workqueue("vkms_crc_workq", 0);
> +	if (!vkms_out->crc_workq)
> +		return -ENOMEM;

Is this a reasonable patch?

>=20
> 	return ret;
> }
> --=20
> 2.17.1
>=20

