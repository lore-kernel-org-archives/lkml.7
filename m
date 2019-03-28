Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FBB206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYVEgaG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfC1DRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:17:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfC1DRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:17:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so10947565pgq.1;
        Wed, 27 Mar 2019 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dTrpAqtvYjeSSKgMyl8y+QHlxeAg6t2yp8Mcmpackp0=;
        b=bYVEgaG32edMYHHxeXMlnczX7ve+Y1+tmxnWIcqYwlHjHZlKa5xX1PHwa/AjdXkPMA
         hZPbOKoiPFVZPq86lSsdaXNhRwKgncYYBO3auBgJAWcbIy4srmmo1XbM39r6gOJ6oJO2
         ESReyGphwpzHlVrVy81UCSKkLBcmhD5ohl94PZdZl4LXs8LeGRQm2q+9oN9wZwiitBeg
         yZIUAr9RvqsPRNLbO8OXfbrHGl/XB9oZH41PFWrCJHuZ+Fom7r4FIw9bAQRVHH0MWacW
         niUB6GlxLThhICo2isooKV89gAwdujQI8XL4mHrdnCABhzty9713uXJmr72xuwrwRrMO
         /ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dTrpAqtvYjeSSKgMyl8y+QHlxeAg6t2yp8Mcmpackp0=;
        b=U9dsZgVRfwfT7up7DVXMHqUeQpnci4+hjxcMry/r+lBmPdHzXDGYwaul3wCjbaPUSY
         D/X6MuKM09Ik20OxgxHitoCz96sDOdYZk94ypDelaRsjQ1ZNgQ3+X7ae8vsxQDr0M1Sa
         0Tp72r5jinC36IUsuEay0HFWdSASdQYA26L8OcB/SuJTwyABHo3JV3Eh0HejxpakMU6a
         beZ23cAnp5xKNp+6/ly0EFEiMqYNgBfK517Sx9oPvBudQmw59Zpv3kjnPww3eY4E42ca
         W4V9RnOEnweIxPAR9P7doefQByu0lXRnVjni0oxiTXdwyFE5gcfyvnOgt15Cui5slU1Z
         3tZQ==
X-Gm-Message-State: APjAAAWDqDoMKRCG54/UAmA5tV87LD5yFifnMUJCMf02R9ycfmpTImne
        ummfAjNCBcsNmhMO4Z63/H4=
X-Google-Smtp-Source: APXvYqzIJwlCT569Mw/YCvjTvglgmHZt9qPEtbiAUuEikBQgoPKScmxilxKSpkgGn769XCGtD00Yxg==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr37075033pgr.411.1553743058812;
        Wed, 27 Mar 2019 20:17:38 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id l184sm37557658pfc.41.2019.03.27.20.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:17:38 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:47:33 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tty:serial_core: Spelling mistake
Message-ID: <20190328031733.GA13375@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix spelling mistake "overriden" -> "overridden"

This fix resolves warning reported by checkpatch tool.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
Changes in V2:
              -Make commit message more clear
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

