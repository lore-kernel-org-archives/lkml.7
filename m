Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394AEC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1076221537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8xZ2RJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGIGPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:15:23 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35599 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGIGPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:15:22 -0400
Received: by mail-ed1-f46.google.com with SMTP id w20so16605999edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDzjMWxwokXwvdx7TqR3+5NdbnOSDiEOotLEa/Zg7Nk=;
        b=K8xZ2RJnipyWngJ53bOuctxIW7TEMd/MljxkcYd6t7879ub/ZQHx6ZxQZy8GuM0iwI
         Q5Xa5YlgWnVqTQW6ZlzrLxzHSRhystAdkSKYbgzd6bTh6hbXMwUvVRiwdEvqPESnJnGH
         9JJjZVW0WbeXMlXKAWelEJw+GYI5HoFrFU06k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDzjMWxwokXwvdx7TqR3+5NdbnOSDiEOotLEa/Zg7Nk=;
        b=YJu9mgEcf2GMhdo6LY+IJuTmoVkii+K2p6xR4Ln+ct6OmgnfA7Ym1EJn8+vgtgKGjy
         C4aQKhhKr5sJFrC67r8PQAiZ1l3l5+vdYK4+kumxuil8fh/NJVGQm52Nqwy4kTgz3YWz
         yYfOpseObmoI2nHBs4ChsPxvB7l2s+KjDXCQzgWBifZPUKdUZaymEK3rzL4YfyE/YVcb
         wdUXNry/hUNf37myyaJ5aVN5AH5zMrAjuQr9t9NgYyiIAQlCt9I/ToA8ps0YKSApXFqP
         NwXFRva5Qhl0exaQsNAyDLmPzxRW4FPqRrqcPQzhbhw4sIEW3deaimQBK3bUl4fK9aRf
         E+Bw==
X-Gm-Message-State: APjAAAVsePnY3Rf1KkKG0SaMstceCeX4ywmgIfk/eRRtZFjiCJ5ycWLm
        N58lxL1dbmo4O8lg1yD+NQltYVx3tbA=
X-Google-Smtp-Source: APXvYqxWd3B1Kh0VkZpObuRf3P7sB5FCpNx++dFCGr9oaRYLRlt+ovsV6co822Rd0vKVV5iiIzk5Ug==
X-Received: by 2002:a17:906:b203:: with SMTP id p3mr19660586ejz.223.1562652920364;
        Mon, 08 Jul 2019 23:15:20 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id q21sm3962635ejo.76.2019.07.08.23.15.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 23:15:19 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id p13so408797wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:15:18 -0700 (PDT)
X-Received: by 2002:a5d:5012:: with SMTP id e18mr12159590wrt.166.1562652917666;
 Mon, 08 Jul 2019 23:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190620073505.33819-1-acourbot@chromium.org>
In-Reply-To: <20190620073505.33819-1-acourbot@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Jul 2019 15:15:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cn9GzXEj+tBtJsL8GXouJEyj+HSUng5StqNsCxKZK9yw@mail.gmail.com>
Message-ID: <CAAFQd5Cn9GzXEj+tBtJsL8GXouJEyj+HSUng5StqNsCxKZK9yw@mail.gmail.com>
Subject: Re: [PATCH v5] media: docs-rst: Document m2m stateless video decoder interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:35 PM Alexandre Courbot <acourbot@chromium.org> wrote:
[snip]
> +Initialization
> +==============
> +
[snip]
> +5. *[optional]* Choose a different ``CAPTURE`` format than suggested via
> +   :c:func:`VIDIOC_S_FMT` on ``CAPTURE`` queue. It is possible for the client to
> +   choose a different format than selected/suggested by the driver in
> +   :c:func:`VIDIOC_G_FMT`.
> +
> +    * **Required fields:**
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
> +
> +      ``pixelformat``
> +          a raw pixel format.

We should be able to set different width and height as well, to allow
strided and padded frame buffers. Otherwise we wouldn't be able to
import DMA-bufs allocated from some other sources.

(FYI, I've posted a similar comment to the stateful interface too.)

Best regards,
Tomasz
