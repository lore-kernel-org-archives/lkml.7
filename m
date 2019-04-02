Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00031C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AA720833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554169654;
	bh=24/yeMM4srSefdz105ZIJ4vWynMZvRgIsKmpPnd9QRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v6FHxpnqRL2Dhf2tykBPG2cr8li2w5qFquFmuzBmh34L/zavI3Wbr39r5ISOGuwBw
	 Pwocj0LeR5HV5cC7FzaGRtCHf1jqG2YM2YiXRsHHUca01LVP75nK0Q9dU4mYG1Equf
	 pOmfCdvsS/MRyB/utZu/Ig5NOzL0k9BlBeuvGrGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfDBBrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfDBBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 21:47:32 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B256D2147C;
        Tue,  2 Apr 2019 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554169651;
        bh=24/yeMM4srSefdz105ZIJ4vWynMZvRgIsKmpPnd9QRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KLnIbom/vPpkBcgaNE5ZPeHkG5saqMWtoRjVB4yEY5lPuaqupeKtakbr8EPy7ZQ2h
         5Uz1B07sF4JoQ3jozu6md8LfukxUglwt6i9W3Qsu6w12rXWbWuxIrWsbxmj70JHkB/
         Yeql3DT+gDgAMdz508FSr3pzoj4LVYfq+s0lvBeE=
Received: by mail-qt1-f173.google.com with SMTP id x12so13404185qts.7;
        Mon, 01 Apr 2019 18:47:31 -0700 (PDT)
X-Gm-Message-State: APjAAAU7KMnB8N9zXIpw0ykcgWA9cCR4l3gTUgO//AUaZAUvPUKw2elz
        0WDuKK32BmX6fhMofv8k7Au1JnpCXtgLjm3B0A==
X-Google-Smtp-Source: APXvYqyBxdS/DHceiZeX1gTgaLZ8ZsItOJgp2eKTqwQARHmrmL97B9/Hte3BxjvZyvN2gqJf7eXBmixsw9xu1iK9ySs=
X-Received: by 2002:a0c:c950:: with SMTP id v16mr54860654qvj.204.1554169650985;
 Mon, 01 Apr 2019 18:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190401173353.g4k5vb6flsfgtaaj@arbad>
In-Reply-To: <20190401173353.g4k5vb6flsfgtaaj@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Apr 2019 20:47:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxdP=Xthpzg-stxKBLmA6RQffCVJh3ot-NDkMdTxPEVQ@mail.gmail.com>
Message-ID: <CAL_JsqKxdP=Xthpzg-stxKBLmA6RQffCVJh3ot-NDkMdTxPEVQ@mail.gmail.com>
Subject: Re: [PATCH v2] avia-hx711.yaml: transform DT binding to YAML
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

On Mon, Apr 1, 2019 at 12:34 PM Andreas Klinger <ak@it-klinger.de> wrote:
>
> replace avia-hx711.txt by avia-hx711.yaml as yaml devicetree
> documentation for avia hx711 iio adc sensor
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../devicetree/bindings/iio/adc/avia-hx711.txt     | 24 --------
>  .../devicetree/bindings/iio/adc/avia-hx711.yaml    | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
