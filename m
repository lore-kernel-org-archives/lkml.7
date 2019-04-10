Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C29C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7720850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxaaloNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfDJA1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:27:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42012 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDJA1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:27:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id b74so172459qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISji1uWGDu3/ZIVPvH/7r5GRI7lMA0M7ljNcVxm1tRQ=;
        b=OxaaloNFA+kOssXZg7/iIDcQiEOwx4H0wen02+B6pgsRn2G8ujVxkgpIo6vEA510oB
         k5zTCfdbTzn/LFo0Ky2SZa/SfJbyHhUWHsUEivaVRNbX/P9ug0l8+8Qvsvy7n4wulPnG
         c7Nt6LXPnIkET1OrcI6l0TTTFtxx+wvp0IIrC/VCvlSqX+rJc+sg4rLfk9EVBvbTqj9X
         OdxUqL4Eb2XAhMz40uXkkuCKnbTfVPXXBE0XyDBmRu52URZp3cNY8HaeqYjgORtZhx7p
         rxJzkdK0Ld31xFc4uCmU9yQf9CKvty1b9u6KkiX5/rXM/HNbC46bWJIH/vRUdIO0A7rO
         4+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISji1uWGDu3/ZIVPvH/7r5GRI7lMA0M7ljNcVxm1tRQ=;
        b=MdgJfw/y0S2N9v/Vp/fDqVSmR8axi134a7Q3nBfmVjBZy8h58z0SVoRoiVOJliUMqx
         pG017WiLhHnE7qlt4lIlxXXvsrbsQvL7KtDXGq5tsGDA3NA2XI/w8U8HUAA0MV/Cv6R5
         aoxo7DrHr5wXVIl9zU2Q9iuRwMkxO5XRvtWz4nNv6Yb/PWrFN/k1HFxvwB8QPnVBCjwY
         n5syEbDB6Q7aTvUYdNjv8LBT9Gllrjgax4DE1+k32+lqN6CzkY9oHsR5PYhWLtPbpUJc
         6l/uFzx56G78UEqCHgEAfgRKUxyUYS7aqCD8lXAxPgIsh8Aj+g+qeX4NkR5sMUXh0xL/
         /zjw==
X-Gm-Message-State: APjAAAWVk9+uDZfoOWQZ6cz1hxitJHia4gT/70RQz139T86+F0TBR1GN
        SXiDToloKspV46uF6WaOWY70AfUf
X-Google-Smtp-Source: APXvYqwjsa5S7dwtQRkJPB5GPilohtzFIFGFlktHTggZi/iWzUhct3uijsf2hgEbdHDBu7fgNYQ+ng==
X-Received: by 2002:a37:b444:: with SMTP id d65mr30588401qkf.125.1554856036377;
        Tue, 09 Apr 2019 17:27:16 -0700 (PDT)
Received: from ultra.ic.unicamp.br (wifi-177-220-84-112.wifi.ic.unicamp.br. [177.220.84.112])
        by smtp.gmail.com with ESMTPSA id j93sm21808977qtd.82.2019.04.09.17.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:27:15 -0700 (PDT)
From:   Daniel Junho <djunho@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: rtl8192e: remove a blank line
Date:   Tue,  9 Apr 2019 21:27:05 -0300
Message-Id: <20190410002705.25932-1-djunho@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpath error:
CHECK: Blank lines aren't necessary after an open brace '{'

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index 467287ae6..b2ef3462e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -20,7 +20,6 @@
 bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 			 u32 len)
 {
-
 	bool				rt_status = true;
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u16				frag_length = 0, frag_offset = 0;
-- 
2.19.1

