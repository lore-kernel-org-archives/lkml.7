Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1096F21874
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="f39Zqjgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfCOBAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 21:00:10 -0400
Received: from mail.nic.cz ([217.31.204.67]:46480 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfCOA76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:59:58 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id A9A4C63483;
        Fri, 15 Mar 2019 01:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1552611593; bh=kaKbvPrh06oT00xDZyUk9wq+ZqUPUkEk6HDMmKKZYqo=;
        h=From:To:Date;
        b=f39Zqjgm/jTR9MMMM0UtB4cb90of/5IoKndMflk3cV2oCVuIopSJme08kdHtaTwOH
         OlgSqp9YrDhMaIgzAzC1vu3uqvB5HRIenHZAreHRWRpMOPT7ahgRft3NlzkK5RO/dP
         JBscdB031GHfq7DulAz/p6EaZk3BuwHKLhl4L86I=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v3 mailbox+firmware 5/6] firmware: turris-mox-rwtm: Add sysfs documentation
Date:   Fri, 15 Mar 2019 01:59:25 +0100
Message-Id: <20190315005926.5994-6-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190315005926.5994-1-marek.behun@nic.cz>
References: <20190315005926.5994-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs ABI documentation for the sysfs files created by the
turris-mox-rwtm driver.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 .../testing/sysfs-firmware-turris-mox-rwtm    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm

diff --git a/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm b/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
new file mode 100644
index 000000000000..ff6cd30f0cf2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
@@ -0,0 +1,60 @@
+What:		/sys/firmware/turris-mox-rwtm/board_version
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Board version burned into eFuses of this Turris Mox board.
+		Format: %i
+
+What:		/sys/firmware/turris-mox-rwtm/do_sign
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(RW) Gate for writing requests for signature with the ECDSA
+		private key burned into eFuses during the manufacturing process,
+		and also for reading the resulting signature.
+
+		When requesting for signature, a SHA-512 hash of the message to
+		be signed should be written in binary form to this file. This
+		means that a write() operation into this file shall write
+		exactly 64 bytes, buffers of other size are ignored.
+
+		When the signature is done or the rWTM firmware responded with
+		an error, this file is notified via poll, and the result can
+		then be read. On error, the read() operation fails with errno
+		corresponding with the error. On success, 136 bytes are copied
+		to the buffer - 68 bytes for the R value and 68 for the S value
+		of the ECDSA signature, in binary form. These are 2 arrays of 17
+		32-bit words, in big-endian form, most significat word first.
+
+		Format: binary
+
+What:		/sys/firmware/turris-mox-rwtm/mac_address*
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) MAC addresses burned into eFuses of this Turris Mox board.
+		Format: %pM
+
+What:		/sys/firmware/turris-mox-rwtm/pubkey
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) ECDSA public key (in pubkey hex compressed form) computed
+		as pair to the ECDSA private key burned into eFuses of this
+		Turris Mox Board.
+		Format: string
+
+What:		/sys/firmware/turris-mox-rwtm/ram_size
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) RAM size in MiB of this Turris Mox board as was detected
+		during manufacturing and burned into eFuses. Can be 512 or 1024.
+		Format: %i
+
+What:		/sys/firmware/turris-mox-rwtm/serial_number
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Serial number burned into eFuses of this Turris Mox device.
+		Format: %016X
-- 
2.19.2

