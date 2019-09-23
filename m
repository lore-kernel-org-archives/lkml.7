Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032DAC32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBAC20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnqKrCN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfIWOOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:14:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44133 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732548AbfIWOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:14:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so14095968wru.11;
        Mon, 23 Sep 2019 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8lFr4ZwIttjBYV2ogrlwO0w9q8AMXRri5mgGEzyZHU=;
        b=hnqKrCN7lLeYsPQiig8wbtkvC3eseac9EPEnUHjq3dHHrYjA6VEsPHo16jRG9yP0W5
         9CIzqMdeKZXuk3XalqUTD8USFPKaxePq2lpYU99VC47YZjROqtz3e6Hrw2aIi96vwqgN
         ShNg51yP6x3AXadrCjQZGBGWjKGhEToZ5hn4VPIKnOXeeqBIbXQQ5+1W6MO9Gjrqch1z
         /fcs4UHaMCZKpDgndKm+JMnkyyOhy/a51+4evmftLHLwY0XimYqjFJH8vXvO3mdwnIri
         59qVfJYPoDsSbCtvmp1KS0f+zAGDXrHeq+Optp+3AjrO9EOcQeeZKmRl6WZAnvru+RhF
         BhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8lFr4ZwIttjBYV2ogrlwO0w9q8AMXRri5mgGEzyZHU=;
        b=arFhGDjTRzCnwk0upmAuBS9885Xr8HIsQg6TVGcx9n92KDeMoR7pelKvrLvGmKIoz5
         59dEiLNml5labVdmZZdYjFelgE3OrTPi3UFZpd/d7JYmDR09/bob8r1z1skpKNOB3cm0
         hyVXh0joJBmzeYiM8kkwazqszZeIJfCxxD2rLhaCZZvHijYxYEhRFjzmMNAzIHcgicgL
         tF/IUOjdOk6t6K3EqPWO9/aBTBA+Z5IBhKnid9weEV+y3/eWE+S5VMq8Zi2DK1xqCrwS
         NDpKGwGZs6Jr+fuvSCRVMv8I9veRgYr8iasq/EPZvKut7LgpkUsjXRDl22u3Bw1M0Aw7
         8kAg==
X-Gm-Message-State: APjAAAXi7zgQhMtxSVFn6l8VMMbVisFimsqbeihejWFjgCpTl+rhXApd
        h5XusDB4BR49UC5KHtzPxoHPjVa71v4=
X-Google-Smtp-Source: APXvYqwaiZzlkw+r8pdoD05JXP8R8T9t0jmcqcK9qyqnQjd1fiZ/EgRLvOxtV+9EryA+EgMHDqLC2A==
X-Received: by 2002:adf:a50d:: with SMTP id i13mr15806940wrb.152.1569248091098;
        Mon, 23 Sep 2019 07:14:51 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h17sm7001700wmb.33.2019.09.23.07.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 07:14:50 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Ivanov <balbes-150@yandex.ru>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v5 2/3] dt-bindings: arm: amlogic: Add support for the Ugoos AM6
Date:   Mon, 23 Sep 2019 18:13:55 +0400
Message-Id: <1569248036-6729-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569248036-6729-1-git-send-email-christianshewitt@gmail.com>
References: <1569248036-6729-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
S922X chipset.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..2ded61d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - ugoos,am6
           - const: amlogic,g12b
 
 ...
-- 
2.7.4

