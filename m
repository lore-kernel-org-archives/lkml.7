Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754D21900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcCv+oJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfCURSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:18:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42983 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfCURSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:18:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so4631732pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+6vk1Y2CFYMkd90yT6sdZwK6wtMV3xm69BtCbUlzG0=;
        b=AcCv+oJIKvG54X4XIiKChRRBCd64AapLB03O1VpSotZHO9pkVYNgVtpiqQj2758g9m
         /bbeXL+FYzwfrqgV56tZjw8rHbWq6/la1mXbKA6fgDz0A2HkIG5ZN+nNlvUEHbXVo4xn
         7AnHRKXYM+VFZqQ6SCItRG5ArIKdREVkGNUoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+6vk1Y2CFYMkd90yT6sdZwK6wtMV3xm69BtCbUlzG0=;
        b=tFx6oB4TEfl6HNuP0mkV476S0nKmdgnH/roWe9sb2eFHlh12Vd+dtRyfWFbDnvVAr6
         9vO/NiC2nYxP0zSZe9vaWgmdcb9EdK8eR9WX9fA09spdjrs6b/JJo3K1pa9u9F30tgAc
         4oeoEdWc47aDWPpCMG6VwCQHJyvVXSfaCUx+2Acttf6znYFNB6VU84ASt1n18uI8J0dX
         +Ib56Ry07gyxajwDCIx5qnl9oprfKOD0Jow50LmQbRK74A39OXbk/flSXgg0gltBeouD
         u/0eocybeyQITCUcv0RifhvqBqVougUqiN2hokQWHCgwFcKwN4f6lpoubIWf8EobENHR
         q9sw==
X-Gm-Message-State: APjAAAVk4akMCvfACBNbsGWLeoxZm2SLWsje1qSjfXXR9tDshMpse9hX
        25xsSK7fy+QRNT2oojH+63MUrg==
X-Google-Smtp-Source: APXvYqwZ7A3/SO3Qyiz1HQnNKa9WPyj7Ebk6Ogmp2TQl43qx6oz1cGdoAJ6LzNGvQPj7G7ny3uHZ5A==
X-Received: by 2002:a17:902:8692:: with SMTP id g18mr4519908plo.149.1553188694579;
        Thu, 21 Mar 2019 10:18:14 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z6sm20953866pgo.31.2019.03.21.10.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 10:18:13 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        liwei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/8] dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
Date:   Thu, 21 Mar 2019 10:17:53 -0700
Message-Id: <20190321171800.104681-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321171800.104681-1-evgreen@chromium.org>
References: <20190321171800.104681-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qualcomm UFS controllers to expose the PHY reset via a reset
controller.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index 5111e9130bc3..f647c09bc62a 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -50,6 +50,8 @@ Optional properties:
 -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
 			  Note that it is assume same number of lanes is used both
 			  directions at once. If not specified, default is 2 lanes per direction.
+- #reset-cells		: Must be <1> for Qualcomm UFS controllers that expose
+			  PHY reset from the UFS controller.
 - resets            : reset node register
 - reset-names       : describe reset node register, the "rst" corresponds to reset the whole UFS IP.
 
@@ -79,4 +81,5 @@ Example:
 		reset-names = "rst";
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
+		#reset-cells = <1>;
 	};
-- 
2.20.1

