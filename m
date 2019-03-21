Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0391C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350420830
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTgb+W1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfCUD7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:59:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34611 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCUD7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:59:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so3337921pgq.1;
        Wed, 20 Mar 2019 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sTJCTkiGL0YMxJOFyoiEIrKymZQwUjvC5BUDJW0308o=;
        b=lTgb+W1+kzspDllZzMym/+c1dkwnUtz3cd5I1NH5wPzwBLv5DTNfQAuJNAXbaz+CQA
         ueBxibFqGfB5XyAoIETVWrOTBvn5KgECIeDW6CBx/dZopLeJ/DIR02TRWm/PTWRVENTZ
         Luh2PKtE4FLCgnJ/jO6Ew9JvxxOkU5+69+UmdqbAZUlxW6bmtIQvbaAOg+a9SpOfyk2K
         Yfg8XaNBRoEt//uTrpA4N19So5scevly8qN7gpKJjjLwZgJVNHM2WQ3APriWQpn93EjX
         /McgD53qb+OzjxwjciqV3uKUSrdm5u4kGrbCu61Cju3mIWpoNf8DZCeMd7tUYzLnNOYD
         slXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sTJCTkiGL0YMxJOFyoiEIrKymZQwUjvC5BUDJW0308o=;
        b=dF6V9zRh7yz9KX+fVRTa6B96bW4uwTQAH8EiGbAGxe9vHt8IAfv6lXrgO8zdz/Mgm/
         ieS4tQj+ifwgmqFjXVZ7a3iXvN9/PouFDAyq58PweGp+d6TA2fgrSID2OqIiPiNkO0Uq
         cJIt8oVprTAiUHbGzdO4Ofk8JghpVCEXQqDYB+NmxYMIoYOq+jvxZFWb83/le8b3wZmQ
         u//1mKbMl8hl4SVG0MfqAtKZbp033e0d73/XK+mjm0GSkNBvpkxXrhBvKduRWmhOKfpw
         KlcTFuB2MDJiTRzkFzfrUwFQGsVnefaZvbW9rkTX4BZ7EzQiXLE+PaPwYCIurWnEFpP/
         HqyA==
X-Gm-Message-State: APjAAAW3fgktTdw1kX+aWWdm95A6Vqu34bKGKNLRadWBifLR8wo3onF5
        5IpAAESg0DW/i8gvwvyB/HFG1yL5
X-Google-Smtp-Source: APXvYqzVh0W5jsSsq8ULUCggHNNM6acnHmJARhrGzg0hiRRKIsBX2PNcgxTWTi/1oBLxa3x9ww+ysw==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr1323985pfn.45.1553140746051;
        Wed, 20 Mar 2019 20:59:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id e14sm1075125pgv.68.2019.03.20.20.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 20:59:05 -0700 (PDT)
From:   hariprasadk <hari121920@gmail.com>
X-Google-Original-From: hariprasadk <hari1219@gmail.com>
Date:   Thu, 21 Mar 2019 09:29:01 +0530
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial_core: Spelling correction
Message-ID: <20190321035901.GA12851@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix warning reported by checkpatch tool

Signed-off-by: hariprasadk <hari1219@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f..69f4871 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1514,7 +1514,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	}
 
 	uart_change_speed(tty, state, old_termios);
-	/* reload cflag from termios; port driver may have overriden flags */
+	/* reload cflag from termios; port driver may have overridden flags */
 	cflag = tty->termios.c_cflag;
 
 	/* Handle transition to B0 status */
-- 
2.7.4

