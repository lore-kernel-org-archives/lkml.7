Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2627C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A211A20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cihfZ+Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCKHGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:06:19 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:52836 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfCKHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:06:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 585DD7AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J2GbdaFrIbU4 for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 02:06:16 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2BB9D826
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:06:16 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id k2so3516436ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bvO7v7oxdUe9xiXt3S678nHr/b8b0DJEbTnfoL/BRME=;
        b=cihfZ+SqY9xq0NaaxaYR8WyiVnCZstf6DcJBgxwndsqZS4NzWGLp1eg86VHMuut515
         2bqSs4xqrl8AEz8XKKDLnXCNuwUklWkMoauXgDeVMOQo7JUiEgfdmdN+deJ2a0SEf3Pm
         KrXKiyDPjH0pk+WwDVj7/DGR5CyVrXgJwBkCiu97K/+b1mdnP+RcMJTs9LdpG+d21p3C
         cXr2bgPEhXXjXycaS2lWWuNwsKHLDlrC6aPQasNdgoVrNcBs+Jqsyb63yo7kMGQNVQdx
         gBYsCEZP5cf0PhL6qb5F7uKq/6y3RZqZsTe5c70TRbxkuU9N4EN9Rv3tXNuYJ/MgHeRL
         Uprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bvO7v7oxdUe9xiXt3S678nHr/b8b0DJEbTnfoL/BRME=;
        b=Ak9brv1eNPxFfFoNujSIXPF/d9gU6atk6xa/TlOJOzJcevNZbjZFZIKiByOWZAyuIt
         jpBEEBZ1bQW25b4g/e3bZZh/4VfDO3nWq4RtWBcKls0fncnXzBxlIJAIyp74yLNrEceQ
         UB+Zql0k06MbM3YWXtkrBOVxC8+PHogq/HKJWp+c84iXM+QUu6t+y+iBmO3aK+DRHViq
         9ChenN9QOUyKNbfZ81VdaR4sm+jxRzqGvkuLfvqRIishXB6v11izjN+zquvv2GHCZa8P
         Fx1OJSguo+SLnSuQzONfFFxvNOPhiKU3zfHga4Vklst19/GjvwTNMvQpKcNcUJI4K2hH
         7yfQ==
X-Gm-Message-State: APjAAAVJ96pRvS6qUO4p30oH+3f+RVVKMoLcjm64yJC2oZ5yowl2wplc
        QcrTjiAzpjJP2rpkxSsb72TBW8Kvaf+kdAt7fJfJvq17q5Rw+/QrT3VkHN7cS415DhY/hZzNyLf
        OK7UHQW/g2eY4x870VBeX2lGahc7u
X-Received: by 2002:a5d:8905:: with SMTP id b5mr17530816ion.241.1552287975343;
        Mon, 11 Mar 2019 00:06:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKaMEJ8r0XV+XO5t7XnDWfO48FKcHRqY1LJfmohesNx6d12OCvW4czkOpuSpfg0fbuhvjo+A==
X-Received: by 2002:a5d:8905:: with SMTP id b5mr17530804ion.241.1552287975110;
        Mon, 11 Mar 2019 00:06:15 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s1sm1883981iob.32.2019.03.11.00.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:06:14 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: rocker: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 02:06:06 -0500
Message-Id: <20190311070607.25859-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kzalloc fails, the fix releases resources and returns
NOTIFY_BAD to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/rocker/rocker_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index c883aa89b7ca..a71c900ca04f 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2805,6 +2805,11 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 		memcpy(&switchdev_work->fdb_info, ptr,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
+		if (unlikely(!switchdev_work->fdb_info.addr)) {
+			kfree(switchdev_work);
+			return NOTIFY_BAD;
+		}
+
 		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
 				fdb_info->addr);
 		/* Take a reference on the rocker device */
-- 
2.17.1

