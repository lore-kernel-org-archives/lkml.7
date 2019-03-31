Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE66C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C4D20881
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="tfc5zil1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfCaC0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 22:26:55 -0400
Received: from onstation.org ([52.200.56.107]:34310 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbfCaC0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 22:26:55 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 29ABD456C5;
        Sun, 31 Mar 2019 02:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1553999214;
        bh=K/PCJWYiucYgdku+Wj5YPzuNDDtA/AtjdJ9NC89KHtA=;
        h=Date:From:To:Cc:Subject:From;
        b=tfc5zil1VaPHZulSbYQwoCKyAVsbcAqlk3TKTp2mbgXlvRnxG8/xdl6k27O7f9jnx
         vlu5k3h2MVlsMjMBp2KvY4Ffib0Ot3axNUGR49J++2i3SF3FfV/yIby3jhviSipQ9y
         Ha7CvD+bUVQAOz2/Klsn4Mg4eJVVZYxGNkIvn3ZA=
Date:   Sat, 30 Mar 2019 22:26:53 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 'reg: property has invalid length' with new JSON-schema bindings
Message-ID: <20190331022653.GA8727@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I'm finishing up a patch series that adds device tree support for a
backlight driver and I made the bindings use the new JSON schema. I'm
running into a problem with the reg property in the examples and I can
reproduce the issue by adding an example to the trivial bindings:

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
b/Documentation/devicetree/bindings/trivial-devices.yaml
index d79fb22bde39..bdab6a015db4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -341,4 +341,10 @@ required:
   - compatible
   - reg
 
+examples:
+  - |
+    isl29028@38 {
+        compatible = "isil,isl29028";
+        reg = <0x38>;
+    };
 ...

'make dt_binding_check' fails with the following error:

  Documentation/devicetree/bindings/trivial-devices.example.dts:11.5-18:
    Warning (reg_format): /isl29028@38:reg: property has invalid length
    (4 bytes) (#address-cells == 1, #size-cells == 1)
  ...
  Documentation/devicetree/bindings/trivial-devices.example.dtb:
    Warning (i2c_bus_reg): Failed prerequisite 'reg_format'

I see that dt-extract-example hard codes those two cell values to 1:
https://github.com/robherring/yaml-bindings/blob/master/tools/dt-extract-example

The I2C buses for my board (qcom-msm8974) sets #size-cells to 0. Do you
have any suggestions for how I can correct this issue? I can make the
binding check happy by adding a length (reg = <0x38 0x4>;) but I assume
that we shouldn't do that for I2C addresses like this.

Brian
