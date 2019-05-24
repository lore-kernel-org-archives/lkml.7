Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307B5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F7B217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="L6PogmLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbfEXQAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:00:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51125 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390550AbfEXP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:59:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so9932616wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVMrVxqp5uNYAADGtcNFRrXM8D0V8rtijn49YKBWYRk=;
        b=L6PogmLHo0jNT0q3SHbieEK5uu8kWXU7Q5Gg/0ku3q1S9k/Ebjee+cG+WjBE+RPq9v
         Y/H8nfILdWj6v/AHbTPrwPz/QybwEzejPfwbeYBRevpYccpVndlyiXhyMbbe9PJW5Vps
         /rIUeTukoIRPxkSOpnwPUkh+bkJ+/i0xpbCKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVMrVxqp5uNYAADGtcNFRrXM8D0V8rtijn49YKBWYRk=;
        b=A855Tuzi3fiT5pd60ku5fc387aBsCy71mK8u48CmYQs+YwXHmDQdAfwyoiNkyxK0jy
         BjClBjAEIW/2JKWSN37phRn3jpa7Atzm/NNTkQtdzxF060esX1h7Ap5Qv2EIcrdeGZQI
         OZL6KN9b+Y9SejnqfGRGfMFk1YSfCEi52kaH8b6qKVyOQ+LZnIHRh0F2i5XB3uaTysoK
         IlL9++caLo3N5gMLpIez+Khn+tRpZm4bJaehhH/TRih83+knApcbCKGr922dhxsTMlva
         JWaPoQU0plTvgwhGltDBLEwojIIiB2GD7jIU04dImDvgcE+CzAZvR6XKMCFz171Ytbjb
         zreA==
X-Gm-Message-State: APjAAAVUv3hecv0ryIb3sdfZ2TcpDLCgNr7CzSmlrzCLAgoAAOoOoVui
        GDk4bmkBRTsHdm2NuH8zDuUJ/Q==
X-Google-Smtp-Source: APXvYqyNJlQWHmGB5EFzivM0mI9t1uikYdxRz758//QRkWMrdEHQuMeg1tQxrCEA1ilrzYv6Ie9YYA==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr15995872wmh.55.1558713586104;
        Fri, 24 May 2019 08:59:46 -0700 (PDT)
Received: from locke-xps13.localdomain (69.pool85-58-237.dynamic.orange.es. [85.58.237.69])
        by smtp.gmail.com with ESMTPSA id i185sm4535054wmg.32.2019.05.24.08.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:59:45 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/4] bpf: sync bpf.h to tools/ for bpf_sock_ops->netns*
Date:   Fri, 24 May 2019 17:59:29 +0200
Message-Id: <20190524155931.7946-3-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524155931.7946-1-iago@kinvolk.io>
References: <20190524155931.7946-1-iago@kinvolk.io>
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
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf66f01a..e64066a09a5f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3261,6 +3261,8 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__u64 netns_dev;
+	__u64 netns_ino;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
-- 
2.21.0

