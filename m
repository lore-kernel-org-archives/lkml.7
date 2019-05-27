Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF40AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A68208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U4DCnRER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfE0S2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:28:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42855 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE0S2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:28:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id w9so12454022oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wseEiwf2iDxEx0rB6+bstHWLvTH8+Jm8S/2DOnZEoi0=;
        b=U4DCnRER3Bo6N+YBQxNx5r8BgFCch9KSnniaEr49R7m55UNQtYzfvpxNgR0+hZ07dk
         ruQ0Sn/8fhPl2/tfFl6c2jn9N2fIdH+XhAAXLvCA4kqSAwyHFw7eHic6OZxxPXL+AE1k
         H3TbEeSrYrXRSTzCaxdNCYQ0h4NhvWgLwWh6D4sufX/FXiEmldm7jgDK4QKI/LSRyWYS
         Kz7OEw5lcbqIzeigKpu8jNJ9dCaIfJW8siWZZ8fDOa48812IBYJ/86Moowk9etD/dmWS
         S5P5JVOBPr6OXKKwv1mvSuuYYiWNywvQSa66j+CN+AuD7RqiRbn8xIhIzUjRjhHPuM40
         f0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wseEiwf2iDxEx0rB6+bstHWLvTH8+Jm8S/2DOnZEoi0=;
        b=DjRlJPPkmx5A+PeJFXtR268GBqKj/tvzkDNsignokCBJVNrfSLk/Q3m5RhyglsAo+g
         Um+a49V7EUr5Nzoa0mJUQoKqHW6dRfmFuek/6MN67MUy2Sxqz1djnIJi98KCqrjRcJ1I
         DlzGO57NlDy9TVKDfVDVh3w85tejbe7nW5ZMKrxovKALR2nJvCH1cM42mGZIatLIiGye
         seh9RcZnSBVNjgOW5SoRHkK0p/w0H+dYtGM0oJtrrng69GfYJ3liBZY9DVMkx0qgyTa0
         YvQCXzPKQd4A6KRROESjRHouX1hq929aJix66H1p0hmITaQhmrev2nsbJndWilmV9HfP
         B7dQ==
X-Gm-Message-State: APjAAAUtjvyw7UVohQC/i3R57SZWrW98pjKlDDnoUEQSHoFeDqlfDv7x
        1aGxpbj8vCMIr7KGmMuvarw7t4glOkbH/DuigiE=
X-Google-Smtp-Source: APXvYqwbfigH3TZlE9H2ckoSvg4wg8rLamp2jsQJnsfdYO0iUsmSoQWOoyFjfHYjDukhRzfcHFO1gwm7ahn3PyklXkU=
X-Received: by 2002:aca:f144:: with SMTP id p65mr194565oih.47.1558981680480;
 Mon, 27 May 2019 11:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-10-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-10-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:27:49 +0200
Message-ID: <CAFBinCBZr7nSnNTGO5upowuT48-pcR57VU7-zaxZ3Ocb-tZ1sA@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        christianshewitt@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:24 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Fix the SDIO WiFi support and add proper Bluetooth support on the
> Vega S95 board.
>
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I'm the cause of everything that needed fixing here. thank you for
taking care of this, the result looks much better now:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
