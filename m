Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB8C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD68B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xSTOh9h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHLQbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:31:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53526 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfHLQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:31:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so126537wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7j2F6czmvL1ihv3E7n7MMuOUAa5rNveJU7g593UBgYA=;
        b=xSTOh9h2HX4eRr/sFVEwfbnUvN24DujY5BIcNJrS8ivVAR6KMTWJ/ODWqQXBloN/jK
         z/XY2ixB+QMFtF0BLRbNSzSwRkyzcSXSXgWNBjcaF1mI9AaGtSexLw18VhF9X1SySAsY
         wynbSdt/jvTDFZkKTDx6B/u1LupR6bRzT5md+cGGgrkRNhvEbiHdHwhsbQ/ylF7TPebN
         gKiWtFddsM80lb1BkTKx++1N7O58a5UhkYM8AZjfqwnwm3Z/1SRF9fIkbeb5wrPkKy9W
         DkstxnclguamE68bROEp5JsalTxz2zlCJTDuRzy6UJF/bYrYmzf80dRMcooY8DeHBCPN
         bDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7j2F6czmvL1ihv3E7n7MMuOUAa5rNveJU7g593UBgYA=;
        b=OguCEVUKdG0Se7enkG6ClEG84vuOYjRqpmsFCm/m/TRWHqWlINWD1Z+W1FqHxqshgk
         O/kblG6BP/PJwTZftG+iPJwWty62J91jiYxiCAKdnOKGqh7lo/lGDMwrv1axxqg63cZn
         iWSsTwoZoUKni/YpmHAOGw8kftpB75kkGMlkroFggR3GxfhIvGCtiSl5cXgl0Ui455QM
         l1WhSVMKdqvmHwa03IKnk/LcPbf8YTc0QJSYFZGmKcc+trxbwRYEzJpK41qiWBAuVIbR
         gK5Oae8WkkmDqSYfHYvGwqU7fPulyZ0qmd7+eDqw4I4UpgSyD9bp9I61nKCzzYDaPn2N
         8mLA==
X-Gm-Message-State: APjAAAVuYzgmqJOEoBC7XvkwH98jyS/NQJrXskAw8gQ1q/dPw+kVZZsc
        nDus5thVQ3qUF6VF2vDQG2RYgau7HwhSNgDoI6qFtw==
X-Google-Smtp-Source: APXvYqyBPrcQ6sKCBQ9GudU9fmlJm1BzQW1oNBg6A7HHuE1qGnnV3Lr+F7PfdpqBa1bRHlFWSF9yk1iPYMGg2B6knOM=
X-Received: by 2002:a7b:c04f:: with SMTP id u15mr165779wmc.106.1565627476232;
 Mon, 12 Aug 2019 09:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190808085522.21950-1-narmstrong@baylibre.com> <20190808085522.21950-4-narmstrong@baylibre.com>
In-Reply-To: <20190808085522.21950-4-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 12 Aug 2019 18:31:05 +0200
Message-ID: <CAMO6naxDkpjLTaByYBhkgP6i1YE1F1ATBAp8gPuVjDy9DAUM7g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Update with Amlogic DRM bindings
 converted as YAML
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 10:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The amlogic,meson-dw-hdmi.txt and amlogic,meson-vpu.txt has been
> converted to YAML schemas, update MAINTAINERS to match them again.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6426db5198f0..c55c18531cd1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5318,8 +5318,8 @@ L:        linux-amlogic@lists.infradead.org
>  W:     http://linux-meson.com/
>  S:     Supported
>  F:     drivers/gpu/drm/meson/
> -F:     Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
> -F:     Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
> +F:     Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> +F:     Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
>  F:     Documentation/gpu/meson.rst
>  T:     git git://anongit.freedesktop.org/drm/drm-misc
>
> --
> 2.22.0
>

Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
