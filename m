Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3593FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D5A206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vfdW7e5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfGaPUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:20:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38318 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfGaPUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:20:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so31256842edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIXZ0F8v9y0X5Vlr65FlBUe43ILwGFJ310V1qk1n87Y=;
        b=vfdW7e5VZM1NTRsW9Qj9s3ymywg9Z9eZf0L8H23FhduBuIwBKrkUvK2YDh7+VgvO2z
         3q9p0yQ2/EX6CTrY+uDCaCJl6TyJDc+BnE2CZKywXpecMsM8Q5tNHXv9bcx8OOj8tnBm
         QH3O/qxckPbmTmy4X1F0rKZmU1UXd0VSYVNKsK+ChAul5R8pVMmYFyXbEmcIU9HHfUbN
         frKzsjweIKsQ0mnZrk/2o3FUXu9XTU+CZ3leIN6sTXmycUuVIoqiQg6NFsv1CV7J2zOR
         MHvIFNk9NC4quOBkwU2rhdIHH54BaXnZovl+oi4BNME3i/u2OjU/uJHdK2YV59LnCg7W
         X1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIXZ0F8v9y0X5Vlr65FlBUe43ILwGFJ310V1qk1n87Y=;
        b=KuPIYKxm60FVeLsrciDMA/K2JhrmMZY0tq7snA5JnaB5FJ75CpC8Er4KwJyhtNuTvM
         1a4ezv58ithG+ZqAoXhkoMcX61EEc6GLDKOcEL7SMAUDFBI8L4VeiHa5mxlvArjd/d8J
         OeTUuPmDSajsmJKuKFgrGmpSox70p/d05gtwnTsrcdXmM4WI1tEK+GII/PYDdVn6zCwY
         t/XZP4SuXUfV6Y4Ipij2z+wH4Qkli5keoHoR54Z5RxEGv/ujBAIWD2glaYIgV94prJbM
         ZC/W8zcGasg7nMf7YUUAPPm9SZtZ5FhzgGxQd+8o4PVys48VuXX1qPboDHHrlx6zvi4e
         pGcA==
X-Gm-Message-State: APjAAAU6I1RIQYEEDxmYYj54dwxiGaVZEJ3ejVAIJ+Sgq9obASqY6970
        cxFn62TxOkLI9dKz4szQawg=
X-Google-Smtp-Source: APXvYqwYeWMLltpEBPBckLNCM+g7S+IY4Us955LLaX0vHxxronyzv/ZLKgeH3uRrChjLLmvrEg+r8g==
X-Received: by 2002:a50:c28a:: with SMTP id o10mr105376291edf.182.1564586029913;
        Wed, 31 Jul 2019 08:13:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j10sm12539092ejk.23.2019.07.31.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:47 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 095281045FD; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
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
Subject: [PATCHv2 39/59] keys/mktme: Support CPU hotplug for MKTME key service
Date:   Wed, 31 Jul 2019 18:07:53 +0300
Message-Id: <20190731150813.26289-40-kirill.shutemov@linux.intel.com>
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

The MKTME encryption hardware resides on each physical package.
The encryption hardware includes 'Key Tables' that must be
programmed identically across all physical packages in the
platform. Although every CPU in a package can program its key
table, the kernel uses one lead CPU per package for programming.

CPU Hotplug Teardown
--------------------
MKTME manages CPU hotplug teardown to make sure the ability to
program all packages is preserved when MKTME keys are present.

When MKTME keys are not currently programmed, simply allow
the teardown, and set "mktme_allow_keys" to false. This will
force a re-evaluation of the platform topology before the next
key creation. If this CPU teardown mattered, MKTME key service
will report an error and fail to create the key. (User can
online that CPU and try again)

When MKTME keys are currently programmed, allow teardowns
of non 'lead CPU's' and of CPUs where another, core sibling
CPU, can take over as lead. Do not allow teardown of any
lead CPU that would render a hardware key table unreachable!

CPU Hotplug Startup
-------------------
CPUs coming online are of interest to the key service, but since
the service never needs to block a CPU startup event, nor does it
need to prepare for an onlining CPU, a callback is not implemented.

MKTME will catch the availability of the new CPU, if it is
needed, at the next key creation time. If keys are not allowed,
that new CPU will be part of the topology evaluation to determine
if keys should now be allowed.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 47 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 70662e882674..b042df73899d 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -460,9 +460,46 @@ static int mktme_alloc_pconfig_targets(void)
 	return 0;
 }
 
+static int mktme_cpu_teardown(unsigned int cpu)
+{
+	int new_leadcpu, ret = 0;
+	unsigned long flags;
+
+	/* Do not allow key programming during cpu hotplug event */
+	spin_lock_irqsave(&mktme_lock, flags);
+
+	/*
+	 * When no keys are in use, allow the teardown, and set
+	 * mktme_allow_keys to FALSE. That forces an evaluation
+	 * of the topology before the next key creation.
+	 */
+	if (mktme_available_keyids == mktme_nr_keyids()) {
+		mktme_allow_keys = false;
+		goto out;
+	}
+	/* Teardown CPU is not a lead CPU. Allow teardown. */
+	if (!cpumask_test_cpu(cpu, mktme_leadcpus))
+		goto out;
+
+	/* Teardown CPU is a lead CPU. Look for a new lead CPU. */
+	new_leadcpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+
+	if (new_leadcpu < nr_cpumask_bits) {
+		/* New lead CPU found. Update the programming mask */
+		__cpumask_clear_cpu(cpu, mktme_leadcpus);
+		__cpumask_set_cpu(new_leadcpu, mktme_leadcpus);
+	} else {
+		/* New lead CPU not found. Do not allow CPU teardown */
+		ret = -1;
+	}
+out:
+	spin_unlock_irqrestore(&mktme_lock, flags);
+	return ret;
+}
+
 static int __init init_mktme(void)
 {
-	int ret;
+	int ret, cpuhp;
 
 	/* Verify keys are present */
 	if (mktme_nr_keyids() < 1)
@@ -500,10 +537,18 @@ static int __init init_mktme(void)
 	if (!encrypt_count)
 		goto free_targets;
 
+	cpuhp = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					  "keys/mktme_keys:online",
+					  NULL, mktme_cpu_teardown);
+	if (cpuhp < 0)
+		goto free_encrypt;
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
 
+	cpuhp_remove_state_nocalls(cpuhp);
+free_encrypt:
 	kvfree(encrypt_count);
 free_targets:
 	free_cpumask_var(mktme_leadcpus);
-- 
2.21.0

