Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F63C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6762A2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRSZ0exP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDDAd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:26 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:53726 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDDAdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:23 -0400
Received: by mail-vk1-f202.google.com with SMTP id q204so423814vkf.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QnWxYoXtlXDh+QYWjqIOEuesK8IQe5p8ynytMTjRSCY=;
        b=QRSZ0exPdykYG3cj/sT33FZBrVPjgVKfkWxlUaPoJlH+1DajR1vVTmcbDfFyR6avby
         Wxe4IX3n1oC3chdRudvb0e+ylQ28+iwE2YhKNTqQlSkzpMHCx9hqehJekQmQTDokmLzD
         mUkkVXl4ZFfV+2k1VnSAdGJSBoZXckgW5Np1Wb2y03jTR/jTtQomaIxjwojXJpKhc54d
         RbmFl9S2XnDxKq1OmSjsZastyUtz1ogS5H3eMyo7zoETL3YfYxiJLoRJeAiH5J3BOuFd
         S1pbxEnJEOyBQJoBiT363sBxTIMeCic0LZm2gV8woq1tCeca4SEbm2+knVkM1qWyvagC
         3IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QnWxYoXtlXDh+QYWjqIOEuesK8IQe5p8ynytMTjRSCY=;
        b=aq3z+/oFWq0vO9lY19Cy3qe217ObNVU/BOvikCvWLaCTU86qwa2cYmONnOk/zQGuqk
         gGZMfnbvn9SQoBEu/u5MpoU6ebCP6AxE9UW3XvEOwACuc+DNAtbn0GAYQR7026+KHtnf
         Nm3MmHdkHqgF2CEKRAr5bzsmSajri+4k6YxD7hjUI9ReGcYSTMxtFtBSMsOiVMhSH2RX
         BqZO+zqW9Y0aVIhfrXb6aO5d1x9BuLDcJ8P7NW/n3Lia5IPWbY1YQWTsjBHRqaenKuAT
         1UNr+r4tE4+WS8dQ8PMosItkfM0fPFBChvwmah9U4Sjz27ArfivP6q39eOuQ5VZ59W2t
         OP9Q==
X-Gm-Message-State: APjAAAUwB8uQ9cvsSM+uRvDVcBEKYWgTaaYsyAIqV9iVIdIAL5MIqWb2
        sld43iOInGjXFnv+HYoPbIjEWzNSLVNIJkodVRJ0iw==
X-Google-Smtp-Source: APXvYqyOil3nuWTZ6/0rdgwNmW40JoGvRbCcJ0rRgKX73/Ad46aVWMGAxdMPUwnYWI5bZZbMNYaINRVrrUkWxTpUmAg1uQ==
X-Received: by 2002:a1f:746:: with SMTP id 67mr371895vkh.24.1554338002654;
 Wed, 03 Apr 2019 17:33:22 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:33 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 11/27] x86: Lock down IO port access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: x86@kernel.org
---
 arch/x86/kernel/ioport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..febbd7eb847c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -31,7 +31,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			kernel_is_locked_down("ioperm", LOCKDOWN_INTEGRITY)))
 		return -EPERM;
 
 	/*
@@ -126,7 +127,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    kernel_is_locked_down("iopl", LOCKDOWN_INTEGRITY))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
-- 
2.21.0.392.gf8f6787159e-goog

