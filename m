Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9987E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053722;
	bh=qcaCHRrJutC7PBtw8DrRMnauqZWyAhYooM+x7R3QrsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wAizcwt0YXmMvz4UQnM4363AdKOz1QTuQ3PvCy/lirQAO2PILer9HAu6tGBRaE44x
	 fRWGZtbsq9Cp5FpPi9CULFYjb80n/RXmdOizbu1COlwCj6cR0KIaLGRsp/6PcAr4p5
	 AdRziJE3/iisy3hzoFKdR33OPjFKxlpTtNwhb3aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFTSCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfFTSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:01:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DD221479;
        Thu, 20 Jun 2019 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053717;
        bh=qcaCHRrJutC7PBtw8DrRMnauqZWyAhYooM+x7R3QrsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WltWGjEDTvIYKjBoJsWgxe9vWctbXbybLrNqroCgFYJF1LAvXnIcvprYhgf3l+acY
         RmEiDYexiESiaZSfwf2VNXcaRDxLcaC3kZ7mNvn8SKgiMW6tg0ofgBeVxJT8usCNiq
         S50PQXSaC+WrhsVqU35xcCi/vbBHJvjOHxN6/kiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 68/84] sunhv: Fix device naming inconsistency between sunhv_console and sunhv_reg
Date:   Thu, 20 Jun 2019 19:57:05 +0200
Message-Id: <20190620174348.465053200@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[ Upstream commit 07a6d63eb1b54b5fb38092780fe618dfe1d96e23 ]

In d5a2aa24, the name in struct console sunhv_console was changed from "ttyS"
to "ttyHV" while the name in struct uart_ops sunhv_pops remained unchanged.

This results in the hypervisor console device to be listed as "ttyHV0" under
/proc/consoles while the device node is still named "ttyS0":

root@osaka:~# cat /proc/consoles
ttyHV0               -W- (EC p  )    4:64
tty0                 -WU (E     )    4:1
root@osaka:~# readlink /sys/dev/char/4:64
../../devices/root/f02836f0/f0285690/tty/ttyS0
root@osaka:~#

This means that any userland code which tries to determine the name of the
device file of the hypervisor console device can not rely on the information
provided by /proc/consoles. In particular, booting current versions of debian-
installer inside a SPARC LDOM will fail with the installer unable to determine
the console device.

After renaming the device in struct uart_ops sunhv_pops to "ttyHV" as well,
the inconsistency is fixed and it is possible again to determine the name
of the device file of the hypervisor console device by reading the contents
of /proc/console:

root@osaka:~# cat /proc/consoles
ttyHV0               -W- (EC p  )    4:64
tty0                 -WU (E     )    4:1
root@osaka:~# readlink /sys/dev/char/4:64
../../devices/root/f02836f0/f0285690/tty/ttyHV0
root@osaka:~#

With this change, debian-installer works correctly when installing inside
a SPARC LDOM.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sunhv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -392,7 +392,7 @@ static struct uart_ops sunhv_pops = {
 static struct uart_driver sunhv_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "sunhv",
-	.dev_name		= "ttyS",
+	.dev_name		= "ttyHV",
 	.major			= TTY_MAJOR,
 };
 


