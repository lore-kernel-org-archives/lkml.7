Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA399C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8982C2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="J3+DENYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCTP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:27:18 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:37344 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfCTP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:27:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 44B883F5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CW_LLI9y23XJ for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 10:27:15 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id E3FE7BE7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:27:15 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id s3so2491860itl.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gRegdW0Vp32TTwcRwpYr4FmCrFCirUJNOAYEJ5vzjtw=;
        b=J3+DENYuvYqwCOu+pPdJN+D2rPCmz2ActBpNZtlQS0s1N3ufbgHzTJa+pF/kc2mb89
         0gCJMAW5LPC3I+KBSHvHSJGBFwCFwX+iptQ7650iMKljz8C1w5BwNuqdXwElp2LwLtZc
         zQh+5ANjwtAU3fFw1wtmuPtxuJY6AdHLKIbLdL0EFvH5v4FpMRvIv5tcroZkHZUJR0LY
         Fxpbh7UJy+hGNHeq+QdXzXx5fXljJYnVTv6STeZQ+oQYXO+p2bzTZpY9/bI3Zaz2hCXa
         99Pcdz7gOYMFCg7H8lpzfcFTV/49bpdcX7RtgBBCzXfHVy9KOy+Dj2pDfzn4sVDOqtGf
         aB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gRegdW0Vp32TTwcRwpYr4FmCrFCirUJNOAYEJ5vzjtw=;
        b=OPI6qbWT9rZDkvyPqD836vK2K0PvyTOfxQ8W3/wjAFD71yLr87XgH7UV/d5mEuGtj+
         RGLfG/j1XZlTXRn1NMcS3fXh9FLjh/0zwKaulQnpz6cKHuYSwTlhO8b6B24pjokD2pMs
         tfRC3XobhRwQxM8KilS3sQXBX2u/tRm7citzuiS4Ezy7RBmCEg6CoJds1l+4kkzXwqyf
         i6F7nEGClJEvxMhqvofoHsqhfrMORtoaaUx8zwmfk3go+xd+jLIUEaoW8ukvsfnz9ECs
         AUULoS4J6Jigr17ZUBTSqX6+KxCTGxOvwDshmq/I05W3ni7U3uwxiFUYI57LwMNElNgm
         BZDg==
X-Gm-Message-State: APjAAAXIOz4CH1wo8piJpoknuZgDc9RCX3Bywjrj4QdAjsHpe7Fnxv3L
        xaB7L9Gvgd9gjGg7L68eUOkaaGuYbPXJO7V9uGn7BWoQGwRXIMM91PUyswsGrZ30o1G/SWMi/AO
        ZnkvNEYIo3vyYUQ7cmLjP/sW3tEtf
X-Received: by 2002:a02:b510:: with SMTP id l16mr5491649jaj.13.1553095635464;
        Wed, 20 Mar 2019 08:27:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBV7QdKKUjEZ1/gxxhpw0SlCp9GmDwccNurPAzXuaqQ17sJ/z1lFlUDEvyrThV2c7t9oCfTw==
X-Received: by 2002:a02:b510:: with SMTP id l16mr5491615jaj.13.1553095635019;
        Wed, 20 Mar 2019 08:27:15 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l62sm1195945ita.12.2019.03.20.08.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 08:27:14 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: usb251xb: fix to avoid potential NULL pointer dereference
Date:   Wed, 20 Mar 2019 10:27:11 -0500
Message-Id: <20190320152711.28749-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device in usb251xb_probe can fail and returns a NULL pointer.
The patch avoids a potential NULL pointer dereference in this scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Richard Leitner <richard.leitner@skidata.com>

---
v2: Fix version changes below sign off
v1: avoid return in case of error, per Richard's suggestion.
---
 drivers/usb/misc/usb251xb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 4d72b7d1d383..bbfdb7447d6f 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -612,7 +612,7 @@ static int usb251xb_probe(struct usb251xb *hub)
 							   dev);
 	int err;
 
-	if (np) {
+	if (np && of_id) {
 		err = usb251xb_get_ofdata(hub,
 					  (struct usb251xb_data *)of_id->data);
 		if (err) {
-- 
2.17.1

