Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2266DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA27221881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Fzqv4nQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfH0QoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:44:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43408 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0QoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:44:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13so32145386edq.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T4/dJTACRgyspP6PQrEfl3SMkEU0BRTMNnpAOcNAN9k=;
        b=Fzqv4nQ+umzv/2+KsGP2IW6/1O7DBQCIYC2HmBh/Ixkm0qxY1XpDuoKgz+tncImxs7
         N7m7N3ReqRn0EeNNxHDIVftSZ9fXBGgZpadIxuWhZwJwT9VgxqDJeUZWp8QGR+pDw7jL
         MrGOVuuTzL+18NS2EevgZPTFpC6D+ugKy/n7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T4/dJTACRgyspP6PQrEfl3SMkEU0BRTMNnpAOcNAN9k=;
        b=Ty75hcnaBuvGO0JY0JRzowfhVFUPEVI5V2ySk3+HlaIJye2ZLmIygjMo2iSV+5XMpY
         O//o2wMaHvyhz7gfT1qsOhTKeNQ2S3VAalKPFa/WUW18eb/qaao2e/awiPdK2ZNcnGKR
         thLJyBdhGVQbL7C3ex4iSsDzEiWAHIQpah1P7ooFSC3GQxqwtEXhZPurzKdcjT9kggry
         UyGWG5CMEpsjXfiXkRpE9AUDRFFWuDXCl175mYwZUGE1Of+QO1g7QWIVeHY8iZeIvWmg
         OLn7mFtyiefc8Wp2WanMa4KGXJGlACD6uMa4U88Rrci6Az+pYQa90tSsETJSiZ7evM2k
         Er2g==
X-Gm-Message-State: APjAAAUApFvh0BeHKhoyTTZswQIVD0wylXwxy1VPSRLp5UKm5AAGGDqH
        X9K3dzOS1/b13dazt/E1i4uZWQ==
X-Google-Smtp-Source: APXvYqzGZWYGoQY3nS9VufjvpYmxU7hjhjBeufmUT4bsglP7TAQ2Nsm6LWhsAFqb4Pi6mCtsDOWt0g==
X-Received: by 2002:aa7:d813:: with SMTP id v19mr25334216edq.45.1566924253874;
        Tue, 27 Aug 2019 09:44:13 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l27sm3498970ejd.31.2019.08.27.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:44:13 -0700 (PDT)
Date:   Tue, 27 Aug 2019 18:44:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/2] drm/meson: add resume/suspend hooks
Message-ID: <20190827164411.GE2112@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20190827095825.21015-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095825.21015-1-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:58:23AM +0200, Neil Armstrong wrote:
> This serie adds the resume/suspend hooks in the Amlogic Meson VPU main driver
> and the DW-HDMI Glue driver to correctly save state and disable HW before
> suspend, and succesfully re-init the HW to recover functionnal display
> after resume.
> 
> This serie has been tested on Amlogic G12A based SEI510 board, using
> the newly accepted VRTC driver and the rtcwake utility.

No idea about the hw, but looks all neatly integrated into pm stuff, so on
both patches:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Neil Armstrong (2):
>   drm/meson: dw_hdmi: add resume/suspend hooks
>   drm/meson: add resume/suspend hooks
> 
>  drivers/gpu/drm/meson/meson_drv.c     |  32 ++++++++
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 110 ++++++++++++++++++--------
>  2 files changed, 108 insertions(+), 34 deletions(-)
> 
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
