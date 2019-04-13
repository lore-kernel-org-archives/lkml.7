Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2215EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4132171F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j718zd9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDMMC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 08:02:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34484 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfDMMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 08:02:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so10180488oib.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYW1l5O3FluBf8+XNARKHUH9qJumpHRGxiYJg+cTA6M=;
        b=j718zd9ijociYSwQhRpEiQC/8sCqLoJhrI/XIRABPfmVE90t2uL8UlrXRdw/TRie9t
         QlrBfrouQ0Y6RhoDC8XkYRyTPz/LQFYt0TANlUQp11NcAoULMdSmMBBCarw3IU2ggnBI
         AsKHgUMYNkyECx5T+L7h8mCllopo42N6V8OgN+had7EaaHOwrJkk9FUMTTvuFRLps+9Q
         YjLbFRPhjInUO69rfKeYKCbv0CwtSeacI2ePkcgSQpTNjnjDAFAX1DA7OkKdshdMhL7L
         EKQHGxbBEh8xSwsGk3FBV9UFLCSWDlhvg4gqJC1dt76Make8kzP+bW6I15jxctTaIOkp
         cewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYW1l5O3FluBf8+XNARKHUH9qJumpHRGxiYJg+cTA6M=;
        b=l69JjF1gsBTCP7v0d6vqF77b+AoL/Sd4gMLpsa31NWj9pSqUlZ7j/MUZMxqFCieh3q
         JDBivk/0dPf2VfRtN2eXj/2w37a3pWEAF0tXAvIU7LM2oe+DFw0VnB+rmW4mcukEsSJU
         U1tsQVYxcrDVuI5ywu+qfKU+N0fBkHalzJBr5jZN9hhTbGS3rtUByhDySdWHW5+bXfbh
         2UmUgiDwTSaSUl1jBjvgUEk0ovB2QxChA/GV9GiPAcocs2psPUgmt0j0YirwrYRmOdE9
         xMN/K5YJ7BfrIBWN1ePbgUVyksbZbiUIlYJcpIYC/dxqWC6CRzShUnBsMN+w0NPsj/wn
         ZxjA==
X-Gm-Message-State: APjAAAUH+wxxlOax93IKZLSWPjoUi9tix0gCeDql82pYNS88nI86fHSH
        z2c00fSR90JaZKYpFq/h4I5HBlEnGKTRoTSJf44=
X-Google-Smtp-Source: APXvYqzsKWcXSlWINfu/7neHTQkWozJwcAACSs3EG8yenqYsU7UgecbMArvvjB6K9A2LGvI0JPIguXUmwEVkVjUf+aY=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr13342536oif.47.1555156945654;
 Sat, 13 Apr 2019 05:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100518.24470-1-narmstrong@baylibre.com> <20190412100518.24470-2-narmstrong@baylibre.com>
In-Reply-To: <20190412100518.24470-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 14:02:14 +0200
Message-ID: <CAFBinCDoxuM18+rRm0BR5usHYpBACXt+HzC6o3TFU-fqi3kkQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: meson-g12a: Add IR nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, baylibre-upstreaming@groups.io,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Apr 12, 2019 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Amlogic G12A SoCs uses the exact same IR decoder as previous
> families, add the IR node and the pintctrl setting.
as far as I can tell there are either two IR decoders or one updated
IR decoder in G12A and G12B.
I'm using mesong12a.dtsi from
buildroot_openlinux_kernel_4.9_fbdev_20180706 as reference:
  remote:rc@0xff808040 {
      compatible = "amlogic, aml_remote";
      reg = <0x0 0xff808040 0x00 0x44>, /*Multi-format IR controller*/
                <0x0 0xff808000 0x00 0x20>; /*Legacy IR controller*/
      ...

the registers which you are mapping are for the "Legacy IR
controller", so our existing meson-ir driver will probably work (I
haven't tested it myself yet).

can you please be explicit about this in the patch description?

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
apart from the description you can add my:
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
