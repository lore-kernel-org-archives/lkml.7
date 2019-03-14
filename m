Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00641C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4FD217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJeqQKdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCNEVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:21:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43215 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfCNEVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 00:21:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id 67so3333253oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnLTFhnEsKldNLbdUAUAkEIkD6mIrlEW5IhOy35tzCo=;
        b=mJeqQKdkK4IQ70UvOEKETmLQ1JL9+3HPnUch9Xp0expLLDAmdsnAB+i4WzXF8EwzOO
         tUeeFvJZAgN7AGEbpr3NhfiQp3qN/p+D1LoEVlIbUn6aHDwXJXLnkhj3EVy8MKGVUWxo
         8Obt6BH14ejUF1RBG0a3zSpHS/0ovU/DhSoYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnLTFhnEsKldNLbdUAUAkEIkD6mIrlEW5IhOy35tzCo=;
        b=UZ+cX5FdhHzvr/7Gl71+2Mau60MryBAPiV/3NI+4OSG2RlimQp2y3UUrswqLfB8CzM
         0gTMYOtDyWHKnooxZtsNA+BUPC9XpMPJ4qia3+yzhEyZn6TucSPEX5Y26ICx0Tfi8fhL
         k5NxMbSc3DjPyuCSTqGNszFkLxuTHcoG1gAHAJPrfghWFP0Qk3wAx5S2shKNe2Od6uvg
         TW/rW6BqlcWMZU95IEuHkD/AmYyFcTkNKNJ4HffYcUiGany7cQ7ZTedtJFA0TKJOTqgn
         q6U/20XxxAFE6ozYMhvR/MRKmWuy26QRfy6Dd0cHC2d9WlYzEkuTq50PAVh5IQ2wyiCb
         AjlA==
X-Gm-Message-State: APjAAAWD/cjjS6apO6rFimGtHQxV35eta45NaA2PujdB6snOV2SFoDJx
        UKvKSNm6Z2tGaTFzIG9S30Cf2kRi2yxolw==
X-Google-Smtp-Source: APXvYqy3x0JOKs+fzQNCF85dOs0vuse/JdLlxncE9oUJcwJEnEQDeGHKtAqjSctVQvDQy57R8spn1w==
X-Received: by 2002:aca:bd56:: with SMTP id n83mr801023oif.178.1552537311289;
        Wed, 13 Mar 2019 21:21:51 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id n12sm5322382otl.22.2019.03.13.21.21.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 21:21:51 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id b3so3923926otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 21:21:50 -0700 (PDT)
X-Received: by 2002:a9d:760a:: with SMTP id k10mr5570644otl.367.1552536825939;
 Wed, 13 Mar 2019 21:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.f011581516bfe7650c9d4c6054bb828e6227e309.1551964740.git-series.maxime.ripard@bootlin.com>
 <1d374e71ffcc396b71461ea916cac3d957f8d86c.1551964740.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5AKXz5QmqnSEkChf8DqPkhEuUQg--q9dZKPmB1kBR1hzA@mail.gmail.com> <20190313153130.hnp5eybcgjm34i4n@flea>
In-Reply-To: <20190313153130.hnp5eybcgjm34i4n@flea>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 14 Mar 2019 13:13:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BeiGVvDcZTFVYg_Qbw1NxRcWFybW2FcDGE=ohFWHFbYA@mail.gmail.com>
Message-ID: <CAAFQd5BeiGVvDcZTFVYg_Qbw1NxRcWFybW2FcDGE=ohFWHFbYA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 12:31 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi Tomasz,
>
> On Fri, Mar 08, 2019 at 03:12:18PM +0900, Tomasz Figa wrote:
> > > +.. _v4l2-mpeg-h264:
> > > +
> > > +``V4L2_CID_MPEG_VIDEO_H264_SPS (struct)``
> > > +    Specifies the sequence parameter set (as extracted from the
> > > +    bitstream) for the associated H264 slice data. This includes the
> > > +    necessary parameters for configuring a stateless hardware decoding
> > > +    pipeline for H264.  The bitstream parameters are defined according
> > > +    to :ref:`h264`. Unless there's a specific comment, refer to the
> > > +    specification for the documentation of these fields, section 7.4.2.1.1
> > > +    "Sequence Parameter Set Data Semantics".
> >
> > I don't see this section being added by this patch. Where does it come from?
>
> This is referring to the the H264 spec itself, as I was trying to
> point out with the reference in that paragraph. How would you write
> this down to make it more obvious?
>

Aha, somehow it didn't come to my mind when reading it. How about
something like below?

Unless there is a specific comment, refer to the ITU-T Rec. H.264
specification, section "7.4.2.1.1 Sequence parameter set data semantics"
(as of the 04/2017 edition).

Best regards,
Tomasz
