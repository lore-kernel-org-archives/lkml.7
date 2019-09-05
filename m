Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE149C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B092E2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl8cg9pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfIEHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:42:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42437 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbfIEHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:42:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so865040plp.9;
        Thu, 05 Sep 2019 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBvvS8Ifgerj64qNxAVniHlq7uYFZXu02QIX7Pp36ko=;
        b=hl8cg9pclBKf75yEQ+msalibhdyY9q5LWoTXIs+1N7KckJ3pGTQedG4HmXLAvSYKgS
         FpfPBCyrHLVc7T+hCJyyC/PQgOxGhloNN3OrR9zlp87irsupRrcp1oq6V49Eflq1c+6C
         SWyJVdfn91hYcXTorcIpiBmaJyyRhtYyv9RHlJ0beXH4JZXm1NDLAY+FnoX2hZjd2ggp
         7tYsWeAMSw0P3UxSPXfcfkzR3daB7Ze9HjrG/aNW+d8Jsc5LuXjZt2WuBTeINpxxt1Ks
         WfDrZZTqkFP2VQaVhULP9RoXJtLvsqhCtqvslirdlYcGIznFwik1/GL0LNbEvrg5e4ds
         wO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBvvS8Ifgerj64qNxAVniHlq7uYFZXu02QIX7Pp36ko=;
        b=dDvZOIMOFzmxv4S+cjsv/TK+D7Eg2ETjazVhoK3275N5ynoAMgQw+/c8vmPNBXhRff
         hDU8KwdCelYb+snf9NRXuMOx5UiWU0Bwh/5FnMnD6S/hvXuZlJVe9aL17Obw3t+nja2c
         PIdfomRUfn60F2r2bmn96QUhySrWd1vWoygtdsODhouTJ73swlGPZYBaYazVmMGzwpU7
         J+oOkTEaH46kHoUjvxA/ki4NT/pBPgaYGlR6UdplsT/IiCWT88DEHJ3ibB6X00g8IiX+
         B56nDLXo6v/Nmpyg2YlUvI0n3xu/Znxx80rQ1TRSCOxVkSjNfnl+00n3r4mLEc8okKb7
         obbA==
X-Gm-Message-State: APjAAAUNP4Cva0EiOwXcoE0jExiB8mRCYbeBVgysZusoYBa6DLS9jJ7A
        JOYp9ZZiRT5f6HT8qqrG9es=
X-Google-Smtp-Source: APXvYqxdmtveZ3KQEVhgFRZfS/cuFePwXE7S0QmrtMkNGj3TaeJ8XraBevqCTwyIF+IRKVC7nyXtMQ==
X-Received: by 2002:a17:902:7449:: with SMTP id e9mr1980377plt.242.1567669347125;
        Thu, 05 Sep 2019 00:42:27 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k5sm1058919pjs.1.2019.09.05.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:42:26 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] serial: sprd: correct the wrong sequence of arguments
Date:   Thu,  5 Sep 2019 15:41:51 +0800
Message-Id: <20190905074151.5268-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The sequence of arguments which was passed to handle_lsr_errors() didn't
match the parameters defined in that function, &lsr was passed to flag
and &flag was passed to lsr, this patch fixed that.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index c4d8c77c1261..4eb5dbfbc46d 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -609,7 +609,7 @@ static inline void sprd_rx(struct uart_port *port)
 
 		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
 			   SPRD_LSR_FE | SPRD_LSR_OE))
-			if (handle_lsr_errors(port, &lsr, &flag))
+			if (handle_lsr_errors(port, &flag, &lsr))
 				continue;
 		if (uart_handle_sysrq_char(port, ch))
 			continue;
-- 
2.20.1

