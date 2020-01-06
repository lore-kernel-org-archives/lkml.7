Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A430BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79990208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEOu5dAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgAFUIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgAFUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so51128766wrj.12;
        Mon, 06 Jan 2020 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JnHdGaV2EYztRNWEzGusYVpDY82eC9xf3HPJR7UpcnU=;
        b=NEOu5dAtLRDcyB3H/RegmNsINhyNORd0RjuQsDjcGYEqOvt+NU2RBuwohrmJgZkAmj
         I7ArGpaMIK4FrFBRph34NT27zbGey/SYiIss9py1LatEoVvqS4K3tTPB/FpJmlfj3TYj
         n1Zuwy7zS2zaA4WyAn169hUXjCLprEeamptgfxm4UN7RrKVPS+i+E3tXdWCx3NwgysMx
         NI1Vqouxtvm5nm35yMq8aYcEt3x0QZ/5uGfDZSv89J2bmo1yzYyOrgzvqFr0KIaj5uMq
         3nSyO7ZtxDk6YK5PWlPjLvqz75+Lb90ofal83RwMe5R1Xiw/ntW9Enm/tll9LaCWL9d6
         73JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JnHdGaV2EYztRNWEzGusYVpDY82eC9xf3HPJR7UpcnU=;
        b=L3kwqS76b0pt7/g3IB3nWDwilQ3JQwNVj8IO27ZA2KdQ2PB9uEsLpnqxEj/ReZWtUj
         FkT1nwxvD67YKNaDp/6o2u9zypsK2Al8KpuX1p7Q7VCfFBAdl5NmQfvOnGOhwqrtMp7G
         wVbz1SCSu4ytNkZ0gjEC/Z/CRfJmHn2QwMa4oZUnqHtGn8cEejyN20ggZZTtq5PyAXWJ
         MaYKvgbCFSeiHv+l6uvBVuwNRBssHmpBQx/fvo0B1uaUgnMkLmodoaqTUA4aqbI337Zl
         XjMhbZPuRR4GB+ODUHRxsQDRN+4kiDTZfrvUFlAWn/U0scI3nPDsT0LjN3REzkfoxoDL
         DBSA==
X-Gm-Message-State: APjAAAVG07gPNP468CLq5ufloMNuIm6tHQAc3tz223NUVSydKa1v//Nr
        EIDW8oyMkdQyVq/SwiHS8WjOXoHe
X-Google-Smtp-Source: APXvYqxmn5J8Z6yUBZwmv88hgBMeQiDGz/UzAEfRa75QT7cc35nPDjBwLXRfkvoc3jfsJiOXzMJHgg==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr100533306wrs.217.1578341307901;
        Mon, 06 Jan 2020 12:08:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:27 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 4/7] doc/RCU/rcu: Use ':ref:' for links to other docs
Date:   Mon,  6 Jan 2020 21:07:59 +0100
Message-Id: <20200106200802.26994-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
References: <20200106200802.26994-1-sj38.park@gmail.com>
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

