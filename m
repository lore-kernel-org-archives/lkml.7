Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2603C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE5920830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gt2Z+naa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfCYWKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:46 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:54544 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbfCYWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:43 -0400
Received: by mail-oi1-f201.google.com with SMTP id w139so4442906oiw.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2ssyPCg3POhze4DuCq8LOChiCT8h5s76Ul4XqmSv8/4=;
        b=Gt2Z+naaOI4jaIW6k6icatZYz0vOiPy2qQ9nWh4sgTRJW+JPWo1rJPvo30ZMFECFRY
         dgHSFW+svQkWWl66DCDhDd0woNHp+XMrO2ZLUSjv9WtcKjHMozhhMD+MfGNh9FxgW+Dj
         ZCqjb4BXBWTTp3+LHvpASWsulruWVnM/NdFY/ZqEcdDbdxfTlwwrzvjWZGaUv92IC28E
         1YpiArWA+SDGmq/Zj9zxjuWzr4y7OAhA6CHeFzHsFlnNtOd6VOQidtM7KJ5lIKE8a3g1
         iwjwSj6qJ5ZcgCMcI98N5Hc8JovlNS+bMh0Pm6YDdgK+JAMlKOupdWfL9u8Q/3d9U5Ss
         7Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2ssyPCg3POhze4DuCq8LOChiCT8h5s76Ul4XqmSv8/4=;
        b=mWPxvbMjo857FbkEkYzpLcc009iPxHr9TzUL8tZT0ou/MXgyXU4/RaPbnH0Y3gWaWS
         e2ltwYa8W5xjHqYb+NV6YW4RweQBgAJLlYfElBIEcvJMMZ86rZIhexxxMXCUFFrN0yTl
         DblVxq1q/jGF1ubbVb5e4R5YqB4dnY9lT1uom/ELw5LoCbC9K3ZUjUukvjQN/DstJ5MR
         +KVMdeOEr4CEBfIdJxnM/B4bnWTeUVExIwQm4Hr5IyGC/21kGtWGoEvknpiYMxt2WlmP
         8mDWxD7l60xbf018NVtAyl38QMml1QO0UzXIu2NKrfSiFlgJ0j6sWG8ahFlaqSk3g7BK
         ZWiA==
X-Gm-Message-State: APjAAAVcozVvnw3Z+D9bedbwaO1xuRoL3LsKjJp52btK0VO3aVxV+21Q
        tMkmZY8Ovm839O+akgYRe+C8CZJtPhEMsQGAZ5BPHQ==
X-Google-Smtp-Source: APXvYqxi96o+qhxfCxMD7tnM4/PPRFA30e+tCetBW41PK8yY8O9kn57CJsnOy71MxaE6ZAIiNGzV/YN9QkpclEO2gJ3zUQ==
X-Received: by 2002:aca:3b56:: with SMTP id i83mr13547187oia.162.1553551842820;
 Mon, 25 Mar 2019 15:10:42 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:44 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 17/27] Prohibit PCMCIA CIS storage when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-pcmcia@lists.infradead.org,
        Matthew Garrett <matthewgarrett@google.com>
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
cc: linux-pcmcia@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/pcmcia/cistpl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..8adf092d0e18 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,9 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage"))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
-- 
2.21.0.392.gf8f6787159e-goog

