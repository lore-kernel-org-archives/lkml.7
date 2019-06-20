Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9BDC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB44206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055035;
	bh=GdAVIKAYlmrnV5ik0UioPxBb+s+7a4Cqaxt58ExCFrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tL1GmHPp3MX3IPK8hhMemcR7f99K95ol8Qp4rahmVvTARtbOd2hi6WPdqCE0b/y5X
	 AA8ik+cyypl10IP4wekzsfFKw5QDokrBQ1dq/wnnPXpYuWB7k8A/vTMXCMp+GI4BNs
	 s5/n6Pyppctt1YZ0eP22yjSjKydg04aLvCrzo5pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfFTSXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbfFTSIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:08:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C4E2082C;
        Thu, 20 Jun 2019 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054129;
        bh=GdAVIKAYlmrnV5ik0UioPxBb+s+7a4Cqaxt58ExCFrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUMOkmgwL1lRF5H5mPdtJ5xUK+bImZeDQsmPyDqzhJiSlwjaq8qAzHFqLolD+FBnu
         gcxmcba8AefXfUOZxnEqo3aSPQinT28ToiOxY3hcGndjS7fxjNYpPsGRiP5WNo60Jw
         fNDFi7tomWyNr0s2S/+MsxCuix/tcKHU+CmiLzLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/45] sunhv: Fix device naming inconsistency between sunhv_console and sunhv_reg
Date:   Thu, 20 Jun 2019 19:57:11 +0200
Message-Id: <20190620174333.195180327@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174328.608036501@linuxfoundation.org>
References: <20190620174328.608036501@linuxfoundation.org>
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
@@ -396,7 +396,7 @@ static const struct uart_ops sunhv_pops
 static struct uart_driver sunhv_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "sunhv",
-	.dev_name		= "ttyS",
+	.dev_name		= "ttyHV",
 	.major			= TTY_MAJOR,
 };
 


