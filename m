Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE931C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AFA2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139845;
	bh=yQb2NK5lzLzpbsQdb7FnXLvG2WS+4nHq8EhJ1bLLPWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIcXZJcJESsbckGEdMKwJzvHojG10tLhGcIGJGRbD51NPfgLUwx08yalNFXITLrsV
	 zER5jBrYnG7jjFlUD/Q69zUAveVlVVlTW0Et4x0aXTLkIgKI/yIZeX0sKwno6h9aPt
	 8u0RPff7fqTC3q4r7lCvFUiPcGS1Hvwg4HjbRn5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfDARao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733130AbfDARaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFADE20856;
        Mon,  1 Apr 2019 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139839;
        bh=yQb2NK5lzLzpbsQdb7FnXLvG2WS+4nHq8EhJ1bLLPWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJPe64sdes8Nt92wjMpcY3BdzEyhNPgi2JenejlefAKHV6kOMPM3+uU0ihyjHNWyM
         /4XuSDOa1wGm/uh3E8dspwW8YhE74rAK0jq397sy+QSZUDkeZOr+w7qDx+Wmj9JTs+
         /p5wVkSW+YOZCnAjpN6lmZO3MiCQek1EM7ToJwM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Qiao <wei.qiao@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 029/131] serial: sprd: adjust TIMEOUT to a big value
Date:   Mon,  1 Apr 2019 19:01:39 +0200
Message-Id: <20190401170054.525814625@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Qiao <wei.qiao@spreadtrum.com>

commit e1dc9b08051a2c2e694edf48d1e704f07c7c143c upstream.

SPRD_TIMEOUT was 256, which is too small to wait until the status
switched to workable in a while loop, so that the earlycon could
not work correctly.

Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sprd_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -36,7 +36,7 @@
 #define SPRD_FIFO_SIZE		128
 #define SPRD_DEF_RATE		26000000
 #define SPRD_BAUD_IO_LIMIT	3000000
-#define SPRD_TIMEOUT		256
+#define SPRD_TIMEOUT		256000
 
 /* the offset of serial registers and BITs for them */
 /* data registers */


