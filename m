Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C19206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G226RTXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCKPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:15:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35001 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLCKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:15:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so1635679pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la8F/ukOCmlxZOPSk03ZdEI5AybzNjyoXK4eemJfXxE=;
        b=G226RTXHw3qcB+VS063+Ay6A/MbQWClSU74oKAEWlESOOxPKzIsw6XIGv1bELVqcNg
         jmYzwjk2ghqoJSwOP6SlpYxj33qgOQyzC2jq3UkuNRyXEsJNFzg0z+zIMQ9IZJ448EZd
         ctOO2I5biTxKUYaUd8ePhb5JWZ4NK5eJwEbOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la8F/ukOCmlxZOPSk03ZdEI5AybzNjyoXK4eemJfXxE=;
        b=sIoRoKQPhxn4b5RVUkQICfpzxilhwfX8bZ9JyXS09Y92jzMRVIzo32a5ZETLlyBYd8
         lia1a16Fhnm1he2dMK2e4e3GxuhgRM1Qq2yXcbpAc7cGy0gF2U+fevpe2Z/Tu7MJZnWR
         zYoWKy49+L1Q1nto0LnZPd83aERGki4gTvab3rs3h9RKVsUueQtbhuzrrvsw4kSmDfn3
         4QL7NMm8UdtPFVtYgMgtuWaFls5u1EsXoKnEk8PeWJ4PbYZ7XqizsPbkn6IUksXu//0E
         X/lufhUbRTTBGTcvdCAsoG96lxcYNnDiJ5N8nW0DWiBv1dZuWQAKuRMDw4m9PLGqkz4r
         ddmQ==
X-Gm-Message-State: APjAAAUrKgHmpa1/XLiYbF3GeFpeT9JhlccemTe3CQF1ccK6YBEK3UKH
        KGmJWGsec8Xjy/gB5w3niPqApw==
X-Google-Smtp-Source: APXvYqxi6mHP/CPl92Tl/wfPvYWI3JtJFadHEo9LlGyht/c7K25YTpYXkaeEZu0Y3pG5p+MUZJWu0Q==
X-Received: by 2002:a62:b504:: with SMTP id y4mr3894348pfe.251.1575368141054;
        Tue, 03 Dec 2019 02:15:41 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id x11sm2943131pfn.53.2019.12.03.02.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 02:15:40 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        IkjoonJang <ikjn@chromium.org>, JohanHovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org
Subject: [PATCH v4 1/2] dt-bindings: usb: add "hub,interval" property
Date:   Tue,  3 Dec 2019 18:15:36 +0800
Message-Id: <20191203101536.199222-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "hub,interval" property to usb-device, so hub device can override
endpoint descriptor's bInterval.

When we know reducing autosuspend delay for built-in HIDs is better for
power saving, we can reduce it to the optimal value. But if a parent hub
has a long bInterval, mouse lags a lot from more frequent autosuspend.
So this enables overriding bInterval for a hard wired hub device only
when we know that reduces the power consumption.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 036be172b1ae..44bef2ff2704 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -66,6 +66,9 @@ Required properties for host-controller nodes with device nodes:
 - #size-cells: shall be 0
 
 
+Optional properties for hub nodes
+- hub,interval: bInterval of status change endpoint. The range is 1-255.
+
 Example:
 
 &usb1 {	/* host controller */
@@ -75,6 +78,7 @@ Example:
 	hub@1 {		/* hub connected to port 1 */
 		compatible = "usb5e3,608";
 		reg = <1>;
+		hub,interval = <8>;
 	};
 
 	device@2 {	/* device connected to port 2 */
-- 
2.24.0.393.g34dc348eaf-goog

