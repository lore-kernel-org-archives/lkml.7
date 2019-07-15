Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CEFC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20C420651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XStDr0pO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404303AbfGOOn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:43:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44374 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392041AbfGOOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:37:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so8371022plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zPd11qsqBV6enPH1pgmEhMrw3DVmEsKL+rgelJGu5E=;
        b=XStDr0pOpAvfMPGvyaCiXhax5OpTI8omiicJPCmLonS9L7hbMWB8WbkqauDTlsAue1
         /IzXyBhFpxdPHPkwfVRCjLPZYScMK7RsrUnJmmgQGxgyicRfMpFtWxfw1YpluI/oDB0w
         mhjDfrjf8F43ROWC4kjFdePNxqWjxG9UE7yCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zPd11qsqBV6enPH1pgmEhMrw3DVmEsKL+rgelJGu5E=;
        b=KZQlHr6jq96z/BKkOuJmXHy1B6wMD5XoAJrVYf8J1IwiuaPMnEe5r9375YPN37M6fx
         vDYl0x+cEbqiK8n0FhNVGoMQfy3tN4IR17iVAoUVfuhTMHoTCo/98A+YVnlpkAYqTu8n
         wYDh4vvi6L4GSKtQUsG5rfR7cwWJM6FNq79tW2g58ipiFpD3rbH5SkBDVfYw9r+4ex/o
         m4Qx8nA9Js2KZbozU3BmgQdO8tKFFWAV5bjfNvj3sjjPd7tBlVNEjfEkSsQ8z7CO79Yy
         KXj1LJedCJ5GiEm0bhRtdLl6n4gdt8SYVR07VtknRJ0tWqGJLc6/mRUH7ZEtYN6h3N5V
         HrCg==
X-Gm-Message-State: APjAAAXStnScEh97pf7xYuu3J289cGj2Vxv2xZnm51c70mNIkVBclROv
        Y5fWZsLI92llaLSOg8eZ7RBP0ve0
X-Google-Smtp-Source: APXvYqzkIpFv5vPuz81gmhFr3B+gCTSP4FKDqSNzw1vK/5n3JtNPasCMdlzt1VHFYex1IyUvrWl66Q==
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr27373830plb.230.1563201466638;
        Mon, 15 Jul 2019 07:37:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 8/9] acpi: Use built-in RCU list checking for acpi_ioremaps list (v1)
Date:   Mon, 15 Jul 2019 10:37:04 -0400
Message-Id: <20190715143705.117908-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715143705.117908-1-joel@joelfernandes.org>
References: <20190715143705.117908-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_rcu has built-in RCU and lock checking. Make use of
it for acpi_ioremaps list traversal.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/acpi/osl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9c0edf2fc0dd..2f9d0d20b836 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/lockdep.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
@@ -80,6 +81,7 @@ struct acpi_ioremap {
 
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
+#define acpi_ioremap_lock_held() lock_is_held(&acpi_ioremap_lock.dep_map)
 
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
@@ -206,7 +208,7 @@ acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
 			return map;
@@ -249,7 +251,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->virt <= virt &&
 		    virt + size <= map->virt + map->size)
 			return map;
-- 
2.22.0.510.g264f2c817a-goog

