Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0F520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE9IHh/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfDJK3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:29:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38423 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfDJK3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:29:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so1303965pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZWTEOROzeVqtOUOm3L+pkfKp9oS6Q8M/8uwTvZl5S6E=;
        b=sE9IHh/KbdNyeOdXurcbKp4NVnQU3cdoETezujeWZ7FFyu0IvSGr3daXRoaZQQGsLB
         lBMJ7myuniPpzwuC7s20vuEHp+aQPft6bQIlzUgYceE/bzhiK+ZlNXrj0rP5NtD8DTyw
         ePEPBfavMijZGeR4WkQ3xqusjkhynosAfxGkO4r2BzTWkAugGa/EZBQBcfcAp0Z8uz0q
         fmk/pn1YuP9il7tNwNLNkdAa7Ssj5gYYesvtLHtQmJE7+usW+9NlZU0lA1CFaSkV+Erm
         QD14Zf3s6Z+FGAy5A2/mFfvvx/SM6CWAh24xF/FG/2GkJm2oY2qCsA+ZvaUd+l0JMn5a
         IYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWTEOROzeVqtOUOm3L+pkfKp9oS6Q8M/8uwTvZl5S6E=;
        b=jDmV7kHyo37bpj0IzaOghxIJuH7+sIxEraYE6giPUovznMtZqETj+AwaA8X0QEVcq5
         BmSMWzMJuT9+8Xk9YpKV75LXfhIpd06Nu6ZmhaI59LZorehP/VkNEsJrjcQjJgEBCljf
         AlOqkKNPIlj0gWF3tjOvIcKrWcxOSqVqRYvK34Kir49K0p53BA7Ix3Vx1aDteXTgtwXn
         lYdu9Y2ZBjvbLcb7/tG0LOIOEPvAWISWZGQZAStp55OVCwQ/3ghNbjuzKt4qZ8wmXOuK
         3+CFgiKZLBQ4V5dD2DLpvPOKb9OucHT+TbmVb9LARH2+pw8OaPLU0OflEyFm0Hv7kvn9
         SLYQ==
X-Gm-Message-State: APjAAAVWqjj7crS+s2kQOUpt9dCkekiKznLIlcqEWwL1ylLGoLJcd8gd
        sOKAju1TawZbCoS2Di3Xi8w=
X-Google-Smtp-Source: APXvYqyJNSCrh+0zxQ10rhovr8BN4dcsPDAXhIkwtelOoQrLkz+UIwnWDm2SUtMs0NfzgWtAx4R/Hw==
X-Received: by 2002:a62:1215:: with SMTP id a21mr42160512pfj.126.1554892155079;
        Wed, 10 Apr 2019 03:29:15 -0700 (PDT)
Received: from localhost.localdomain (mx.daiict.ac.in. [220.225.53.35])
        by smtp.googlemail.com with ESMTPSA id l10sm29981090pfc.46.2019.04.10.03.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:29:14 -0700 (PDT)
From:   Himadri Pandya <himadri18.07@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH] staging: gasket: replace symbolic permissions with octal permissions
Date:   Wed, 10 Apr 2019 15:58:48 +0530
Message-Id: <20190410102848.12986-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve checkpatch warning for using symbolic permissions by replacing
them with octal permissions.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/staging/gasket/gasket_sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
index 1d0eed66a7f4..28dc422d388c 100644
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -75,7 +75,7 @@ struct gasket_sysfs_attribute {
 
 #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
 	{                                                                      \
-		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
+		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
 		.data.attr_type = _attr_type                                   \
 	}
 
-- 
2.17.1

