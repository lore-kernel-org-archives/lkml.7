Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD826C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F4E2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx7MrBck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFRENp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:13:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34716 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFRENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:13:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so5122474plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HAfVrRGqK9F22xtY9VWwoHp1OFzNIgxgu2VzK0MFrlA=;
        b=Cx7MrBckpG3pV2Jz77wAkDQV+G8/gS0yR99YJXl74q/uxr/lh4mIqYZ/TaVtgP0Pgn
         Lm41b5B3JhW6wfTSP44YLV8rB6h48vW8smzppBQcaujDKhyg6Po39RqODh5x1ZzcGWQr
         Hxu3fg30XhYkOAIDFWNMt+tVmloX873DQL83h4QyI9BP5TYRve5IqjOhOs1AtijW1lZC
         v8AgB2XXjG7GRDeCYGv+8E4O9mhGgfotKiBrjjnGadT1Ka8aW1CA90BrFlF7Pwm8a6Oq
         rrWX8byr+6zOtnS9pOZkR8pOfdHHALmIY6elhrq13K8zMvwUc9Ljq3Ojr4ndykkgapW2
         AHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HAfVrRGqK9F22xtY9VWwoHp1OFzNIgxgu2VzK0MFrlA=;
        b=inKlloH7C0HL6l+Yu9FtkO+MM0uRrPSoCPIVHqkuGsqDPWO6fgk8rYwS01AH3EJlBE
         JQLkeZS+cGtRPzjzRub3/JZ0Exvsum+xUKypPSV8mJnxm6RiMNybNiJKREga7fC4Ix08
         nhBp9OvWJTUYWmcU1xeX2GII31D8M96SURtAp7HGcVDJHUejIZeqSZrYMi9s7MIv37TL
         1f6i3K8dHE0UETAqna/MRNpzTnpOKVFVbHyvqs7XaSJ82ZBHJunVcf877b3bxvNqrFQJ
         oNMgSO0iWUkv+xlH7pcTS4zApGiay5dtSg5nIu0HpvI3QXMmxFRDovzLZhryzR7u0Gv5
         kmHQ==
X-Gm-Message-State: APjAAAUaVIrHNa9xzZ2pbwhyMgqOxhv14hd1tLy/NbFComTklUaR48cu
        44e4XJsWI2wLld5Cuhfvpkg=
X-Google-Smtp-Source: APXvYqz1sz6wqa3ypsfLHHreH23EIZOSxsjDWBq4mEBUZ2lazFOEbB60I2GFP49InHeBWnNzPT3PmA==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr33758995pld.41.1560831224008;
        Mon, 17 Jun 2019 21:13:44 -0700 (PDT)
Received: from localhost.localdomain ([112.196.181.128])
        by smtp.googlemail.com with ESMTPSA id t2sm12836202pfh.166.2019.06.17.21.13.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 21:13:43 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fs: cramfs_fs.h: Fix shifting signed 32-bit value by 31 bits problem
Date:   Tue, 18 Jun 2019 09:42:57 +0530
Message-Id: <20190618041257.5401-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
32-bit value by 31 bits problem. This isn't a problem for kernel builds
with gcc.

This could be problem since this header is part of public API which
could be included for builds using compilers that don't handle this
condition safely resulting in undefined behavior.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
RESEND - Added required mailing list in CC

 include/uapi/linux/cramfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/cramfs_fs.h b/include/uapi/linux/cramfs_fs.h
index 6713669aa2ed..31df3e185b62 100644
--- a/include/uapi/linux/cramfs_fs.h
+++ b/include/uapi/linux/cramfs_fs.h
@@ -98,7 +98,7 @@ struct cramfs_super {
  *
  * That leaves room for 3 flag bits in the block pointer table.
  */
-#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1 << 31)
+#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1U << 31)
 #define CRAMFS_BLK_FLAG_DIRECT_PTR	(1 << 30)
 
 #define CRAMFS_BLK_FLAGS	( CRAMFS_BLK_FLAG_UNCOMPRESSED \
-- 
2.21.0

