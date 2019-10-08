Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D4AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DF021835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G9y99tj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfJHR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:29:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39798 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJHR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:29:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so14713589otr.6;
        Tue, 08 Oct 2019 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKu2yueVNgRFpAUd8185a7uHA6JiCaBaoe2JcBRlEts=;
        b=G9y99tj3v+V4iLG0bqYPs3+tPbnpm+K8PGhBA4ulOWisBfs2mqDJ5CCVcxua9X0Bzx
         TVb6f0KBhJy1bc0l/MMaIsdrzarm2gYuYU9syVv1oPFNOeThISGEZ7Te3Nl1Do4fcAts
         6aNd2x2aW8/U3xy9lGvYlbPdehJm7w5ixP6MhLXb6OZ4g6U97xVFakR9uCo7wfBxUEvM
         CVsTNGDcMCWPv/2wa7pmOUIdy3fSENuSbsO9XA2/gPYh8ehyc5qK0NkzRqq1oUdLiifS
         oZae8ODfAnBk743TO+QxLUlcXA+oX+61WnMPrOhKnethMHPGIsmV2T15IM39OkAhV1fQ
         KZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKu2yueVNgRFpAUd8185a7uHA6JiCaBaoe2JcBRlEts=;
        b=PibE6gaFBzWHxllaDQO0g42te3HDeETeiIlC6d+4GvW/lSAVjNNwzFDJu7zDDaZxbJ
         fEMdjSU2V6FrayI53YwVj9KcWYCql5WmvYm376NSjglJou6ata1FMXFovC2I1AZq3ont
         BM53E83DRfW5KBbu4/pBWPMLRO0x6LNf7An3m2hDi9vTnG5bQYN8kHKyp2fd8Lbac7uu
         jR4XsbYQLaSJLROlDD2SFfm6Bi8VRNmUkv1wAGTiydbU/WNG24hQOJ6mlJpPds1S1jph
         /dWK+6i6paP/VCV3VpSG6yXIcRBaSf1VNdYESe69LlWJXtyLtukyWO/EIBe4z/nTjVbf
         ZtdA==
X-Gm-Message-State: APjAAAXvymCD9bnjnbEq2KQqBIDaWMkxcmGT3dkzPxp8NduxYiPXPSmK
        r+3p4HHGgoGoCjQJyh1m9xlLYFYD3Icn+1FN15g=
X-Google-Smtp-Source: APXvYqzPWuVdtFGE/YccaquQ9QBrKyV7COFmAU7bcwEA7+/a8q74QRmUfb+jPHM6v3jDSj1K4d99J4XdiezQ+Ultij4=
X-Received: by 2002:a05:6830:150d:: with SMTP id k13mr25811500otp.98.1570555778900;
 Tue, 08 Oct 2019 10:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191008102751.GA10401@saurav> <7h7e5f5lbd.fsf@baylibre.com>
In-Reply-To: <7h7e5f5lbd.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 8 Oct 2019 19:29:28 +0200
Message-ID: <CAFBinCBxwcuSd7RYpJ0PvLM3-O1SHuXsbvaLFwO48z-hRs+hsQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: dwc3-meson-g12a.c: use devm_platform_ioremap_resource()
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     balbi@kernel.org, Kevin Hilman <khilman@baylibre.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurav,

On Tue, Oct 8, 2019 at 5:06 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Saurav Girepunje <saurav.girepunje@gmail.com> writes:
>
> > Use the new helper that wraps the calls to platform_get_resource()
> > and devm_ioremap_resource() together in dwc3_meson_g12a_probe().
> >
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
the following commit is already in mainline:

commit c6e4999cd930b8bd11dd8d4767e871b47f502845
Author: YueHaibing <yuehaibing@huawei.com>
Date:   Fri Aug 2 21:04:08 2019 +0800
   usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code


Martin
