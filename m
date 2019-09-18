Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D09C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1489208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VAw2COz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfIRNlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:41:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfIRNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:41:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so6087318wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Le2QH/5p+c8aA6YAOFY1HqDcS4tnXWKjjmJndzg7vug=;
        b=VAw2COz9hJ2GODw4TUYBOjfVafamFQnhqcHSPoGtSL0UpHXJ9HJuVTTAOypbw/e5qx
         nMNd6i1KOl6WeqCM4D0ok9G8UJFmOJrWjiLWaHI0cZAi0qHSYNFzMHIBNFOk3H62hQ70
         CHh9MzUKVzxtb2P6/IH/mtlonsiPEY8GPDRL1GKwiNDjDUiP9ueltLepxrefCUgQvvFZ
         OuLrURYApNhn1n2i1L7upc8GZYAeOH1npStQebjXti8ELLDaKP7yAtRo53Jckej27KnQ
         eYhf8WM6WxDh0q4AZejqt6ACZHHmWXTvTtnjXQGLhQQo85xay3SnkTkDQZfbLei3fg5O
         uPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Le2QH/5p+c8aA6YAOFY1HqDcS4tnXWKjjmJndzg7vug=;
        b=bnyoieq22sDMHLjjdExb111YJwVUXL5ydV08RIi2qBzixB2tvzYKxyOJv2FARSxa9/
         Yb3RB3aHTCosmZcvVj7OFFyMUcVQEQFqdlAUu7mlQ0OTGGsx/UmKCFHHTFsyormPExR2
         OK5U5v+QW5A8GL2xqvzI3XvEilJw76hm5RFgP0/WspZyHo5zDJrQV+m27c4Y+Hh/HhLx
         EApNSAUqsYXhZ6kShk3QfnAc+Gu4NxTdnsvKnkLVn453/G5RZ1nRAHxeCGTgh0esM1n1
         VzUYbQOWY0L/szj2JBQqXQ/KJD6Y4OUQzEIV/RgF+VvPqmjcK54JrS8u1TScfzyZeTN9
         PqSw==
X-Gm-Message-State: APjAAAXKgXrdIW9y41p3ica9Z3YDnKGt8tsqCvCAMNrHjMrAmG3GlOzn
        xoCYLYZIZLjy4OWcqCmpxE7l5Q==
X-Google-Smtp-Source: APXvYqxv03GXuQ6Ll5/5yUHHr2Cqd6aGyprQTYFaVpTYbV1oBVZZcCF8gqYRsSTnVTCyAl0s5B26hg==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr3140609wrt.337.1568814068663;
        Wed, 18 Sep 2019 06:41:08 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id b22sm3332004wmj.36.2019.09.18.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:41:07 -0700 (PDT)
Date:   Wed, 18 Sep 2019 06:41:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH] riscv: dts: Add DT support for SiFive FU540 PWM driver
In-Reply-To: <CAJ2_jOHJ5zuxDc6gsFiZou+-yVg=pr+uSHGJB8VPT1O-Bu3idg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1909180639530.29677@viisi.sifive.com>
References: <CAJ2_jOGO-isv52rnwRusV7jtyCY_JWYWAj9opN3Zg6ZbZr-8-w@mail.gmail.com> <mhng-c8b87e96-987e-4577-acc2-1e22c9b81b10@palmer-si-x1e> <CAJ2_jOHJ5zuxDc6gsFiZou+-yVg=pr+uSHGJB8VPT1O-Bu3idg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Yash Shah wrote:

> On Sat, Sep 14, 2019 at 2:50 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Tue, 10 Sep 2019 02:52:07 PDT (-0700), yash.shah@sifive.com wrote:
> > > Hi,
> > >
> > > Any comments on this patch?
> >
> > I don't see "sifive,pwm0" in the DT bindings documentation, and it doesn't
> > match our standard way of doing these things (which would have at least
> > "sifive,fu540-c000-pwm").
> 
> "sifive,pwm0" is present in the DT bindings documentation at
> Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> Yes, I agree that this patch is missing "sifive,fu540-c000-pwm". I
> will add it along with "sifive,pwm0" and repost as version 2.

Fixed the compat string here and also dropped the superfluous reg-names 
property from pwm1.  Queued for v5.4-rc, thanks.


- Paul

From: Yash Shah <yash.shah@sifive.com>
Date: Wed, 21 Aug 2019 14:53:40 +0530
Subject: [PATCH] riscv: dts: Add DT support for SiFive FU540 PWM driver

Add the PWM DT node in SiFive FU540 soc-specific DT file.
Enable the PWM nodes in HiFive Unleashed board-specific DT file.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
[paul.walmsley@sifive.com: added chip-specific compatible string;
 dropped reg-names string from pwm1]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi     | 18 ++++++++++++++++++
 .../boot/dts/sifive/hifive-unleashed-a00.dts   |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 42b5ec223100..5a29211d396e 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -230,6 +230,24 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+		pwm0: pwm@10020000 {
+			compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+			reg = <0x0 0x10020000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <42 43 44 45>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+		pwm1: pwm@10021000 {
+			compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+			reg = <0x0 0x10021000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <46 47 48 49>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
 
 	};
 };
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 93d68cbd64fe..104d334511cd 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -85,3 +85,11 @@
 		reg = <0>;
 	};
 };
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
-- 
2.23.0

