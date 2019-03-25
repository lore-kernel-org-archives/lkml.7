Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32112C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EF820830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ue7pG1g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfCYWKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:42 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56889 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:41 -0400
Received: by mail-vk1-f201.google.com with SMTP id r189so4703241vkr.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MX7HAsZv9v1mlAMwYMmTO69QilKEqMKiTqEWCeCZ+Co=;
        b=Ue7pG1g3SnEJ+37/Ryx2zTFU/Dp2cL3S75Vu4QwG5wOhef2kL5bd9FMy/sL+mwIDw0
         1Ux0Ivh5ASpU828UAZXsmqgTym9C7SIFi2OYWSDvs+AcNTiL356uen+xZn4erhWd1jwi
         I340B5q0wq7+3jVgryCNL54Vz/zR+uUXVDNdl0AIYsYEdetZfkMgVr7uKxOJ/DQ3/XMG
         r6h/JJ9aF8A5uQm/HGiutfZbUH/OBKEGFXshyG+SZbo6rI23+mc7qlfyISvkmO8LXH0N
         tDA+gBMmuxDd98VTXSb6qicVFeFwlnBzVi0GAqYunCoRzdguUB2POrPEVDiN8TCRn1TS
         Da8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MX7HAsZv9v1mlAMwYMmTO69QilKEqMKiTqEWCeCZ+Co=;
        b=nl/fqo5BWCdPECQ1f6cmzRI0Kg76wJTegnz5W6GkU80owd06vujeLrUyoVQO0ABi7e
         6XNyCQeii1OfY07IFDDmjPHDHlbSM6s3andW3tVpq0TGXIBNzFBeSQ9Yi4IRKfZsKluq
         dqUlO4gfeJsiR1xRt3nUX9r+YWz3sHAmSeDVxBf1D3fD/aadBFircU/tZS4RXQsQj02k
         Kb9X49Pl/+l3Lelx+XSjyNqiIKuuK3oJkuzeMKsBi76qmkeBkrRTBMwsq0hRTg3RMBBk
         VJrkHPZGQAz8kLLdsYUv23566FodNJse1cDa0QNkoZy7TCNp5IHViN3S1VYuHqWpdSUn
         zWfw==
X-Gm-Message-State: APjAAAVVdlBmQ4tmMJo/qup++4gtRq5y4SAbx2btOO+YYG0IGrlyAzRS
        dfHREK5gu9GLIBwRE8F2HFA9gGvL4zBteGLhpk9TvQ==
X-Google-Smtp-Source: APXvYqwIoZTGgFdO8Jf8mlA2MQNxtulFbG3DvCIo9GIeTiFXPfVK2S45XvPskEPu/e//UIjkQTwof+/+BZH2UOUJlvr0sQ==
X-Received: by 2002:a67:dd8d:: with SMTP id i13mr16469935vsk.64.1553551840407;
 Mon, 25 Mar 2019 15:10:40 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:43 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 16/27] acpi: Disable APEI error injection if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Linn Crosetto <linn@hpe.com>, linux-acpi@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

ACPI provides an error injection mechanism, EINJ, for debugging and testing
the ACPI Platform Error Interface (APEI) and other RAS features.  If
supported by the firmware, ACPI specification 5.0 and later provide for a
way to specify a physical memory address to which to inject the error.

Injecting errors through EINJ can produce errors which to the platform are
indistinguishable from real hardware errors.  This can have undesirable
side-effects, such as causing the platform to mark hardware as needing
replacement.

While it does not provide a method to load unauthenticated privileged code,
the effect of these errors may persist across reboots and affect trust in
the underlying hardware, so disable error injection through EINJ if
the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/apei/einj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index fcccbfdbdd1a..9fe6bbab2e7d 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	int rc;
 	u64 base_addr, size;
 
+	if (kernel_is_locked_down("ACPI error injection"))
+		return -EPERM;
+
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
 		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
-- 
2.21.0.392.gf8f6787159e-goog

