Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2278BC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77C52343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SRkoLbFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfH3XSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:18:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40322 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfH3XSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:18:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id w16so5541268pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7Fsc+37SdglEjx6/P+VaXoRvmLqI7xYMe39+8FKKog=;
        b=SRkoLbFdjxOOLUsGorlvwCDB8Y7h+4UZCxPAUooe5JUYDpPZoOm+hC88wSCIUVQUJi
         FedLK4Mry/31IytlGZFBo09jNfGHCQpy+KeCRFEAjd/CHA9NXZ0xgmevw0j+ww4PVOri
         NVgKz5E4oVN1UEDexyn1rDN7wNhQVIao8Kavw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7Fsc+37SdglEjx6/P+VaXoRvmLqI7xYMe39+8FKKog=;
        b=gicbI4LBBAF3bmyv0bu042JXy1gQ/fQC7CcWcUpB3sbaAjJTHtTJTDVFd9gg4fOj7t
         bTWrLlIQjJdpaf5OXQC2phesPYGONeFCGHTwIWApJWUkjvIoOH/6B+OO5fLPBAAxeDMv
         hSE7znRCp3IDaf2yOvCP7chuugmAXrGA86lAyAdTRbMVg2PW5yd1Pp5IsEDvWudkavzA
         6qbWAOuPy/KmU3BvfPtJr2YoWpVeRXwVLpkMLG9hMZ0kiDCxiUk/+HdBmA41uaEya1L3
         9Sebai3lVvAHhPtjBEHYm27erRASd8TWSu2KxXDj4fgcSp1LBOHzm9vp6UkJC9bNoBmi
         iOCg==
X-Gm-Message-State: APjAAAWa1MfywouvzmVgZpYaTq8/73UVBWf/NyfBldr3iqAX3lVHT2Mc
        uja4ClD8+NBSbmbra/g3cT/Y26wlzhg=
X-Google-Smtp-Source: APXvYqzsgIbQD1SS2U2BV8UWGEyzmoL50WWwQMMc6aPYggCkWNncKrpdEs1Qv0qQtklc19SPrZyVdA==
X-Received: by 2002:a17:90a:3748:: with SMTP id u66mr1008427pjb.4.1567207116764;
        Fri, 30 Aug 2019 16:18:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t23sm8479395pfl.154.2019.08.30.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:18:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/2] ipc/sem: Convert to use built-in RCU list checking
Date:   Fri, 30 Aug 2019 19:18:17 -0400
Message-Id: <20190830231817.76862-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830231817.76862-1-joel@joelfernandes.org>
References: <20190830231817.76862-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PROVE_RCU_LIST requires list_for_each_entry_rcu() to pass a
lockdep expression if using srcu or locking for protection. It can only
check regular RCU protection, all other protection needs to be passed as
lockdep expression.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ipc/sem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 7da4504bcc7c..ec97a7072413 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1852,7 +1852,8 @@ static struct sem_undo *__lookup_undo(struct sem_undo_list *ulp, int semid)
 {
 	struct sem_undo *un;
 
-	list_for_each_entry_rcu(un, &ulp->list_proc, list_proc) {
+	list_for_each_entry_rcu(un, &ulp->list_proc, list_proc,
+				spin_is_locked(&ulp->lock)) {
 		if (un->semid == semid)
 			return un;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

