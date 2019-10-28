Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56601CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AF321920
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzKW9wy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfJ1Twn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:52:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42917 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbfJ1Twk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:52:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id m4so9688167qke.9;
        Mon, 28 Oct 2019 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MCaeEL/78MnjFFwuHJ0AYNxPqsK2pIIoZSumh2mRdY8=;
        b=lzKW9wy/0/86TWk5tUgNvR0HwypHCx5Ke+7rBcwC1oNlfL3Q1O4E1fpwN8iYn12e0I
         eXEvn2VLGbx0qEvLAMzuCgwByzc/qQHM3007JnbqP+KybgFqkBvj1tWSTmQim3w1Txo+
         1RbUqYD4PK2qHUVjFysp5ezb6307s8KgAz0WSxQG6Sozh4RovOLkzaxzXMMzmcGXzwSe
         lqij+vZ/N0UH8cFYqpqiFpEK0CUIRB7+QDmnd/w9/rKD7p9zTZ2xIfMKwvH9ldh7LcoL
         SonzMRK6ctiXTwBNzFNhge17fDKAodxVvDamAZrSWpHcuMJAJKmXpyN9AXWEYoUKNFa2
         PSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MCaeEL/78MnjFFwuHJ0AYNxPqsK2pIIoZSumh2mRdY8=;
        b=OIauJzkKE6SYf88xY6obg2fryQP3vGJdIHfY0U+KkuMkQE+DpkiquTkUk84ODfk/bT
         gEwo0MZWyy7Tx/bP7usKzjDuBU25igSRZbZ4s+jRAyzruJab2GHerF6rwmzChiJhl4VG
         CHavttCqqiJ2AzY1Fqndm5CBwEmcl3b2jWMxVPgbTP7ILdqiSdj842EIMpaqoJVlxDNt
         whoHdEqg89QPc3M/HIkIm07brHyDKTwmEzeS0M9FYXiOSNN+xtEl4BRSWSIf/7VuqqWZ
         0/QdlI7Scq3uflfhPCP2KdEXnsQAJyRfV2gDuX/T0d+Ksz+JGt41f8mJksKdPwWvz3A+
         a+Mw==
X-Gm-Message-State: APjAAAVzlalJKUA5be5Z9tB5EzftT30txiv1neygTkMyt6wWD8yODW2K
        rdGIKyh7rNKQA2340LMR9Zo=
X-Google-Smtp-Source: APXvYqxXT16kK5n0lox1JjXJu7w248U/uRiMi9DRanr3/l6tbIsvvDpT8CsQMhrey/whDHLElzMuXQ==
X-Received: by 2002:a37:bc86:: with SMTP id m128mr17662959qkf.110.1572292359634;
        Mon, 28 Oct 2019 12:52:39 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id x9sm3587690qtp.83.2019.10.28.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:52:39 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH net-next 7/7] net: dsa: tag_8021q: clarify index limitation
Date:   Mon, 28 Oct 2019 15:52:20 -0400
Message-Id: <20191028195220.2371843-8-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028195220.2371843-1-vivien.didelot@gmail.com>
References: <20191028195220.2371843-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's no restriction from the DSA core side regarding
the switch IDs and port numbers, only tag_8021q which is currently
reserving 3 bits for the switch ID and 4 bits for the port number, has
limitation for these values. Update their descriptions to reflect that.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
---
 net/dsa/tag_8021q.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index bf91fc55fc44..bc5cb91bf052 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -31,15 +31,14 @@
  *	Must be transmitted as zero and ignored on receive.
  *
  * SWITCH_ID - VID[8:6]:
- *	Index of switch within DSA tree. Must be between 0 and
- *	DSA_MAX_SWITCHES - 1.
+ *	Index of switch within DSA tree. Must be between 0 and 7.
  *
  * RSV - VID[5:4]:
  *	To be used for further expansion of PORT or for other purposes.
  *	Must be transmitted as zero and ignored on receive.
  *
  * PORT - VID[3:0]:
- *	Index of switch port. Must be between 0 and DSA_MAX_PORTS - 1.
+ *	Index of switch port. Must be between 0 and 15.
  */
 
 #define DSA_8021Q_DIR_SHIFT		10
-- 
2.23.0

