Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E13C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086420693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1MKdoQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfDYQiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:38:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45263 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfDYQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:38:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so47718pls.12;
        Thu, 25 Apr 2019 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhP+0qXLKcIvd8zcsCQWUyMz8HeCpuFq4bHAvM6mNOY=;
        b=o1MKdoQzNyvSoLwZ2RDlz/2+alYoKBGAHMj4/+rmBEp/bPOrnZo6CMN4psR1ib+0qT
         bvs0t/QEaaZ+aCbqcwOQrDEOtjvjSR7Mb3hBUkeMabO69OLVUj9WucmwwP8sVXESlXgJ
         VqimlyttCJHrRDZr7T2vyKRSHcFNOZiIFAuVMUA1try5yQUvou8lIsnPPECIuPmbbk7b
         YYg+bcGKAVdXh0l2sYp0jLOqVJmn2dl5gc+oPKSDpOUv8PJy6PKceaVlydw2YJ6iWrfR
         LsKj56nXpPH+xmzdfz0II+4ji17cnul47S0rSyBIr7TtY6CRBCBvJ4/fuyrqrFCfWpVw
         pfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhP+0qXLKcIvd8zcsCQWUyMz8HeCpuFq4bHAvM6mNOY=;
        b=eqLNPbLKDOFy2GnJuWPQfcskXMtgOcem8Guz1juqd0VIGxQSdIFCSQm++fyXDiv51A
         DTmZ3noNVBYJ+TE3Q1eyPis/m0vTkXMyqUNL039N/HJV0h2aPOdJapg/VAo9CxGZZ7+K
         pcNG15Jk3ie29JFZ/opBWQDCm5FxQLjlus2mmWvVyuNkeVdEc8gZ45Z8KsusRp36BV/A
         4eTdQZNT1GcoAWmpJZ8I1LLDYbZD1CG33S5u5j5qLud2+2LhnQQ3pgeDonZNeNivnIx/
         jFrlQHws84Nou6IS15smc28VXJJSseRqryk6SbW+HLmozcXnpuHkvzG+ViE6mchwnl+/
         +sxw==
X-Gm-Message-State: APjAAAWxGDPyBe32LuaBqrRLIKtvbXZll/u5FjEAwThhFh3XdmY3sHC9
        I0nrrmfTJJWPS0ahNhge+DI=
X-Google-Smtp-Source: APXvYqxJHa7Eoe8Mywk7XT/2kzjRZdYUczYsF0opji9chexWdsmUJFKf0badB9V1Qiub9dnFKFOiUw==
X-Received: by 2002:a17:902:2b81:: with SMTP id l1mr39757318plb.289.1556210331156;
        Thu, 25 Apr 2019 09:38:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k186sm42003053pfc.137.2019.04.25.09.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:38:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwink@chromium.org
Subject: [PATCH 2/2] HID: input: add mapping for KEY_KBD_LAYOUT_NEXT
Date:   Thu, 25 Apr 2019 09:38:46 -0700
Message-Id: <20190425163846.51730-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
References: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HUTRR56 defined a new usage code on consumer page to cycle through
set of keyboard layouts, let's add this mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b607286a0bc8..0579b8d3f912 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1051,6 +1051,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 		case 0x28c: map_key_clear(KEY_SEND);		break;
 
+		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
+
 		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
 		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
 		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
-- 
2.21.0.593.g511ec345e18-goog

