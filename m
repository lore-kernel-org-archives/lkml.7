Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1498DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73332085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QWbGWtn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfCNFYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:24:12 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:32846 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCNFYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:24:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9B42ECF4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1D59oec6CvI5 for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 00:24:10 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 62361C8D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:24:10 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id 142so3654956itx.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ijSfNicS7SkNZfR/waD6KTfAoFyPyUvljJrd8v/Py/Q=;
        b=QWbGWtn0IM9M1eVQTT/Gw5EUWIlWLKlJTKkXp3FLF4nMDq0NmUqmayntg8LVaBAFKd
         kTihqCsipRQMhRGno5FElfANq/eZ1aOkpFEtcYR9Pg7jTrnMxrIHKNte/zdUmbsil8eO
         c6Bghu0j7tdiPlJAgEaPyaBge7l+oY1XDL248f9lwh7hgfJMOhAjGmDxq3eNR23/rndA
         V2o1e/nqAs5wf5oS6+vMn4CfcFnZI4PL0Mmv8OSFNi8VfcVYaTukBgymjJUBCZUX2+iv
         24esL/IKILT2LbwgXuP8vBIE83BFKT+zi7WT0woMeFANOgYj1eX5FEFOHU0OYoAT63Qi
         dRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijSfNicS7SkNZfR/waD6KTfAoFyPyUvljJrd8v/Py/Q=;
        b=VHcRzbmG1ljHKNQGtOhCzubnmS4yRWXABGO3cZmrzP28On0rv0dvFDe0bk0/ryu7/Y
         5gwpipz7xKH4K8pA79ZTg5ZxS8c3klE7BlP+jPP9vAGt6WqAjVP/KfanRBTgG6idw0+L
         fyef3otPrqKQxJGFNivVfy3GMueDAsiehgvMLXGmF7CQGUBg2BOnqKXp41GvJlVtiv/9
         itgOi3R3z5AZoCvQaiqyR9vqibr0uRKiaeBqxuNJJsfcwwdG+R4z7f2jmm02dThTS7lL
         iZw8QGgtrsUTYrP+/b8JurCPCPTaL8btBko/3sSBpf7jkcECQFE9/qph6GurTaWVzvET
         a39A==
X-Gm-Message-State: APjAAAXciZPokRaD5rU0K1RoahMIb9NxTNPWwBfhl3IhOZmxRyCNSeqt
        ROpw4tJ3tsrplhAjqN6Eh4MCHMpF6D37EEwMNgrDUxkw07yu2qmF+Mmw1Yt14WzKJ3VJiJkBonv
        Ye6U4iP3VvWjaQcKbdr8tdzI77xuz
X-Received: by 2002:a02:6341:: with SMTP id j62mr8263319jac.27.1552541050012;
        Wed, 13 Mar 2019 22:24:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdR0+YMP/Fw8LwFRspcHb7U98b3dTDkUYuXQfPpmZd44SVxCkH0cTlcc9H4aW81Pb8QdYADg==
X-Received: by 2002:a02:6341:: with SMTP id j62mr8263310jac.27.1552541049780;
        Wed, 13 Mar 2019 22:24:09 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id f132sm5948292ioa.76.2019.03.13.22.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:24:08 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] hid: logitech: check the return value of create_singlethread_workqueue
Date:   Thu, 14 Mar 2019 00:24:02 -0500
Message-Id: <20190314052402.31448-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312100233.106098c8@lwn.net>
References: <20190312100233.106098c8@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_singlethread_workqueue may fail and return NULL. The fix
checks if it is NULL to avoid NULL pointer dereference.
Also, the fix moves the call of create_singlethread_workqueue
earlier to avoid resource-release issues.

--
V3: do not introduce memory leaks.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..0a243247b231 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2111,6 +2111,13 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 		kfree(data);
 		return -ENOMEM;
 	}
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq) {
+		kfree(data->effect_ids);
+		kfree(data);
+		return -ENOMEM;
+	}
+
 	data->hidpp = hidpp;
 	data->feature_index = feature_index;
 	data->version = version;
@@ -2155,7 +2162,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	/* ignore boost value at response.fap.params[2] */
 
 	/* init the hardware command queue */
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.17.1

