Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A33820659
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtkNJOe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfJYXjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:39:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37219 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:39:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id g50so5831533qtb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8iYCMmqsnyVKfjy5XqZLpSW571c10vuJU4rS6T4W2j8=;
        b=jtkNJOe7tP2lgkdaSqNKbilQeINB4ZhCve/X1I1OkenW/X6k7BUqiWg6Nfz5WiY4ND
         xC4W0u8oAtU+Do61c3FgQTJl0Qh/gNMAPM22kmZyg3ftTYFsp03Xs4i8Ql0ThhJM5zf5
         5B32gt5cnusgq6Ra1H1XGB9rn51LWKQykTU5xhtcghebcCWETrYhNXc8VeHS4RhV5e+B
         o7E5VNUntIyNbDWesiUEi9MnjcyrUR4wBDdYWKAQkV67BF0Y5u+jax8fLTnc5J5X+GYN
         M/QqAfGuAVQiyhPleF1vjg0R4ZJYGW9wU4mzjPYCWYS1qnfGcTtIhyc0X77MseI38POE
         YVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8iYCMmqsnyVKfjy5XqZLpSW571c10vuJU4rS6T4W2j8=;
        b=IaJMf9PCFBhjte1URiBo0D0k9W4a59CjgpW2B98XrHrmN8ksA5iVSzI3Ylx87OdzY3
         zMuRNLz1l7XyAAhtMkfCXXkyQXUP2q9xEMvbLsqCQIeUcnV7YAQvs3dZjdmSf42klgW1
         YQTmb04wF9UUC1byTfv7ljTn6h/txe7PEnjmYDq9/WlieervfHyhCNU43dX8O/Ejidd5
         nEajisrDl75XMiGDnmv4IYFbbw29V2sMDLEmox6VeUJY5b4JfpznWjdZ+h9enDM6tYgl
         krXCh7AoO/aNyssagWy6K6k6LND/h7Ws2z+kALl4854BMClm6mvxr/TdoYVuuoC0xEZR
         8ZZQ==
X-Gm-Message-State: APjAAAVWA2y3muEePik2atkffya+ZCe1EzLVTU5LPWZSOymuvGY6aPn3
        pkCWOvP7aU3hOh7uFA3ewr4=
X-Google-Smtp-Source: APXvYqzf1Y4E3r2c3YyF+f5hgrgaXDZReYeqvTZ/lTdPu/F6s/wT7asfsvuGRcanfUyfBLG6/EZ6gQ==
X-Received: by 2002:a0c:ba26:: with SMTP id w38mr5919794qvf.24.1572046754893;
        Fri, 25 Oct 2019 16:39:14 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id j4sm1796407qkf.116.2019.10.25.16.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 16:39:14 -0700 (PDT)
Date:   Fri, 25 Oct 2019 20:39:09 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] staging: gasket: Fix line ending with a '('
Message-ID: <20191025233909.GA1599@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix line ending with a '('

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 240f9bb..d1b3e9a 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -34,8 +34,8 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 
 	trace_gasket_ioctl_eventfd_data(die.interrupt, die.event_fd);
 
-	return gasket_interrupt_set_eventfd(
-		gasket_dev->interrupt_data, die.interrupt, die.event_fd);
+	return gasket_interrupt_set_eventfd(gasket_dev->interrupt_data,
+					    die.interrupt, die.event_fd);
 }
 
 /* Read the size of the page table. */
-- 
2.7.4

