Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE52C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D125218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564138501;
	bh=QcBqmWT1eDFbfXvQltSJTXQK5VgWFDe6L5qUdYNzU14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2NjN+Dw+bTqiDjKU7WHR/96aZbv01svQtX+SrkUMM136gef0dKKsfVb/FWCldr3FB
	 IvKJ6igBmnDim6ROwuFSKq3hPovRYXLW613FLGhefC3Tfc7jV3LI80hVT59YnNtU/r
	 DmaKIc+kHDDLRCkE4sm44zaF3pea3uYtEF4dvFwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfGZKy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGZKy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:54:58 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646E322BEF;
        Fri, 26 Jul 2019 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564138497;
        bh=QcBqmWT1eDFbfXvQltSJTXQK5VgWFDe6L5qUdYNzU14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kDX1jvTAaFmwAHF6um8LZ858MvupTznpm2wUipBN5PeE3H1947MUCSEAVZ2Nvbc4F
         tgm7iWphS/2V5GzQzjmZNPinPrJyBl1SbYuJnfvi2Zpuz0G0VnY9mE8hCnhjQV0yza
         V5HQXd+UartsYT3UBHwR+RoelE+NSohHyQtFVEx0=
Received: by mail-lj1-f171.google.com with SMTP id x25so51120090ljh.2;
        Fri, 26 Jul 2019 03:54:57 -0700 (PDT)
X-Gm-Message-State: APjAAAXXpnxF4BiNG4Xt8MXYIsZI+mG3T1UHSbb684LcZDraa2+BZtkJ
        frWwXAwDAQqheFkeWxHWSV2PiM4GLpTh6sQiV5A=
X-Google-Smtp-Source: APXvYqxTlRzDSn9sbhFxeql0yCfXveBv7a1iK7aO3MeMerFVnh2aP1/nHaikwd3WzBomLVdxTjE3GlOxz7unJ0BF6jw=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr49683952lje.143.1564138495608;
 Fri, 26 Jul 2019 03:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190726081505eucas1p22472e5d1e81180b7bca4f0c0af302af5@eucas1p2.samsung.com>
 <20190726081453.9456-1-m.szyprowski@samsung.com> <20190726081453.9456-2-m.szyprowski@samsung.com>
In-Reply-To: <20190726081453.9456-2-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 26 Jul 2019 12:54:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPceXJ4UPu9HDAy5rb0zqfe98YyS0pXCNMiT4zjjxQ0+nQ@mail.gmail.com>
Message-ID: <CAJKOXPceXJ4UPu9HDAy5rb0zqfe98YyS0pXCNMiT4zjjxQ0+nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: switch Exynos EHCI/OHCI bindings to
 use array of generic PHYs
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
> Commit 69bec7259853 ("USB: core: let USB device know device node") added
> support for attaching devicetree node for USB devices. Those nodes are
> children of their USB host controller. However Exynos EHCI and OHCI
> driver bindings already define child-nodes for each physical root hub
> port and assigns respective PHY controller and parameters to them. This
> leads to the conflict. A workaround for it has been merged as commit
> 01d4071486fe ("usb: exynos: add workaround for the USB device bindings
> conflict"), but it disabled support for USB device binding for Exynos
> EHCI/OHCI controllers.
>
> To resolve it properly, lets move PHYs from the sub-nodes to a standard
> array under the 'phys' property.
>
> Suggested-by: M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt    | 41 +++++++------------
>  1 file changed, 14 insertions(+), 27 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
