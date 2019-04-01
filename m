Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92836C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6125820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141239;
	bh=cTS973a1KXUR3V5y/S8QiWh8jv8P59jnKtazDowFzsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1vV9iHB7W3yYYM/P25C5A8yVbSnodeNZ4HZV36M54Vx4jLWQwnYC9ZfZawGY0krt
	 TPfXN4Rq1OCKrgJoqfC+oug8avKOYP19JwmNd82BsRO+koQsxPws4hdqomlD9qMUZc
	 YWjN5BN4NO599RYr7JTGrfZ5Ow2NSC6tr1z1xhwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfDARx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732348AbfDARY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7782063F;
        Mon,  1 Apr 2019 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139497;
        bh=cTS973a1KXUR3V5y/S8QiWh8jv8P59jnKtazDowFzsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQ3IoVgXmhd4nIpfgH6Ed/OVOPT+Vq9VWqXeV9pdRV81leQhP6gv/zoLOnG/P1wez
         2rjRs9m78sX6k7gCeDi6qfzgdRkqfvVwDSoCfaJlDFMqEaUXp0laSl9fOTNkIS/W6r
         T543UpAqCxcKKQO0Mj9w3Ll0lL9oWYXHgYNY0t4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 094/107] usb: mtu3: fix EXTCON dependency
Date:   Mon,  1 Apr 2019 19:02:49 +0200
Message-Id: <20190401170054.224139943@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3d54d10c6afed34fd45b852bf76f55e8da31d8ef upstream.

When EXTCON is a loadable module, mtu3 fails to link as built-in:

drivers/usb/mtu3/mtu3_plat.o: In function `mtu3_probe':
mtu3_plat.c:(.text+0x690): undefined reference to `extcon_get_edev_by_phandle'

Add a Kconfig dependency to force mtu3 also to be a loadable module
if extconn is, but still allow it to be built without extcon.

Fixes: d0ed062a8b75 ("usb: mtu3: dual-role mode support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mtu3/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -4,6 +4,7 @@ config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
 	depends on EXTCON && (USB || USB_GADGET) && HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system runs on MediaTek SoCs with


