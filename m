Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CF220675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp22GgP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfD2QYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:24:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41893 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfD2QYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:24:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5554859pfd.8;
        Mon, 29 Apr 2019 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uB2Cn6vt7lIHnf3rgmPWq5gvyZqG3kA3H3L/WXF6eJw=;
        b=mp22GgP5px0fmIqfkmimZYOiRhIzoxPaiTvDL/7i07QjDIIQJ0rpdygJtmuy/AWKPc
         DnQq3BrvQwpq7tQeOeF35NdBA16WtWGFGSvNbh+1t83b+GdSfrv9v5JvvAvug8M8Q4ht
         7tvzfamRLebvk00LU3eRV38p/NFhgx+sr+YSxJpxJILiaZp40gbKz4g4JUpUe687VCRp
         oLPXWYrUBKkSUijNyVusjOH2s2VV2dlQy2ahF4HvPqtDKGS0FXlOidRajgaKGNu2zZ4h
         0631a0sNTixhig1A0WUVa0clS2+P7u2iMwsscFATCUXY5oQNlWzD5zYgz/+jGtamHaye
         kSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uB2Cn6vt7lIHnf3rgmPWq5gvyZqG3kA3H3L/WXF6eJw=;
        b=RGzXA0S+o5ycUW9/aSQZY+nYAuDu6G6S9q46IGTz8J2IMxMazNrtZw1rDOI+nb5i4g
         DHoZv9iGLFP2bbY46INCxGT29Mvi9+dfjSQAcgLcX6oZWVs02mO0f4G3g7IkKJqxWENI
         grukDFwX224XjcObtR1IYc/nihF4jMMK5iFgDdodyecN4dmwMnj+bY4fDn6nj+Mvkli+
         zxN9RHKWhRbcHuGoagJ7ZGp9hTGXmRhX3kbIHepbK7FXZrzRDZIbRM4NI1lBoX5fetbZ
         11CUgvZ8ejA3OHVLzkTMAPp4XczNGvJAJ0tZIfzKC8es08KF3DOEeF/zdlgzst4lOLrW
         oRVg==
X-Gm-Message-State: APjAAAVYqqTRL5vycFq9QcjdXoquMfamf1GG+WdWHbSkD67ayK3J3QX9
        nDRNxTJUp8l5xHguuT1z0N4=
X-Google-Smtp-Source: APXvYqwtFrG+aznLkWMjUUxD5mJkPl2+rcD4GhwpQwuID2vGgJPv3EzF65p2NYVstIAmSoJ+wwkpgg==
X-Received: by 2002:a62:b602:: with SMTP id j2mr63953905pff.68.1556555045404;
        Mon, 29 Apr 2019 09:24:05 -0700 (PDT)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe77:6cf4])
        by smtp.gmail.com with ESMTPSA id 63sm3114849pfe.140.2019.04.29.09.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 09:24:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 00:24:02 +0800
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, haolee.swjtu@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: serial: 8250: Fix type field in format string
Message-ID: <20190429162402.GA5086@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_dbg statement should print the value of uart.port.mapbase instead
of its address. Besides that, uart.port.irq and uart.port.iotype are all
unsigned types, so using %u is more appropriate.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 431e69a5a6a0..dfca33141fcc 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -462,8 +462,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		return -ENODEV;
 
 	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
-		 uart.port.iobase, &uart.port.mapbase,
+		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
 		 uart.port.irq, uart.port.iotype);
 
 	if (flags & CIR_PORT) {
-- 
2.14.5

