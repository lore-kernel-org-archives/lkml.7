Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D602FC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772E205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plzq5Hfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfLIVw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:52:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39775 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:52:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so927007wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhsD4XoraOrhcYU/bmdtm44QDUDPKPQnbWRVNcj/Pdw=;
        b=plzq5HfxDYgsXkKks69lSVb87yXZcc+LP3zeyOWaTML+CBz5kI3xgDicZhmUusmvel
         AI0QyiJCGj2PBkyana9/jxKAp/5rPwkTsUXwCanmkIEEGisSD694ul6cvhBCaOFV+aGR
         WKoF0tUw5Cmb9OHB6TSsBvRHcGftHn1ITnnbh64/y5y6DZNzHQW6sdI+sp/zk7yPFD9+
         BCxneGqB05jT2K9DHDIeITH+9eQthGT5BGnyFCw+y18krFNzPPH486yQXVpUL6/U8mM0
         EMyZybof3qOwy060Z58GZJWK0QXlAUc1n5/ZcmVJ5TCJ+4Cz7aCbXoEBc074apNSryjM
         kszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhsD4XoraOrhcYU/bmdtm44QDUDPKPQnbWRVNcj/Pdw=;
        b=GLLFMuVdWy0/lfvDXlO6ba5jw0PJz9nEPL8cwpG6PiQxW5R6jeAI99Su6zYM2mAVaS
         +KpEzPZmpD0frGzzA8nGxiODGQg6a5jx6LhZDiuKClmHT46MLH8AkVuKAK2/uPsH12/K
         tzVMtMOkvdeIbvXYrN+G8/vwwz1FL/J1dOJrqSp69N1Pnm50QunsamJmVI7WeSVkQzeh
         CB8STEly79bWETjGMJkBsOnqzWMZsiEjzALPpYnRtePgp8B/DvCH+bYAY5i89RT70o/u
         x24xKSG1FIRwSQQPOrpAliT6k9+jSqEVhn2jM02aKSuY0S1z95P4wwEkSBAUD3ZzdzPq
         7Ipg==
X-Gm-Message-State: APjAAAVKqdAkHBLzGAFDLcsW8OOGZnFDa1S7XlA7fU7IavDPVaSIxHnl
        gPgfsNR1g1gvCElpiEW0594=
X-Google-Smtp-Source: APXvYqzdsMbGJ/Vc4zou2dhGGxJpSrNwVwIkMYpQX3RAQP3qPEPPUgc2H/VrRbCaM8yIyXKSVS0xMA==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr1306927wmb.43.1575928346943;
        Mon, 09 Dec 2019 13:52:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40f6:4600:a51f:44c:fbfb:c44])
        by smtp.gmail.com with ESMTPSA id 16sm788661wmi.0.2019.12.09.13.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:52:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] lib/generic-radix-tree.c: remove unneeded __rcu
Date:   Mon,  9 Dec 2019 22:50:20 +0100
Message-Id: <20191209215020.58281-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct __genradix is defined as having its member 'root'
annotated as __rcu. But in the corresponding API RCU is not used.
Sparse reports this type mismatch as:
	lib/generic-radix-tree.c:56:35: warning: incorrect type in initializer (different address spaces)
	lib/generic-radix-tree.c:56:35:    expected struct genradix_root *r
	lib/generic-radix-tree.c:56:35:    got struct genradix_root [noderef] <asn:4> *__val
with 6 other ones.

So, correct root's type by removing this unneeded __rcu.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/generic-radix-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 02393c0c98f9..bfd00320c7f3 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -44,7 +44,7 @@
 struct genradix_root;
 
 struct __genradix {
-	struct genradix_root __rcu	*root;
+	struct genradix_root		*root;
 };
 
 /*
-- 
2.24.0

