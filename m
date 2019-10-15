Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED6BECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA72067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1zG6Jhap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbfJOWkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:40:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51263 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbfJOWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:40:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so732635wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=iZRsPQdHp9SLgaak0uCg5zZVvF+bpajXIslG7GktzEQ=;
        b=1zG6JhapAFrNl9H/G9haIjwOSPhXxIzgd+JP8SxRf8dnolCqxWD1w6CO7HDJsTyypi
         +A6EfO2IJXDbdIdoYxIX3WO8yav7uD01sSFSZUD2HUCArC6u28MFvlqLS4IgjbGTLoFS
         O0kqSq6o1QnhEFkfh3asOqJLit5Dq6ibvv06O9x6Lut3VGsWFCT7vANBNOU1XDozmgtE
         rJWRhQwVKSRSCs1W2UVQrvoFSr0xaGywDweOnuNMkbJ07BLg+1sU37WWQqaMd6AZtSAJ
         otPBO3uDRRWfdhwm41enVEbzlXHiFNc5PhpDwEAMA/SMlOpClNF/+KO9a61XGhW9oBI6
         PP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=iZRsPQdHp9SLgaak0uCg5zZVvF+bpajXIslG7GktzEQ=;
        b=RAgdMKMMf4DHuq50BnV+SXkRV3YkTlZ2CMOP4Ucrgf9fvfgXUsuyrn0fVVyCbN3hDn
         hl/kVRxK4622lqIWzs3rKl6CoR/MsLFUBC6XSHFpoWi30BdTUqPmYrTySbTMXbbESrVw
         t/896BY5iW8NFkDKG1Sm5nsye01a8BtyszYKAtyy8skk7qjO3Z10PzcJEdJVv4OcH+pN
         jBU+p+/sBef3NWQljbdPmFyA6zfrtYck+YL/o0dfu3qCoE+6GAHsSO1Pj0p1e3xxCXXQ
         wKmpSqnERdEbG34dg4w7wuZ1/JoEWKYXPjZKB3wrrkVGYM2M9nkkCLRgLwB/c9Tp9vih
         n9bw==
X-Gm-Message-State: APjAAAWNcSM+MVoCzlh6l4yxsh7pGCiurEBWYYHwf8Mvrntd+GNkkZ0J
        fUMNtUYPrZ4r9432q6bLN0ddwQ==
X-Google-Smtp-Source: APXvYqxcr2ndTUnfFqjZeUrSWhp8vJGQEpy/4ricJO83dIPWdZTjkTrWK4vpO8W2+oYAH/slWJDg+g==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr711493wmc.78.1571179206429;
        Tue, 15 Oct 2019 15:40:06 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x5sm41120834wrg.69.2019.10.15.15.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:40:06 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:39:55 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        phil@raspberrypi.org, jonathan@raspberrypi.org,
        matthias.bgg@kernel.org, linux-rpi-kernel@lists.infradead.org,
        wahrenst@gmx.net, nsaenzjulienne@suse.de,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: bcmgenet: Generate a random MAC if
 none is valid
Message-ID: <20191015153955.2e602903@cakuba.netronome.com>
In-Reply-To: <dda8587a-0734-d294-5b50-0f5f35c27918@broadcom.com>
References: <20191014212000.27712-1-f.fainelli@gmail.com>
        <dda8587a-0734-d294-5b50-0f5f35c27918@broadcom.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 15:32:28 -0700, Scott Branden wrote:
> > @@ -3482,7 +3476,12 @@ static int bcmgenet_probe(struct platform_device=
 *pdev)
> >  =20
> >   	SET_NETDEV_DEV(dev, &pdev->dev);
> >   	dev_set_drvdata(&pdev->dev, dev);
> > -	ether_addr_copy(dev->dev_addr, macaddr);
> > +	if (IS_ERR_OR_NULL(macaddr) || !is_valid_ether_addr(macaddr)) {
> > +		dev_warn(&pdev->dev, "using random Ethernet MAC\n"); =20
>=20
> I would still consider this warrants a dev_err as you should not be=20
> using the device with a random MAC address assigned to it.=C2=A0 But I'll=
=20
> leave it to the "experts" to decide on the print level here.

FWIW I'd stick to warn for this message since this is no longer a hard
failure.
