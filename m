Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4CAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB9E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370272;
	bh=ZDcPbPhpv7QesIOP6V8A3EIB5GehUV5YQtLVz9w1g38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IrwBYy7N4J1TeQfUYChJsvMT6Anaq/MXTc5zOJ48tTGhB7m2B/DXWqcldFulyLtAd
	 dNEoLB2/OckBAbWbyZpmuHQ8eY2HFbJLkbxT9HQN+JGtXzkhKvVbYxjsbO+CpAYrtd
	 kNxQmxN5POdG253aRNpR+JfEkXa6ByMRYhUlIidQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfFXJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfFXJ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:57:47 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54949208CA;
        Mon, 24 Jun 2019 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370266;
        bh=ZDcPbPhpv7QesIOP6V8A3EIB5GehUV5YQtLVz9w1g38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JCLZg8JnTuLcW6rO0GvILwvAfmzaXROraATpwkXrRH+ZO+D4NDvpOhpNpZ975Xim
         CJE6u6AoLTxfb67DS2IEN0ll9RzhQLNzZHJEdj1CXunis8gnScEDe7m0MlKm7AmXFq
         2pNq30Cbst3UsviCAjEPrxOuseCSc9ZpVvDg8QdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 10/51] Input: uinput - add compat ioctl number translation for UI_*_FF_UPLOAD
Date:   Mon, 24 Jun 2019 17:56:28 +0800
Message-Id: <20190624092307.611971368@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

commit 7c7da40da1640ce6814dab1e8031b44e19e5a3f6 upstream.

In the case of compat syscall ioctl numbers for UI_BEGIN_FF_UPLOAD and
UI_END_FF_UPLOAD need to be adjusted before being passed on
uinput_ioctl_handler() since code built with -m32 will be passing
slightly different values. Extend the code already covering
UI_SET_PHYS to cover UI_BEGIN_FF_UPLOAD and UI_END_FF_UPLOAD as well.

Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/uinput.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -1012,13 +1012,31 @@ static long uinput_ioctl(struct file *fi
 
 #ifdef CONFIG_COMPAT
 
-#define UI_SET_PHYS_COMPAT	_IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
+/*
+ * These IOCTLs change their size and thus their numbers between
+ * 32 and 64 bits.
+ */
+#define UI_SET_PHYS_COMPAT		\
+	_IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
+#define UI_BEGIN_FF_UPLOAD_COMPAT	\
+	_IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload_compat)
+#define UI_END_FF_UPLOAD_COMPAT		\
+	_IOW(UINPUT_IOCTL_BASE, 201, struct uinput_ff_upload_compat)
 
 static long uinput_compat_ioctl(struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
-	if (cmd == UI_SET_PHYS_COMPAT)
+	switch (cmd) {
+	case UI_SET_PHYS_COMPAT:
 		cmd = UI_SET_PHYS;
+		break;
+	case UI_BEGIN_FF_UPLOAD_COMPAT:
+		cmd = UI_BEGIN_FF_UPLOAD;
+		break;
+	case UI_END_FF_UPLOAD_COMPAT:
+		cmd = UI_END_FF_UPLOAD;
+		break;
+	}
 
 	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
 }


