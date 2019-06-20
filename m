Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B18BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEA921530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053643;
	bh=nchVeo9fWOEdnEhL4Ng1VYALYo3aQz5cZl/1ewDa29A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WWRTy8htlvn7/IX+MDTbEP7EgBc4qeavpyZE4zx+lppSKZelr3o8lmD93EUa1t0T1
	 DEmfuxFHti6z5fFSq6DtLR8MHmYufbxREm0ebC94VvGwcJAa3Vo1WNHxkIKTY0YFxF
	 WVNwetYvujpHJWoytWTsmriRG2rJgnSaeZtvc8+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFTSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfFTSAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:00:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7186B21530;
        Thu, 20 Jun 2019 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053638;
        bh=nchVeo9fWOEdnEhL4Ng1VYALYo3aQz5cZl/1ewDa29A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMgc5X7azQ88F5b+HOMTy+CsF7Ia5ySnGCow3JaW4Qf2tOowIbPYSOqm2LJASPwCT
         EmGlDpXP9HpIC5+vNaKfOSKbkC5TQOQP6hc0G0aQDDkG4Y+U/hjgVwutd03pfaEp65
         QHUyPUzOvb/0J7QIycqko9AsttNtHEG4n2SWCJoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.4 59/84] USB: usb-storage: Add new ID to ums-realtek
Date:   Thu, 20 Jun 2019 19:56:56 +0200
Message-Id: <20190620174347.808371760@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 1a6dd3fea131276a4fc44ae77b0f471b0b473577 upstream.

There is one more Realtek card reader requires ums-realtek to work
correctly.

Add the device ID to support it.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_realtek.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -28,6 +28,11 @@ UNUSUAL_DEV(0x0bda, 0x0138, 0x0000, 0x99
 		"USB Card Reader",
 		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
 
+UNUSUAL_DEV(0x0bda, 0x0153, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
 UNUSUAL_DEV(0x0bda, 0x0158, 0x0000, 0x9999,
 		"Realtek",
 		"USB Card Reader",


