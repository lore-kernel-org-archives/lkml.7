Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512BFC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1611120872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559725064;
	bh=c0YEsqOYSkHPRoBUDuZFnNT2TV2vkO/fBx9LryXQQZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GUBLih7blSMGGwDkj3trUHPs5Ix902Pj67owj8zrnabfbhsrBT772VBchYiJvT5jn
	 Hxz4Y/afi9OowpuQJX6EeUYXPJlxzDMiHu+qpJ5sQo1OrWoJ6afqCsZZOAMsLlrdW0
	 GSontaFvFJe5I4aziDhQ2m7p0T3dXhgSI9Vi+LhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFEI5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfFEI5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:57:43 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135622075C;
        Wed,  5 Jun 2019 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559725062;
        bh=c0YEsqOYSkHPRoBUDuZFnNT2TV2vkO/fBx9LryXQQZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=teZM/VNmaW2NHqGV+N5r5iL6lXUjHQig6NHWnNF1S4mYmzsi4NjAF+fDOk9ojtHv/
         25WU1Ez7qjGG2oOTnK4qQ6beAa8EzJL3ZIvJGdHCforEvAOk3AV311Tb0ce+T3SpAR
         Y7j7xuy/LI67Ly841xOLS0ynRGXPJp0OtJa5QCRg=
Received: by mail-lj1-f171.google.com with SMTP id j24so22436407ljg.1;
        Wed, 05 Jun 2019 01:57:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXX8KtjYKOl8qzbP1TH2BJSO/F+OW8cJfD8+/sHWKUohKUw+PWM
        qI7EINhyRdVmIeq3IrvWq+ZSSaqdO39ek/3YSlM=
X-Google-Smtp-Source: APXvYqzWe9Tothd6asG+gMZd5Vz4a7A8Pf6iNjr+UUtXa6DLhJ+wX4cCJAUOiSl2wA1tKPJahmNyoUGCdoEKUu6MJcQ=
X-Received: by 2002:a2e:424c:: with SMTP id p73mr2829347lja.216.1559725060311;
 Wed, 05 Jun 2019 01:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
 <20190503204958.GA12532@kozik-lap> <20190506130046.20898-1-m.szyprowski@samsung.com>
In-Reply-To: <20190506130046.20898-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Jun 2019 10:57:28 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcCL6i5RYbKSrLVL+U4bEP-cUvOzdZLKONqOcRBudUPYg@mail.gmail.com>
Message-ID: <CAJKOXPcCL6i5RYbKSrLVL+U4bEP-cUvOzdZLKONqOcRBudUPYg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 at 15:00, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Samsung Exynos SoCs require to force UTMI width to 8bit, otherwise the
> host side of the shared USB2 PHY doesn't work.
>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif with phy_utmi_width")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
