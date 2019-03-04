Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EAC20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCDUHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:07:30 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:07:29 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M4384-1h0trt2NiC-0007i2; Mon, 04 Mar 2019 21:07:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: fix wilco-ec dependencies
Date:   Mon,  4 Mar 2019 21:06:51 +0100
Message-Id: <20190304200719.1382717-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/v3yO6TDk5tSSmrr8Ji4PHRmHqwKTNQ/vI50XsyjOHrBvdh6gIr
 9+e+YQf3vylviPbDCfq0RyXNlgESMuVKYzb+r6s3Pp6dYg/dIqAN/QO4l6419+OCMtoX3Gx
 2hrIm00ncWASPYMZJgqpHzkKqZlw9KBgoK1eydhaz3HwxgxZUaCKbAECFo6pEGzgUhh5cFz
 Woq0rXDUiWYPsu9+vc36g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KBqFG4Xa3S4=:ZKL2GIl6XwJMIHaPRqv4Dc
 g1Rhkbu6a2Y2V9N7qHAfxu+UCzn97MEBQPZb8JyFRl6NojM1LEi9Vvdv+5Oo1OvV3LJP7+jlI
 N1WlJXbGzaQjcC1VYxqeHsbrEX8UgUrnYKXd0Cof806m6O80H37tk/0k2OyjPefuQn1kyrTit
 py5xIhsvwzWlefvL56ZxyRvEOAKzOpWCxHjUD4YlcM5W/t9F61l7Fd7u+JPkpVlqPuTldnjML
 w2AmLqKeNr0xbiyQHeVGtOal2QI2nyV0AQhYzPFnu+QhuofQweMYk4cLPEGi4gBjrxV9DD8y4
 EXEITP5Sz1lDwo5JUt7T5POAI6yXxP9OOjWm1Xpa80luQuvo+eHrWcUodDVUNdvM2dDDabM3q
 IkrSnNpwC/B/U0BmplxNxfH+YOK0+YXMLtyIZCDO6PwkHu5b4JjZAlu+qU/bWz7OFBoA1bNDW
 PIBKxLHOKds6iLnuynsKUQfwt/rYzGiLPw/W4XjgZbPTQ0gJNTFteteUIUY/ZBRgOq+Nd5/xI
 srVDcd1cvrCJwfA0fK2mWTa+R39ZoFpw7wyNW3AT1hJtowJkbGk05V7BKCM3uXZwp34YpPpDJ
 zzSlEv6LKrechgmVYnEAK+meODBA0aC/7dpPZePvCRrzOLlxowDfj8tXyyytEsLd7fV8PsUtE
 ynI+NeApVQJ6Aya8VM1Et3U05UboyJ6e5puOAdjz2kV28b/HVdEt3ys4jP3GolBXAmIWtHDhV
 TqjoMVyM58SV5AfN9wnSxUJcMykcwGrZ855/eA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CROS_EC_LPC is set to =m, we get a link failure for a
builtin wilco-ec module:

drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_remove':
core.c:(.text+0x26): undefined reference to `cros_ec_lpc_mec_destroy'
drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_probe':
core.c:(.text+0x18c): undefined reference to `cros_ec_lpc_mec_init'
core.c:(.text+0x224): undefined reference to `cros_ec_lpc_mec_destroy'
drivers/platform/chrome/wilco_ec/mailbox.o: In function `wilco_ec_mailbox':
mailbox.c:(.text+0x104): undefined reference to `cros_ec_lpc_io_bytes_mec'

The problem with the existing CROS_EC_LPC_MEC dependency is that this
is only for a 'bool' symbol, so the information about the exported
functions being in a module is lost on the way, and we actually have
to depend on both CROS_EC_LPC and CROS_EC_LPC_MEC.

Fixes: 7b3d4f44abf0 ("platform/chrome: Add new driver for Wilco EC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/chrome/wilco_ec/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index 4a119ced4d0c..e09e4cebe9b4 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -1,6 +1,6 @@
 config WILCO_EC
 	tristate "ChromeOS Wilco Embedded Controller"
-	depends on ACPI && X86 && CROS_EC_LPC_MEC
+	depends on ACPI && X86 && CROS_EC_LPC && CROS_EC_LPC_MEC
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
 	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
-- 
2.20.0

