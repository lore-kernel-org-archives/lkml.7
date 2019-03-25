Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B930C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF52070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FVYdD+cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfCYVgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:36:23 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45088 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCYVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:36:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id A4973A2C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yC0itTaAB4vX for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 16:36:21 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 7DDD5A42
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:36:21 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id r21so8746717iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g601nBRwh4LxhUF6344o5lBNrR46nPwpXk2iHQObz+U=;
        b=FVYdD+cUCKCIxxkEq41vsBRkbkNrPKHNwdzUcvQLOqWGVzAW8hxZZTc/iubZm+Vvlu
         2f+HipoRBwl2ka7QLI/Sy+zRf7GWUUk8cwIPRf8EVLs2zLFHyeDflbLaLlFI2xadi3LG
         TAI+gqDzEhw6K5y/HLUv6R1RHwqLCNMUV/HPpFBwg0b7bM1Kajwu0FMpTXLfoyxAvO/R
         31GEXC075gH42GO1WKQx+b3euuKAaiEZ33zqBMCQANIo26p5dEhSU+DI80hTRApNrSpg
         7ZAcHyJM1VBnITYVjMI3Qk0d6hB8+eS4Sqx9Gb6kM49jan/WXFwZJXoNYWAvGitY8BL4
         tCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g601nBRwh4LxhUF6344o5lBNrR46nPwpXk2iHQObz+U=;
        b=XIQy9dY+FRCLQlHwzEfAuNvgBqYnemItIhBK3YSFyHdp3JJXLhadB7Aby9QuFuEWc1
         6gBK6LdUClB7Wqkn0BqwshMAikcHwkBc7xHAJ6J3Y53mB20Qr6C+Hc5BFWhlMr0LhIHU
         jSKM9Rqety0GRnnkXB3VmwBocZk0IvxAk7C/jWQbunx0ztd1IvKEvJ/l3Y6vqspr3cia
         SyMtjd6UUmV4QqG80klHtX3xojUPtJicMhdwmFqLhcYhxywYe84cITV04drzYedk9KZU
         0c/3BZIHvjvXv1IZv0oGC66EOlShC+4grbVpt8k0wc6EBtjsG6boowZOPtK3+iYKm7XL
         f6Bw==
X-Gm-Message-State: APjAAAVk4l3ufz5C67214KeJSWpSeGeqHhemXpe9dGwrZaP4u7cGHPv5
        AVd87JrgJD/3oxXTCgx0lsaxlrKvkXH3KymaibXHKlO38cjcCnF2g2zSn59dIdNrm5+PG1D6tcJ
        Ez2cixJA7Z78LUIWCpBu2vX0ufBps
X-Received: by 2002:a02:ab95:: with SMTP id t21mr18461977jan.89.1553549780965;
        Mon, 25 Mar 2019 14:36:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwy1O1hpDfyTCF9/VtofsWjpIk8HUOoCBLDx2F4KIZnVPA9TgidPvxLa5Jw8GRXLocDUJGvNQ==
X-Received: by 2002:a02:ab95:: with SMTP id t21mr18461960jan.89.1553549780791;
        Mon, 25 Mar 2019 14:36:20 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id p18sm6375798itp.10.2019.03.25.14.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:36:20 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvdimm: btt_devs: fix a NULL pointer dereference
Date:   Mon, 25 Mar 2019 16:36:18 -0500
Message-Id: <20190325213618.12139-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix releases resources and returns to
avoid the NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Replace incorrect kfree with ida_simple_remove, suggested by
Johannes Thumshirn
v1: Free nd_btt->id in case of failure and avoid double free, suggested
by Dan Williams
---
 drivers/nvdimm/btt_devs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index b72a303176c7..f73fb5fdc93f 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -204,8 +204,11 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	}
 
 	nd_btt->lbasize = lbasize;
-	if (uuid)
+	if (uuid) {
 		uuid = kmemdup(uuid, 16, GFP_KERNEL);
+		if (!uuid)
+			goto out_put_id;
+	}
 	nd_btt->uuid = uuid;
 	dev = &nd_btt->dev;
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
@@ -220,6 +223,11 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 	}
 	return dev;
+
+out_put_id:
+	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
+	kfree(nd_btt);
+	return NULL;
 }
 
 struct device *nd_btt_create(struct nd_region *nd_region)
-- 
2.17.1

