Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090082133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFAiskDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfB1XMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:23 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:48103 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbfB1XMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:15 -0500
Received: by mail-io1-f74.google.com with SMTP id p12so16956333iod.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aUJ3gj1BGh2zGHelWKN3pyJi6By6RKX30KpBOEKPul4=;
        b=uFAiskDh5YOvPl+wLevkVOmLyB0rP5MpnZCwM5Cdq4JbKPDNdETsQoQQhPf44rumnx
         yNlTriZ8CWScxgbvk4IB7DqScGbaOvpuB9L1cBnyzWQskOvnTuuoraiinQfXTSMTy1xK
         jixUYPfxULbl+s9sUtiE/4Xb+9e4TYMC1uE+yIxfeGXyY2f8NT/vgORFnrnfLeqOoU9s
         91bvSj38oHYjHIb8foGtyfqIIOJ/JiBNjAs/+iMgoo9ibZ/94HCKueJVY6hP9gqd+cR/
         8snLOK7GWDKJDb8dpA+mbKRkvOp3sxs434DJE+P7LAeUT9q3NVcvaOMgXaImVFNhK0ex
         OAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aUJ3gj1BGh2zGHelWKN3pyJi6By6RKX30KpBOEKPul4=;
        b=a3lUvIb2m7ktdGqQp7Ugz6Onzox57nZtj94mpSBbieY4W0QBcipuNtMCs0yhTYNCO4
         NsmhmpnE194O6Tsp+MKsVmvOqAWLI0PtUfMCiyy7U4oy6/9LQtkRnrfpy+lUBShPjJO7
         jKhTUQlRluteIHnf1m1z+tn4C8sTA/5KntYmqOEKnMrkdDnHcTuKG6m3QA3WtQUX9pFc
         skVjcqOdQL284ZT/zlO2E2QKhXFHa1nwr7nTE83nPOvBO+VvtrKJDbZzTNEtM5g92Hfh
         bGO4PLVYx7u8uqwJfNN+FTe6lJ7Wsk4sORR93PAdxKJg9HxUB7P1u9agc9D8w6woS8nN
         EvQg==
X-Gm-Message-State: AHQUAuYMVTl8aW00SO8+7B1i/+XN35DQrbEOeFN2E+xdhXFw3dpiHlUv
        fpAV9bYGbvpfaVJyRVHwd0odDY6V4YW2ehJ9iIS5nw==
X-Google-Smtp-Source: AHgI3IZPFemQA10IWAIM85WA3Wk2ejfMHY2C8xWBh3ONcvIJaQsycaliSv/+gptRE7B0MQeSX9bkI0OqVPh1zwISRO0EzQ==
X-Received: by 2002:a24:78cb:: with SMTP id p194mr1458351itc.7.1551395534361;
 Thu, 28 Feb 2019 15:12:14 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:40 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 04/27] Restrict /dev/{mem,kmem,port} when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..0a2f2e75d5f4 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port"))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-- 
2.21.0.352.gf09ad66450-goog

