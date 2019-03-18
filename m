Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E112AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADECC2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CPBt6c/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCRXEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:04:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58832 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCRXEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:04:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 75CB3B6F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dNazn7AxCPJd for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:04:38 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 449D5BC4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:04:38 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id s184so2368893iod.23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r+eUpa3ovVvi2jvnpoCV250+eraJD6oc+4vj8+nrBpo=;
        b=CPBt6c/Y5sfB35HnLXEAfSdjV1AeuayWKomQ5lpoECDMoPXnSaDsx6j2CglKRsnNEh
         uggzNFdrC7Qn1K4KX4g7UlOPMpRPxBoyNv+nSvCDQsN5Eln7lolo+O13MZv7FFXJcHjZ
         9xdScl6FYfGRknNjVD95OaaqdGKYj7j+aPmeZG6fbNgLBfbzYFckyiio3WuAAT9vLFPv
         fwcYIDX+J9bagyE/+HYcj7WbZGupvOVXCQNNZBbnNDykJWY/Go+/EBc+Atrp3d3NHEJ1
         DNeKY6l+6MaX8gwfxHvJ/ENyZgF045tHRu8KqzdQ8pgEFPDAp+NtfJnnhbFhJxd2FSG+
         ChpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r+eUpa3ovVvi2jvnpoCV250+eraJD6oc+4vj8+nrBpo=;
        b=uIB9G6fRiPYVHIyV0ukvGVzmUKL0XkVQKZmDCYPBDSRAbvexiWXwSDHVeKwlQ0Orit
         2jZ45Xay9T6HIbvzf99ntJkusPWvGXX+KIeR0j0V8bt8edixZmR8q7TnIgdOy7GZXINO
         lWIqtsmaiVyaNfRImknVJWKS5sqOg0Bq38NbgyLmD4CwsEHE6dpTZnLajvMTo08eAzPo
         1UJRwZRLtWv3Iiq5+D7CWZJfAC0LBOblS14LEIOlyQIZ7/q8VqLr5cAzWqjJz6VMY//k
         XIdavC9j2sjWis5uFfqK5/+9KhSI6KsXmtF4AUcWEyRhN1fbnqu143Ov96GyL06AwqRz
         MzzA==
X-Gm-Message-State: APjAAAXh/oXXMwTN818Vbia/1yzOcnXgL1QQBwbZZ2hU9EJ49lT+9spW
        GBYp5t6mQNOAAjoOUNENvT8vD1F52LoEQZfhjOTJnwbSTTG7mz6z/z5Gxg8QfKcPoM5ugMiYdqA
        EUacvWGjFahfLkd4ZmI6+LTLfSqPA
X-Received: by 2002:a24:2251:: with SMTP id o78mr932967ito.134.1552950277554;
        Mon, 18 Mar 2019 16:04:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwf3cdqM6bIUchuphcQjV4XHh5DwgbU6QDebzJwSbXHDdqK4cCphNA2dpQrydGSglmxecVnkg==
X-Received: by 2002:a24:2251:: with SMTP id o78mr932951ito.134.1552950277360;
        Mon, 18 Mar 2019 16:04:37 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id n21sm4765957ioo.3.2019.03.18.16.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:04:36 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Fix to check return value of of_match_device
Date:   Mon, 18 Mar 2019 18:04:30 -0500
Message-Id: <20190318230430.8273-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device can return NULL if no matching device is found. This patch
checks and returns -ENODEV in such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/firmware/arm_scmi/driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8f952f2f1a29..0e0330b44b7b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -799,6 +799,8 @@ static int scmi_probe(struct platform_device *pdev)
 	}
 
 	desc = of_match_device(scmi_of_match, dev)->data;
+	if (!desc)
+		return -ENODEV;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.17.1

