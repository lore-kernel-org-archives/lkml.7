Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F6AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C1A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cfj+plni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLREBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:01:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35298 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLREBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:01:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so343422wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvdPlfimj6OGtq993uBEH4HDXjgpDehuAkgs24MT6mk=;
        b=cfj+plniTQLIAyRxe47ndjyUvVeRa/IxIB8Mt5PLoJXGK7UIN41nnUaB01hoT40Hgi
         MUnbrBOHR6khmDdC4UHAZn/92St+b/mOb+uCNrOB3V/qhKcx2DP/BjxB+716LHq0wS+W
         hSDCpRef2eFLd+prsDVNKPwH55vxNXrD8pilYnLJlBqPbfG0afcRQ7tBDkgSpTv6ZZOm
         ojAJt9h+C+/Xh2k10LfXKGyGzojYJSs+7jrB6KGxIf3MpBsNiZ7ic9OEWt96tNokgyY/
         Z/VaBmkXTfwqXxhaL03fXunnnRuFxGbRahNjsrwYdezNFhdmLw1g59jY4DR3c/zIIzPC
         Qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvdPlfimj6OGtq993uBEH4HDXjgpDehuAkgs24MT6mk=;
        b=Cm9aD5uMrt9g9stSlQ/05569QbSDEc0pTWlAh0fdHMsVL9HyNgD/MY4SD7fMEoRVeF
         +THMyzH5wRSkN36O/Rmy1wPOZZGqyw0KJ2iyrDa0v30NxbHoiL7KDSaQ+vF0+NNM5X4w
         fXzmkyopKOrA3OpOwSS3UTxgW9ntnlH8JaOF/xyiUx2Jj85w4GEcCyBgFIYvIUXbE5W0
         ApNQgz8/qPi3fohanDHu6eu+BYbaMYCBlR978paY/ZqRKSSLpRSFhmkCQYqF558y4OHU
         HthnQyJqe/v0yhVKkEIIkvk3TBhSPB6A0rjjuKbwfxC1lEjqPletHqwmdWa0LLG4dZTB
         /Hsg==
X-Gm-Message-State: APjAAAUR484jmtAx6L0ynQ13O/pLNpvmA2j2UPBl2BoEqWP9mw0d4dW2
        evs4KcorO1tgcztZIaZ4Uc/U6cASaOQ=
X-Google-Smtp-Source: APXvYqy7s4sbdhuS0pHTU7euxKWmXyOMby7qOb/d/6Sm92wXWIHdT+zGtXXtLAaJP0x1yenu4+qzPw==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr415254wmi.31.1576641677626;
        Tue, 17 Dec 2019 20:01:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r15sm976023wmh.21.2019.12.17.20.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:01:17 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH-tty-testing] tty/serial/8250: Add has_sysrq to plat_serial8250_port
Date:   Wed, 18 Dec 2019 04:01:11 +0000
Message-Id: <20191218040111.346846-1-dima@arista.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrast to 8250/8250_of, legacy_serial on powerpc does fill
(struct plat_serial8250_port). The reason is likely that it's done on
device_initcall(), not on probe. So, 8250_core is not yet probed.

Propagate value from platform_device on 8250 probe - in case powepc
legacy driver it's initialized on initcall, in case 8250_of it will be
initialized later on of_platform_serial_setup().

Fixes: ea2683bf546c ("tty/serial: Migrate 8250_fsl to use has_sysrq").
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 It's probably better to squash this into the 8250_fsl patch.
 I've added Fixes tag in case the branch won't be rebased.
 Tested powerpc build manually with ppc64 cross-compiler.

 drivers/tty/serial/8250/8250_core.c | 1 +
 include/linux/serial_8250.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e682390ce0de..0894a22fd702 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -816,6 +816,7 @@ static int serial8250_probe(struct platform_device *dev)
 		uart.port.flags		= p->flags;
 		uart.port.mapbase	= p->mapbase;
 		uart.port.hub6		= p->hub6;
+		uart.port.has_sysrq	= p->has_sysrq;
 		uart.port.private_data	= p->private_data;
 		uart.port.type		= p->type;
 		uart.port.serial_in	= p->serial_in;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index bb2bc99388ca..6a8e8c48c882 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -25,6 +25,7 @@ struct plat_serial8250_port {
 	unsigned char	regshift;	/* register shift */
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
+	unsigned char	has_sysrq;	/* supports magic SysRq */
 	upf_t		flags;		/* UPF_* flags */
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	unsigned int	(*serial_in)(struct uart_port *, int);
-- 
2.24.1

