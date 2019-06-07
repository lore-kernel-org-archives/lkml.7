Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96D20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="j5fa4Xr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfFGOLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:11:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43826 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfFGOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:11:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so3213748edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xp4rSZI5WhV+6Sat4AULJy3MtrPBifsfu9gUED/8PtM=;
        b=j5fa4Xr7EV3n7eHh1YEh37F4gLNUjhYvDUz4lIuHeMDiEgRSAkv6SQOiAxlkqObRJs
         jPFxqQI4VqeibG3Mb/hOzrk2jSsXV46nL/yVFNtre5PROvxr3dwiMwLpacpOipTz70EQ
         IMFUGoSJBNeL82mmABWec4P0UZrCcMTylCJSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xp4rSZI5WhV+6Sat4AULJy3MtrPBifsfu9gUED/8PtM=;
        b=IIIHqI5pKYuuGwlIGIirDc+XzjxLMupfs6Ol3FMUKHdUJUbp4ZbwC8Y1EckBdrUzpt
         Y5LUpHp9KRpousmSBQGUGtJbylQSk4pIGTtgRJWHv2PiudqOuRXiSjMaULGtT+TMT9o1
         1HAjamCplKM9duoQJRljWzUMzjZv0M10R+wLZY7u6B4NCmz4hgwNutOyctKXVk9rI4kT
         +ljS3hexezLOPf2j2DFh2D4lrfkhLq0xfYO5sqlWweZySh1VxF0PAQIOxOjYX2othwsS
         VfLvd5udtf1XagHesTGfIAP6v2j0AcvfiMAi1a2YL4P6gDy7WW/kTIbL/EaOQ0np5NBN
         9H0w==
X-Gm-Message-State: APjAAAX0jV4ksgk2N9VU6/Lgeabqp3BLkR+VJ5nl0rCzEgT4AepzGbmv
        uWUkzQNV2mMgpMztuSG/0vXlBA==
X-Google-Smtp-Source: APXvYqy8+1YsywtSTa+c9W9VfssePeLtB7JQ8mgPOuXAxMPPEaW6jzftMhXPMHpXDCzCrK7FZDDhzw==
X-Received: by 2002:a50:ec8e:: with SMTP id e14mr17918728edr.153.1559916673628;
        Fri, 07 Jun 2019 07:11:13 -0700 (PDT)
Received: from locke-xps13.fritz.box (dslb-002-205-069-198.002.205.pools.vodafone-ip.de. [2.205.69.198])
        by smtp.gmail.com with ESMTPSA id a40sm546116edd.1.2019.06.07.07.11.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:11:13 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 2/4] bpf: sync bpf.h to tools/ for bpf_sock_ops->netns*
Date:   Fri,  7 Jun 2019 16:11:04 +0200
Message-Id: <20190607141106.32148-3-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607141106.32148-1-iago@kinvolk.io>
References: <20190607141106.32148-1-iago@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

The change in struct bpf_sock_ops is synchronised
from: include/uapi/linux/bpf.h
to: tools/include/uapi/linux/bpf.h

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v2:
- standalone patch for the sync (requested by Y Song)

Changes since v4:
- add netns_dev comment on uapi header (review from Y Song)
---
 tools/include/uapi/linux/bpf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf66f01a..41f54ac3db95 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3261,6 +3261,12 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	/*
+	 * netns_dev might be zero if there's an error getting it
+	 * when loading the BPF program. This is very unlikely.
+	 */
+	__u64 netns_dev;
+	__u64 netns_ino;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
-- 
2.21.0

