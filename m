Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7738206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiNaLzac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfC0RUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:20:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44777 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfC0RUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:20:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so3894586pfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xhx7Gek3AFBf9l+V6lV2mn1K3Aeq+2xvRODYW/FGvRs=;
        b=GiNaLzac41uTmqWh64hrVsr9gp5Uux7ff1K+e7/VmkIdgbZ84efxTVl50wCIO9K+Qf
         ZEQal+FwjXrFO+WKLWlGP5TTyYDXJ37exyKswkIvqPc/f8p0t3dIPmIT29epO6W/SM/U
         3Nfu5GNJbywdLS0kx2eN+pdEh5nl46J0molxULdkq1488m4KW29cSFtvPXGUdSnik3WS
         vZ8wTz8tDzFo+iUv8l2JG2vhTLuIovba5mq1CrYe/bIhEwdFAsi6jj6/Yf/TxWjviCa9
         ilX2qP8yx3govDEm1McixY/NIo8QnSrcho8hrdt2Wxao0Nkan31TK2yYxEHS9hea2RM7
         SeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xhx7Gek3AFBf9l+V6lV2mn1K3Aeq+2xvRODYW/FGvRs=;
        b=SjDrBgSXNOpQ+CnFDELdAXGCJh1RcwNlCos8WOTc2/5tlo+UviixFQBkTS8Sg8tIZd
         X5es29L25akvaMOc6jBY7nC/QVRg6Je+f5CQPOQFC8qCkginI+2gKX5O0wNveNZgUmVP
         HXsNexV9vn+kqNgjMoVfjMHvFnKO2RBA6hwWUnMcwhevr5pD7PHZwYEIhgo5roJBJoQc
         AvhJMXsYTr3SWRlrgY764JDYvvWqADfZClLmjCXuSMPEYOYcDpVMptXao1sJIcTIv0sQ
         A8FwInlj5k0wPc31TcOVXkKcynjZxXa+kao5N1EmRMvQE61GdlQz6WG15rL5MZs61JnU
         rshQ==
X-Gm-Message-State: APjAAAVSfGUCCl2w31b5ZpFk4oO3YB6yvDe6BinFVPm9NLdC+A/6bYkc
        0KN67PrS96zUwqA2xcASLx9VFJfC
X-Google-Smtp-Source: APXvYqw1ZIbG8jjm25W9tTVtda4ztofjrHIkUJS9aTcgpUO8ajBpgZKj89XNCgfwF0iZn/nINXht4Q==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr36185522pfn.45.1553707211373;
        Wed, 27 Mar 2019 10:20:11 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.54.136])
        by smtp.gmail.com with ESMTPSA id a8sm8466455pfo.144.2019.03.27.10.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:20:10 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] kernel/trace/trace.h: Remove duplicate header
Date:   Thu, 28 Mar 2019 03:49:46 +0530
Message-Id: <1553725186-41442-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 kernel/trace/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee4..e1e16f9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -15,7 +15,6 @@
 #include <linux/trace_seq.h>
 #include <linux/trace_events.h>
 #include <linux/compiler.h>
-#include <linux/trace_seq.h>
 #include <linux/glob.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
-- 
1.8.3.1

