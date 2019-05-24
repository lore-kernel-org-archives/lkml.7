Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9CAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263A121773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jHBVOno5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbfEXKgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:36:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:36:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so8822353wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jv+/uIukQfW/OxHNR7bAyqpTVp/OLgnxi44gYUFQRII=;
        b=jHBVOno5BwcUjYCRe7UBEvjFH9aCoBem8UeQ5No34z4H12/N1RpbLZ4NMlFLqgkLpr
         WSXAmoVrdKhO8EDk5TWIf0j9VxTfpRvbJx/PYTYbQ9z1VxboNHY7mAduSHrqtQv70pGQ
         yPYyisaApP7w0nx0i523LCSXi4ZFr2nrN1LC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jv+/uIukQfW/OxHNR7bAyqpTVp/OLgnxi44gYUFQRII=;
        b=A8wJWgEEgSeKOJH7ucRVohKqPfocUVk3U0q70kdtGmMHLLyHIun/PsFBkfhAIpMVMy
         hcRoO4q3g4OCcdbGp5EXb4Xfm1hvzxLALca4iEKuJtSPPFhlk95kXJOURnMy0rFOsHGD
         HkNyVPLlh/aCVuSSKNLEmOoWq0o/X8K6yDcpdWCnZCq19kMJ206Z6gzFU1ab5IwrAwNs
         xjNCvtN5WsamXRYg7bqQ4igOXj+Aa5uaN6OCGr/W7pfzZ8oDVBswdDChX5xhzx9ur4tp
         COlBv9qoc2VSZ8Xgu8JaXqST435408YxUsA/ptcxJLnQSc93f2X00WmSoQ5fKYf/PBZ9
         LMCw==
X-Gm-Message-State: APjAAAVF/6XK5shFb5hFfDxdqkf9Ot9sEfC0+DSw0LmM6LOs40YupcKe
        pyg95IoKMoM31uzPHsQ6KuZTNpTe7BS+bg==
X-Google-Smtp-Source: APXvYqzOF8c6dcpLuEx32dQGio5YxaEepv+5uijVeRGIeWU/m0vjVdwVeInCDrSgBOLzBdtFeYnX3g==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr16760046wmb.76.1558694172544;
        Fri, 24 May 2019 03:36:12 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id n4sm2111272wrp.61.2019.05.24.03.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 03:36:12 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 1/2] vmw_vmci: Clean up uses of atomic*_set()
Date:   Fri, 24 May 2019 12:35:35 +0200
Message-Id: <1558694136-19226-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primitive vmci_q_set_pointer() relies on atomic*_set() being of
type 'void', but this is a non-portable implementation detail.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jorgen Hansen <jhansen@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
---
 include/linux/vmw_vmci_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 0c06178e4985b..eb593868e2e9e 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -759,9 +759,9 @@ static inline void vmci_q_set_pointer(atomic64_t *var,
 				      u64 new_val)
 {
 #if defined(CONFIG_X86_32)
-	return atomic_set((atomic_t *)var, (u32)new_val);
+	atomic_set((atomic_t *)var, (u32)new_val);
 #else
-	return atomic64_set(var, new_val);
+	atomic64_set(var, new_val);
 #endif
 }
 
-- 
2.7.4

