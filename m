Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94596206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556258431;
	bh=jnmuq7yqnIOJMkcmN7f+GLPkX7bV2tjbMM3SZN5ocns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=by1XKYlOfj/KP5+UesPzhQpe5mpYy5UXDjU3O4rbRshObQSnywmlg+xbteIDoL2RQ
	 tjsC1QRZeSfurlD7qTe/Td0ve+V5bYFY/7PbebyupHt8jNrKXc9Lj8YOmreJqzoisT
	 vzDKoEZtt7tlzvOx3iOk4U9wnHgyjS42nRw3LdGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfDZGAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:00:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38085 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfDZGAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:00:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so1790630ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xt1S7YWTN5fkfDZ1Qpl5OKzw3BI4K8ze5odHv7qZycI=;
        b=WJMXf8iP2Ty4T4TZEp4+EVaIEOaM4+sP94acqT2pSyruGgTMMsYI+FQu9GoOVv/iYL
         M2Q31xZBZcvMBXyVblfvKRJ7V6lerngPM2UWorgRjSSHGLvsyn/iQWCVWRRt1cD444FQ
         1bj73NCYKouR9c4xVrhuu7lgtI+rDN/c3UbyGXfcNcAqadj9sb4LpjIJw/p/FvXNP9Z1
         ABYwUGqKQH6r6BFiSgBCH3ThEhWQkSxK2HtuDzdFFAADlBGyNxYQj1xZaZXN34kyeAxU
         oQnuV5DCrWsVZ17xZ3Y/RhRq0hTktqb6F8ufM4IN9ns5QfxKkl2qgqxJ2X+ZHK5aDL90
         9NYg==
X-Gm-Message-State: APjAAAXN8hyOy7BCgt91U1Moc5MuszveRAYkbV5XH00dYAEMmn7U3yec
        uTlq7oUBpyZtSj0f4MoBkyw=
X-Google-Smtp-Source: APXvYqyurOWEHrT4Fz2SjjTTLem3zFo+cihUAkrxaD7l6NkYbhhrJ8YNzD6DFd/OKXTkD/njtJ6C6A==
X-Received: by 2002:a2e:974d:: with SMTP id f13mr23528804ljj.140.1556258407188;
        Thu, 25 Apr 2019 23:00:07 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y20sm1584684ljh.27.2019.04.25.23.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:00:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hJttz-0003WC-Pk; Fri, 26 Apr 2019 08:00:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] tty: cpm_uart: drop unused iflag macro
Date:   Fri, 26 Apr 2019 07:59:25 +0200
Message-Id: <20190426055925.13430-4-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426055925.13430-1-johan@kernel.org>
References: <20190426055925.13430-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the RELEVANT_IFLAG() macro which hasn't been used at least since
the dawn of git.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index b929c7ae3a27..505262b1c6c2 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -567,8 +567,6 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	/*
 	 * Set up parity check flag
 	 */
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 	port->read_status_mask = (BD_SC_EMPTY | BD_SC_OV);
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= BD_SC_FR | BD_SC_PR;
-- 
2.21.0

