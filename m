Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6700DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F21E218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFOEFOiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGCJTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:19:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfGCJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:19:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so1372022edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVFrMDI+TIQ3EAjz/kn7jqtoTqpSeOgOSw47GSuS08A=;
        b=QFOEFOiXZa43v38UtHueJUcH0w9gOYmIWxCxcVuK3nnhCkiBHsHLpKr5NA2tsftAxe
         C0V1gkqEBj6kU/wKk7dtVKcDF2g6/jxsek3TMFLLFbvZ+38n8KMQmmXWDOfJXnwZewvj
         lyVZbNq9k7tamV2vzKKpHClJWsyldODbNmgqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVFrMDI+TIQ3EAjz/kn7jqtoTqpSeOgOSw47GSuS08A=;
        b=OHsf0+haYsYVsStVTi11E+hG5JU36XudQ2d59Pysfy2UNdmh3GEKBVwfkx1z+3KhFu
         Ew+gnDXH2wLg1xeWoRb3Fpnx2FvqtXvEKoRw0Q/qD3zy99pN+uc/AaLmGtIiuXuFaVMW
         d0wZqE+Fov4UjSxzNPs3/RVu1kKSMX3Y2KRDLkWmqSm6KBAyYk/jrR5XYDfmyaEusoMY
         v4NWHrzn9iiyhxUu4SrDmhSM8kb+eANO4ZjVmPWtw85HVp0aO09e4Si4rKzGa6NAGG4H
         z29R50JzatMz/kmuXoZcl5lnoKYD5EJEyfygyBTs+yfWJxyia5JybnB5OUb0Ho4BVmHz
         QcPQ==
X-Gm-Message-State: APjAAAURJ/FhYZiEyLDYKdwKicggNNHPYHk4vj3OjsOrIUyfcJWQdICM
        BM70ShzFZ30ricGotFBKwmkEMWbciyM8+Q==
X-Google-Smtp-Source: APXvYqzfhvq7qIKgp/CLPuUQJZoFowFmnhNzLbzyZH0rZtyXAS13R0O4qyUliecDZiRbn7fd8IpIgw==
X-Received: by 2002:a17:906:ece1:: with SMTP id qt1mr33789371ejb.171.1562145585610;
        Wed, 03 Jul 2019 02:19:45 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id jr20sm333754ejb.88.2019.07.03.02.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:19:43 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id s3so1411173wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:19:43 -0700 (PDT)
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr7659213wmj.64.1562145583298;
 Wed, 03 Jul 2019 02:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190702170016.5210-1-ezequiel@collabora.com> <20190702170016.5210-2-ezequiel@collabora.com>
In-Reply-To: <20190702170016.5210-2-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 3 Jul 2019 18:19:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CG3LuT3tq40USFw4D7gkN_zP1j-YY+9JTqxoBjrGOwJg@mail.gmail.com>
Message-ID: <CAAFQd5CG3LuT3tq40USFw4D7gkN_zP1j-YY+9JTqxoBjrGOwJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uapi: Add VP8 stateless decoder API
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Wed, Jul 3, 2019 at 2:00 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> From: Pawel Osciak <posciak@chromium.org>
>
> Add the parsed VP8 frame pixel format and controls, to be used
> with the new stateless decoder API for VP8 to provide parameters
> for accelerator (aka stateless) codecs.
>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> --
> Changes from v1:
> * Move 1-bit fields to flags in the respective structures.
> * Add padding fields to make all structures 8-byte aligned.
> * Reorder fields where needed to avoid padding as much as possible.
> * Fix documentation as needed.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
