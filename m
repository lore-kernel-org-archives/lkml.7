Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71428C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA702168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8T4eCKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEYISc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:18:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46585 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEYISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:18:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so1825923pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=urwobqpVOqeWHUA2ik1ydI/vY7DJ9p3a1at1hajr40U=;
        b=S8T4eCKaCoYsoURxZ5mZBNX54bF7p1VWFjVaAtDfSyoYOL1oGf/FpFWkPfTaqRIwuS
         uXtpM6TcZP+6F240cKgqYAMOonZlz9PyjkeP9ZhY5VIFgGK0/GXVnFJURRZJeTqbO/sR
         JKEWxmzoEtnWUczQyQvw8qAjvsYBQVJb/FKjjOgouFLT9yh0ZFgcZAuxWFiDTkFy4167
         63gKGjTFSu4xM17yJajcm6Wgz1FezfIptRs6ODVZvT34GZ1Niv2HLUdc1er8LwZG1VYi
         QGdDyOVTvrh01VbOH6SYZDDpYB9GVPLTRGH2clzU0oGihl9mh8RRq7lbXeoy/MO3cRAb
         xCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=urwobqpVOqeWHUA2ik1ydI/vY7DJ9p3a1at1hajr40U=;
        b=MwiV606s6Li11VSbM5+8PfGge99NuH1AZlB+iHxgN76WMRxra1RnWSWgI2jlV+0HWC
         9o+jZxm80nJTKL6fnaHmsOkti8HRvmW3BfrWQo+qLhrsWkQuiRyX4VUT/OoaHk9xaoiO
         gWvLNsaYOPqqgygWSLCml8UvqwFcnPMlZGhVKoDcHdKCRCQjVw1P/w1tdRSUm0hgCZBQ
         d5I6ryiR5NrcDpUjxepf6iY4mg89M57wbxjJ5PTkgyXdwvHgYpH0NPCr8iufgjTeUXWG
         8NBmSnp5UeWQOd+g5YjBo6uiEeINNXUXeRQLIdnoNCicKfrosoF0y5wsqWo67aWrkITB
         zsoA==
X-Gm-Message-State: APjAAAVhqKwwgeeKN/hay1EuZPzYLbB+VfgzCDW/mwxSFOoJVy73A9yx
        JG70oZZ+5E0JIAKAxz/FcL/+XvSe
X-Google-Smtp-Source: APXvYqwVnT/dAB9dGOwGLRu5tGnahqFl1pMKIgJnXcVKcQB8TBxC/YB0ec9BzvU9W4fuwa/WtKEAGQ==
X-Received: by 2002:a63:4006:: with SMTP id n6mr111844911pga.424.1558772311004;
        Sat, 25 May 2019 01:18:31 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id b3sm6763549pfr.146.2019.05.25.01.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 01:18:30 -0700 (PDT)
Date:   Sat, 25 May 2019 13:48:26 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/dca: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525081826.GA9002@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

./drivers/dca/dca-sysfs.c:43:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/dca/dca-sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index 126cf29..5270705 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -40,9 +40,8 @@ int dca_sysfs_add_req(struct dca_provider *dca, struct device *dev, int slot)
 
 	cd = device_create(dca_class, dca->cd, MKDEV(0, slot + 1), NULL,
 			   "requester%d", req_count++);
-	if (IS_ERR(cd))
-		return PTR_ERR(cd);
-	return 0;
+
+	return PTR_ERR_OR_ZERO(cd);
 }
 
 void dca_sysfs_remove_req(struct dca_provider *dca, int slot)
-- 
2.7.4

