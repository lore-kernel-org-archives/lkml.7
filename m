Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E7DC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F1215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPqJo+I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391719AbfFKVyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:54:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35132 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbfFKVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:54:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so18292076edr.2;
        Tue, 11 Jun 2019 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enVQQiD0qEvE81kIlPzU4UOe7eV8T+/6nHsnl/OSqaE=;
        b=uPqJo+I+2gRZvEgFHAxSICGCcvMalPcwnaQOwTZ2l/Fgcp2WFfbnz9pzM1VPxUu18L
         PPvvbUqqkPcmpZHvBlm2qbBsdg/dcMGiS3apoX+CdZx81jm9K5RXZj2EAQCVth8/0n4k
         nf2qPmN0hw9mKbPPDnRyyTxQ/MW9ksJqGoQlML5gUq8yIEBprrAFbiNv3CK0GJj5x34f
         BlSKG5NOi9RAIZf7jCmYiUhP6jwGD0Uu8I7yb8ZrluH885HhqpsoQ0CVgcEpUE6VHGwP
         4FKmBTX9sNDPMaRmPhBRmiG5+KMDjJrwiO3uLSLn3lhgjs/Iv32+MbgYroUDrv16JjbW
         2XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enVQQiD0qEvE81kIlPzU4UOe7eV8T+/6nHsnl/OSqaE=;
        b=Mf/K9OAvoE0uQ/P4spG2/05AoeidfIAyuxuNPItnFrbzEuZ1rqBLhDfh3UB2jcfWeG
         Br8dPzAH0JWHHh+wii/uCbU/B5jzATQ//i6i0FiH2e/pCiuZ3FzW/uUwOg1V1ED3C0tg
         IBy+lmAL3ZZrm6noyFswLiiO8ti8DoCrnMNBIFXH/HG7WsyWm88kZxuzI3d2OXltySwy
         ySABf3dlRp2Y+FoArot4qRdxK/SKljmH15yJI9vdaDjRb8/jznobpVyiYRSxq7UcfYez
         Jsx1DKtlYszWYVbnJRNr+/n/tCbFnSA+v2b+C9LCE/KGa/JqmDE64NeWeNDguzkmRCkf
         Hf2Q==
X-Gm-Message-State: APjAAAVE/dJfhZGVuoJPzdAKpdKYCcPmePhb0jzRRL5+tTN934qvuQ2n
        cKt1z5USaXqYyPum8I8vKZ4=
X-Google-Smtp-Source: APXvYqxz2kDWi7DBQi+Y4uLa+i8+0Gq0mwrASzfFnHiXgKzerihODElkUUuJm7ZITNSJi1M7b/T2KA==
X-Received: by 2002:a50:eb8b:: with SMTP id y11mr17934715edr.154.1560290038648;
        Tue, 11 Jun 2019 14:53:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o21sm790246edr.12.2019.06.11.14.53.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:53:57 -0700 (PDT)
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
Subject: Re: [PATCH 1/7] ARM: dts: Fix BCM7445 DTC warnings
Date:   Tue, 11 Jun 2019 14:53:48 -0700
Message-Id: <20190611215348.9994-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-2-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com> <20190528230134.27007-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 16:01:28 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Fixes a number of unit_address_vs_reg warnings:
> 
>   DTC     arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
> arch/arm/boot/dts/bcm7445.dtsi:66.6-225.4: Warning (unit_address_vs_reg): /rdb: node has a reg or ranges property, but no unit name
> arch/arm/boot/dts/bcm7445.dtsi:227.21-298.4: Warning (unit_address_vs_reg): /memory_controllers: node has a reg or ranges property, but no unit name
> arch/arm/boot/dts/bcm7445-bcm97445svmb.dts:9.9-14.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> arch/arm/boot/dts/bcm7445.dtsi:255.10-275.5: Warning (simple_bus_reg): /memory_controllers/memc@1: simple-bus unit address format error, expected "80000"
> arch/arm/boot/dts/bcm7445.dtsi:277.10-297.5: Warning (simple_bus_reg): /memory_controllers/memc@2: simple-bus unit address format error, expected "100000"
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
