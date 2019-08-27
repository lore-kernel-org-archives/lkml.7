Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF82C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911192070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d9bP2dr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfH0CzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:55:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42832 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfH0CzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:55:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so13088392pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3qi2zzHMk5Wx4T0VpqzCsoi+g0ChTEtNAjfI0RCyHs=;
        b=d9bP2dr4DUzCy0oD6c+0A6kCWj/mxlc0QpCS+/aWoCAsJ7/FR5zpBqchKLAHfxdlLK
         x2YgAjZtNXvk9CiZON8i3WoW/+B7LozfuztmXCBX6gUz43JvroAFIIrYhpCA1wolkBW1
         KUOStyE0yFic9S4dI+jrNwsE4hJl7vE5FNfdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3qi2zzHMk5Wx4T0VpqzCsoi+g0ChTEtNAjfI0RCyHs=;
        b=ZvNZAqX45R8ttel+6RR0dAPGZmSP6ON51DsZHgqwcSfywM6WZWhd7P2YQUPnR0Ytro
         hZA7IwUAHNsVjae8xdguQHzb3lcakkEjtQKCFeUMJcDPrMZoey/RJenlnNjshnIarNeP
         8CRLQ5sARwuZciHZdpXa2JpuF4PGqG9AiDb9Bqi0chufoRv4dStcPEtgjyxDzzXhjY+u
         j/NbFbZAkxwCVYONRdaAigbZT6WxLmkrllhgRiX3pn1/zbfqCAuN1h04p9XTG+RXqhwx
         kQxEydjwEeKExFotNDB1T4Tu8lUsz3uoT6VbYMHbsCmzhGYRGEMDmuD9lN0S5gu9oSI1
         hpaA==
X-Gm-Message-State: APjAAAUjY6P8EKj4WweBBT17gMU91lAv3cTzrw2PhxPKjg8aWuycmR6s
        phw6+/9KlvUw7VS4tEJOeq3fJMMIt30fHA==
X-Google-Smtp-Source: APXvYqz7qcYmFntbKxwqe8W8CAyqaSHTVk0IhQXfW8fvfm7h+NJTRxohzDkI0zEpBuwjwgBx3kjshw==
X-Received: by 2002:a62:754a:: with SMTP id q71mr23227033pfc.15.1566874512591;
        Mon, 26 Aug 2019 19:55:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o67sm22196757pfb.39.2019.08.26.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 19:55:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH] dt-bindings: Clarify interrupts-extended usage
Date:   Mon, 26 Aug 2019 19:55:11 -0700
Message-Id: <20190827025511.22166-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the description about when to use interrupts-extended leads some
developers to think that it shouldn't be used unless a device has
interrupts from more than one interrupt controller. This isn't true. We
should encourage devicetree writers to use this property in situations
where it isn't the inherited interrupt-parent so that we have less
properties in a DT node by virtue of not having to specify an
interrupt-parent and an interrupts property.

Reported-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/interrupt-controller/interrupts.txt          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
index 8a3c40829899..4a3ee253f7f0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
@@ -22,10 +22,10 @@ controller node. This property is inherited, so it may be specified in an
 interrupt client node or in any of its parent nodes. Interrupts listed in the
 "interrupts" property are always in reference to the node's interrupt parent.
 
-The "interrupts-extended" property is a special form for use when a node needs
-to reference multiple interrupt parents. Each entry in this property contains
-both the parent phandle and the interrupt specifier. "interrupts-extended"
-should only be used when a device has multiple interrupt parents.
+The "interrupts-extended" property is a special form; useful when a node needs
+to reference multiple interrupt parents or a different interrupt parent than
+the inherited one. Each entry in this property contains both the parent phandle
+and the interrupt specifier.
 
   Example:
 	interrupts-extended = <&intc1 5 1>, <&intc2 1 0>;

base-commit: 609488bc979f99f805f34e9a32c1e3b71179d10b
-- 
Sent by a computer through tubes

