Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87C2214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IQKBc3XP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCLIdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:33:42 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36674 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:33:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 2BA0A110
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vQAYnxlJ9R7B for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 03:33:40 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id ED5C1126
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:33:39 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id a9so1262550iol.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1Kj4hoC9dITtNIrl+8snzf0Zk7unP3O6zZckjwOk6eY=;
        b=IQKBc3XPE5JCHoW53Cy8XA0rofA+dJ0fdn22VJu+f3gypErflNzqk0WhJLE7kfuoVn
         iHlFv8xSpGyriJrCnTSIti8Ek6tD3G4QwMkSLm8zINdeg5XYyjhXjlcba+Mih67PKIAf
         KW3Si2lLYqRuYG9xNDdUoJiYd0LRblowqrZKaUhTz+1LlOqPRkKehP7WP1ECiAaWLy7/
         d1yNUP5quPYX/D1em7CPzXDwv/r1YT2dJZcN9Pog2Z1wf/WXxHzSPiG3Kj/GfVRUTNC0
         fJMSlQkylPEBXO0QqZfdt3/86tx8HRA6uJshYATL07whQ+IKN/GMnqjtFw/hMdLJ1VPa
         6lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Kj4hoC9dITtNIrl+8snzf0Zk7unP3O6zZckjwOk6eY=;
        b=QMWBtaE3ZKYzgK3/afacB7kjQfqb5boCFdGBjJrBaesHKlakwCdR7AzJQFmNU/kbBV
         WfsDnqVoNcLLBCmeteLnpXghife/sMLvNhvfL39uorm5Nw79K8oJ/GpceOzNdhTlIn1X
         VP6fIQ43yD/hghVPNLHo9byiO3vFteESJShG/+OC04HXLp1nLS/tyDiY1iaZKcf9W0+c
         x8JelVqI1BrkUdcLDXl5zUn6Oi0fud5aIvz4/WaIfa89yCJB8Y7gM8EoQgzHdcZ1m1/8
         iuUmN/rorMjfwsG77XNxxcqRSeb/X/SYzlgy2DUnTup9gZ2ed01Hc5wsPCrPqbwAj/jX
         wz0w==
X-Gm-Message-State: APjAAAU+PvzEPe9V9l22rw6x149/ifrRESvnZcyUGalH+i9ZSs3W2StO
        xXJUm75p66kHcrAQZRHOrXYnzbSqXNUbELnLlZWuAVpH4Rtmeitx2+icqDpYa74bC+4xghE0oW6
        WCsG3gxBNBdv0ALXOY2EHWr1ykVvg
X-Received: by 2002:a02:8a44:: with SMTP id e4mr4268986jal.77.1552379619629;
        Tue, 12 Mar 2019 01:33:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxibWCDg+Qn7G0FBvsRWNKaVFVAu1MG7uSjcDt0tRDtvRQpaCXhMuXIVV1K4PLD73afRfRJFw==
X-Received: by 2002:a02:8a44:: with SMTP id e4mr4268972jal.77.1552379619387;
        Tue, 12 Mar 2019 01:33:39 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 197sm1138931itz.24.2019.03.12.01.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 01:33:38 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: property: fix a NULL pointer dereference
Date:   Tue, 12 Mar 2019 03:33:28 -0500
Message-Id: <20190312083328.7793-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kzalloc fails, the fix releases resources and returns
-ENOMEM to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/thunderbolt/property.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index b2f0d6386cee..ee76449524a3 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -548,6 +548,11 @@ int tb_property_add_data(struct tb_property_dir *parent, const char *key,
 
 	property->length = size / 4;
 	property->value.data = kzalloc(size, GFP_KERNEL);
+	if (!property->value.data) {
+		kfree(property);
+		return -ENOMEM;
+	}
+
 	memcpy(property->value.data, buf, buflen);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.17.1

