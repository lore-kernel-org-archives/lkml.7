Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76355CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8592064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="2MqfhQSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbfJWJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:47:22 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40503 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404068AbfJWJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:21 -0400
Received: by mail-lj1-f177.google.com with SMTP id u22so2353588lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pz3+DWB7oWbXAMad9r4Qc00otDyvGCAkqWlDBm/r8Ac=;
        b=2MqfhQSv6tqOpcuwa0h8Eybcz74sI3Tp4lryUBh2aIxUyOL64r/aYAZ3xTtYYfOYD9
         RCjJUFcTEtr4o8bEJvken2RukeojMYMklq7krPDQHaQy7KGL1EV9IExVVsSuqMVO/PIR
         m0FKEEOGcTXwEAe0SqBnPDdnQ4wLmuQ94SUz2V2NjCKXoCKfaxg7aQKkWn950vzAyMMX
         75GH/398Bg9tQCH8zTq2yUHm4ycjSu8XNl4rc3x50aDe2MkItq8XG1GuALqket7QJdEs
         8DC/IDi2buxlt9pVwoVNo7poUOkbntuMC9O3BYd3pcwdhT4u94L6umoijY8dFgXZ0s6Y
         D9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pz3+DWB7oWbXAMad9r4Qc00otDyvGCAkqWlDBm/r8Ac=;
        b=S/2LbZSfv9zUNu1VfmwvUl2vVpO7DjxEzyWpgZybB5ca4IDoJoJcj70zNzBNCZY8Tl
         qyoLFkwBE8OJj/XA9SvkjfFdMBQ/r+3I6Zbt8zIBe/pdZUraVOUmic+67QX91GIUvxIA
         P0Mo/7zSs6BmJam+l2xNYS4rlcUpLaD0O+A/EQ3DXIlRpjvSz4WAIRFR3PP0PVW6EHmO
         9F1a2WQA4iJ07zdd9hi5sognw0PWsS5IwdSo/+VFSvLxmBkLG9KF3MGQzRdYG451X99K
         Q1YHB/W4d5ZTThpeaQu1oJUTwoNEsdz6sEWtnPjKhPo/USwi8CqjyP/KmKoswvmLqgnW
         r9zA==
X-Gm-Message-State: APjAAAU/KofJwNDrFS4keNO9CVZlD9U9abz+2gxGI6cbPfwWBfhDT27L
        6J7nYPBa2gHNM4Wc7cLArQFZmw==
X-Google-Smtp-Source: APXvYqwTsLR1aQcC2X8hJihtXbTlmk+xv35POn0v1gmzDTjGJMP1rJO0MPxSfZjDSJsHzoSASfGjrg==
X-Received: by 2002:a2e:575c:: with SMTP id r28mr1321715ljd.245.1571824039306;
        Wed, 23 Oct 2019 02:47:19 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id t6sm9602971ljd.102.2019.10.23.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:47:18 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:47:14 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: serial: document LiteUART bindings
Message-ID: <20191023114634.13657-3-mholenko@antmicro.com>
References: <20191023114634.13657-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-0-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
Changes in v2:
- binding description rewritten to a yaml schema file
- added interrupt line
- fixed unit address
- patch number changed from 2 to 3

 .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.yaml b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
new file mode 100644
index 000000000000..87bf846b170a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteUART serial controller
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+description: |
+  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
+  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
+
+properties:
+  compatible:
+    const: litex,liteuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "litex,liteuart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index eaa51209bfb2..1dc783c9edb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9498,6 +9498,7 @@ M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	include/linux/litex.h
+F:	Documentation/devicetree/bindings/*/litex,*.yaml
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
-- 
2.23.0

