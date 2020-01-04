Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB8C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEB224654
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173416;
	bh=+Qf/U6NtpKJ9fQHq35StSjVjKCuV7e3504KVM8Lxj3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C3DXuFXU7ekGTdmBujMMG9eAss1HkKuPXoaiJTt/G4wpZ4WE8yY+f7Go6VU8qJZf+
	 oMmdpUmtrnQnm9wzGgpSbardEYMZfpmKI4Yx58wP91DM9E8zMhoN71K2XtlAMKemV6
	 Oc9deWvKEPMSvAWDYh1dIcCKbAziy/NQUVjoCvsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgADVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:30:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37858 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:30:14 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so14419154ioc.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4H4SgxYFF1sZ0FF/6Ems4wMDN7ra7/R/gc5/aNjkHc=;
        b=gzB45bWm0hcIue6Uf0Sy5zkoE2PUdttEEg3dUbw+AZdgTWieXDM0gqRZq6vy7a10CG
         X2otYAwTxWJrhF0yYKdhAmHkU6X8//0s9X0QPc3fAJxTuDslawCb1shGrY5vXEV8y4xJ
         lS37l66Vk6FJSI1IxCL5E+Auf/k2jY8HII2Lrpha0v0jWErfXPNNMr6mWTfL40IK7Bcr
         ONic7o+puxt/RFq1uQvLEoVnNzd/MgcsObvOYfQEoIPh7Ed88kdvF3pgSRNcRyQAu6w4
         KBNPLf9f+zGTpHUsYYSXPw0Fu8Q/ME/F9v0w1TQwP1v8AbwdvJJ3f2svaZYySiPJd6C+
         O3qg==
X-Gm-Message-State: APjAAAW6dpyD/cGcrDM+cW0Fjf70AEFslexNVRDnjLX5UcvCUHl0XhNi
        Q9OCfzxUeXej7Zkd77Z2pNUw6jU=
X-Google-Smtp-Source: APXvYqxfFOGIwA2S6icJHYyE3qH2X1TQyZdsJb8tULRpos/lhgJwmbf2SBgQJEakLE0trLEfz6lfqg==
X-Received: by 2002:a6b:b941:: with SMTP id j62mr66943197iof.168.1578173413911;
        Sat, 04 Jan 2020 13:30:13 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r20sm10053786iog.18.2020.01.04.13.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:30:13 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219ec
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:29:42 -0700
Date:   Sat, 4 Jan 2020 14:29:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: display: rockchip-lvds: Document
 PX30 PHY
Message-ID: <20200104212942.GA18654@bogus>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
 <20191224143900.23567-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224143900.23567-3-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 15:38:51 +0100, Miquel Raynal wrote:
> PX30 SoCs use a single PHY shared by two display pipelines: MIPI DSI
> and LVDS. In the case of the LVDS IP, document the possibility to fill
> a PHY handle.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/display/rockchip/rockchip-lvds.txt     | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
