Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35A4ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E202064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvZZU4hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbfJOXJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:09:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46602 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJOXJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 19:09:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so25697163wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuHx+fF2E92JEhlaePQoLmuFeHNU/07czImxZEwxanA=;
        b=NvZZU4hCK4gBl9/e1Md+nHXL0Y0WlXJ6WZlZpGkTX+su4IryR+CmQW0avCndLe1Nbx
         R4qxA1LunmzZIv9pDDyNN89hSl5hEczj17U5L59hxr02ZXC5UvZYoSdfF6SwK6pyba7u
         U+fvVl8x8Cdk9tv11EbYxmdqQyGwQdIio1OUSvK2XTG+qjZm10LhX9todDHLRQFK8zEB
         Qm+cWX4SvVM/aQQw9Bxjn23b1bry15KahaM/sA8SgopC4eTn0yR4XCmind9ejxdbT0PB
         ugyCDvNRIvstdlDhbpCpIWW1ClD7YMvKBdw7YdiqI19sjI/xN+stgC09eCpN7HVP9xo9
         4sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuHx+fF2E92JEhlaePQoLmuFeHNU/07czImxZEwxanA=;
        b=KMvpy7MVM1sil+sscy1ok7urRfDKDv7Qr/Tr/wJU/Cw1iP1jgCTdvnknGUjRHE7rxq
         DFoiTd9ZCsDzy5x/T6Pm5SYlhia5Qo3bjbA0mU7GSSOUwMF+ZHSvRGbEEBDm3pRsmT35
         PLTo58IQnXmyZulpgFZW+KJ6XeygutkacS2ZmCs6gjBU9Nf3dROkGUh8p/HoXlkCaWW+
         0gBlBG8Fn8RMx2A8BUZOFWcbE/F7H/N0jfs2UMRbnR44m4zu77RHJk+OBLQmuO9MhA9C
         H1IxoQVh0VppengZovt6/mfHD6D9n7SaPTjMkWx3iEXz9zFVd0HDvMEC1avN3CjXYA+s
         bvVg==
X-Gm-Message-State: APjAAAVkyvbq9t1KTYzdiDpXEyTwn05Bak26jMFi0sJzrSGxsgT2LUPB
        maPc6UG16uDW4wpqozw34Q==
X-Google-Smtp-Source: APXvYqy1oYXENQDYU+ylMQuWE3kL0PhJH09RZX3/Ee8okUe4msaZYKwLrL/ZIr4HAyKGvcTumVM//g==
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr33618982wrr.91.1571180972896;
        Tue, 15 Oct 2019 16:09:32 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id s1sm33064362wrg.80.2019.10.15.16.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 16:09:32 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     eric@anholt.net, wahrenst@gmx.net, gregkh@linuxfoundation.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: vc04_services: add space to fix check warning
Date:   Wed, 16 Oct 2019 00:09:22 +0100
Message-Id: <20191015230922.11261-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space betwen operator to fix check warning.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi_cfg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
index dbb6a5f07a79..192c287503a5 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
@@ -163,9 +163,9 @@
  * by suspending parsing as the comment above says, but we don't.
  * This sweeps the issue under the carpet.
  */
-#if VCHI_RX_MSG_QUEUE_SIZE < (VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS
+#if VCHI_RX_MSG_QUEUE_SIZE < (VCHI_MAX_MSG_SIZE / 16 + 1) * VCHI_NUM_READ_SLOTS
 #  undef VCHI_RX_MSG_QUEUE_SIZE
-#  define VCHI_RX_MSG_QUEUE_SIZE ((VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS)
+#  define VCHI_RX_MSG_QUEUE_SIZE ((VCHI_MAX_MSG_SIZE / 16 + 1) * VCHI_NUM_READ_SLOTS)
 #endif
 
 /* How many bulk transmits can we have pending. Once exhausted,
-- 
2.21.0

