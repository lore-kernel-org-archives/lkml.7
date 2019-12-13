Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E57C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A19206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aIUYOHnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfLMAJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39573 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731875AbfLMAJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so385893plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hompvs4TzHM6s+1/5TyS4xDRIwWIj/44vZj5QlCvckg=;
        b=aIUYOHntjzAwxd3L5BARNwmmEk6JQIP8acefncyZcp2QiHgm5HQZv+zhKNU/xkJ16s
         sPSrprQUm6NWIX3lQSCvjJRnLZCZygrbhvclb/9KRyJwACumT/xx48RI6QMCdcT5Bioj
         ZyMWZpiYgt4Awz4x0KzQTwlOAje8OnkoaLxXVxnJJP68wyH1RTYYtSpN6Ha54GhfC16Y
         WL3GMHzTrOEg7UEYYLonxEEz+lA3YcYBkfqQJuctAaOE1C4401OHGK1MPSKzUNnoM8Ig
         AU6McbGVMmCeb4Jeyawvqr++ESFWk0oJ+iKBM9fCWRvGDyfrpAz+3WNSfAEih82sdmeQ
         ki7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hompvs4TzHM6s+1/5TyS4xDRIwWIj/44vZj5QlCvckg=;
        b=bZZSoANaVYD3EHRfIQ26RsHROIEjJ0o8ktzEWCfNPI/kMjVHPff819Obk2/g2b09N6
         mS2hGxTYhExxNVyg5ce7vcNggWFJFPyq0/ucaiD/sYMigAnuYqfIioAfCwh5iQB0T4Yp
         UEnK59KBwLdukOz5q3fvBdToi+Xl99l8xTgqclVf5zgL9knf+e3Z8Haa9Z6E/Q3cEoKC
         GHtmV+1JMIS+yn1BRbxkSdLpkqgRHHZADEdzN0sRy9hU/51+3TFKMok5277int+OzBqf
         1zCkPeohN9HNFj+QCzq3MH/LmACiHOMMT3XZ5aScKrVEW1yeVb+6xmX0JiIDo1d7ma3y
         k5Qw==
X-Gm-Message-State: APjAAAU7d8VSypMqg1mapacW0E7S/Dk8tl2QLG1uYOIZe/el1cl9VRhP
        I4/C65jASUl5sDZK3b8KIMUNaMs/9yg=
X-Google-Smtp-Source: APXvYqwbjk8eQ60HCsyGrINj/6WOIvDOU0q5FM1bdjC6TvtdYoMStt8wLyL1RMXEwsRxfaqNgqVesQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr13291140pjv.78.1576195780272;
        Thu, 12 Dec 2019 16:09:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 49/58] serial/ucc_uart: Remove ifdef SUPPORT_SYSRQ
Date:   Fri, 13 Dec 2019 00:06:48 +0000
Message-Id: <20191213000657.931618-50-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ucc_uart doesn't seem to support console over itself, so maybe it can
be deleted with uart_handle_sysrq_char() from the file.

Cc: Timur Tabi <timur@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/ucc_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..ff7784047156 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -551,9 +551,7 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 	/* Overrun does not affect the current character ! */
 	if (status & BD_SC_OV)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-#ifdef SUPPORT_SYSRQ
 	port->sysrq = 0;
-#endif
 	goto error_return;
 }
 
-- 
2.24.0

