Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153D42054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swY5goSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfC2PUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:20:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfC2PUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:20:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so3038925wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3sg4MTnbdL1BrXYtTzR9636LH/iHJOQmHyWH4t3rTv0=;
        b=swY5goSuRF0KkZgd7N9noglbSp3PTs627UjtfHmAAEN7ql6JIoukIIepfxhYqR3H34
         bfMNjZ7/ipMg32iPBow/fyl6tCIF9dN5ijliJfmn1N17FOAeoHOiH8IpKnkntcuYVnJu
         PFaDf0dh9kDVi7tlHr5+n22p6i+B6I0cNDCWVbQMIn26OG6X7CKamAhBoRBUNCGeLHRD
         slkF9xtSM7axu7QeJFN7PxmzRM2y9VrNKmAPyFIjMmhqjNZ5v/cEyxB6aMPje2cKYZuu
         S80P9BIw2gRUuT8qvjtJx32568oX4H1wymQ1iVNYh4r61ACXwUPKqUWsaNpr/CFJurI0
         1Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3sg4MTnbdL1BrXYtTzR9636LH/iHJOQmHyWH4t3rTv0=;
        b=k6ZEQosJmrrQOdtc3qxWpYFyYyc5tN6QK3/AJLhMvx2newhS99BC1h4tW5kBs26GsG
         SICg56kiRC7naRLCjZZOYqPWJ5MYto3xDcyiqAGe9JOJhOl7XH6WSKfCYr1tflvY3cbl
         yArn43o8cpmYqwGu620hcSn0tP2R3C56Y+0gEwV/66/sgxkoLopAL28jSLRwNztu905X
         P7ahE65nvz0xZ1EpHu/ldd4vHGot01C4YqXJcxB/c7CGrYqYeDYSfSIheaWQ4Bg3+eHP
         bGnzEULUTTI7rkCwUw9vEw27v5mMgm/Hy6h4bXTlGRmXbXnawSu3eullLv+L9QgLrfs2
         KcNw==
X-Gm-Message-State: APjAAAVEx7SojKiA4+gCC0csm9heWUgUueOgDxAL3EjJol1myMYe5E3z
        MTwud2D823ufKKIU3nrPS2U=
X-Google-Smtp-Source: APXvYqxms/eC+WjXzGHuLLatSRGfDjERBdHPNA7eLZsf2luN3rU+Q4e7/zZJqAEER1bRtk47zgZiFw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr33112608wru.117.1553872847498;
        Fri, 29 Mar 2019 08:20:47 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id o1sm2737128wmh.47.2019.03.29.08.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:20:46 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] parport: ieee1284: mark expected switch fall-through
Date:   Fri, 29 Mar 2019 15:20:44 +0000
Message-Id: <20190329152044.27992-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/parport/ieee1284.c: In function ‘parport_read’:
drivers/parport/ieee1284.c:722:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (parport_negotiate (port, IEEE1284_MODE_NIBBLE)) {
      ^
drivers/parport/ieee1284.c:726:2: note: here
  case IEEE1284_MODE_NIBBLE:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/ieee1284.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index f12b9da69255..90fb73575495 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -722,7 +722,7 @@ ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 		if (parport_negotiate (port, IEEE1284_MODE_NIBBLE)) {
 			return -EIO;
 		}
-		/* fall through to NIBBLE */
+		/* fall through - to NIBBLE */
 	case IEEE1284_MODE_NIBBLE:
 		DPRINTK (KERN_DEBUG "%s: Using nibble mode\n", port->name);
 		fn = port->ops->nibble_read_data;
-- 
2.11.0

