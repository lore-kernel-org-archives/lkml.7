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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138DFC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4D8216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnmR6S3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF0DZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:25:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45750 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfF0DZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:25:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so461604oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DspknQs36A/5uQZX53aWrrdTwDH7n/43l0dEQF/NX0g=;
        b=FnmR6S3UdvxSAXrt4YakXY+vA/wkVhU4l9+b1MXMa7h47IiKVdslEShfoIOjhVAu+A
         CHE+plwYBAfdLkY7mCGM2sBx+LHdtyh3KQNMcT1egYV6b3/82KUnTlGJIm9IcfZlGrvE
         aYCkPHKdxlFQGh5+5WTbawbIFIJHDRsskbAp6a3oQn1XcLXFfDDAdcZXF3kIA9xExHUD
         uW4jwOgqNAC5JiKaqpKFNetlim8XkuaYVoStRsdp9W9uFkc76yRwEJ+5UrYEF9VB67jy
         YpT8T+29gg6/tS9FTzjwY9s/5T8VjnjN6HxxkfONF+7Hvs5DNjJdgS0MRRlk0Z3uH1Qc
         IG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DspknQs36A/5uQZX53aWrrdTwDH7n/43l0dEQF/NX0g=;
        b=WsdDKHCt2z5C2fSRhie82IkTn0AbF08ribERrCe/y8moIL7qtMKNbBU+jN83tyD6Oa
         kQoL9CGJSZbn0wkY8VCY2GcIlO5RjMuoVkpnDR4TdKVE1rqd6oHyYQgp82/4wxfDvY/Y
         OxGtdkcA9ZbJJGQ/uuAeSoL+WOMssqPs4RAm+g/XMcTld3OHjhRrIOR1yd2j7ZuHFH2v
         djIq1p9z0BXuMPXDrpaM7bH9qnWgDQCO+xvHPZjreYX3iBhyrofPozrEcL0jgtcpX0+h
         hKuuFW/1jDvo0V2EWTjFDZNJHDof8YXh1cdkdetBI5ugvxKGRDkIcZyZX7enveutaePu
         Hnqw==
X-Gm-Message-State: APjAAAU10mAz/Oc8WHS+MQC/wWrJ0ywmkRRE5m3lCnD25v1MiQAEe4wd
        +qGxrNwnTTw5x8E1Dt7UGDY=
X-Google-Smtp-Source: APXvYqy3hg34R0jgTYAW4T1SMDgeAtq+nnmQVEoxqu2nLKH+jbuWe+E3KiBTJky9/6oXvYkKTVdf0Q==
X-Received: by 2002:a54:4f95:: with SMTP id g21mr303543oiy.23.1561605935712;
        Wed, 26 Jun 2019 20:25:35 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id y184sm417647oie.33.2019.06.26.20.25.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 20:25:35 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        oded.gabbay@gmail.com
Subject: [Linux-kernel-mentees][PATCH v2] drm/amdkfd: Fix undefined behavior in bit shift
Date:   Wed, 26 Jun 2019 22:25:31 -0500
Message-Id: <20190627032532.18374-3-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627010137.5612-3-c0d1n61at3@gmail.com>
References: <20190627010137.5612-3-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined.  Changing most
significant bit to unsigned.

Changes included in v2:
  - use subsystem specific subject lines
  - CC required mailing lists

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
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

