Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2010C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4EF227B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Wm1mNu6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbfGWNcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:32:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34651 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbfGWNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:32:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so31108437qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wbi64v5rEm7HFsfzzjJbp4J8IcfJcVaeKh/hngTyPsU=;
        b=Wm1mNu6UqeavxWOEv9yFut+W+fp2Xfz2mxznFffbwjCks5mWAtMQpvqN4WKT8fewzE
         doKdEAQZrxmTg4yjAvRZAUj15w/BhRF8ap0MApOagCbi8xBmnWPv3ip7Hh0SuZA2nUJk
         1ip3sMCQSdaBtX1inP1N6J4KCPsyxRMNGQO118ffvc2WVK6HndKK+CI2PMVIZJagIYBt
         aFu9dEpf0e+WeW4lrD6d+D9peMnb1pOUB8ck3G7O5a238/7PSV0mwHFKUxTAESrSVChn
         zt301VhbDs+aL0GT9Za2mZel5hhsGcAqv6z+yFgHmouATgrbdpgmgeHgkCvqY8xJsVDO
         6PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wbi64v5rEm7HFsfzzjJbp4J8IcfJcVaeKh/hngTyPsU=;
        b=TZDJaDuYgdKxMDYad1Qvl/k40oTYLl2OdV/sFE1NTkeHRqr5v7W4pndiXjXN5REy6+
         57j8Qn6oVUQIDeCUV7LkYG12V1IrgXYEm5S/PYKBbQA8xzKkD3e4jXPcO5xet0+LuXT3
         NV3YkauCzhNQ5zn4jExS+kKygTM6rFokpkF9hC92qGqlfgxnFceNKzatfdgFu7jV552q
         0wdJWsggd7Lybxlnc94M4/wiDyx4GFvesO7MSgAKAQf36L0oLhPgNSoQnX+k6VWDF6tf
         h79caHP93J224e0DzncyncOiRFg4aRk8ZLOruIMquyXm0SM2wpYW9ZXfv1oT+eweUddm
         cbxA==
X-Gm-Message-State: APjAAAUXbdpRfEj7LF32hwRwZ4QDdKnaqk9ARGlYF7sYvQrCvRO9OTX1
        NvJLn+ue0yuq0orlgqw3aerIQw==
X-Google-Smtp-Source: APXvYqzywbHBvFhQzJwOjcTOk+fswqbm/DHtvEWcjepHqXbWX+gBtnTNSNqQRraTpHwslRtn2i4pzg==
X-Received: by 2002:a37:94d:: with SMTP id 74mr50337891qkj.101.1563888736189;
        Tue, 23 Jul 2019 06:32:16 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h26sm26379995qta.58.2019.07.23.06.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:32:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, issor.oruam@gmail.com, tiwai@suse.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] firmware: fix -Wunused-function compiler warnings
Date:   Tue, 23 Jul 2019 09:32:02 -0400
Message-Id: <1563888722-24141-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5342e7093ff2 ("firmware: Factor out the paged buffer handling
code") introduced a few compilation warnings when
CONFIG_FW_LOADER_USER_HELPER=n due to fw_grow_paged_buf() and
fw_grow_paged_buf() are only used in
drivers/base/firmware_loader/fallback.c, and the later will only be
built if CONFIG_FW_LOADER_USER_HELPER=y.

In file included from drivers/base/firmware_loader/main.c:41:
drivers/base/firmware_loader/firmware.h:145:12: warning:
'fw_map_paged_buf' defined but not used [-Wunused-function]
 static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
            ^~~~~~~~~~~~~~~~
drivers/base/firmware_loader/firmware.h:144:12: warning:
'fw_grow_paged_buf' defined but not used [-Wunused-function]
 static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)
{ return -ENXIO; }

Fix it by removing those unused functions all together when
CONFIG_FW_LOADER_USER_HELPER=n.

Fixes: 5342e7093ff2 ("firmware: Factor out the paged buffer handling code")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/base/firmware_loader/firmware.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 842e63f19f22..e74117bf8587 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -141,8 +141,6 @@ int assign_fw(struct firmware *fw, struct device *device,
 int fw_map_paged_buf(struct fw_priv *fw_priv);
 #else
 static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
-static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
-static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
 #endif
 
 #endif /* __FIRMWARE_LOADER_H */
-- 
1.8.3.1

