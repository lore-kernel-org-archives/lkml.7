Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C16C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F28820850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sMJt7uF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfENSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:13:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44839 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfENSNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:13:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so15920787otj.11;
        Tue, 14 May 2019 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyGqEkYvn3BjYrUHlUmuJ5keO+5aqjugox8sRHwUIKQ=;
        b=sMJt7uF/4MNIcXxMXbk2JGh9sK1ZuIkDIyJcENl1EXYhzKzodF1+ugcoWijVBgq+i8
         9EhD8c5zI9PaWrG06IIKSesXQ0MoUwdjL4UipV2+zYdA8XqkgsRMXtyKaljBghy2R6Ym
         YJACxzNY2afZNBKPl0H8CEVcVdKZRazC9WYzgVJQ00NYkrfHKHRFYAXIoV4CNjbfFG5B
         07M/t4bMdKWo/yxz464eIynQQPJZMaYkQyP2bI4BriaD64C9EmnziZMLV8jootQU8J8W
         WOsTK7N+x8ilXKC9COudzpcDlYC+mWifszg5v143FlGiIaiRMDUcntuzNrrTIhcY0rD4
         sFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyGqEkYvn3BjYrUHlUmuJ5keO+5aqjugox8sRHwUIKQ=;
        b=NJpGG7QSrTAsBwt5Q6ZEmriD1yf1eP2yQTGJYHi8NWVRNfWm8AcmywRYONguULaZG6
         JsULfMCWtVFAgYUMsd1ur56GNU7jvI+gPvp/bforQMXYeam8wg8j7+75c0Eq9rwRBc/V
         mdn4nQAq+7bXLpJg5DuH471UP+Hvxd2mDGnj7TH+ycRi4lnVWCuDts93Arq0g8BHslHf
         +QsIJfo7VoXB+6MleQ+6FFq5dQLGBLTczdUcJGeB3Gj+JZsrw0+3r8yFPaBnhAN3ROSQ
         B/sVOkF9q4C9ffuphv1nERftp8LOLT+akpw1y+X1JaGjxNwu3LtPNjvosiKCDXwL+n8N
         UU/w==
X-Gm-Message-State: APjAAAXM9QcB/BISWMJE8dY3mjvXiZru/x9FSFkVtrXM5/GluqzUrLAs
        XieIH7JunRlxhdQsNLBRnttDxcRrJksDcqzhaKY=
X-Google-Smtp-Source: APXvYqz+CMQFl/iOZjK2ovpb8x50ggC+uyHiRTZ4z3hnHfRgzwsvxnfKT1wYL9y9zA8iIXUs4gGObTt3HYxN+WCmozs=
X-Received: by 2002:a05:6830:1182:: with SMTP id u2mr11543945otq.71.1557857634583;
 Tue, 14 May 2019 11:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190513124531.20334-1-jbrunet@baylibre.com>
In-Reply-To: <20190513124531.20334-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:13:43 +0200
Message-ID: <CAFBinCDASu9_wx+hhyqYBb4=m=oxcgJv=UcBpPXhfj50p+gkCA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: meson: g12a: fix gp0 and hifi ranges
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:45 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> While some SoC samples are able to lock with a PLL factor of 55, others
> samples can't. ATM, a minimum of 60 appears to work on all the samples
> I have tried.
>
> Even with 60, it sometimes takes a long time for the PLL to eventually
> lock. The documentation says that the minimum rate of these PLLs DCO
> should be 3GHz, a factor of 125. Let's use that to be on the safe side.
>
> With factor range changed, the PLL seems to lock quickly (enough) so far.
> It is still unclear if the range was the only reason for the delay.
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
this matches with what Amlogic does in their 4.9 vendor kernel from
buildroot-openlinux-A113-201901:
$ grep -P "\tPLL_RATE" kernel/aml-4.9/drivers/amlogic/clk/g12a/g12a.h
| cut -d',' -f2 | tr -s " " | sort -u | head -n5
 125
 126
 128
 129
 132

based on that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
