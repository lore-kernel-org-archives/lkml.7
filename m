Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED012087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7dNOb7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfCZS2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:40 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:37001 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbfCZS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:36 -0400
Received: by mail-qt1-f201.google.com with SMTP id f89so14453012qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4G8m95jwtwdfjA5z7EFk9aUl9ztD0RqYosPZp4xmjEc=;
        b=h7dNOb7RQMavv0sp0Zow1gRw63LnZH39UfrTPdhj02fkrvrZrEAZH78cfkEj+UQc+0
         CJjusC/IoWX8sWu5YfQZWyBfIgCg1kdW7WmC1R0rHpjM1s0mtPsNpGYbUAw46xxOqXel
         5tAmEK9SZvRqh7JM+1CynPqgm4agy0u9BCaznisqLEyI4iz7fwYVAXlnEe3mqReVkYi5
         4mr/vqCxtGCrvpZY5FgmdB521DBRBqUSK5XY3wb/gMVqgChTLP1opGEFzTWsSfXhNHwd
         HVr3wnpU0+ls7oaLhQK8AaYMFujCCN2584QK2ScCQc8RLOMnVgvxdxBTdqIU+FBrYXyX
         6JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4G8m95jwtwdfjA5z7EFk9aUl9ztD0RqYosPZp4xmjEc=;
        b=IXm5Gk9OgxvueySvAjRHgZbYGy0DlsCS3PKTGZpj7Fe+oQTR7uM3P17V1QPgF3HHfi
         nb70F3bDn8qB1WRDpL61/mlzSLWNTVoj3fZ3Ifr2C6pro04ihNMme61+qHeZUushiwEK
         fyJdaItHEN01z+QyVvPOKGGEGAuLTCg+4PuHXbN0aoShdxtsMj+XHjG16YUr5IR8f58X
         BprO1v8vSqLFSNS1RECz4WlBK2+CoLBQnYbUsTlfo5+M4z+OmWqPlFwUmEoEpInWbsQp
         S1p4GP6MQ3pLU9C3nFurHEeSgOJt5yevGATzv3mniab6/uCvbePr778TRdJ4VrA+dpKr
         w20Q==
X-Gm-Message-State: APjAAAXSMxeciuy3vjmcrKh6wnaREAeCUViKSXmpPS66baf+IiDGU6gQ
        3PCubLNMJ+gSqRHNwsCGefWBxU+8Z9//0N+Bk3/Biw==
X-Google-Smtp-Source: APXvYqxQhg0QFZGUTOuDkDlVLMMfRXQc/lsxF8gnvkp3TvGjpj2EedXHo5jW5sl13rNyrq6r75ypdN01tARzQW4WSXWCWQ==
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr24386884qkj.185.1553624915314;
 Tue, 26 Mar 2019 11:28:35 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:32 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 16/25] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/pcmcia/cistpl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..9e23300a55e5 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage",
+				  LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
-- 
2.21.0.392.gf8f6787159e-goog

