Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55DC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E360218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7rsIl/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfF0FE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:04:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46769 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfF0FE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:04:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so916049ote.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 22:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWDmwpCTBQqLpDz0dRgn3YK1CHaVNxNkpin7tUBvoI8=;
        b=X7rsIl/Lss2UF+YgRBSZj01GMxecdMu3tEiMfl78ztSoQvqZHvCjEzk7tQc9zNb/IU
         dESlmnXn3eUZ9wzUSyVZis5KvkU9oyK3IlpkbQyXR45Oo8eWchGmS9pVGSSn5wvXvpaF
         NDB6eaeZy3GcUVDWhherRLmFoQS63A/rjfSh0E6QnFdQOSjsmpfFBQHqjzCu2CJ1skT1
         QnszDP864mFYD+lYyRntgWflyUB72yb34+rOcjJailHP2qYD7TiLaRS7X7xutNCA2FZy
         5xt7TKICFtWbVSCFq7QWILZJCkak+C2W1szmI616AYLR+ZQy46en3VpLr23eMQ4inwsG
         Gd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWDmwpCTBQqLpDz0dRgn3YK1CHaVNxNkpin7tUBvoI8=;
        b=oklS6wgznk9/Ap+hn7BeLduLhdy0hBH0q1V6k0gCjqffzCGRGBKf+ax6zA96I0sOet
         ltURF3l4HZN5rBIJpcdKmnXTQMY7qBYl9lBJ5KltvTHtx+JNp8G5pqWY9cwCDB8K+uU8
         a9PP68H5BVJ3SHseXkkWwnYandeq2BfCsWcmJEusOl6QBxOx1yBnoxNjh2Aj3XrVbqEF
         lEIe8A7rsiIGGFQBrn0JZnVAx2JOzGV1MUGM7HR68/RodLGV+iqf4phy1P/LdFaZg9qO
         4zhIsRgfsxIKcQRgRPi1CEs01Q8GPjOd0+Bp4oNbQLPri+HfA2mZ+EdnllbE0JYlUf7i
         WlyA==
X-Gm-Message-State: APjAAAWJJJDBBcbaI1VJKn3jfBK5/8wpfKr7rWly7heE2DWFvF0DE5/v
        ed/e28cW1On+02VlQAU6hT8=
X-Google-Smtp-Source: APXvYqxrLE7yZDnXYq8JzwdSU6DtCWyCSdlSmxNA0lehODTbPsdrtJtZT2zNCR23dGuXBCCxzQHcIw==
X-Received: by 2002:a9d:774a:: with SMTP id t10mr1613384otl.228.1561611868344;
        Wed, 26 Jun 2019 22:04:28 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id v18sm613318otn.17.2019.06.26.22.04.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 22:04:27 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        oded.gabbay@gmail.com
Subject: [Linux-kernel-mentees][PATCH v3] drm/amdkfd: Fix undefined behavior in bit shift
Date:   Thu, 27 Jun 2019 00:04:25 -0500
Message-Id: <20190627050426.17925-2-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627032532.18374-3-c0d1n61at3@gmail.com>
References: <20190627032532.18374-3-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined.  Changing most
significant bit to unsigned.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
Changes included in v3:
  - remove change log from patch description

Changes included in v2:
  - use subsystem specific subject lines
  - CC required mailing lists

 include/uapi/linux/kfd_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index dc067ed0b72d..ae5669272303 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -339,7 +339,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_USERPTR		(1 << 2)
 #define KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL	(1 << 3)
 /* Allocation flags: attributes/access options */
-#define KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE	(1 << 31)
+#define KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE	(1U << 31)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE	(1 << 30)
 #define KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC		(1 << 29)
 #define KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE	(1 << 28)
-- 
2.22.0

