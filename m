Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798CC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E43A24659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="h0F9bA9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfLEXml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:42:41 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:52028 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLEXml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:42:41 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47TXMN1YsKz9vYB1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 23:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GY-RTDTUES6a for <linux-kernel@vger.kernel.org>;
        Thu,  5 Dec 2019 17:42:40 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47TXMN0XbWz9vYBT
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 17:42:40 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id u10so3883360ybm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pdZdRYJjEUXDLjH6ecgkCpYlUe5NSw8y98ikYjaziR0=;
        b=h0F9bA9gPBWqhHGztxcSe9ZaACWK7AXiD76k291yefwX093tjV7CdXxN4t9bTx+RaT
         T42W+y97udOSBhOlx/nzcZQYOLyo806uKWVtIoJhFul7qGm+4Tt45DkKKiHfGjbIyGR7
         0egnwSs320Qax6mGNYh1klTbVdb5KN5oYfdh/7J3sALZmZBOnPygEw/drcQuFc3LZQaZ
         QnZ0SuMcchPcB4zGcIr6su/rxJmaW+GvmDPx2QZ8S2sCSx+C8Ih2Lox/kSPEdfcfafXU
         DDHIAv2aIgKHoc1QIp3HVU2uDX82d7Vt9K8zyx++Gpv9TL8Q1eb+DgII9rwJ2iiGwIv+
         P4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pdZdRYJjEUXDLjH6ecgkCpYlUe5NSw8y98ikYjaziR0=;
        b=Fvc9jU+MN8jzjVT1r6RQF4+q1Qfypg0KZ4SwQTrTp2cM68GK58rj4VPDY0VM7fKkcw
         tvU0d7/C5eCTXI2rl3tck10LL57ss5TqA732mA+IeI85m7i0fXY72c341n3izXMIKE3M
         lVH34BK3BzQnpgW2XuCNfoMlVJEN2F1+1fbl8Vuqd+uSuswz5W7JwB0851rvk0BHWoit
         6sBMtAcYGcrs7El5LwkLUswMkYdY6JKdVApAZpBsYjxalAseVKv8xJm2Nj7O5xux825Z
         a+RfmexqN9hK7YmT2J9tlHqzpRnhsaZRm3p0XeraFTf2sDeDuf0WFN676SQW3k7WvZVJ
         tGVw==
X-Gm-Message-State: APjAAAU6tX8TcHvMjwDy+H/WE1YIn0EkGD/dxbHcAUuoIYzMeZUWc8Jg
        IJmtOnTM7FSlrWcFvpZn7lSraQLK0p0Xfhx59OZIL8zWkqVtI1nnX0LZBQHuZnupx0Z3zYrpHNf
        hPlAxW3YeBMyFlIAoBTCy3DhjHPh9
X-Received: by 2002:a81:24d4:: with SMTP id k203mr8565850ywk.308.1575589359473;
        Thu, 05 Dec 2019 15:42:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+x4PNK70e3ElY7ROALSM9ZNL3VxTDfROlKpZSqQ1+jPpCF1o7EJYZ7UIRDoZlqzpTBuX5Qw==
X-Received: by 2002:a81:24d4:: with SMTP id k203mr8565837ywk.308.1575589359236;
        Thu, 05 Dec 2019 15:42:39 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id v186sm5388395ywv.34.2019.12.05.15.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:42:38 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: remove unnecessary BUG_ON check for handle
Date:   Thu,  5 Dec 2019 17:42:31 -0600
Message-Id: <20191205234231.10849-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qxl_gem_object_create_with_handle(), handle's memory is not
allocated on the heap. Checking for failure of handle via BUG_ON
is unnecessary. This patch eliminates the check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/qxl/qxl_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index 69f37db1027a..45b779a8bc22 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -84,7 +84,6 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 	int r;
 
 	BUG_ON(!qobj);
-	BUG_ON(!handle);
 
 	r = qxl_gem_object_create(qdev, size, 0,
 				  domain,
-- 
2.17.1

