Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6FEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9E32171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552489614;
	bh=VCA8acnYEgQg0n7PnODEQE4MBbEwavUiOdW8YbYpGxM=;
	h=From:To:Subject:Date:List-ID:From;
	b=V7QmcZvKURb6dEzyuZlbubRz6QtvhoW7JnBTxCcbz6fzhdZZHhjB/l2UscfbdvwrH
	 Ah0J7fByDkjCQ5lToL/QmlWkYq1WkvjWzibybJklajD6hODbI1QlT2DCRwNy+s0cFt
	 0NBr3XwKKmVMOyr8z8czP5NdHwVpxnZBx/UPOONE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCMPGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:06:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33207 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:06:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id q24so2051384otk.0;
        Wed, 13 Mar 2019 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXVLhq9kpm2DZ6wvNbMETOIexe2mowMhAjdqPq0I9ZA=;
        b=H0XCfEjJjRHOjK9IKWXU3Fa6zMjtWLAwp2pJ8K+FkrisxXwVqxCgRdsodEAMllcQv9
         D3map5O4NNwvINKiJyWitnKpn04dIJpGzKzu/Xaxz4sfMBfk7mWAzDBD+6qj7RBJNfWA
         ziYygB9BFe+ynGnWMl3ujnk7Agv1NT6ulbb9YV9UGqjhDZzPFY7CkwiuLDJfkTFLcbsk
         +M9iDNCxwUqSdGwFGOWjWJTkQ+VGDbsz9VcLsmADc/kuBevD154zm+TPjLqmGLtQt9Rn
         B8rU5C7Ed9HyiznZINsdTVguFV3fdCch5oLm15sofZKVMaI5ZAYYoRUyUcM5Cf+B/JuR
         6thA==
X-Gm-Message-State: APjAAAVsIBu1faenyciTovPJA3A3xePeDfTmGNVKvSShhucUjS1QAhjK
        7lnb/48xFl9G30bJbDDlJM4XSHE=
X-Google-Smtp-Source: APXvYqwRuhx6o+OTmbetjnm0dCatKVRiUEvFF3Y3HuD6FJ3mqG8ZWBgC5JoRbUAZc21X/PsimSp5aw==
X-Received: by 2002:a9d:7091:: with SMTP id l17mr29476943otj.198.1552489609679;
        Wed, 13 Mar 2019 08:06:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y124sm4869409oie.57.2019.03.13.08.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 08:06:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: Add a guide of do's and don't's for writing bindings
Date:   Wed, 13 Mar 2019 10:06:48 -0500
Message-Id: <20190313150648.32404-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree binding reviews have a lot of repeated review comments. Much
of the guidelines aren't written down. This list of do's and don't's is
by no means an exhaustive guide for how to write bindings, but at least
the "rules" are written down in some form.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/writing-bindings.txt  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/writing-bindings.txt

diff --git a/Documentation/devicetree/bindings/writing-bindings.txt b/Documentation/devicetree/bindings/writing-bindings.txt
new file mode 100644
index 000000000000..27dfd2d8016e
--- /dev/null
+++ b/Documentation/devicetree/bindings/writing-bindings.txt
@@ -0,0 +1,60 @@
+DOs and DON'Ts for designing and writing Devicetree bindings
+
+This is a list of common review feedback items focused on binding design. With
+every rule, there are exceptions and bindings have many gray areas.
+
+For guidelines related to patches, see
+Documentation/devicetree/bindings/submitting-patches.txt
+
+
+Overall design
+
+- DO attempt to make bindings complete even if a driver doesn't support some
+  features. For example, if a device has an interrupt, then include the
+  'interrupts' property even if the driver is only polled mode.
+
+- DON'T refer to Linux or "device driver" in bindings. Bindings should be
+  based on what the hardware has, not what an OS and driver currently support.
+
+- DO use node names matching the class of the device. Many standard names are
+  defined in the DT Spec. If there isn't one, consider adding it.
+
+- DO check that the example matches the documentation especially after making
+  review changes.
+
+- DON'T create nodes just for the sake of instantiating drivers. Multi-function
+  devices only need child nodes when the child nodes have their own DT
+  resources. A single node can be multiple providers (e.g. clocks and resets).
+
+- DON'T use 'syscon' alone without a specific compatible string. A 'syscon'
+  hardware block should have a compatible string unique enough to infer the
+  register layout of the entire block (at a minimum).
+
+
+Properties
+
+- DO make 'compatible' properties specific. DON'T use wildcards in compatible
+  strings. DO use fallback compatibles when devices are the same as or a subset
+  of prior implementations. DO add new compatibles in case there are new
+  features or bugs.
+
+- DO use a vendor prefix on device specific property names. Consider if
+  properties could be common among devices of the same class. Check other
+  existing bindings for similar devices.
+
+- DON'T redefine common properties. Just reference the definition and define
+  constraints specific to the device.
+
+- DO use common property unit suffixes for properties with scientific units.
+  See property-units.txt.
+
+- DO define properties in terms of constraints. How many entries? What are
+  possible values? What is the order?
+
+
+Board/SoC .dts Files
+
+- DO put all MMIO devices under a bus node and not at the top-level.
+
+- DO use non-empty 'ranges' to limit the size of child buses/devices. 64-bit
+  platforms don't need all devices to have 64-bit address and size.
-- 
2.19.1

