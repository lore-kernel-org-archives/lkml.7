Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBBCC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9CB20989
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJASSwao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfGCE6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:58:55 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46172 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfGCE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:58:54 -0400
Received: by mail-ed1-f44.google.com with SMTP id d4so670090edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uf5aCU6aY5t/9fyL90O/cqUCzIfpNsCzgBmR7PWCe0Y=;
        b=kJASSwao08QQ12P0yrheKoob6wHDYCL0MeriSYWmYAymiP4LABpOrMNoNyF/wCA3kr
         uYFEqJKV4aZsU7s8nJUFIWjf5HHdnAlnZ3xEyNpTUvFXTHaVcbC79gezsNkfl80hnR/g
         fu07wEe13+Ad9Xzpx+1j3p/HXJlP2X2+GVKE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uf5aCU6aY5t/9fyL90O/cqUCzIfpNsCzgBmR7PWCe0Y=;
        b=Sy0T8pGUMHt1fpG19BLJ4rUm2JZigiwAowBvh7E8Qpdn3rHw14ErgXdpilTDpGDyVr
         E/pvHGsZhKlRlWr/bc8eYdq0C5axjWz7kEMqqf3/9MGQHvOexbDldjmAMty0orpLHJy1
         i0PIfB90c0U1GkbcTm7bsJL3MAJFB7fR3iWPZ98JZWWqT2hwqiqpjI484udAjOKc4t2G
         utjk4xGYlCxXjq4mBcvSAXo3JawloO17EsidfNZ7Wr5imvViIVectY4RjLtgV+F7moV4
         c3oQRtTGONS4sy47HLNjBar8eSG3D3x473E+YnUab3T/VNLt1tyRrdw51p9XlCCvfDAx
         CqEQ==
X-Gm-Message-State: APjAAAVX/qs4YSSOxAsdJ+8/MWZWFi5U439lyPpQ1rbmm0w7MweqhYO8
        zUbn36ilO1+2wtnxnE17tQIlG5Oq/sI2cg==
X-Google-Smtp-Source: APXvYqxOqK64HcI+65raV3B7IvnwCVrhAA1Ui2WiC/OSz47LIPeHjMdbHMlsi2KpKELScq0NkMeM1A==
X-Received: by 2002:a17:906:80cc:: with SMTP id a12mr32156288ejx.132.1562129932245;
        Tue, 02 Jul 2019 21:58:52 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id b25sm335222eda.38.2019.07.02.21.58.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 21:58:50 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id x4so1078957wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:58:50 -0700 (PDT)
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr2514295wrx.48.1562129929689;
 Tue, 02 Jul 2019 21:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190603112835.19661-1-hverkuil-cisco@xs4all.nl> <20190603112835.19661-2-hverkuil-cisco@xs4all.nl>
In-Reply-To: <20190603112835.19661-2-hverkuil-cisco@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 3 Jul 2019 13:58:38 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Aa-PQEakeg3sC_EDYdKy15hHx09Qmk6Jik4COeBe3xVA@mail.gmail.com>
Message-ID: <CAAFQd5Aa-PQEakeg3sC_EDYdKy15hHx09Qmk6Jik4COeBe3xVA@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Jun 3, 2019 at 8:28 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrot=
e:
>
> From: Tomasz Figa <tfiga@chromium.org>
>
> Due to complexity of the video decoding process, the V4L2 drivers of
> stateful decoder hardware require specific sequences of V4L2 API calls
> to be followed. These include capability enumeration, initialization,
> decoding, seek, pause, dynamic resolution change, drain and end of
> stream.
>
> Specifics of the above have been discussed during Media Workshops at
> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API that
> originated at those events was later implemented by the drivers we alread=
y
> have merged in mainline, such as s5p-mfc or coda.
>
> The only thing missing was the real specification included as a part of
> Linux Media documentation. Fix it now and document the decoder part of
> the Codec API.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1084 +++++++++++++++++
>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |    8 +-
>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
>  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   41 +-
>  5 files changed, 1132 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
>

Thanks a lot for helping with remaining changes.

Just one thing inline our team member found recently.

[snip]
> +Capture setup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
[snip]
> +4.  **Optional.** Set the ``CAPTURE`` format via :c:func:`VIDIOC_S_FMT` =
on the
> +    ``CAPTURE`` queue. The client may choose a different format than
> +    selected/suggested by the decoder in :c:func:`VIDIOC_G_FMT`.
> +
> +    * **Required fields:**
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
> +
> +      ``pixelformat``
> +          a raw pixel format.

The client should be able to set the width and height as well. It's a
quite frequent case, especially in DMA-buf import mode, that the
buffers are actually bigger (e.g. more alignment) than what we could
get from the decoder by default. For sane hardware platforms it's
reasonable to expect that such bigger buffers could be handled as
well, as long as we update the width and height here.

It's more like a clarification anyway, so if you think it would be
better to just merge the current revision, I could send a follow up
patch.

Regardless of that and FWIW:

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
