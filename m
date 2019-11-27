Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E439C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1522084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888112;
	bh=S8kGG9p6HSMDgtKASDhnwxvtfT614CVOtoxaHvrPciw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJzmoH1m26ZOSSZU97zgufZphTDHrWCSg7B0llIGFQsEFPNUlJTA+a7MAHPnyANcr
	 1iGEbx3Gql4zcYM/6qYv31s1qq8yzvPGJpdyWAKNaiWJca7Hkgta25NJQEHVYIJjrA
	 966kGDOESesIRawJiLySTX3dmS28jUn8zjCLYqPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfK0UzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbfK0Uy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:54:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487252086A;
        Wed, 27 Nov 2019 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888097;
        bh=S8kGG9p6HSMDgtKASDhnwxvtfT614CVOtoxaHvrPciw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkYrcrnHsfLSxTUStDtQ4kKnHyFr3tYMDTAczJ1cKbGTN/tCgZo0dKVqbY1y5ND5B
         W/NRjtez5kzrOHp1Z2E9PsIAXJV0laiDhsKY7GEK33IBnmCt4iJJf3GDAW1G/NQOy+
         hv0gexPfjXlvkZG+jej5WQCi0bBpz0jI9A9XJk2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+711468aa5c3a1eabf863@syzkaller.appspotmail.com
Subject: [PATCH 4.14 186/211] nfc: port100: handle command failure cleanly
Date:   Wed, 27 Nov 2019 21:31:59 +0100
Message-Id: <20191127203111.303012805@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 5f9f0b11f0816b35867f2cf71e54d95f53f03902 upstream.

If starting the transfer of a command suceeds but the transfer for the reply
fails, it is not enough to initiate killing the transfer for the
command may still be running. You need to wait for the killing to finish
before you can reuse URB and buffer.

Reported-and-tested-by: syzbot+711468aa5c3a1eabf863@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nfc/port100.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -792,7 +792,7 @@ static int port100_send_frame_async(stru
 
 	rc = port100_submit_urb_for_ack(dev, GFP_KERNEL);
 	if (rc)
-		usb_unlink_urb(dev->out_urb);
+		usb_kill_urb(dev->out_urb);
 
 exit:
 	mutex_unlock(&dev->out_urb_lock);


