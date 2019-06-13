Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13D120B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjAOpihm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfFMPIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:08:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39006 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732886AbfFMPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:08:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so22923279qta.6;
        Thu, 13 Jun 2019 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM86v/g7D2pxbif/CtotD7mg7Of2Y0H8jgV6mxk3r7w=;
        b=JjAOpihmy54WG2SZzRzlpXDCurNpV6fkt/PA0AHkY24Zf/jQNeHsJRYBLpgnTk3Uth
         Z5o+cXC8quJuc8v5Ww4p7zXVuur3gHwJZskR03Tq0K/BVarzrVf/ES+S1cpSKRYGY3He
         aChfP36jXnWam19h6ktm/hwREpSKkjTaGWEee4P0VWUfJx8J0KhUUS31LMnt8agC3Qrd
         z4QtZRjz7pWq2DvsFKPmfvRye7rLtGIp0/VPDueaIPOmcTLSbj0OZumKTxrZqIKVI88w
         wHJsYPW4LXD73Ay/HaNLrrXvyVTRhV97yxNdpgfLHY7a1R1ya8tgrVBJvoKZC6vIid0x
         z3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM86v/g7D2pxbif/CtotD7mg7Of2Y0H8jgV6mxk3r7w=;
        b=p0eyCDgdhIk+Vw1lrjT5q1jmHnV36ZPd6MalwE33Aq/WvZnH/vdmScJkt3GWP2lFNR
         KAkom7rcX1C6anoLwRKPPfNc+FqHWCcNAMz9/OKKkF8UWmAUNbEiQUbVZAqixRhkEJ7B
         Nur5NxpqOYpCMDqHUgr07780KFIKHs+P4e3qbbeq2KN+HZHhMIH7yl+NjNs7V4g84ZB2
         LdT1eRbk52RhPLEbWYA2ualZuCnXz558rZTTc7mo8pQPcly8YdhTx9MkqcjvZ8p0RAkY
         kQdGtFqCyi0Se1svsaOdE7G6Rkrzsl6SmHgIgP1GkcHerdl+5bLEvTxz7E/5w23YoY+c
         6bHA==
X-Gm-Message-State: APjAAAViDgsLvYIzE8acFHdFrIUbK9cluWB97hmopY+8IzNxGdGt12eq
        FRVZpkQAKzrGQF8EtrTLLbM=
X-Google-Smtp-Source: APXvYqymmrqksCNR2TzjqJTxLKTez3Rqa9+i9DKOUnm9ktIhzT/+epy495o0i3qSjJMP8+1br+eRSA==
X-Received: by 2002:ac8:17f7:: with SMTP id r52mr77196979qtk.235.1560438500713;
        Thu, 13 Jun 2019 08:08:20 -0700 (PDT)
Received: from willemb1.nyc.corp.google.com ([2620:0:1003:315:3fa1:a34c:1128:1d39])
        by smtp.gmail.com with ESMTPSA id d188sm1641989qkf.40.2019.06.13.08.08.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 08:08:20 -0700 (PDT)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     jakub.kicinski@netronome.com, peterz@infradead.org
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/2] locking/static_key: always define static_branch_deferred_inc
Date:   Thu, 13 Jun 2019 11:08:15 -0400
Message-Id: <20190613150816.83198-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613150816.83198-1-willemdebruijn.kernel@gmail.com>
References: <20190613150816.83198-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

This interface is currently only defined if CONFIG_JUMP_LABEL. Make it
available also when jump labels are off.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/jump_label_ratelimit.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
index 42710d5949ba..8c3ee291b2d8 100644
--- a/include/linux/jump_label_ratelimit.h
+++ b/include/linux/jump_label_ratelimit.h
@@ -60,8 +60,6 @@ extern void jump_label_update_timeout(struct work_struct *work);
 						   0),			\
 	}
 
-#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
-
 #else	/* !CONFIG_JUMP_LABEL */
 struct static_key_deferred {
 	struct static_key  key;
@@ -95,4 +93,7 @@ jump_label_rate_limit(struct static_key_deferred *key,
 	STATIC_KEY_CHECK_USE(key);
 }
 #endif	/* CONFIG_JUMP_LABEL */
+
+#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
+
 #endif	/* _LINUX_JUMP_LABEL_RATELIMIT_H */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

