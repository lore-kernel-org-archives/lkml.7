Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F92C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D76121994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564138819;
	bh=i7Jv+hmXcDo23S/41bZqkwblKmiu8ujCGUBjwwXkgyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A1JYz58BX+ailrsjue3MME341GM1O5qln46oLhlSNfj+Zy6UrQqa4iAjuFIrTrr1J
	 ZpcNlksWNDYvNgPsz/fAeiV2N/6g5Iyxxp7QKP51LqcIIcnde4C3MoVzVXX83aWgE+
	 3J+YRPb2RmfZ727Ub8GNRGMXAYOyhMyM5kExKD3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGZLAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:00:16 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4697D22BE8;
        Fri, 26 Jul 2019 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564138815;
        bh=i7Jv+hmXcDo23S/41bZqkwblKmiu8ujCGUBjwwXkgyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4IEBPKR/Lciqf1UMucQfUMvmavvkwQlRphFXnvYqpNlvPccVIHEhplBGZL1h4Yhb
         OBnN3Yc8QiRRucyn8zerHxgil/jPSPB9celT1zwCovCbmMMUCJkFCJn+lYUIWL+/4W
         hBClJ4NC7naV5LjVZgA0POAvxBFj8jkrlx7jyXSc=
Received: by mail-lf1-f42.google.com with SMTP id c9so36746018lfh.4;
        Fri, 26 Jul 2019 04:00:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXXwpxFjDLqYgyhQmyaHR1MCzXd8EGkjBttJ1TvGJY/Ctx2qEYa
        TrKiSS2ZKn13k1tIhfsFUbxtvofFUHOFFEjN/eQ=
X-Google-Smtp-Source: APXvYqxiPnbM3nCACHxnT20KdTP4mvzTb2t9ta89yEo/4pk1w14sOxpUlAKxoYBFtMwLQbX8e1ZPaZeidwzTdl6YbF4=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr43199380lfa.69.1564138813527;
 Fri, 26 Jul 2019 04:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190726081505eucas1p146c14eed320c57050aa968b7c97b227b@eucas1p1.samsung.com>
 <20190726081453.9456-1-m.szyprowski@samsung.com> <20190726081453.9456-3-m.szyprowski@samsung.com>
In-Reply-To: <20190726081453.9456-3-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 26 Jul 2019 13:00:02 +0200
X-Gmail-Original-Message-ID: <CAJKOXPddpDso=Zjktwm0ofLe20o_FHD4REtuR5dEG64ttVwLEg@mail.gmail.com>
Message-ID: <CAJKOXPddpDso=Zjktwm0ofLe20o_FHD4REtuR5dEG64ttVwLEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: exynos: add support for getting PHYs from the
 standard dt array
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 10:15, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> Add the code for getting generic PHYs from standard device tree array
> from the main controller device node. This is a first step in resolving
> the conflict between Exynos EHCI/OHCI sub-nodes and generic USB device
> bindings. Later the sub-nodes currently used for assigning PHYs to root
> ports of the controller will be removed making a place for the generic
> USB device bindings nodes.
>
> Suggested-by: M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/host/ehci-exynos.c | 23 +++++++++++++++++++----
>  drivers/usb/host/ohci-exynos.c | 23 +++++++++++++++++++----
>  2 files changed, 38 insertions(+), 8 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
