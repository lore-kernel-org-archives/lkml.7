Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5737BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F33E2184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7b6LevE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCQB7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 21:59:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35461 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCQB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 21:59:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so7340018wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 18:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=Be1rTlt4UvADE2KOl3f3HbV4x273YQFAII+1rDxKx0I=;
        b=N7b6LevEfOdP3RL7xTctfWcq+aqJqzF+sLl9tS0BM9txmaP36xiise5Xk25R9e2AkO
         VmcDdCVuvNuYMDOulWLL0AfrIb1OiJzNzp7x+aaKm780OSka7IJMAnP/FXbHAkSaVzvO
         WepYiByj3Hs9WYWCy/Z0FUWoNHjPtRArmLPdlxJ/fpo4ombqXfl5p7k5AeCRWVjkZydG
         oCs+xqG0kiaDev9rGveByAvJJyxlCVKJCs2S3jGx20VLOb1ZPYlldqOut2c+Pqdyq+xQ
         weN+QbwYo+JW33DztawaETHnF9F6iqz04fJvjB7EbYaRhApsf2EzSYT/PTQ+0kyyNp2G
         fo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=Be1rTlt4UvADE2KOl3f3HbV4x273YQFAII+1rDxKx0I=;
        b=sFBI1acPm2aRwgvXqLpXgNfWhIVoSmWTGgvUUkkMQ/QX9AD2GcRrVUD4jZDfCOIqjL
         2OggKZnE5lLCFabYVMUxPPj5cf+2gHeaTA985dnrdjgc1s0dSR31fDqAAi3oJgLLt7AZ
         nz096M26OJKwpX7/D3Me+ynJnqdUmfVhLlA5exiljXVKORF/EywTmQKWNeq8fQ659VgF
         DuQcbSbESHrok5TSctY+eyvwmIU4aQGzN/SNrjgZ4RiGJqYNxjVYqew1BUV6dUvEkZ2n
         E5kiIV5Ii6ByPtZLfe7w2UA9iceXT0XMyZj8aIIsFYlauRfbrRpiGTYUWTxQTZqQOwQ4
         Gcfw==
X-Gm-Message-State: APjAAAUPSFn7gELGiQM8NqS5Zzt6zk1tQ6cT9QOpMJo920un9YRCuEK9
        pxE8IMgIlK770BYNgiaZLDM=
X-Google-Smtp-Source: APXvYqznQkc4HLVbA3ImIXN8/sjst4PjnPl7c4RHWDqULSFWoO2N4obTlly9lSfM7fWgL3pCXgO90Q==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr7157833wrs.238.1552787947780;
        Sat, 16 Mar 2019 18:59:07 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98705F80045694D516271D164.dip0.t-ipconnect.de. [2003:c9:8705:f800:4569:4d51:6271:d164])
        by smtp.gmail.com with ESMTPSA id y8sm5451525wrm.8.2019.03.16.18.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 18:59:07 -0700 (PDT)
Date:   Sun, 17 Mar 2019 02:59:05 +0100
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 1/2] staging: vc04_services: Add spaces around Operators
Message-ID: <20190317015902.GA1553@p200300EEEE2F.fritz.box>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Check from the checkpatch.pl Script
`CHECK: spaces preferred around that`
in vchi.h

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 0b6fc0d31f4c..7b13cb04c119 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -41,14 +41,14 @@
  Global defs
  *****************************************************************************/
 
-#define VCHI_BULK_ROUND_UP(x)     ((((unsigned long)(x))+VCHI_BULK_ALIGN-1) & ~(VCHI_BULK_ALIGN-1))
-#define VCHI_BULK_ROUND_DOWN(x)   (((unsigned long)(x)) & ~(VCHI_BULK_ALIGN-1))
-#define VCHI_BULK_ALIGN_NBYTES(x) (VCHI_BULK_ALIGNED(x) ? 0 : (VCHI_BULK_ALIGN - ((unsigned long)(x) & (VCHI_BULK_ALIGN-1))))
+#define VCHI_BULK_ROUND_UP(x)     ((((unsigned long)(x)) + VCHI_BULK_ALIGN - 1) & ~(VCHI_BULK_ALIGN - 1))
+#define VCHI_BULK_ROUND_DOWN(x)   (((unsigned long)(x)) & ~(VCHI_BULK_ALIGN - 1))
+#define VCHI_BULK_ALIGN_NBYTES(x) (VCHI_BULK_ALIGNED(x) ? 0 : (VCHI_BULK_ALIGN - ((unsigned long)(x) & (VCHI_BULK_ALIGN - 1))))
 
 #ifdef USE_VCHIQ_ARM
 #define VCHI_BULK_ALIGNED(x)      1
 #else
-#define VCHI_BULK_ALIGNED(x)      (((unsigned long)(x) & (VCHI_BULK_ALIGN-1)) == 0)
+#define VCHI_BULK_ALIGNED(x)      (((unsigned long)(x) & (VCHI_BULK_ALIGN - 1)) == 0)
 #endif
 
 struct vchi_version {
@@ -134,8 +134,8 @@ extern int32_t vchi_service_release(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to set a control option for a named service
 extern int32_t vchi_service_set_option(const VCHI_SERVICE_HANDLE_T handle,
-					VCHI_SERVICE_OPTION_T option,
-					int value);
+				       VCHI_SERVICE_OPTION_T option,
+				       int value);
 
 /* Routine to send a message from kernel memory across a service */
 extern int
-- 
2.19.1

