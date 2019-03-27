Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6251C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9838921734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692411;
	bh=ldyO8hXl6NzVcqV0X1ccrFDZLQrtwPRyFbaP5VC0zIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PGxS0OtBYlRtk1vM7E7yr2sIiKrscd7p32wFlZpNGQYxMKPRO9t2aUkKqfIVM76ig
	 73OEW1DMpiwADBshRlfDFLQGK11oDi3MH7pJbzKRBASCEVQcphAPm9IAedt0qvgTpo
	 YENoQ3rn6P25IL7nX5/VAYMSQ5RZpJJClyUZfMvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfC0NNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfC0NN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:13:29 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BA221773;
        Wed, 27 Mar 2019 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553692409;
        bh=ldyO8hXl6NzVcqV0X1ccrFDZLQrtwPRyFbaP5VC0zIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvwsQFJTuDVfa0jegPO6stpVEPdegcd4DGBpNy01AP+MmfeXwG9taBFRCzQ2xwppB
         dYWXqjcCAOOIBES4HAy/gHp0udoDplgKGiF7wxMMKQQEQ5M6VAbiM0IW6g+Wlfxc9q
         GNSbnORYS3sEDElxYqJFwykSx6SCjNIM6kLhd3Rc=
Received: by mail-qt1-f181.google.com with SMTP id d13so13999367qth.5;
        Wed, 27 Mar 2019 06:13:29 -0700 (PDT)
X-Gm-Message-State: APjAAAU2rETCSX6KsC8WKgaiUiWiGN3QyrkVv6r4aLCIsxm5pxgMRjJU
        lPcxcWheIRwBEz2J7pScbKtQKkHhQYSkisZRwg==
X-Google-Smtp-Source: APXvYqz8FVRPXTmPYEoUGBnOPU0JvMFcTskTfjhJQPvgWJY6PudZW1ULZBglipzA6zR6RS1csLuD+qXwHjzp3eo9BTI=
X-Received: by 2002:ac8:7647:: with SMTP id i7mr29089899qtr.38.1553692408279;
 Wed, 27 Mar 2019 06:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190326133938.oitfjxlx2kou26lm@arbad>
In-Reply-To: <20190326133938.oitfjxlx2kou26lm@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 27 Mar 2019 08:13:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKV1Qy05oX9wm+Fz1HAkAEe4gE3whCNvafPfxsg6hgp8A@mail.gmail.com>
Message-ID: <CAL_JsqKV1Qy05oX9wm+Fz1HAkAEe4gE3whCNvafPfxsg6hgp8A@mail.gmail.com>
Subject: Re: [PATCH v2] devantech-srf04.yaml: transform DT binding to YAML
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 8:40 AM Andreas Klinger <ak@it-klinger.de> wrote:
>
> devantech-srf04.yaml: yaml devicetree binding for iio ultrasonic
> proximity driver of devantech srf04
>
> use devantech-srf04.txt, transform binding into yaml and remove the
> outdated DT documentation
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.txt     | 28 ----------
>  .../bindings/iio/proximity/devantech-srf04.yaml    | 59 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
