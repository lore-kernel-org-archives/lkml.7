Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E790BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C029420850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dre9DV4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfHZSUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:20:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45340 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfHZSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:20:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so27715315eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N4weBUZObjkT0iYXlNG3dax69Dk9pqX9JPbqFubJfc4=;
        b=dre9DV4GAPVr5XXv6RbsvbKURSMw5Dl014a9SaEYkSwkwrAkujcGZ3HlkhsMt/apA2
         oPKRQKcui5y2OtdABmBoJYryUAIhRd+qS+PNFMDV9RXVNheTVyi+mPKpV2UJl1fi1P3v
         8KRvDfhgsukxbKzGMlXmpX5+THBsNBcftlPM/XV2HuCuXoZt0PQTqOBzh5j5VAmttqTi
         s40173KcBShJXbWUK7Ph+tYWFWUF+YcCMGcYAepvpW1b0nKCEuFu+hASBmCghWrFi/T/
         ILLDmW/Thg9Gngo05MkC5blUMuaydGnarDc4+73lA7SXD493VcFycBbLoygPC4eXQkKg
         nZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N4weBUZObjkT0iYXlNG3dax69Dk9pqX9JPbqFubJfc4=;
        b=PtARLQ8hEvT5vSAtqVSca5TBQs1pHzPGVWej2VO13FSIIjHdJfq1rcrELSxxpYObr5
         IdW3SbTRqNxcRfSV+jr6CxF32mdvLit8aw7cO5sGgQ9SqQLVm/9NNR5bf+v41MGzWFSe
         O8oFCKIdcJ8G5p99qDbt3Jvk+8bS5NP5MadQWURuNE0tvHMqPZye7dca8DjiRvXaQyVF
         va9kE5oA2ZvWEt+dJBlPQdkZUz8Zv1e4hS5eqS0dwgOhSXwbWHgdGHR38kDvx5bVODDw
         vYLydpbQnFpg8lwewydRpXNTh38MToEjue9kGMe62v5eFM3ldMWzB0jK2yK19I+2p7EJ
         XAKQ==
X-Gm-Message-State: APjAAAV7iYbkj6MM1aWyBuysQj7H/KUuvM3m5UvN+q0piVCdjY8o7euz
        I9nRruOEW990xADLS/31XPk=
X-Google-Smtp-Source: APXvYqzyPrKcQxofAI6MKAvYwXounjs7XjJoy3FRLmbSpHMx96PhksUx4fz045jbT5+/hueD/uyP0A==
X-Received: by 2002:aa7:d799:: with SMTP id s25mr20374970edq.172.1566843617683;
        Mon, 26 Aug 2019 11:20:17 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d34:8300:85f2:24a1:2141:af4f])
        by smtp.gmail.com with ESMTPSA id c8sm2744170ejk.22.2019.08.26.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 11:20:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] MAINTAINERS: mark simple firmware interface (SFI) obsolete
Date:   Mon, 26 Aug 2019 20:19:56 +0200
Message-Id: <20190826181956.6918-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown has not been active in this part since around 2010 and
confirmed that he is not maintaining this part of the kernel sources
anymore and the git log suggests that nobody is actively maintaining it.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

Len Brown expects no further systems to be shipped with SFI, so we can
mark it obsolete and schedule it for deletion.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thomas, please pick this _reworked_ patch now. thanks.

v1: https://lore.kernel.org/patchwork/patch/1033696/
  - got Acked-by: Len Brown <len.brown@intel.com>
 
v2:
  - also change status to Obsolete
 
v2-resend:
  - applies cleanly to v5.3-rc5 and next-20190823

v3:
  - simply remove Len Brown and do not try to find a possible
    replacement 

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43604d6ab96c..f84173abdb71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14641,11 +14641,8 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.rst
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
-S:	Supported
+S:	Obsolete
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
 F:	include/linux/sfi*.h
-- 
2.17.1

