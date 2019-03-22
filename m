Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00393C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B406A2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8yFVgKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCVAid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:38:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41238 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVAid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:38:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so262127pfn.8;
        Thu, 21 Mar 2019 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1gWlWEmRYUSUaLgIycB8FE1EcJsGJ1IngbbJj4FDKgc=;
        b=V8yFVgKFdh8l5b26BbK5e/B+/uJ6xjjtXsJQjmiEwYo8MOPsKrzkYcM/JpbHHA59nB
         1z6tyK0Vghk8zO+nPe7d8PnbwCW/2Pf868jvk+ZE5bMRoVNL9qp5+eFi+7w9Q69rcsbJ
         9Cx6kjoq60YYX1NnsiEwVbWNXRiSv5ooPrn5/6AuPl03oXBjlwGLJmzjWYv2OaiWwsKp
         ai3KxnZjFKF12Rja1PT3FamRsHVavF1Y9xhFs2mGD4PPC+N/pk1pZdkOkzYHas63as25
         uDY7BtCrsg1aHu8GQEKNs3pPMUwyEEgeEPR4sxXFFyaiHDbKWDJqha+JB+lZdVbtliIj
         d41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1gWlWEmRYUSUaLgIycB8FE1EcJsGJ1IngbbJj4FDKgc=;
        b=SAUV5ddu0QKPmMcal0algw+6yHaAGrlJkvhcRg0zVqPv1HBrsMOwo2ar0IYuc+wXRW
         +WW+jA7lcu4neTYRZ8IeVZsIJ0w/yBSYqSXyo+jyhxXI4nTgW5xx6wkoKKmLDl6C9cir
         pGX+WY/z8g5M2Kl0Or/xYK2BJDSGKym3LHP5kDZkOK0DeRVWHExNBghniEkAXgq5v8y/
         id0bJzyl8V+VhHOay0arlrV18tbgVc7Wdoud2hutmQ6fvyH0ahmnyB8VGywjmHYsQ7jI
         7ZIBeZfbT2t5ABPDH9gmyorRCo/gnnPc8Q7tPGTV3+HerHy3J2QvXFa6w9Jm2gTd0ZZn
         TS8w==
X-Gm-Message-State: APjAAAV4hOKQsSIEKTQ4S39zDXUlO52WDPa42+4k8dYfXb/STJUZAXtg
        ymfLXhd38vGZgdj078wAvEo3udkmi2I=
X-Google-Smtp-Source: APXvYqzgHUUjFIqbV0e5BYZl0TZuE1A5IeIauzRz83agH7CTB6iW5KdgnHIftEKSOGG/PzEa90NPVg==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr6613005plb.155.1553215112848;
        Thu, 21 Mar 2019 17:38:32 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id l184sm9405719pfc.41.2019.03.21.17.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 17:38:32 -0700 (PDT)
Date:   Fri, 22 Mar 2019 06:08:27 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial_core: Spelling correction
Message-ID: <20190322003827.GA30643@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix warning reported by checkpatch tool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
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

