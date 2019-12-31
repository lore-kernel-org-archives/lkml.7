Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796D206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hePclLS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfLaPQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so2069625wmf.2;
        Tue, 31 Dec 2019 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JnHdGaV2EYztRNWEzGusYVpDY82eC9xf3HPJR7UpcnU=;
        b=hePclLS7i3OzVaMuvM1NYINH4n6cJpNx1kqWuxiyOESHzYvPrtaB4pe6x8VGpmFQ5r
         6faEdO+yI9sopEDrpSPpkh6fzLRMD/SS5sNvN8+hvOYdhEHfJYzLGuhs3mMksitQtwcG
         cWW6baz6Z8w8ER63VMWEW3Lu0ZyBVkjdQdaVe2tMJFLGx68UbhLoFXel5nYocuyW3oon
         O1DXOpkTsUnyAeJthGrfjnkHy6IBcuycUj2gUCvOQwI532hUHmRGqs/zCgN3ub0WCrm6
         G2fyDrNPSvoB4TKId2+OJsOZhO+Pim55guzaDguMV6ButumbiH1+eERbK7Sv5eECTe3w
         px3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JnHdGaV2EYztRNWEzGusYVpDY82eC9xf3HPJR7UpcnU=;
        b=aZilCx/HK/8nryeRQm5yHpQAkSvrr4VhkMxbB2oZuc8JKDBuD7XA1cIQD1ndnVl9R1
         RG1m3Dk5GqVWVhYTWSkqEyMSgbPvazQFJt/Z94UylyrW32SznC2fToMTcAxXo+tdhaOH
         QiccewdIdWUX7x4T5f097M+hU6CLwaldXBqC7EjIkwIfWpMP3nZFrB+HmD6r5COqicKf
         mrvUqY0vUcFDxuqWuC3p6Pe6+6MArI1/ZLoEgIJ9Zuk8mHM/qXoQV+R068FZipcl23MI
         cNljF3SUQba973Bn1nx+CCugr7uVy5p9DKlI2JkxOKIu/2/QzL91Uijb+tvB2gUKCTN8
         3hjw==
X-Gm-Message-State: APjAAAWwlPWvVZY4tx9EXKFgvMVk3zEHIVq3bOLCQgqKgOwLj0WmnBaE
        oco1Y6E/fWjyOxm6QQQD0PvrDblhd7U=
X-Google-Smtp-Source: APXvYqzlRTk9w2B921KGJceQlHsXVKusg3BiCjxha/HlLbDewSERlFQxsVtBQmkFSvF9KNjhvJ+HXg==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr4845448wmf.113.1577805364433;
        Tue, 31 Dec 2019 07:16:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:03 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 4/7] doc/RCU/rcu: Use ':ref:' for links to other docs
Date:   Tue, 31 Dec 2019 16:15:46 +0100
Message-Id: <20191231151549.12797-5-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 8dfb437dacc3..a1dd71d01862 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -11,8 +11,8 @@ must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
 a grace period to elapse, then free the element.  See the
-Documentation/RCU/listRCU.rst file for more information on using RCU with
-linked lists.
+:ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` for more information on
+using RCU with linked lists.
 
 Frequently Asked Questions
 --------------------------
@@ -50,7 +50,7 @@ Frequently Asked Questions
 - If I am running on a uniprocessor kernel, which can only do one
   thing at a time, why should I wait for a grace period?
 
-  See the Documentation/RCU/UP.rst file for more information.
+  See :ref:`Documentation/RCU/UP.rst <up_doc>` for more information.
 
 - How can I see where RCU is currently used in the Linux kernel?
 
@@ -68,9 +68,9 @@ Frequently Asked Questions
 
 - Why the name "RCU"?
 
-  "RCU" stands for "read-copy update".  The file Documentation/RCU/listRCU.rst
-  has more information on where this name came from, search for
-  "read-copy update" to find it.
+  "RCU" stands for "read-copy update".
+  :ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` has more information on where
+  this name came from, search for "read-copy update" to find it.
 
 - I hear that RCU is patented?  What is with that?
 
-- 
2.17.1

