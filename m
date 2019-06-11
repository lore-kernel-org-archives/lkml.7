Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB70C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBBC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Y9LYbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436676AbfFKVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:54:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436664AbfFKVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:54:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so8254359pfy.13;
        Tue, 11 Jun 2019 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dpOYw6H5sSXAWPYrrV8Oq9GrgOxO6vd6WyMoz+YDOCs=;
        b=j8Y9LYbhdrOl8+Ff06oBDZcEbCwVSbiPnz/Vo3+FQlWIlwY64ldLMABhRyoZolgOnI
         d3AgD5/9hFPfw2ZFH+5isLn7hWSAInBDW4nA/p8MZMwAr+A5aKj7Vwdw+Q92iCq0T/oP
         6fDVdzIDpn6FrMfwU8wkfHPMKYo8dxtQEsYmor7ZhaxCcfuY+sfcsQVTn2I0Bgs1/cOO
         CdOxtrI4V3pwHe8xBLgo/AdmQrk0+WhLXmK9SbBF6tVwFq8bhdacgemn83FxU9eN6S6A
         5G5dHkOxxVzNPx2uWwZ53VxshO0dPDRnTYGY9WdDGLtMfHmX8HEUpV/jpRXb0D3QM0du
         /nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dpOYw6H5sSXAWPYrrV8Oq9GrgOxO6vd6WyMoz+YDOCs=;
        b=RtwA/5mZTfzoQSCl+H1b0Oymu9gRhGynZUqwaHo5kvxNatnNG/CtxRLQVAkU/gsqHJ
         tCwsH6Hs8i2t2+lJa2jefIRNVVt0yRdRW/WagVzCG0A1+0lj8USedNafpu9bs4Hz5S2M
         F+pW/ysxGz1DGDyLsxaFmwp0FQZTQgNWQtsQm8s/GKygroF+4sEIEcMmXQxgN/GI2Ofp
         meieQoS5wlOZYdtFUOjgX1frCxi2sP7B8qDpijiqe2TV8b2tZEQRKw6glwXcMXR5HOMD
         Y9nwixAvX/2ki3sqfg/Jk7LUir3pne/Ro2UCCV8m2uOYa1Ji9Va2hT6JaO4GGfqyHwJm
         If0w==
X-Gm-Message-State: APjAAAWS6RJnffTpnkcrtEKggldtG5+/PtBh8qSA+P7g60HtNH4OUfAl
        2lrpO0f0N9th/eXDBrCNQZI=
X-Google-Smtp-Source: APXvYqzELoAdkhlGDYwht+pWw2u8R41cpdF+7mnY62nqz2DllmtC2f3yYGikAv2dI1PmTRDtP1Fwng==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr29546924pjc.31.1560290098203;
        Tue, 11 Jun 2019 14:54:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a3sm43519pje.3.2019.06.11.14.54.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:54:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] ARM: dts: BCM53573: Fix DTC W=1 warnings
Date:   Tue, 11 Jun 2019 14:54:56 -0700
Message-Id: <20190611215456.10353-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-5-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com> <20190528230134.27007-5-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 16:01:31 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Fix the the unit_address_vs_reg warnings and unnecessary
> \#address-cells/#size-cells without "ranges" or child "reg" property
> warnings.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
