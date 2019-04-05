Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55E521855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="DJvQ6R6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfDEM50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:57:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42395 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfDEM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:57:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so7168301qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewPOYsoLdshTz0QFbHBekjbAvAUxAVDFfTNkCeNZ35E=;
        b=DJvQ6R6o7Kw7oyxChXdtwbj1S4jH+15wxMUIKr3qiwvtMv7eowNWk7awAH3ByEnw3j
         ezi653XIxO8/Pf94L17poMYis2IuobgOySIRaSwKjnhQf/5teSx7hCFFQiHEDcE+miKH
         lbRDlm3I+ncirNPCt8yp48jyqI9ZQ7kRHG8OvLhLFI9hiwZLw867rPTbPIO2HMDIYWCD
         qruhozNo2V0ZsuAjBfOpWDGSX9sVvXQrGXOvKB2lTApj3UMbvKpSNvO2uyU9/nImEnqe
         bMzV7kHR4QSGSV9UMyM9rs7IHrmqKxPc6yqzfs7Yv40w6jfO0CZmsEX5EbUeXE8dKXyh
         Df8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewPOYsoLdshTz0QFbHBekjbAvAUxAVDFfTNkCeNZ35E=;
        b=pko5KZcaUTDQrAITlyTj4b/PHRmLW2yUz35EmAkcr5CgxD3GtP+sc9uPnvNkuLvJWJ
         qhVW2OHptbHwW8rMjl4I6eHQ9Ap+QJu8F76ydCTb+lFdiNOGpmbBRU0FN1+hkTIdt4z9
         r6ixjmMy4qMwOuX5NQh9oDnYuDAf3zhuwldujrORLDsld7Wtcojztjia8qrlRfTf0CoP
         e5MAKx0LnlhSbiR4kLBpFyS0DYW0EfrAircW+mhYjCle+EsnVsanW1ZeVH7pr89xhlMU
         A1DhgvM5ZZ6eXnhxdPRzLAsctPGt2gu+Xxelhk5egQkOBQPVF9ThWBcQ0PB3Qmv9wRQw
         PzQQ==
X-Gm-Message-State: APjAAAVSLa3X+ieFer0H1kqaQU7HNYi0CvOsYv3zM4dGNNQSs7lJLpib
        m8Mp+cyV8a5ED1PsBlmgX3iyCw==
X-Google-Smtp-Source: APXvYqyvrPBZL6zGiH8gNAISAQzWcD2nioJWG6K8Ba4+uCaao35YAFOF2X0cx/Dn1VOE3NE8kAYxnw==
X-Received: by 2002:a0c:89a3:: with SMTP id 32mr9939868qvr.116.1554469044648;
        Fri, 05 Apr 2019 05:57:24 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 11sm15697549qtu.5.2019.04.05.05.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 05:57:23 -0700 (PDT)
Date:   Fri, 5 Apr 2019 08:57:23 -0400
From:   Sean Paul <sean@poorly.run>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/gpu/meson: Remove link to meson_canvas.c
Message-ID: <20190405125723.GD17077@art_vandelay>
References: <20190403205652.183496-1-sean@poorly.run>
 <2afc7c09-a6e4-5191-d7e3-7a3a75451aab@baylibre.com>
 <de19dd7b-40dd-408b-a024-53036dedf7c3@baylibre.com>
 <20190404143125.GB17077@art_vandelay>
 <0897093a-246b-211b-bddf-6d87877b429c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0897093a-246b-211b-bddf-6d87877b429c@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 02:14:35PM +0200, Neil Armstrong wrote:
> On 04/04/2019 16:31, Sean Paul wrote:
> > On Thu, Apr 04, 2019 at 10:28:29AM +0200, Neil Armstrong wrote:
> >> On 04/04/2019 08:56, Neil Armstrong wrote:
> >>> On 03/04/2019 22:56, Sean Paul wrote:
> >>>> From: Sean Paul <seanpaul@chromium.org>
> >>>>
> >>>> The file was removed in the below patch and is causing this error:
> >>>> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -function Canvas ../drivers/gpu/drm/meson/meson_canvas.c' failed with return code
> >>>>
> >>>> Fixes: 2bf6b5b0e374 ("drm/meson: exclusively use the canvas provider module")
> >>>> Cc: Maxime Jourdan <mjourdan@baylibre.com>
> >>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
> >>>> Cc: Kevin Hilman <khilman@baylibre.com>
> >>>> Cc: dri-devel@lists.freedesktop.org
> >>>> Cc: linux-amlogic@lists.infradead.org
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> >>>> ---
> >>>>  Documentation/gpu/meson.rst | 6 ------
> >>>>  1 file changed, 6 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/gpu/meson.rst b/Documentation/gpu/meson.rst
> >>>> index 479f6f51a13b..b9e2f9aa3bd8 100644
> >>>> --- a/Documentation/gpu/meson.rst
> >>>> +++ b/Documentation/gpu/meson.rst
> >>>> @@ -42,12 +42,6 @@ Video Encoder
> >>>>  .. kernel-doc:: drivers/gpu/drm/meson/meson_venc.c
> >>>>     :doc: Video Encoder
> >>>>  
> >>>> -Video Canvas Management
> >>>> -=======================
> >>>> -
> >>>> -.. kernel-doc:: drivers/gpu/drm/meson/meson_canvas.c
> >>>> -   :doc: Canvas
> >>>> -
> >>>>  Video Clocks
> >>>>  ============
> >>>>  
> >>>>
> >>>
> >>> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>
> >>
> >> Applied to drm-misc-fixes
> > 
> > Hmm, the commit referenced in the Fixes line hasn't landed in -fixes yet, it's
> > in -next. So the fix has landed before the bug :(
> 
> Seems I'll still need to apply it to -next !

I've just applied it, thanks for staying on top of this.

Sean

> 
> Neil
> 
> > 
> > I'll ping mripard on irc and see what he wants to do about this.
> > 
> > Sean
> > 
> >>
> >> Neil
> > 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
