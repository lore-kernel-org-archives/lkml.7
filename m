Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DB7208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="IOKuLaqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfGaPY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:24:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37828 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfGaPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:23:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so66107082eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nUUGiekxDXyLHELJNk1/crPjGXFhQCWsxTcExxSHys=;
        b=IOKuLaqnLIIvDxh8sGiA5Ti1EgZD/pb+tvmY2A/5Qcpvrnrj/8Q6+39fm9WysKchIW
         hxGKfQI/tErC99xqo32YRJXMLxuXvw7D5FxRJcrBpR8LO7tBGljabTEW8R9zvaZ7Gtu/
         5JhEe4A5G3i8YpbuhOwyBAKNi3WqHjxlhczPzXXfzxS1YgpNI6CrX/YkA/t7pf+O56zg
         jZvbsgItFZICFlQrj2qkMS9K0sSkOv6pJAFh7XH0Y/DNZ6ULvgHOHCZfkaErZTNsmjQb
         h2tqUsjMeDmKdo4PyoPbBB79hWABkWEqSQS6tHXaEaeEcq0q3LGFncuHeCOpiPphT7io
         M6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nUUGiekxDXyLHELJNk1/crPjGXFhQCWsxTcExxSHys=;
        b=QREi9jWZFmOJtlGq4j/AXy6n4dd/J1rJY1tFFnyEV5dIWhCgyrRM1ZUkvXHNERF1t0
         iJvD1CwFbOGpU0cbMsGf7edYB0Z7997Dmm1bCGS78uUp90QGiVp7O6UTSF4jdi6MSDk1
         8+hEeLXtc2anyqPxQIrk0fg/UkQgBeoyDRlNijo/9Ux2hALblYi8/F/kEr7ripUAu1Wy
         3VRn9P5nPCVeVHN+xsT4QkyOeJfXfAIRp0vNPLurF1W0sxHJvI9TxHjwFHuxAFnRNFAx
         e+0GXFkz0sZE3RYfF1nCSuhO5fsfxnEDVLQBnwTZpHk7M/FuzqFSv4Y9jgotW69I8soX
         zeMw==
X-Gm-Message-State: APjAAAWvG8U5ZMrOwmrbBk+bKe5DvWZTMuJkPIwQ/pbLMYZQhR90QBoS
        jz9CXu/WYqtoSbRqyPAeGVI=
X-Google-Smtp-Source: APXvYqyocU9LaLEieM1frl2MdSDXaIV0gvyho3ioPkKIqAAuamyJHGIwJo2jc8AHxo4CrQ5fTnM4cQ==
X-Received: by 2002:a17:906:9711:: with SMTP id k17mr96659095ejx.298.1564586629507;
        Wed, 31 Jul 2019 08:23:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 9sm8073168ejw.63.2019.07.31.08.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:23:47 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id CD18F1044A7; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 32/59] keys/mktme: Clear the key programming from the MKTME hardware
Date:   Wed, 31 Jul 2019 18:07:46 +0300
Message-Id: <20190731150813.26289-33-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Send a request to the MKTME hardware to clear a previously
programmed key. This will be used when userspace keys are
destroyed and the key slot is no longer in use. No longer
in use means that the reference has been released, and its
usage count has returned to zero.

This clear command is not offered as an option to userspace,
since the key service can execute it automatically, and at
the right time, safely.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 18cb57be5193..1e2afcce7d85 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -72,6 +72,9 @@ int mktme_keyid_from_key(struct key *key)
 	return 0;
 }
 
+static void mktme_clear_hardware_keyid(struct work_struct *work);
+static DECLARE_WORK(mktme_clear_work, mktme_clear_hardware_keyid);
+
 struct percpu_ref *encrypt_count;
 void mktme_percpu_ref_release(struct percpu_ref *ref)
 {
@@ -88,8 +91,9 @@ void mktme_percpu_ref_release(struct percpu_ref *ref)
 	}
 	percpu_ref_exit(ref);
 	spin_lock_irqsave(&mktme_lock, flags);
-	mktme_release_keyid(keyid);
+	mktme_map[keyid].state = KEYID_REF_RELEASED;
 	spin_unlock_irqrestore(&mktme_lock, flags);
+	schedule_work(&mktme_clear_work);
 }
 
 enum mktme_opt_id {
@@ -213,6 +217,27 @@ static int mktme_program_keyid(int keyid, u32 payload)
 	return ret;
 }
 
+static void mktme_clear_hardware_keyid(struct work_struct *work)
+{
+	u32 clear_payload = MKTME_KEYID_CLEAR_KEY;
+	unsigned long flags;
+	int keyid, ret;
+
+	for (keyid = 1; keyid <= mktme_nr_keyids(); keyid++) {
+		if (mktme_map[keyid].state != KEYID_REF_RELEASED)
+			continue;
+
+		ret = mktme_program_keyid(keyid, clear_payload);
+		if (ret != MKTME_PROG_SUCCESS)
+			pr_debug("mktme: clear key failed [%s]\n",
+				 mktme_error[ret].msg);
+
+		spin_lock_irqsave(&mktme_lock, flags);
+		mktme_release_keyid(keyid);
+		spin_unlock_irqrestore(&mktme_lock, flags);
+	}
+}
+
 /* Key Service Method called when a Userspace Key is garbage collected. */
 static void mktme_destroy_key(struct key *key)
 {
-- 
2.21.0

