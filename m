Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDCFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC03920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GgMDYljg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfGaPUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:20:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37394 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfGaPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:20:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so66097631eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5WMXVoIZssEiK4OS2ZsI14EAD5bwwEyXB7tLs9S9Os=;
        b=GgMDYljgt69NuT2KJuOpsbtMf2bZflY04jkdcsb64J58gp3TxiHEEkOrT1ozLhakGl
         94A0Aqkr8JolguUGlRobFPi57btYrwT3g8MYH4q5fgBYWQAov6IpM5yec8GdWQhRD5tC
         0Ax6JsB0ooIwmT4n5nblwvmWo7thAMBxnFrHSP9RfZBW9LLERr65CaaolDQ48tv/CAKX
         l2OBdufhK2nJeUB9MMPZPdYfYOqpvH6oRpIZCUxqhsrsgYyEegj1/UXzCzFcS0ucxo4Z
         EdcRyeDiAndnOaS1LNOs83hgApICxD3lTMqnXM53LXOsfL7gbP+s6/BUFBXV4t3iCpQw
         uzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5WMXVoIZssEiK4OS2ZsI14EAD5bwwEyXB7tLs9S9Os=;
        b=VnbhGlJR3MVDalRybDRBfhBFwhm64Zfi6KCzrUfk/gIGCBHdgoh0r7E5MXGl99Mwj+
         hmypdgJ2OMYmXSoHFbaVyLhAXa/7M8JxdSWNEAItnofUZX3bxG5xgo3AVGhCskWCjhBz
         Byk2DbaOH0eLGfCM88UKrbGcJGe8y5rlqKcHKE+z8jdeXzpYSmmX31rsdgteLIhuP6Zv
         b0yVDBaYGfOOBXobLy8W3zVWCYfDjem0A4sN7WVze/OGeGe7Ikdtd7gJvCIEOO78UkOd
         fQ1KZVIA8eC6EmY6KhIeZ+rhGikvTwEOK1MXci0sMuMT2k/58Gm5beCeV0RQK+xoKRhP
         L10w==
X-Gm-Message-State: APjAAAUGBSnJtCPXzShVbK82vACiqXGWajLExWCCEqnN2L3RhytZSrGA
        46vEyRx8hLGiJWGpaX8d8qs=
X-Google-Smtp-Source: APXvYqwYMqulY0Xx64lB5aqfOhV4++kQN1Oobfks3JeYhOF1doEtw6JzyLb48pAr8c5dYOSv/qswsA==
X-Received: by 2002:a17:906:e204:: with SMTP id gf4mr92542915ejb.302.1564586036461;
        Wed, 31 Jul 2019 08:13:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d7sm16507912edr.39.2019.07.31.08.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:53 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id AA55A1030C2; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
Subject: [PATCHv2 27/59] keys/mktme: Destroy MKTME keys
Date:   Wed, 31 Jul 2019 18:07:41 +0300
Message-Id: <20190731150813.26289-28-kirill.shutemov@linux.intel.com>
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

Destroy is a method invoked by the kernel key service when a
userspace key is being removed. (invalidate, revoke, timeout).

During destroy, MKTME wil returned the hardware KeyID to the pool
of available keyids.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index beca852db01a..10fcdbf5a08f 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -50,6 +50,23 @@ int mktme_reserve_keyid(struct key *key)
 	return 0;
 }
 
+static void mktme_release_keyid(int keyid)
+{
+	 mktme_map[keyid].state = KEYID_AVAILABLE;
+	 mktme_available_keyids++;
+}
+
+int mktme_keyid_from_key(struct key *key)
+{
+	int i;
+
+	for (i = 1; i <= mktme_nr_keyids(); i++) {
+		if (mktme_map[i].key == key)
+			return i;
+	}
+	return 0;
+}
+
 enum mktme_opt_id {
 	OPT_ERROR,
 	OPT_TYPE,
@@ -62,6 +79,17 @@ static const match_table_t mktme_token = {
 	{OPT_ERROR, NULL}
 };
 
+/* Key Service Method called when a Userspace Key is garbage collected. */
+static void mktme_destroy_key(struct key *key)
+{
+	int keyid = mktme_keyid_from_key(key);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mktme_lock, flags);
+	mktme_release_keyid(keyid);
+	spin_unlock_irqrestore(&mktme_lock, flags);
+}
+
 /* Key Service Method to create a new key. Payload is preparsed. */
 int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 {
@@ -198,6 +226,7 @@ struct key_type key_type_mktme = {
 	.free_preparse	= mktme_free_preparsed_payload,
 	.instantiate	= mktme_instantiate_key,
 	.describe	= user_describe,
+	.destroy	= mktme_destroy_key,
 };
 
 static int __init init_mktme(void)
-- 
2.21.0

