Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA40C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AAC20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RjgAPfvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfDRUVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:21:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46908 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfDRUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:21:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so2567277oia.13;
        Thu, 18 Apr 2019 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtGQ+YEd9cFM435Y4nG6uPQp+65A7CRaSBJF8Tu+rlg=;
        b=RjgAPfvZR4pQdg/P2es0HvdZ8Zt6/zmfZjbXp8pdapFsXaBFdOhEdUWSmoUFEj8T5H
         SOBhKgFOc5iOhsaSyAidTlCHN0rVFR0y8D1MWPg1Ay8SjrF/gV2TZ+40mDZr0KUx4/eN
         FINAJD9jIcR+Lyph6rO/xRRgnSQoY7EjkOJXroxIGd5lDyMrnmjJnQHMj+Wzk9GUg6PM
         vuctQqUVpCS29vzgIFTDMImgA5TfDlaLLI976J83QAlQqNGiC4SZ7XgGVbZyHCP1Afm6
         Uv9WpnNWpP6snYDC6VJc5Gcfs3Qw9NyRspVFpG453+odRmJTEuJkRgmDUqRiy/rfoFAD
         cjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtGQ+YEd9cFM435Y4nG6uPQp+65A7CRaSBJF8Tu+rlg=;
        b=da4kEfCSE3agcXK2xDc/7hmSzQTlIFDw8GixMs09pfOELSzamoD3cIt0aiuwu879A6
         U7Uh6ldEyUZfa6niMNb1o3hSzxQusW7wdQU75exMUee0Kp2mOR2rmizxh3EXFa2P26qO
         4RJ0MnkUkqAINhYRc53FvjgAiUbDBJ0ZC7W3wvlV5WMXsxU7FiQLaR9S26qJjTTkIhQr
         8A+H29L9k0jNnVdAY9vpzXYEzeW2fnjpPysNiQrR7Ozdj7pNykbExO0bnv7uPrPnzwDW
         4LBwD3CYN5WQ/2IbF8LQpKtstnHlPzPMBUCVsrxFkMYRI5vNGXK/L3VIyGUkL6sO7Wu+
         JBpA==
X-Gm-Message-State: APjAAAUvqKeb7UIiv7RPEHAnsEw3FlwIkfp6slqCIrsBI7WFRZmF+Cvz
        VsW87Ya/YGINsqGQ4g3C0ycoFLkOpluL0HU3IR4=
X-Google-Smtp-Source: APXvYqyqGfVor5eXCaWPuNwHwDNeH/pBygTjaatZU2W9bXgOHtwfX01XA9J2zLcwKfgcdeR96LZUMRy5JBD1WhblRVc=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr3314934oif.47.1555618903942;
 Thu, 18 Apr 2019 13:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190418122714.30805-1-jbrunet@baylibre.com> <20190418122714.30805-6-jbrunet@baylibre.com>
In-Reply-To: <20190418122714.30805-6-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 22:21:33 +0200
Message-ID: <CAFBinCBtMbokg_Vsn4Q8Pc2q_hW-v2SHxg8qjdMKwCM8k3myAQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: meson: vim2: add missing clk-gate pinctrl
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:28 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> For some reason the vim2 is missing the clk-gate pinctrl setting all
> the other board have. Just add this missing bit
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
