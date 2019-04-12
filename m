Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9479C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744C02064A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKTQFvc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDLQB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:01:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37531 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDLQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:01:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so11645500wmf.2;
        Fri, 12 Apr 2019 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hzDTtEH6j7d7QGWta1h02BQu/5flGAz2BaklLVXWjnU=;
        b=KKTQFvc+iIKQMbFKw5zF+6Tp2ztad7JcoNC0e0CsFVVOXxYGPg0Cq8ZSoylHDr2LBJ
         Uql1ido8EPjd/5OUePzBeItUJKJfvDMi0o70vr/bZGHJVjHhTkcBHBgKQK8Gy8f/lPaM
         OmVe08sqK/u0OAB1NcM1uw6VqND5obbg1gz5pdAJN5ELQXCXoCtzW2BUXTbjRY7mDq/h
         ckbpz4oAQFMuWVFmYU6dUzjdxjz+MMFAB9CDl1xTEDT7r0UnjoM3s6+bfnuxI6ngmiWR
         Ax1oA8QqT8voDW3EFvUz14cKRv8HbbOoxsM+9WS1lggXH4CoRRhQJMGtw5pKJQS1ZEKN
         hD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hzDTtEH6j7d7QGWta1h02BQu/5flGAz2BaklLVXWjnU=;
        b=uCSMG8l/rTD+dhw+ML70irObAUzrcu4boLYA2lx64wn3nyOVn00M9CtF/fD8CuTqI8
         B1j9Oh+rM9HJWPiXHETKvVvSMSji2f+yI1gXhlNKhdihNmcyQ/i8Kd+41yigLjugDk1H
         /YTgpTVZxFU/SfswwU6KExNd0pmZmKQnqTChHByEdMSfGMVzDoBwXy+GJRqnHkIYKZFt
         2hERpm5PWBcV0Er7Vn4qMY1CgDbScm+h3HLI9QSP6t2WI4idCTrQywVl0e8QPTl6qZBf
         xIo1hDfG6H3H47uYdNICZgQOKk23IzfYxsis3zKXHRcJgqYFAnr+xtNjsBEVd7COVzGp
         KVRA==
X-Gm-Message-State: APjAAAXAjipoNZmaeZEoVM/C2vZdSmv6JjqM1SqV3AvcqTSf7GKeDTm/
        hj9vyHe1J4LvU8UN34l7jnk=
X-Google-Smtp-Source: APXvYqzyLxHScy7/GPW+R4acGgzbKFwtOnXYAIJONlU4pueQ1UK3phnanLk9/O8Q7VNjizymEpH5rQ==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr12218162wmd.59.1555084915897;
        Fri, 12 Apr 2019 09:01:55 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id 11sm8719849wmk.17.2019.04.12.09.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:01:55 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:01:54 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: about cci400 pmu
Message-ID: <20190412160153.edbbe7mrwm7xsewa@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to add pmu support for CCI400 on an Odroid-XU3/4.
Following https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cci.txt,
and other dtsi, I end up with this patch:

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f4e8c5823bc2..8432f01fb463 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -170,6 +170,16 @@
                                interface-type = "ace";
                                reg = <0x5000 0x1000>;
                        };
+
+                       pmu@9000 {
+                               compatible = "arm,cci-400-pmu,r0";
+                               reg = <0x9000 0x5000>;
+                               interrupts = <0 105 4>,
+                                            <0 101 4>,
+                                            <0 102 4>,
+                                            <0 103 4>,
+                                            <0 104 4>;
+                       };
                };
 
                clock: clock-controller@10010000 {
		
Saddly, I got:
[    5.375913] ARM-CCI PMU 10d20000.cci:pmu@9000: invalid resource
[    5.389595] ARM-CCI PMU: probe of 10d20000.cci:pmu@9000 failed with error -12

By pluging some printk here and there in arm-cci.c in init and probe functions,
all return 0. I assume that the driver initialisation is succesful.

I trace a bit more in really_probe function, however, I can't find the real
cause of this error.

$ dmesg | grep cci
[    0.070299] drivers/bus/arm-cci.c:569:cci_init()
[    0.071484] drivers/bus/arm-cci.c:580:cci_init() cci_init_status = 0
[    0.071610] drivers/bus/arm-cci.c:595:cci_probed() cci_init_status = 0
[    0.113575] drivers/bus/arm-cci.c:569:cci_init()
[    0.113684] drivers/bus/arm-cci.c:572:cci_init() cci_init_status = 0
[    0.770287] drivers/bus/arm-cci.c:94:cci_platform_init() 0
[    0.811655] drivers/base/dd.c:516:really_probe() ARM-CCI 10d20000.cci try probe drv = c1058908, drv->probe = c0593498, dev = e8b2f010
[    0.811788] drivers/bus/arm-cci.c:72:cci_platform_probe()
[    0.811866] drivers/bus/arm-cci.c:569:cci_init()
[    0.811937] drivers/bus/arm-cci.c:572:cci_init() cci_init_status = 0
[    0.812023] drivers/bus/arm-cci.c:595:cci_probed() cci_init_status = 0
[    0.814718] drivers/bus/arm-cci.c:79:cci_platform_probe() 0
[    6.738502] drivers/base/dd.c:516:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 try probe drv = c10859f4, drv->probe = c0593498, dev = e8b2fc10
[    6.747909] ARM-CCI PMU 10d20000.cci:pmu@9000: invalid resource
[    6.753711] drivers/base/dd.c:522:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 fail probe
[    6.762416] drivers/base/dd.c:561:really_probe() ARM-CCI PMU 10d20000.cci:pmu@9000 probe_failed
[    6.770940] ARM-CCI PMU: probe of 10d20000.cci:pmu@9000 failed with error -12

I don't know if the provided values for dtsi is correct either.

I would be very happy to have some help to make these pmu working.
Many thanks in advance.

Best Regards,
Willy
