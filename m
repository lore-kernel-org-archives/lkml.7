Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750BF2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1DTSJR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfDWQxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:53:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46232 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfDWQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:53:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id v2so5474834pge.13;
        Tue, 23 Apr 2019 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Er4EroENafjpj6BNvtqsvuEsl/fZK0kj5FQcKEZWn4k=;
        b=L1DTSJR0Mk6vwt7KNgYsAlkV2TfOnPFgHWk9IHCFAULoblfLM64ygg50XK3RWWbeNn
         Zot7Pl0WrV1oOPmzIhvLJ9XHjFX6KP71K5hRZhKJfvY2MGoeS3BPmJhLEvVnB1UZSgIu
         p49gk3m22O6NjGJ/UPLj4UAZgUJW3HlUgTqe4mgw8WnGXLDb+zdWvUgJry88nC637uFY
         +DI9TOa+YZzyNjI0SOr1fwUDHYRZUBJKRhXHoKBf5sDZ9iHlzthJ9ONGhy4iNo6Nuejd
         PzJpI+dMUi/4tazrwDzfvLBlvF3IEciP30z5SVkYDghclqaCz+7LoD4yNqyJGkQIwild
         FPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Er4EroENafjpj6BNvtqsvuEsl/fZK0kj5FQcKEZWn4k=;
        b=ODl2QbSEz7dB7UmqxsV7KykCr6suqAQ+ka1JSDreIMUAWkLysBKGQsLFcR0f1IAWxA
         DY0s25emMhI41zfDJW2evxC+J/OXlDKFXpMCHHlDkFU8PYQOh59YYj+1LaZbKiw232xX
         hUaXnOYX2LRgOmt2HH9aPct4VRYROZwO6Q0cs5Kpdq/YVWM9e6YJClbSePudafx41CbK
         26byplUyo/52nr8ZMJMQ+eeEwhGt47X4v6I2Pbi507oYihIG6QDDyYqonCSKcRKnG4hT
         Wp62Fv7bYZUC0hL+HwvK56joW7X48SYOSYnzDS/hXQeoHSdQsGz1eGRgTP1jDvBpxF0Y
         DI5A==
X-Gm-Message-State: APjAAAXQ8+dXX24KVXBCvJEMCpRfnrZ31JFCVPp2yTJLhy3XT8LG4HQb
        6DEMIJjIhnkJP8+UxhtSuA4=
X-Google-Smtp-Source: APXvYqzb5B+L837HEp/YIU1euISbJNIWUxehJaKMUK8uNmUWEvLfgD9bkzevA8lbfJplRzSCn0aDpg==
X-Received: by 2002:a63:4b15:: with SMTP id y21mr25732595pga.430.1556038389463;
        Tue, 23 Apr 2019 09:53:09 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id 71sm47192565pfs.36.2019.04.23.09.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:53:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 22:23:00 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Force type-casting of current->real_cred
Message-ID: <20190423165300.GA18837@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning:
warning: cast removes address space '<asn:4>' of expression.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 87500bd..36478c4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1529,7 +1529,7 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
  */
 static int __init set_init_ctx(void)
 {
-	struct cred *cred = (struct cred *)current->real_cred;
+	struct cred *cred = (__force struct cred *)current->real_cred;
 
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 
-- 
2.7.4

