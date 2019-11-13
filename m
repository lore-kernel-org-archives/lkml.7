Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9384C4741D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E49323895
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0C2zq6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfKMQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:06:34 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46058 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKMQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:06:33 -0500
Received: by mail-ua1-f65.google.com with SMTP id j4so812772uak.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ayLEgLCWpr2v/YpRT1vekWIlyB7F5pG92dGazdBvwI=;
        b=G0C2zq6m15OVUAh+WFhsjZYXXzcdOByoFghlCOloPCUxpwsOe48d6TWKiBYF1Jt+3P
         pCkyi8gtQTCFIBPO9DwTV6c0WxkptrtOWz4iYPnK/cnKPm7I5zvj+dxET+BVtJ1DQpne
         xvFFiYgEs8mmbZJfAKBvvDnvS95WxPpEuPkR3s9WkN17IYO9Pb5tGG3tSajwy1byyD4N
         F16i2K46Gs2g/bj6Gi2+PLQDxaHl6IMmz66pxEDl3gH6mDW5O41D81GUalCuv66KK2kl
         pzplG0H99Acg6QnE2CyrhUpnwJAaLbkNCMS71/7karx00Scg1v8aAwzEcypXqj1ia3qp
         NQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ayLEgLCWpr2v/YpRT1vekWIlyB7F5pG92dGazdBvwI=;
        b=k9SwbfhuySxzvaxPw/IP/i7u23Ld9ruChwiomL7CAIPVIvT4PQZPsh2Kb253IcBPi4
         ns4eHqTJ8gCGcEbPT4H5CH362byIDZscAnzGUYhEBYJx67mIfrNQA+zeCBxeSNcy648N
         aXqZlqSnllQQmqxmRPi0rGHIRwfeVlMEVFG851MNXC/os2+wsHVmhSQNT/JhWbAWG12/
         LkqG7a0usKiflWKsN93mCPNIpRlhl97/ODEp0bfj9t/P5R78i/O7MvB0PjpzOy1ufb+W
         hP31s9EbvReJg+fgBvU1e4f08OIiFTeBeOeP6TAibIcqN5yfG9KkigMNyQnjbzdF0H7L
         IPtQ==
X-Gm-Message-State: APjAAAVYEkHaFR+pd8U83PebHc2rFl4QAog8aJRZ0GQaGedtl3LW9j1L
        5fF3jULe5qhgZgGNrlGcsE9aanrhIVgI//yWS4s=
X-Google-Smtp-Source: APXvYqyzUYrhlIoEugbzPslmvADNMfF2xvcbUO3zTaYeh1c05O5Pyx2U0QDgD4P1JCUm3NiogsNTTpD6/UoykImOIHY=
X-Received: by 2002:ab0:14e8:: with SMTP id f37mr2288342uae.64.1573661192697;
 Wed, 13 Nov 2019 08:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20191106163031.808061-1-adrian.ratiu@collabora.com> <20191106163031.808061-5-adrian.ratiu@collabora.com>
In-Reply-To: <20191106163031.808061-5-adrian.ratiu@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 13 Nov 2019 16:06:05 +0000
Message-ID: <CACvgo506P+qNUg8vbpxY0_E7AAwJMHseM=Jwb3c2K8zo-v-2qQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: display: add IMX MIPI DSI host
 controller doc
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 16:31, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Please drop this one. I'm not that experienced in DT to provide
meaningful review.

Actually, I've just noticed that respective maintainers/lists are not
CC'd on the series.
Please use the get_maintainer.pl script got get the correct info.

Personally, I read through the output, adding only relevant people as
CC in the commit message itself.

In particular, I don't think adding the "maintainer: DRM DRIVER" or
the "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" are required. On the
other hand "DRM DRIVERS FOR FREESCALE IMX" and "OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS" seems pretty accurate for what you're
doing here.

HTH
Emil
