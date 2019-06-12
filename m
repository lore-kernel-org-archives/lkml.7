Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47241C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21489208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="SV7v+oSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408884AbfFLOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:52:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44255 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405540AbfFLOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:52:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so26154881edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VcpZN6jk1/9bVC0qVaIXUbUOZgbUqMWmXO++ggzEl8=;
        b=SV7v+oSlKP02RKrzvraJe/XObO6YGPhyRCJfQIZM/hN0vLPDPwy79s8HM4yqQA7uFl
         4CGyBbgaYXEs+ouckzrrSxPxMmWrtC1rAWcNVIp5zXBJ1iwQU+EA9ZlBZfllUPdQeRXI
         mGoQI/lNcJUPyK9y0shi1g1hCjmAIzA7lMOztTd5aOXCQySArEso+mWng4CgDC7Rd9nI
         J6Du7cwS/HJSExCP4xlVsBAFQJPpr6R7J6tkvKdWjraOgN2Dm7cvG+fKq7PZ9jYmDPu9
         uwhCmogKBFMz9M/ZF/ZGplvKN9bCzPkGXG4NUZUusQxFp6lw3XgltG4vWcrJGyAVpydJ
         9R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VcpZN6jk1/9bVC0qVaIXUbUOZgbUqMWmXO++ggzEl8=;
        b=c6um9bQxMmA/a3WVqkgOcJnkpiuJb1Va36CTiUp6uTBfPLjEHqN0p/eUmLH7cy4b/m
         l4mkA1wSoahuByV55Bs/Y8fqs2ByMd1ylDxHqeqCKsPWzZW8TJvLwBC75S1kdSafZ4tf
         LfgelJQZGEy9Str2Fg0XU4e/ugXPAJxsVZ1AwfJ+DhYw3h7dakjwUrCZv7ZZy3JAPu+9
         lOZWxJyqvki5A3p/m9Ye2UJWn2rGmJUC7fj5znkxdoUAeXp5ffnnHtpXtJwj3w/O6vPX
         5vq8G2hx/iSOCJipRo5h5ksgGL/E+ExDeUNAGaXffZf0rsBq8yqPbCM3YcpAKVEtEbJb
         kWwg==
X-Gm-Message-State: APjAAAWa3GDla+m3ycsMiQi8PjdqkCuhveptOMtKOc+dQNsmKUlnfduH
        jGfsc0GN2mEcSaUsmL//g0zTWQ==
X-Google-Smtp-Source: APXvYqzuvIXLNRoinQlWVrHS5zBEX1xZJq+QjAYHK9QzUA8loRvePk582eNBHyepokc80P+I8EHYhw==
X-Received: by 2002:a17:906:7d4e:: with SMTP id l14mr22796555ejp.188.1560351162223;
        Wed, 12 Jun 2019 07:52:42 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id h18sm26229ejt.5.2019.06.12.07.52.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:52:41 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] MAINTAINERS: add counter/ftm-quaddec driver entry
Date:   Wed, 12 Jun 2019 16:52:23 +0200
Message-Id: <20190612145223.8402-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintainer for this driver

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..6671854098d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6218,6 +6218,14 @@ M:	Philip Kelleher <pjk1939@linux.ibm.com>
 S:	Maintained
 F:	drivers/block/rsxx/
 
+FLEXTIMER FTM-QUADDEC DRIVER
+M:	Patrick Havelange <patrick.havelange@essensium.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
+F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
+F:	drivers/counter/ftm-quaddec.c
+
 FLOPPY DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/floppy.git
-- 
2.19.1

