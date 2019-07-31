Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B499AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2292182B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AOy2CWLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfGaPT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:19:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46998 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfGaPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:19:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so66094070edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukIFHDJenwkznoJ0S+ycGyH8eEeHrvR6n2ACiYDuDdk=;
        b=AOy2CWLXXb5HmAhiEuMvNlpAfvbzvVTmBhdFbnfbTg/elp4wHPlGZlanZYYDI/FrxG
         XR1qjn43zM5orBwV4t3lyE99FyrF9PkSX5oImrC331w0Zqkq8aM4qZ7W1MIsKYtR1Iq+
         R9RJkh8iSQEpA340quOn7TlujXd6hrIkjm5Jm0Xb21fUTBV8fnmRZXlmIojL8rcIgjCU
         PUTp3qDE06KwYQHnhsuC+tatmmIbYIQBPxFpZQsboYojGA8UMc7qiPLpOzuIoc1jePqI
         mj+jOHlIVv7dZaf23nr1b3w0Wc5cWJIlxSvk362WiEcqLVDtgLk3XpruSZHTCkoabCWN
         v2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukIFHDJenwkznoJ0S+ycGyH8eEeHrvR6n2ACiYDuDdk=;
        b=IDuTKXakbZE8xPiY9aL+AFg0sUjFIgmJTmJ6hsjxTmBDflHqst855Pf6HYTXkuFbSL
         zvcdcwSk1ReMtHXflTYib2FimvkvTsyinXuC5ESv2nkHQeH/CDDOpKrJkXMIGkpieLKR
         hRFxi6mS0ycAisetFnJQyRUe+/cZL/BoWe5aEmmMXX47Ye7n0dU26esEPFuLuTFvi44z
         mBPngg4dTQDm6lnbqMmNNR43qZOWFACsbr9k+jqk6zSkNP3ry+g0LpTdJ5DJVfiUXSkf
         4FGQSsbuxZ0PjPNPOgWY5nNNFMOTb124hzPe+CvSbaTCEAfWoCaKR213S44RYRTzX1kv
         BWFQ==
X-Gm-Message-State: APjAAAWyfnl240+QazssT/qw+3wVvuJX+Ft1CGpZLxsziurJPW8+Pxm2
        +uAjxP+VQT/2evUQhS2PHTM=
X-Google-Smtp-Source: APXvYqySwhWDf4JA3GLQlNS2pqACUoF55kJ2wCVDTSRm+FoPw2vi1mKPJsOuuhC2eFbEA1+1nD2ApQ==
X-Received: by 2002:a17:906:1e85:: with SMTP id e5mr94007378ejj.200.1564586029031;
        Wed, 31 Jul 2019 08:13:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v6sm12580413ejx.28.2019.07.31.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:47 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 025681045FC; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
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
Subject: [PATCHv2 38/59] keys/mktme: Do not allow key creation in unsafe topologies
Date:   Wed, 31 Jul 2019 18:07:52 +0300
Message-Id: <20190731150813.26289-39-kirill.shutemov@linux.intel.com>
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

MKTME depends upon at least one online CPU capable of programming
each memory controller in the platform.

An unsafe topology for MKTME is a memory only package or a package
with no online CPUs. Key creation with unsafe topologies will fail
with EINVAL and a warning will be logged one time.
For example:
	[ ] MKTME: no online CPU in proximity domain
	[ ] MKTME: topology does not support key creation

These are recoverable errors. CPUs may be brought online that are
capable of programming a previously unprogrammable memory controller.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 6265b62801e9..70662e882674 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -23,6 +23,7 @@ static unsigned int mktme_available_keyids;  /* Free Hardware KeyIDs */
 static struct kmem_cache *mktme_prog_cache;  /* Hardware programming cache */
 static unsigned long *mktme_target_map;	     /* PCONFIG programming target */
 static cpumask_var_t mktme_leadcpus;	     /* One CPU per PCONFIG target */
+static bool mktme_allow_keys;		     /* HW topology supports keys */
 
 enum mktme_keyid_state {
 	KEYID_AVAILABLE,	/* Available to be assigned */
@@ -253,32 +254,55 @@ static void mktme_destroy_key(struct key *key)
 	percpu_ref_kill(&encrypt_count[keyid]);
 }
 
+static void mktme_update_pconfig_targets(void);
 /* Key Service Method to create a new key. Payload is preparsed. */
 int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 {
 	u32 *payload = prep->payload.data[0];
 	unsigned long flags;
+	int ret = -ENOKEY;
 	int keyid;
 
 	spin_lock_irqsave(&mktme_lock, flags);
+
+	/* Topology supports key creation */
+	if (mktme_allow_keys)
+		goto get_key;
+
+	/* Topology unknown, check it. */
+	if (!mktme_hmat_evaluate()) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Keys are now allowed. Update the programming targets. */
+	mktme_update_pconfig_targets();
+	mktme_allow_keys = true;
+
+get_key:
 	keyid = mktme_reserve_keyid(key);
 	spin_unlock_irqrestore(&mktme_lock, flags);
 	if (!keyid)
-		return -ENOKEY;
+		goto out;
 
 	if (percpu_ref_init(&encrypt_count[keyid], mktme_percpu_ref_release,
 			    0, GFP_KERNEL))
-		goto err_out;
+		goto out_free_key;
 
-	if (!mktme_program_keyid(keyid, *payload))
-		return MKTME_PROG_SUCCESS;
+	ret = mktme_program_keyid(keyid, *payload);
+	if (ret == MKTME_PROG_SUCCESS)
+		goto out;
 
+	/* Key programming failed */
 	percpu_ref_exit(&encrypt_count[keyid]);
-err_out:
+
+out_free_key:
 	spin_lock_irqsave(&mktme_lock, flags);
 	mktme_release_keyid(keyid);
+out_unlock:
 	spin_unlock_irqrestore(&mktme_lock, flags);
-	return -ENOKEY;
+out:
+	return ret;
 }
 
 /* Make sure arguments are correct for the TYPE of key requested */
-- 
2.21.0

