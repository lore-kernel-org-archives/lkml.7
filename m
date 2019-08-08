Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2399BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8982218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9YPinVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbfHHIEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:04:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33673 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfHHIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:04:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so2825876pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zc/nRqOvNzHMrKAB58mSOIQ6hQFHOAxtPLfnS5Pwwg=;
        b=p9YPinVBzkKiADzWLbHOB9eEOT/JbWpsWfw8+bP1HF/X5rFLJbbm+Az9qpXVWtS8v5
         djuRJ7P3foaPEXsvo1paVGQPpIHscURNKI+h1D55eRXf7Ik9lmZ4ysW1EqdYbELCSzOY
         WxsShJZN7n6qaW2CYQcb/gAqvko83nhmx52+SB4jC7Hl/hm1gqXI7IAbKOFunbkJexMP
         JiGPB6usrr0Ut43D9eiogX9y0LN3QWlKnt3lcMigO5bHWf1qW17kUOBPCzF3p2ejjcXy
         g5fucwGqkEeqweI59NmHIoAF54BhN8XqgvKQ8aFw1msGZoR1hWymiRYj5weRzcX8pPgj
         k91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zc/nRqOvNzHMrKAB58mSOIQ6hQFHOAxtPLfnS5Pwwg=;
        b=U39nXtLaS+cE0Thny351HoIkFOn2nZKPLXMoQRd/2feRuyGuyGKPSjvE8VYafR2NLW
         Q2idtQcalAOecljH1Ke156kB7MrXXOGBJakUsVeaUmx59l36vJfMpF/3bQgYIM/LaVU6
         uE1rMArYsAtX3wF5ks/5uHFWiv2Y10Hd23OL3JbI5j3tvy8qyQXdRM8gQm2wjCHMxMH5
         HhJL1shAHpXNsrlJKO26WrSzVwhJ0cdqEfBrfwipjfmFJXjBX2E9twvv7E/9B6Ez3Tlo
         sOP8QzTsB6SFg8jo3JeKCGo2ego6ARKZyDYTRxCGkH+bQez1EfOee9AZw+rhfTqHcgf6
         3SPw==
X-Gm-Message-State: APjAAAVKVi8+ZsuTarrb1+WkkBHUDJdobEp94NIHF1aQDn3ZBZqAG4Oi
        jQNy5mGcobDjmaGautiH4j8=
X-Google-Smtp-Source: APXvYqzmHJtNbmvqH5x02KLP9NvXXrQGaUa5RFObharE/E1bqetddb9f54vnUjMxywWW841rPaUOfA==
X-Received: by 2002:aa7:9dc7:: with SMTP id g7mr13517880pfq.170.1565251477031;
        Thu, 08 Aug 2019 01:04:37 -0700 (PDT)
Received: from localhost.localdomain ([122.163.44.6])
        by smtp.gmail.com with ESMTPSA id v63sm97536749pfv.174.2019.08.08.01.04.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 01:04:36 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     cpw@sgi.com, robinmholt@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] sgi-xp: xpc_uv: Make structure xpc_arch_ops_uv constant
Date:   Thu,  8 Aug 2019 13:34:22 +0530
Message-Id: <20190808080422.16503-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static xpc_arch_operations structure xpc_arch_ops_uv is only copied
into the structure xpc_arch_ops, after which it is never modified; nor
is it used in any other way. Hence it can be declared as a constant to
prevent unintended modifications of its fields.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 0c6de97dd347..89c4b04337d3 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -1678,7 +1678,7 @@ xpc_received_payload_uv(struct xpc_channel *ch, void *payload)
 		XPC_DEACTIVATE_PARTITION(&xpc_partitions[ch->partid], ret);
 }
 
-static struct xpc_arch_operations xpc_arch_ops_uv = {
+static const struct xpc_arch_operations xpc_arch_ops_uv = {
 	.setup_partitions = xpc_setup_partitions_uv,
 	.teardown_partitions = xpc_teardown_partitions_uv,
 	.process_activate_IRQ_rcvd = xpc_process_activate_IRQ_rcvd_uv,
-- 
2.19.1

