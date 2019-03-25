Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB467206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u13CIWRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfCYWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:20 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54480 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbfCYWKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:16 -0400
Received: by mail-ua1-f74.google.com with SMTP id n17so1334806uap.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X5oNP2XY53YozTNmiCclewjXBZfVRAeb2tiuFY95Uwk=;
        b=u13CIWRGtDMPj3byxBFCVrr6OnDevFvTn8bFk79IWQ56LzoqBeROHSCpVHTrb9tna+
         QqcOQTtuSPNkcEgBAV1gJh/I5l0ktQ1woTpRAK9ZjwYb5I9okHjQGn/SUFJsOBIz09cC
         YvzwPEyi3dt9tEGY3MgzzFHFpsLDpERJo0wH8uf9DAVzkxAZMf2v7vlwDs0lSjNRpRnu
         LQytjUdQZEjm61YEsjWouhp1uiqxAatExqMEZordeAQwIvcSNsJrsF7viRyi2MSggQ3J
         8V0vRKYU0k5tp7SWc2P8q99CmUAqb8NFdLeibtJIap7kN4PJsARZLkTr3HNNjTBVfY8c
         Inng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X5oNP2XY53YozTNmiCclewjXBZfVRAeb2tiuFY95Uwk=;
        b=bNJ2LeIpZvsA477O5x4ABYK9zV3RWhjanCKoO+7X6PC4NJ8ZuWToJuQHoFGT6pGi+2
         0HAzhpfkI47mI9iHlHG9dlCA3PfqFf+UcokTxqF/TJgWunndznvQOH1kUGgvzDixwkIr
         BGutCSR3injPji+bI0Tp35AZBFg2BsbYDutOmPSeGGu/4fDslahgvewxLVKAqwU+HitK
         jMj7yHqMEdI5NDrXXeBNCL4u8zyrIHKzVVLEbcQoDZiG+JY7o0YZQHCt5Bn9yhE8xDBg
         cP86jsiY+VIJKKocOkT90dLIfH42Cc8N6E4nL968f57NhwmmGvE0TJ7VNehiauxol8tv
         KXsw==
X-Gm-Message-State: APjAAAWHBfTgjJdVHHchlBC7n/dzhRS9UZDwt+YtEB9psR5vNgJdPzGX
        /ezxfkTlmLPTBQDDNNCI7x4fhlVDpeae6sxBCKo0YA==
X-Google-Smtp-Source: APXvYqzl8l3EaB0PMaAyRgeDP1NMm5UxwAKE0Y/KH6TdWobwyxdUCyK8eGNGGP2jA6Rf5lBiNWAOaSO27zLTkKTYrWTFQQ==
X-Received: by 2002:a1f:b587:: with SMTP id e129mr15961016vkf.23.1553551816082;
 Mon, 25 Mar 2019 15:10:16 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:34 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 07/27] kexec_file: Restrict at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Jiri Bohac <jbohac@suse.cz>, kexec@lists.infradead.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..0cfe4f6f7f85 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (kernel_is_locked_down(reason)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.392.gf8f6787159e-goog

