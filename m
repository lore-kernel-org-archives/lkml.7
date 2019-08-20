Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF088C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BE422DCC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="UlFn4EbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfHTOL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:11:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37000 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbfHTOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:11:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so2798623wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3A3veAm3Lpp8I1KUBVdHNM6t1y4gslFCu/nH33gQzj0=;
        b=UlFn4EbMZAEbKFED6p6zZZVirxz5HsF1OJcSpQzIPznev4XNwDnsO1YHKvTkKPcJjB
         3Ot35pW+7Hx6vbjXtLW6iLwRbjAHWbP+UcL3NfR0Vu/YAtXP3ELGvHb8/Vlcabio7nkf
         A9HTYmV3seHnrCTYdOhhrJcZXhU14qiDN2lAyQJ/0P+Vab9OcyJdra63NyeUudUjdTtW
         QLCAGVc5LB3PFzKuYyQmiJlaW0U0bZhY3MLwfPVPPesGkhjJBudkidVOh69hERvRZVfU
         Gf9mB086LUk6W1geanUZYyKuUBpilDfDen4K+fe0FtRb3bWFLlUktGHDf4XJiKPPHk8f
         Mv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=3A3veAm3Lpp8I1KUBVdHNM6t1y4gslFCu/nH33gQzj0=;
        b=bpfeBwJaquUk29kV///IXX1Ik8ZHQF1xnJ6US5eMtV1/PR+q+4UjVU+ymSBBqbIL8d
         gwsOk2wHdpRolMwC4SLjaWNzclfFeqQMGDY4NYviS6imcuJwpgYt8/xSLEm/uBdTgeC7
         zqrsh4R2MjOTvJnVljCzhs5kriF9LseufbjTUN+lWhcsszSjydBE47g06vq4lwHNiMYF
         eDg0uOwdki4QWmve5NqlAnNLLnRntSPvKL7T700DnfRs7ISSIgReMc4DBIhVrEq6psiD
         OpD3pu/vJfwSd4+s/Le5/pyrP6gTY7pR4ABzIorTeHtn3JVCM38V5PVUByDTbuuqS1W/
         8y2A==
X-Gm-Message-State: APjAAAVEScQaWopJ02Ww80VbIP5XcWiD6RWjmi/cgig3t1fJ0GhGOe/a
        xqRdDdyGcAskf8wTrMcLy8fztzpb2BYhwg==
X-Google-Smtp-Source: APXvYqxjghaCyCbikfVIF7P9kVbfPe71/TZPk84eJm5nxA4vZdhH9MGYRrqrXJuh7H9rsOBBIiEuuw==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr207839wmg.63.1566310312089;
        Tue, 20 Aug 2019 07:11:52 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f13sm10145717wrr.5.2019.08.20.07.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:11:51 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] dt-bindings: Add optional label property for ina2xx
Date:   Tue, 20 Aug 2019 16:11:40 +0200
Message-Id: <3c56deb8cc1842d2915b203e622be1eb442414de.1566310292.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using optional "label" property is adding an option to user to use better
name for device identification.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/hwmon/ina2xx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
index 02af0d94e921..d15bf7e46fd7 100644
--- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
@@ -14,6 +14,8 @@ Optional properties:
 
 - shunt-resistor
 	Shunt resistor value in micro-Ohm
+- label
+	Symbolic name for a power monitor
 
 Example:
 
-- 
2.17.1

