Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F73C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D4A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="h5JueMEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437058AbfFLBAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:00:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44186 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404906AbfFLBAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:00:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so16865917qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kGCYosRguXq4elehaPFOveEwgPcblLIUUh1tydiqlv0=;
        b=h5JueMEL7krh+Lb8jEoJH4vzMieW9Ynm0WMNBzCOFjIznSTZa7pc332ziUaX7BXKJ3
         pXHzyqkatzuzJneWeW7w9rbl7kg/VRwj+ApC7uDfSQVDTMekZStH2lvgviPm+9ZBTMEq
         GdXEzbiYevwqVMZ8KpQZLdc7zGrbM8OLA7wKKtZFEwnDI0sEaF9/U9YRVe0P9ViIjz0l
         DWoeIeyBgstsX0aObxmXHDz8HDCvqyLf3IefResEwj6NIad/+82M3bmTIiT/CdFAYgHA
         mMy1WBGFRyGkbArSW8o2UvGVTGq84vm/oxhq2k7cCB21LRqAbT9pxMDOVEVxkVq6UuvM
         uUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kGCYosRguXq4elehaPFOveEwgPcblLIUUh1tydiqlv0=;
        b=A/f3I4wPkJLmUkFKUe1f03O3C4zOiwDSVIev6KnCotvpPX/m5HC2pNFzZf1H0hb/ge
         4BoKPD9ivZP0TFRRj2jAL+EieZbGgz9iXqJot8GWa+rwGXwp//zDD+ckpQIpoy+C8WHU
         faopogzHqmD0we193b7Zq4adzhpKWj0m6isZc8MinSrRzp7HCh98FA1vDxYMqyrhN1SR
         Vj5cEHe2iUhmb3/hreanj/68n61FXMuL0hJy4inKlHIusesNQUpo9CVyPNISd06ww+4M
         A+wlhdwUzXSUyfGG1Nd+kE2PBpqoiP/ybEwaoe7c9/yRER1Anasd7jS8JYo7vmgzt2FT
         C36w==
X-Gm-Message-State: APjAAAV3lv4OEOUUbjZlDsfxAFr4qA3prK63EWE/MzmnQxGXXq2UIqco
        ZRAvfBNYP/Dikc4aV4nwgywQLA==
X-Google-Smtp-Source: APXvYqxZuRR2hJ2pElF2t/9lGshSakTd6RGMsXt59FPQH7rSPXBg4udJBQ0orZJzB6AngdKEjeJO+w==
X-Received: by 2002:ac8:2af8:: with SMTP id c53mr22206710qta.387.1560301214655;
        Tue, 11 Jun 2019 18:00:14 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id d188sm7473200qkf.40.2019.06.11.18.00.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 18:00:14 -0700 (PDT)
Message-ID: <09e608da8abeb4cd9c84bf9f559af2438540eb2b.camel@ndufresne.ca>
Subject: Re: [PATCH v7 2/4] media: videodev2: add
 V4L2_FMT_FLAG_FIXED_RESOLUTION
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Tue, 11 Jun 2019 21:00:12 -0400
In-Reply-To: <1d2adae2b6d0f370f17b9bac94ae4e9207dccbad.camel@ndufresne.ca>
References: <20190531093126.26956-1-mjourdan@baylibre.com>
         <20190531093126.26956-3-mjourdan@baylibre.com>
         <9731b2db-efd4-87d0-c48d-87adec433747@xs4all.nl>
         <1560243127.13886.3.camel@pengutronix.de>
         <1d2adae2b6d0f370f17b9bac94ae4e9207dccbad.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 11 juin 2019 à 20:58 -0400, Nicolas Dufresne a écrit :
> Le mardi 11 juin 2019 à 10:52 +0200, Philipp Zabel a écrit :
> > On Wed, 2019-06-05 at 15:39 +0200, Hans Verkuil wrote:
> > > Hi Maxime,
> > > 
> > > I am wondering if this flag shouldn't be inverted: you set
> > > V4L2_FMT_FLAG_DYN_RESOLUTION if dynamic resolution is supported,
> > > otherwise it isn't.
> > > 
> > > Can all the existing mainlined codec drivers handle midstream
> > > resolution changes?
> > > 
> > > s5p-mfc, venus and mediatek can, but I see no SOURCE_CHANGE event in
> > > the coda drivers, so I suspect that that can't handle this.
> > > 
> > > Philipp, what is the status of the coda driver for dynamic resolution
> > > changes?
> > 
> > FTR, to my knowledge there is no dynamic resolution change support in
> > the firmware, as there is no signal (interrupt nor picture run return
> > value) to indicate that different headers were parsed.
> > 
> > I am planning to add the initial source change event required by the
> > current decoder API documentation, but I am afraid there will be no
> > support for source changes due to mid-stream resolution changes due to
> > firmware limitations.
> 
> I'm far from familiar with this IP, but at least on CODA988, I can read
> from the manual that the workflow is to first guess the allocation, and
> if you guess it wrong, an error is returned. What seems to match the
> SOURCE_CHANGE event in that version would be in the picture status
> register, the bit 20, which is documented as triggered if the stream
> requires bigger buffers sizes, or more buffers. After fixing that, you
> should, if I read correctly, retry.
> 
> It does not notify if the buffers are too large, but you can detect,
> since there is register with the output stream information. This
> basically means that for V4L2 restriction, you'd have to bounce the
> buffers on frame size boundary or something like thisé
> 
> This workflow is very similar to how OMX works, but V4L2 is even less
> flexible on allocation vs format, forcing more re-allocation.

Oh, actually, you already bounce the buffers through the color
converter, so I guess this can all be hidden internally.

> 
> > regards
> > Philipp

