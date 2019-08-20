Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1BC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B222DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WYO56BcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHTRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:45:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42633 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfHTRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:45:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so3811478pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mI/fsnxr7SJRcgo+NbhPuqvEtthADzWDuenEYEuutw=;
        b=WYO56BcRaUfZzl1gOuDdMFCvIgKrBAM14lmqr6BUMqMPpMsNtPVYwjuPwb+2Cdc3vc
         lIdsyCEWC5QfSDVo8KFK+qUx/hOgdgm2aBIXcru6VOops555F1ZEolkzSS/iVCPRaUm1
         otmI2omSG0IUJxQI7pIlV04OIbKPqUYyaReWQ1obwyutYxSjTHVYPwIaHhgX57kQZxo7
         aBV/a1hvrQWC8d54OaMKs1NL+ZurhX8CqUDzb5yux6tUGQokxPb1vkqLxuWfvdCkCP0x
         JHW5E6PQK0fNc/9etfFq/U12O7j+ueDIq+tmPYEt0sirVCgFSzaiqd9w2bcp3nB3Owq9
         N2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mI/fsnxr7SJRcgo+NbhPuqvEtthADzWDuenEYEuutw=;
        b=O6E9PTIPy19o67QuGenK0COEpEcPjN/lqNCeuTlZ6ECwzcB1RhfG1YCmTCwvR6pKt0
         j2uE+MTeJ4CpcCJew412wWI6l9d2Jq1aUj3eXxxfX5+EhruD2HmIe6G69ctVPgS8KP4Z
         rCKM6xDZq6T/+55DtpXUxY3DOn29QB6e9fWA6/p7xVhkXf+k/xpNvcZYffSlubhQd4PQ
         J82IC552r+B98SzhfDltU3iDvEoEz+yF71gkhIdcZhVjXYRN/GZuu/KsAhKCnVyygxme
         +6xfsZtvS7Lq5BD097rixqietCarVDGSbtiky+D6JYtFUwpIgr3/371QhgT4OaVvnnuv
         hSyQ==
X-Gm-Message-State: APjAAAWkC6yUBRpO2YpbQNfP+fGLyh4lb7GPOJvpe2FwHxPhqb1L/AaH
        tniAZMBSp7isfqJLE+xQcne4D+gprmCMgA==
X-Google-Smtp-Source: APXvYqy7oTAAl5zE65n3kn58l9U02ciVMZiLy4QXiS3K+51wT2cNIbXx1DyGZYRHcSlxaWgucITIoA==
X-Received: by 2002:a63:f304:: with SMTP id l4mr18303453pgh.66.1566323124945;
        Tue, 20 Aug 2019 10:45:24 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id y188sm23403339pfb.115.2019.08.20.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:45:24 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, "Yavuz, Tuba" <tuba@ece.ufl.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        stable <stable@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: USB: gadget: f_midi: fixing a possible double-free in f_midi
Date:   Tue, 20 Aug 2019 10:45:13 -0700
Message-Id: <20190820174516.255420-1-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yavuz, Tuba" <tuba@ece.ufl.edu>

cherry pick from commit 7fafcfdf6377b18b2a726ea554d6e593ba44349f
("USB: gadget: f_midi: fixing a possible double-free in f_midi")
Removing 'return err;' from conflict.

It looks like there is a possibility of a double-free vulnerability on an
error path of the f_midi_set_alt function in the f_midi driver. If the
path is feasible then free_ep_req gets called twice:

         req->complete = f_midi_complete;
         err = usb_ep_queue(midi->out_ep, req, GFP_ATOMIC);
            => ...
             usb_gadget_giveback_request
               =>
                 f_midi_complete (CALLBACK)
                   (inside f_midi_complete, for various cases of status)
                   free_ep_req(ep, req); // first kfree
         if (err) {
                 ERROR(midi, "%s: couldn't enqueue request: %d\n",
                             midi->out_ep->name, err);
                 free_ep_req(midi->out_ep, req); // second kfree
                 return err;
         }

The double-free possibility was introduced with commit ad0d1a058eac
("usb: gadget: f_midi: fix leak on failed to enqueue out requests").

Found by MOXCAFE tool.

Signed-off-by: Tuba Yavuz <tuba@ece.ufl.edu>
Fixes: ad0d1a058eac ("usb: gadget: f_midi: fix leak on failed to enqueue out requests")
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org> # 4.4.y
---
 drivers/usb/gadget/function/f_midi.c | 3 ++-
 drivers/usb/gadget/u_f.h             | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 5ead414586a1..e5c4a907e5d4 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -366,7 +366,8 @@ static int f_midi_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (err) {
 			ERROR(midi, "%s queue req: %d\n",
 				    midi->out_ep->name, err);
-			free_ep_req(midi->out_ep, req);
+			if (req->buf != NULL)
+				free_ep_req(midi->out_ep, req);
 		}
 	}
 
diff --git a/drivers/usb/gadget/u_f.h b/drivers/usb/gadget/u_f.h
index 69a1d10df04f..3ee365fbc2e2 100644
--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -65,7 +65,9 @@ struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len, int default_len)
 /* Frees a usb_request previously allocated by alloc_ep_req() */
 static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
 {
+	WARN_ON(req->buf == NULL);
 	kfree(req->buf);
+	req->buf = NULL;
 	usb_ep_free_request(ep, req);
 }
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

