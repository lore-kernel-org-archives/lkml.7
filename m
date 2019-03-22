Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CA3213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o91PhKL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCVDCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:02:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCVDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:02:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id r124so465942pgr.3;
        Thu, 21 Mar 2019 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NDVLMf7ewRfh6LnuprP26c7/SHCwSPciThVk173FrnI=;
        b=o91PhKL17b3/9z9/Kyv1nZM/avF4BEwkn3+atQNF6r4MtlN8ZbiJrcWzmy6eQKNmyn
         mQeF39yGhOk3tw4rqWG7zAF71gM44Ylvryemk6apr8/rph0AhInWffxMDp/YawCBDdY8
         KLReJk/Em4paH/OxjPtntSyjw41kIjsEf5uMAcTQXOZwQEYthHzaANVSoao566WMkIUA
         a4uUI2mK4WkN7nhRv65AEX3JThIqS8qdDlpGePbQusQ4uFtl+kbbzSdfCr82fjaAK69o
         htrDcKYgWrYbJKAAlti6dBySv+0iU89qQi3fCtQv+YHzPh57kCdzV7VCNUWnVXCYaUXI
         ulCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NDVLMf7ewRfh6LnuprP26c7/SHCwSPciThVk173FrnI=;
        b=gxzygZTH+00SvMxubWOR6Q5YI6p4rC0AvZCreIUmG8zOnDhADsPxEVUibzzSItNLAl
         cLQr+xV7Mf+RPp+ZkmrUCnk1NDtOC7jqRpbUEVhumOJKFJN6PimGyHnb7pA3kQAfMQmX
         5rRKiSlGOCDxhSbnutj26dr6EUt2U4vndlCx/wvhOty/v/WNUkQ909Dhhq2BQbTUW9ZN
         qnx7iFQN7kZCLcBd/vJzP8Mz6hc+Dwn5X4ZskqD9HDTT3GZzyb2wRNWDzHLFvOz8zgL1
         BVbTkl8N1wp+Ff3xhIDfg8r7ONzIfufg10IYoTSv2OpUnJ4aA2/cqG91Djg7VWsZcRiu
         v4HA==
X-Gm-Message-State: APjAAAVc0VZdnZ4TaQLbUIi5+2adROyUApZn7Rl7TcLUjQ0DizYmsw9H
        eSmX8nZwaWrcI8bN/XG35FI=
X-Google-Smtp-Source: APXvYqwldKtZZ1VRasVAueLICUObKnwXOKkWwDW/SsBdmSq4ZihALKEY4LPaNW66lZPDXcQu9VNbTA==
X-Received: by 2002:a65:5281:: with SMTP id y1mr6777310pgp.59.1553223724402;
        Thu, 21 Mar 2019 20:02:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id m3sm6850608pgp.85.2019.03.21.20.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 20:02:03 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:31:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial_core: Spelling correction
Message-ID: <20190322030159.GA6551@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix spelling mistake "overriden" -> "overridden"
This fix resolves warning reported by checkpatch tool

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

