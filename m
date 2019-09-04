Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F4DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C823721881
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpC1Uemg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfIDQYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:24:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45772 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfIDQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:24:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so5982366pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=500EAXypmcyMGKBYWd2w5eyXzyKNNSw+MVc9qIH+qt4=;
        b=CpC1Uemg8Vp3yPAXWEZ+YhZHrHbduCTfFit9lvBYiWGi9czs6h+AHvy94Lw4JZs5g/
         iOoDGxCkAI7McyDzGNINbgBRODlkJrAH4ioeJsdMAVV41xGmgFZ+gdGfSRAPTzDNNOZk
         lBE7ksqRgn8qXmTngB+4j4896ClNWHLwaALm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=500EAXypmcyMGKBYWd2w5eyXzyKNNSw+MVc9qIH+qt4=;
        b=LZFuBBjVYdHhYwLCZvcRTf8Dgnb7RCRTDCvva+i02Bu6RREh4FUngfNplUG2cragTu
         b3WkoPxS4Q0o43iSNVAJ/zIjy5h/FiN4k1xdbE9Ja6MPm/0jYczhTt3o/l5Y0CGQ6vRf
         QWLEmMch421HjK5jYvl5m3m/yQax415GhH1PvEQFbXuqU2jyXJN9hG5wBctM4eIqJxEm
         KEz0D4iXwRaE7d64Hc0QAE6KczSCak1bTrkKz0Xu9avIxg7SWHhJQujMCBsD4u9I1PJv
         YP4UsrBVqxzY1EIGNU1f4Y1Zr1Av1/vwzjobpD+xrBg/yCUc7s8d9Q01IA2H7Z37vIYe
         NYbg==
X-Gm-Message-State: APjAAAXReZHs3p6Q1bjKw1sekavwIa92SdXCjPQ/RlBmhZJswloA6M1y
        O5Z18T+BBtlHsjhMMECBoNtcuQ==
X-Google-Smtp-Source: APXvYqzMB1y4zOK8LbQK+a/EfvyNa3p5unTYVWzWPoWeZFczGzCkoU5hsg2D+SGb0mrvSzf2IwK+Pw==
X-Received: by 2002:aa7:998f:: with SMTP id k15mr33565950pfh.203.1567614291796;
        Wed, 04 Sep 2019 09:24:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm21863347pfn.104.2019.09.04.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 09:24:50 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:24:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        Matt Linton <amuse@google.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/process: Add Google contact for embargoed
 hardware issues
Message-ID: <201909040922.56496BF70@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds myself as the Google contact for embargoed hardware security
issues and fixes some small typos.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Matt Linton <amuse@google.com>
Cc: Matthew Garrett <mjg59@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index d37cbc502936..1c1ad684d753 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -5,7 +5,7 @@ Scope
 -----
 
 Hardware issues which result in security problems are a different category
-of security bugs than pure software bugs which  only affect the Linux
+of security bugs than pure software bugs which only affect the Linux
 kernel.
 
 Hardware issues like Meltdown, Spectre, L1TF etc. must be treated
@@ -159,7 +159,7 @@ Mitigation development
 
 The initial response team sets up an encrypted mailing-list or repurposes
 an existing one if appropriate. The disclosing party should provide a list
-of contacts for all other parties who have already been, or should be
+of contacts for all other parties who have already been, or should be,
 informed about the issue. The response team contacts these parties so they
 can name experts who should be subscribed to the mailing-list.
 
@@ -230,8 +230,8 @@ an involved disclosed party. The current ambassadors list:
   SUSE		Jiri Kosina <jkosina@suse.cz>
 
   Amazon
-  Google
-  ============== ========================================================
+  Google	Kees Cook <keescook@chromium.org>
+  ============= ========================================================
 
 If you want your organization to be added to the ambassadors list, please
 contact the hardware security team. The nominated ambassador has to
-- 
2.17.1


-- 
Kees Cook
