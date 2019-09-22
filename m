Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F9C4740A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D6120C01
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcjrmN2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfIVCrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:47:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33031 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfIVCrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:47:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so3631366pls.0;
        Sat, 21 Sep 2019 19:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8k0SwpGf5Bb8pzeQ49ciEIxov4dZSC0LkZDesCWc830=;
        b=AcjrmN2xrPN9Upj5EftARXS0NiQknr5QW7pGihwKqAozuz7D6ABrCXROlyDdMBh1hE
         QuzT5wP4Wd1IgptjUpWKgonUBYHC+t8iw/rs0bD50f1CJBDpelF0gp9ybf/7vwv/WSDw
         4mkZq5pOYjpUgW+mXbxSFMaVlathPEZhlbDOb/cDAycP8c1aX3A6V33vL9Z0eDre9122
         LAVEzkK1ZvTi9A6UO863BAIa+IGeQqUIWq1pI81612envXbi95/WKPu1x9pLgFrTrKet
         wpR9qTzIqe+bczwHXrQtCIjwXF3YyUZBR07776ZJICjmOLxU4lHNGBPnczBgS5RVmOql
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8k0SwpGf5Bb8pzeQ49ciEIxov4dZSC0LkZDesCWc830=;
        b=qV6X+q2XxTNIVKplzo0CVVfFXOooXfYZkycA/2DJUhWpZyztG5GpDZk6y/32KT+PCQ
         IxifJRKKdIipSjXU5i83MqaZoLFmBKTv8rUJjV9EQFRBS+5R7xIfxl7W6nzPleHSVWsg
         u7YaoPnuHulZIkE32g+pGwjM6p2tsdCGnL+TWl10Se8ft8HTj99FbP8K1FgdCOZFAx+H
         nO4koKptkEi4eCvaAuJjErtULL249c7U8o+Ty7rM5Ddf1opAfrvGVs7esmLwUHMRhR7v
         vms1eART8VBrBJuwqfmnXbklg5PWubSrYaYTbOx+IDFkVqryzzdKAtEa1/k3NxJTo9jq
         rHIA==
X-Gm-Message-State: APjAAAXnse0LZJHjkUSQVMtPBmeb7lwzurZREKN8LnvmTFWLJW5GBtzV
        hrXpO1BcOlAw+Qk9FT8sYAR8Q1e/08ZkUONVItle+VgN
X-Google-Smtp-Source: APXvYqxuSbvo8IzNwrx0Up49F1PB+SWNCpx3+hjoX/VlOQO5BjNa9BTGAvtN2Qpck5ZddS1+RJgj/wZOzG8Yn53O6jI=
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr24144340plq.274.1569120420100;
 Sat, 21 Sep 2019 19:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <8c17a59c-82ff-aa6b-5653-a38d786d3e83@web.de>
In-Reply-To: <8c17a59c-82ff-aa6b-5653-a38d786d3e83@web.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun, 22 Sep 2019 11:46:49 +0900
Message-ID: <CAC5umyjWuFH4iADS=_KYWsL=osdw1o56cdabjNftgSDsXzzLUw@mail.gmail.com>
Subject: Re: [PATCH] rtc: r7301: Use devm_platform_ioremap_resource() in rtc7301_rtc_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B49=E6=9C=8821=E6=97=A5(=E5=9C=9F) 20:49 Markus Elfring <Markus.=
Elfring@web.de>:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2019 13:43:07 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
