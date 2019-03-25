Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E852085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XaXSfXnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfCYIeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:34:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36623 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCYIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:34:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so6708868edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=005/y9dhLaehZ55GHv8wRHBBOPfk10DRRFcPIJ9eiCA=;
        b=XaXSfXnXqJqS5qF98b+kuYzVIFf09mtn3ZC8sov+j2WdtDKzuAMbugFGK6Z8aaTvvU
         ZUXTi8Cad9sphbbzD7X5s3Tz93m8d5MyTNzgyO4YbLGomOyX0eofDyrG51BezSOZRg8f
         Dk6v+FTrll9L1C+Ge7QFIh82l6bGkz55pikrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=005/y9dhLaehZ55GHv8wRHBBOPfk10DRRFcPIJ9eiCA=;
        b=g3RNviALdritT2sv69dkyIW3bWMim+2SpKtOiMnOmnoccyD3FfJBS52ZZ3lBEsyxKu
         al6gGneeldWFi5NXVvsMLPv3VgqcU7kpzFLTBhsrP3f7CqZPHaQvTlI7Sje1qGvSo/qZ
         FnjtkgI1CyxLOyHF53GOE5RFeNhZtkLTp7rI8eOBIgYM2yMVlDCY/j0WFUQ3NNACu70j
         XEB8UAxqqQmGL0g5WgYRxphFUECSzk1QZIO1hgejQA+nscvHQMZHnioFrUEa/nW1OyIs
         aZZ2RE5SD/lJqgVXnrYz5/gPj6huU3c3h23zPlI3cg37SeFeLm0L4o36pPhcB7C+msJp
         r7Dg==
X-Gm-Message-State: APjAAAUMq+5ixPdOb8xJnLkMesWRDgQQ3g5D+GUD4wwVnW21F35XmLOd
        nwAGSZklu8d9er1mZWNQJwu6lQ==
X-Google-Smtp-Source: APXvYqzZFAmfiIITtEoGplm9HWd7rzW9bdHDk5QNWxuYe518yubaWydjzSFcFA4abSaz1mor7S4Aiw==
X-Received: by 2002:a50:cccc:: with SMTP id b12mr15765430edj.94.1553502855792;
        Mon, 25 Mar 2019 01:34:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z39sm2793560edz.26.2019.03.25.01.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:34:15 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:34:13 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: vkms: check status of alloc_ordered_workqueue
Message-ID: <20190325083413.GC2665@phenom.ffwll.local>
Mail-Followup-To: Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190309043628.6078-1-kjlu@umn.edu>
 <9E681935-0B8D-4157-AED7-A851FA265BC7@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E681935-0B8D-4157-AED7-A851FA265BC7@umn.edu>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:32:07PM -0500, Kangjie Lu wrote:
> 
> 
> > On Mar 8, 2019, at 10:36 PM, Kangjie Lu <kjlu@umn.edu> wrote:
> > 
> > alloc_ordered_workqueue may fail and return NULL.
> > The fix returns ENOMEM when it fails to avoid potential NULL
> > pointer dereference.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> > drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index 8a9aeb0a9ea8..bb66dbcd5e3f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -219,6 +219,8 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> > 	spin_lock_init(&vkms_out->state_lock);
> > 
> > 	vkms_out->crc_workq = alloc_ordered_workqueue("vkms_crc_workq", 0);
> > +	if (!vkms_out->crc_workq)
> > +		return -ENOMEM;
> 
> Is this a reasonable patch?

lgtm, applied and thanks for your patch.
-Daniel

> 
> > 
> > 	return ret;
> > }
> > -- 
> > 2.17.1
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
