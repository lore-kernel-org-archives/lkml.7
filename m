Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AF9218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmFXaXis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLRC2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:28:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46174 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLRC2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:28:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id c22so410883otj.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 18:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsKFomZBuwrGJLUSeibm23zlCqGEUyhwrl7aVRMeaYU=;
        b=QmFXaXismDZnkuWHWZ4GphEMufMQbmlMH1PhovHCviJQRUo/4Qr9/oSfqMvC0PEFBC
         g3x9OXchG4TJjUK1pWOSWhoUL5Ia3hD/rYyNepja+Sz0+d53TLvEg7RPlrfK7IMxaRSD
         ULZ43tbCZ2qAe+4590k56tV9FIQGpttddbkb2beezCTB0RXF9gTG5+caTjwlrwvT0g1E
         yOdDJgOOTQou7Ite9ER5vx7UPdbH3XhLMMSLHdCE5wk6ZAuAV4blg7Q7C1q+7KmwtZBd
         PkfJthDo0ByNwfc+2K/Vj2ewcGkI9THHaliRbkPjJY3Tk8u3noUNuOc8pSP/BPW2iDyC
         /pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsKFomZBuwrGJLUSeibm23zlCqGEUyhwrl7aVRMeaYU=;
        b=GJxPAUDrQsHCm0P/uC3FTXjaZsuDKyCnfung6Cwg0aRInpA2c3kpCsoaaPPANCmCPT
         /e3h467fFONkQ39DtF86dWlNgjt7677C2Nzv/JfShLOODCES7uLtDcOW15/ZHe4Bq6ej
         iEw23nhh4hxDPmCygu7HlrWNNvgCiVd+BsLRLeTaC0CJjlphN3XLZTZjsriRPFBM6eBb
         sqvnhrswyafO7LVY8fd9SJA7oEa+fcK/KGWV3blImzXErxOlipmSdhVuvn92ScpPJ0C8
         mRvPIedKahZc0JEoxTHpyxqwVWWmR48xI9mGbYvoiAwAXvWMqk2kQe0KHUlyEsbdSTop
         ImIA==
X-Gm-Message-State: APjAAAWhIpFleR7LKdp7Ypku3uO6L3M74ojpw3gbVjP9N0MERUMj6RPE
        8qzEqLi6hBJwKxtd1sGT87pSZWuN
X-Google-Smtp-Source: APXvYqzWW6/Qc/mqFu+lt1LWQpXcDcZR4s99BF9VFKHJa32a3nY9wO9N3hAdg9joLuXedsavqt9JfQ==
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr477110otp.316.1576636083890;
        Tue, 17 Dec 2019 18:28:03 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e6sm274277otl.12.2019.12.17.18.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 18:28:03 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] tty: synclink: Adjust indentation and style in several functions
Date:   Tue, 17 Dec 2019 19:27:58 -0700
Message-Id: <20191218022758.53697-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/tty/synclink.c:1167:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        if ( (status & RXSTATUS_ABORT_RECEIVED) &&
        ^
../drivers/tty/synclink.c:1163:2: note: previous statement is here
        if ( debug_level >= DEBUG_LEVEL_ISR )
        ^
../drivers/tty/synclink.c:1973:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
        ^
../drivers/tty/synclink.c:1971:2: note: previous statement is here
        if (I_INPCK(info->port.tty))
        ^
../drivers/tty/synclink.c:3229:3: warning: misleading indentation;
statement is not part of the previous 'else' [-Wmisleading-indentation]
        usc_set_serial_signals(info);
        ^
../drivers/tty/synclink.c:3227:2: note: previous statement is here
        else
        ^
../drivers/tty/synclink.c:4918:4: warning: misleading indentation;
statement is not part of the previous 'else' [-Wmisleading-indentation]
                if ( info->params.clock_speed )
                ^
../drivers/tty/synclink.c:4901:3: note: previous statement is here
                else
                ^
4 warnings generated.

The indentation on these lines is not at all consistent, tabs and spaces
are mixed together. Convert to just using tabs to be consistent with the
Linux kernel coding style and eliminate these warnings from clang.

Additionally, clean up some of lines touched by the indentation shift to
eliminate checkpatch warnings and leave this code in a better condition
than when it was left.

-:10: ERROR: trailing whitespace
-:10: ERROR: that open brace { should be on the previous line
-:10: ERROR: space prohibited after that open parenthesis '('
-:14: ERROR: space prohibited before that close parenthesis ')'
-:82: ERROR: trailing whitespace
-:87: WARNING: Block comments use a trailing */ on a separate line
-:88: ERROR: that open brace { should be on the previous line
-:88: ERROR: space prohibited after that open parenthesis '('
-:88: ERROR: space prohibited before that close parenthesis ')'
-:99: ERROR: else should follow close brace '}'

Link: https://github.com/ClangBuiltLinux/linux/issues/821
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/tty/synclink.c | 55 ++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 61dc6b4a43d0..586810defb21 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1164,21 +1164,20 @@ static void mgsl_isr_receive_status( struct mgsl_struct *info )
 		printk("%s(%d):mgsl_isr_receive_status status=%04X\n",
 			__FILE__,__LINE__,status);
 			
- 	if ( (status & RXSTATUS_ABORT_RECEIVED) && 
+	if ((status & RXSTATUS_ABORT_RECEIVED) &&
 		info->loopmode_insert_requested &&
- 		usc_loopmode_active(info) )
- 	{
+		usc_loopmode_active(info)) {
 		++info->icount.rxabort;
-	 	info->loopmode_insert_requested = false;
- 
- 		/* clear CMR:13 to start echoing RxD to TxD */
+		info->loopmode_insert_requested = false;
+
+		/* clear CMR:13 to start echoing RxD to TxD */
 		info->cmr_value &= ~BIT13;
- 		usc_OutReg(info, CMR, info->cmr_value);
- 
+		usc_OutReg(info, CMR, info->cmr_value);
+
 		/* disable received abort irq (no longer required) */
-	 	usc_OutReg(info, RICR,
- 			(usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
- 	}
+		usc_OutReg(info, RICR,
+			(usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
+	}
 
 	if (status & (RXSTATUS_EXITED_HUNT | RXSTATUS_IDLE_RECEIVED)) {
 		if (status & RXSTATUS_EXITED_HUNT)
@@ -1970,8 +1969,8 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	info->read_status_mask = RXSTATUS_OVERRUN;
 	if (I_INPCK(info->port.tty))
 		info->read_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
- 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
- 		info->read_status_mask |= RXSTATUS_BREAK_RECEIVED;
+	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+		info->read_status_mask |= RXSTATUS_BREAK_RECEIVED;
 	
 	if (I_IGNPAR(info->port.tty))
 		info->ignore_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
@@ -3211,7 +3210,7 @@ static int carrier_raised(struct tty_port *port)
 	struct mgsl_struct *info = container_of(port, struct mgsl_struct, port);
 	
 	spin_lock_irqsave(&info->irq_spinlock, flags);
- 	usc_get_serial_signals(info);
+	usc_get_serial_signals(info);
 	spin_unlock_irqrestore(&info->irq_spinlock, flags);
 	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
 }
@@ -3226,7 +3225,7 @@ static void dtr_rts(struct tty_port *port, int on)
 		info->serial_signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
- 	usc_set_serial_signals(info);
+	usc_set_serial_signals(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 }
 
@@ -4907,24 +4906,22 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 		/*  of rounding up and then subtracting 1 we just don't subtract */
 		/*  the one in this case. */
 
- 		/*--------------------------------------------------
- 		 * ejz: for DPLL mode, application should use the
- 		 * same clock speed as the partner system, even 
- 		 * though clocking is derived from the input RxData.
- 		 * In case the user uses a 0 for the clock speed,
- 		 * default to 0xffffffff and don't try to divide by
- 		 * zero
- 		 *--------------------------------------------------*/
- 		if ( info->params.clock_speed )
- 		{
+		/*
+		 * ejz: for DPLL mode, application should use the
+		 * same clock speed as the partner system, even
+		 * though clocking is derived from the input RxData.
+		 * In case the user uses a 0 for the clock speed,
+		 * default to 0xffffffff and don't try to divide by
+		 * zero
+		 */
+		if (info->params.clock_speed) {
 			Tc = (u16)((XtalSpeed/DpllDivisor)/info->params.clock_speed);
 			if ( !((((XtalSpeed/DpllDivisor) % info->params.clock_speed) * 2)
 			       / info->params.clock_speed) )
 				Tc--;
- 		}
- 		else
- 			Tc = -1;
- 				  
+		} else {
+			Tc = -1;
+		}
 
 		/* Write 16-bit Time Constant for BRG1 */
 		usc_OutReg( info, TC1R, Tc );
-- 
2.24.1

