Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5E1214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gMLEjxwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCLGQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:16:54 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:41360 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfCLGQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:16:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0ECB9A98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3DUipOhhZ4i2 for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 01:16:51 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id CD83C7B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:16:51 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q141so1349770itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/iMNiJvfEscsi58jKgoeUADcaa6upF9XiWwfnWbBtSg=;
        b=gMLEjxwp9VC5wOoH+FEHXOF799h6e4TOQXgsJkkJXCMMPF50e6hp5NJY686kGaiBGw
         cWAHuWyo0IOz5bJ/m9S5AMgJk1rDvqHrw9kODDp87UW6oA6NTOJLl6K33R7cjlgMOada
         6/fwtFIFoRu9x7cq6YIo4Z9E/DB2DEfnE7D6Julq3+22AbmkjEZqA6vZ1A4SLqZCu4KS
         EiRBWbrZ3h7fNdFWIBD22VONRp8/aReneQcnV4Wc5TXYqcLP+Lz9DtKzTtqC2UhfFg53
         Tzpk1erq0jlOZMDNPZ4zRL1EUQl3Tapq/hSUqRXlhmgJSdCXkCLqil8huo1OM5u5OFSO
         8SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/iMNiJvfEscsi58jKgoeUADcaa6upF9XiWwfnWbBtSg=;
        b=qy6V8DnD/NICyjuzEO2FnSE7E/oyva8B570QuBWrQSPQt26pWcXuuicfBn7ofzbdhi
         ghBGLZetf5xp7/paKT6vGRjVhayOPWcAH1/7Sgu2qa4ml9yJbB1QLdnjj0c4dW+Q7xS6
         V/UdFrCttYKQNn/ofblxsHYerVzH6HMrRNExvh9IZu+BOiJ2c4HvXDigc16e1GH2avC/
         TduJe3wjANvd7sXqqxaQyRU7Yc615ialyADs8NUWajwof+ZW33PRFMpqkekEBux+HjSb
         j8ue9jPJCsjgowWsDGcQrRwYrZnP9BfKAduJ92lz1P3iPCjy2X5yvpQUROpbA0fjgfAp
         PcNw==
X-Gm-Message-State: APjAAAUynlEFS/u6tTTsa5sbyjvA0LYngWZ/WEwbebbXBXA0lS1KZCx9
        SOOOAWZgezLJpCcZjj4sway8cye0Qy0Y9+7QeKSoQDTmyc2M5YkfLTiP/E+RwG42dEY5Uvs5Xzy
        J33JCWFmquUiFdVZzrmquSsaLw/xd
X-Received: by 2002:a02:660e:: with SMTP id k14mr20460852jac.34.1552371411417;
        Mon, 11 Mar 2019 23:16:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzOvYXxmfTmxihR8aYpzT8CwZJj0t8G9koKU38XFrwh38WgcFvImiJg9A4u9D8BZjjjqy3GaA==
X-Received: by 2002:a02:660e:: with SMTP id k14mr20460843jac.34.1552371411118;
        Mon, 11 Mar 2019 23:16:51 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id d135sm848697itd.43.2019.03.11.23.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 23:16:50 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hid: logitech: check the return value of create_singlethread_workqueue
Date:   Tue, 12 Mar 2019 01:16:28 -0500
Message-Id: <20190312061628.13869-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
References: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_singlethread_workqueue may fail and return NULL. The fix
checks if it is NULL to avoid NULL pointer dereference.
Also, the fix moves the call of create_singlethread_workqueue
earlier to avoid resource-release issues.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hid/hid-logitech-hidpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..1b7c336cae6d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2106,6 +2106,12 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+
+	/* init the hardware command queue */
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq)
+		return -ENOMEM;
+
 	data->effect_ids = kcalloc(num_slots, sizeof(int), GFP_KERNEL);
 	if (!data->effect_ids) {
 		kfree(data);
@@ -2154,8 +2160,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	data->gain = error ? 0xffff : get_unaligned_be16(&response.fap.params[0]);
 	/* ignore boost value at response.fap.params[2] */
 
-	/* init the hardware command queue */
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.17.1

