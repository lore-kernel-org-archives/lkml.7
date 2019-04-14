Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A784DC10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 03:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D182084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 03:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFsrY3pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDNDLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 23:11:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44697 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfDNDLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 23:11:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so15560458qtb.11;
        Sat, 13 Apr 2019 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pqEpMpq2ZMeZfBmIsXONVhx+1YLpbUMzYss/RTG9tGE=;
        b=WFsrY3pl84XamdBkRXVOC8T345mqK7np0ATeJewLAO3Go8Nug/L41ewGPWk4oe+uxI
         D8H3xjhB+g5scgpnHiP8/vDF5vCoI0xMp5hN2TLV3tZ9s+iJkpeXW1/be3X2GHcPaqFy
         lqVHZ37AQxYa24JyoEIxrsEGWKEKPNiTRFMnY+36kOR4w1WedzZinl+1DPq4hwXcxaF0
         VnOd9IMQPSfy3ZkgmtO5+N93tN3S4l/WK126KH+5MU9YN+adI017pVmDg4ijsRhSbJ+q
         14em3lwbaYUTrnNjIWvgjnCqE/68ggnkafJF8O8CpUcHA9JDQN5UU/wgL4X+4x39BG+c
         XaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pqEpMpq2ZMeZfBmIsXONVhx+1YLpbUMzYss/RTG9tGE=;
        b=k2qeYFqtttzsqO39TongJe48lmf7e+sXIrebsb3f4nLCaerDbDhlxjwCIQVw1mnvl7
         i80W6UvhZBmfRFAtecAI4oQOx0EkRDLiKN5QBJ7NCbcsd8pkyNDkgdv38vT5xSIRT9xG
         3MEG35vS0pFw3nD2I4t73lIDCFyehQM+rShvGPVf8/ENwMkjSFBfDUjJLafeFXRcxUOP
         Tisnjf6PSsO0XReo/o2eSi0c2kEcdcVotZlwjSbyJe3g5dsuR/7ovEDztGlzgPixAxz3
         FiVqZFxyaOrCW9SvGHvAGnFm2hzHZPRqCYTFG265H/tG7naIL6+FQd+axXPwm9GMd0aI
         Jscw==
X-Gm-Message-State: APjAAAWyqy+gH0jYQGz203eutJyP498+3uNdn2PGvFUO/nl+L1xzeAtz
        qFcAKXPiGVia3je+g3SYn2VG++Z3ijw=
X-Google-Smtp-Source: APXvYqyEI/7WNff3Zb5sPurf3Y4kzCAM4naDBy0RfI6Nk75n5MFyUM1pXWaW+ooE1VzLqk/ybwtjew==
X-Received: by 2002:ac8:2368:: with SMTP id b37mr55091967qtb.50.1555211510827;
        Sat, 13 Apr 2019 20:11:50 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.58])
        by smtp.gmail.com with ESMTPSA id u44sm24668430qte.40.2019.04.13.20.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 20:11:50 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 3/3] Documentation: kernel-api.rst: Add block/blk-mq.c
Date:   Sun, 14 Apr 2019 00:10:54 -0300
Message-Id: <20190414031055.26350-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190414031055.26350-1-marcos.souza.org@gmail.com>
References: <20190414031055.26350-1-marcos.souza.org@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now documented functions of blk-mq.c will appear in the official kernel
documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Documentation/core-api/kernel-api.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 71f5d2fe39b7..cc323480ce0e 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -276,6 +276,12 @@ Block Devices
 .. kernel-doc:: block/blk-map.c
    :export:
 
+.. kernel-doc:: block/blk-mq.c
+   :export:
+
+.. kernel-doc:: block/blk-mq.c
+   :internal:
+
 .. kernel-doc:: block/blk-sysfs.c
    :internal:
 
-- 
2.16.4

