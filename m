Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E351720848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hwdmx+4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfCAUK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:10:27 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:42031 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCAUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:10:27 -0500
Received: by mail-yw1-f74.google.com with SMTP id c74so23551541ywc.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 12:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0pj3h/XnwOwIzHOuDRkJHpH5NVy6ymoFJNdB153FB1s=;
        b=Hwdmx+4KRQbz6Vx9b18wMgbTr+6Cv9XfreEUSnAPHoibjc4Hnh6tLvaoANhM8bDqWN
         jbMlWGs03KcgaxSiHVgqv24w/+Dq/8oe8KiMef0+BixH2fxmvcGdIKlShwDWGN3CHA1+
         azm09dqG094Lq2nIxZOr7hvzUd1Q3c9lTMGPxe+70qV1hbMppjzySpXPE+DYuDUxXq9D
         nZ5MHlH0aVg/bEH/feg0AqTALVROrdBeEjrkE4zWkeTrG8z2SP8CW+mFP5RZuMehvXhk
         ZZNuLtmzwSJ4WH5NwNPrMjTpryHLte32gcKOoVwYWaAqvyc1VWKjN0w+qlzOLtKf3sFr
         2Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0pj3h/XnwOwIzHOuDRkJHpH5NVy6ymoFJNdB153FB1s=;
        b=Ic+/D7QdIeuvvwDEMIBudnwZEf/TPOHg/vPO+gwawME2RkJWPxztJXbRtzPAX1mgnt
         dTgJiZy8EeWwURqvcAnsvD6LWmmX7cLFeBhoGm3QZVb7WiV/wmjleKYCpwvMKRW+X+eZ
         rXnkx6RENxiRiV1Hp0LpU314nIuTN5DzZhrLO/TOEkFGuFxJxoA1K0pC+QIbK91E7ug2
         mzchwd2Fs/fysiNr5V+H5BKYKjlHL4FasPX02wzklTdTMLtaTI/27OtUUhPqK+uGZXkR
         4//S24q7QcJgeKdjmrw5JkNpdQYNlvocDkv9aYbU2hCbFd5PDpSTK2amfjs2oIQtsf95
         mjwg==
X-Gm-Message-State: APjAAAXK8lK6Q+cRYCNERUO0ibQ02dhoGu4DJVFVSG3GGDi3wLEVYSUV
        EKqq8pQdVR5b/18P+JL9JMT085APJw==
X-Google-Smtp-Source: APXvYqxp26fpoSLFLbW+Jmjloi/7TCoqGyJfoK6CR0vXEYcLAvImbDwo5re+YvSQApTWCo6VnOWRtEYVyw==
X-Received: by 2002:a25:bed2:: with SMTP id k18mr3198613ybm.72.1551471026380;
 Fri, 01 Mar 2019 12:10:26 -0800 (PST)
Date:   Fri,  1 Mar 2019 21:10:10 +0100
Message-Id: <20190301201010.19094-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] integrity: use KERNEL_DS instead of get_ds()
From:   Jann Horn <jannh@google.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, jannh@google.com
Cc:     linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_ds() is a legacy name for KERNEL_DS; all architectures #define it to
KERNEL_DS, and almost every user of set_fs() uses the name KERNEL_DS.

Let the integrity subsystem also use KERNEL_DS so that we can get rid of
get_ds() at some point.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/integrity/iint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 88f04b3380d4..423876fca8b4 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -200,7 +200,7 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 		return -EBADF;
 
 	old_fs = get_fs();
-	set_fs(get_ds());
+	set_fs(KERNEL_DS);
 	ret = __vfs_read(file, buf, count, &offset);
 	set_fs(old_fs);
 
-- 
2.21.0.352.gf09ad66450-goog

