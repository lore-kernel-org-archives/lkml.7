Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01108C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75ED208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ViEkGJ48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfHJImw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:42:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53501 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfHJImv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:51 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvN2HhjzDq;
        Sat, 10 Aug 2019 10:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426480; bh=e9HoIno2Ud8Ms+1jHlklnu2iR2HfeMr8Q+Yz4Y7K1kM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ViEkGJ482Yw0Dx8ReA6sAcOxN52Kza1DGpdfAgdNdARVhRE0pxdTBqoZbyh/kPnHO
         VF6CRYyJ9vqY9cciElWbv517N1cJ9WRxetPAwg3qe4bS04hAVZLajOOHeKfP2kZDe1
         +C8KpofGgMKVqlzP4Hmo5Re/b2ZNXJ8yzrT2RpKydL7KmsVy7fB/cs3W+FakrdMN91
         s+h510653B+F1qaChrlytnZCliUb/DCLrb5jThvSsZXYsMhi5tbp/dFsNW1MkI1tIr
         OW8HjHLKflhvu0uZCW/kHC/nLUaGgkmFTfgrYtMv5mtllKX7nw6A3G+WbFuuOtmTnE
         1iSR0NDNRe6cA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:48 +0200
Message-Id: <4f3ba23fd4e8963cf5651290a34be894aeedb570.1565426370.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
References: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 1/7] usb: gadget: u_serial: add missing port entry locking
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gserial_alloc_line() misses locking (for a release barrier) while
resetting port entry on TTY allocation failure. Fix this.

Cc: stable@vger.kernel.org
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Ladislav Michl <ladis@linux-mips.org>

---
  v6: rebased on balbi/testing/next
  v5: no changes
  v4: no changes
  v3: cc-stable
  v2: no changes

---
 drivers/usb/gadget/function/u_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 65f634ec7fc2..bb1e2e1d0076 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1239,8 +1239,10 @@ int gserial_alloc_line(unsigned char *line_num)
 				__func__, port_num, PTR_ERR(tty_dev));
 
 		ret = PTR_ERR(tty_dev);
+		mutex_lock(&ports[port_num].lock);
 		port = ports[port_num].port;
 		ports[port_num].port = NULL;
+		mutex_unlock(&ports[port_num].lock);
 		gserial_free_port(port);
 		goto err;
 	}
-- 
2.20.1

