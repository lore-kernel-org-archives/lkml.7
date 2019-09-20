Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8012EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7D8206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHOjNklA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfITBnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 21:43:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38373 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfITBnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 21:43:12 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so12505580iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ciGUDPl4daxVTPCSsv9JO87yt3PVdb6Zm3OOVvC6yPw=;
        b=tHOjNklAaMJ6NaXT9aZYxw9+scfwAUKAZkp3KFY/qY9PL0cWS6H2mZ72aJNKB+9AdW
         Skh3k1tUMEjj7V542VW/vmcoqXXJvHvmVgCI6G0twt8kxYuf3Kq2ER/4X/JQlJRtHvch
         14cHBKpejuibxfpOLBbz0fXdZWK+adNvMEEtjMkMRwbUaFEjOwWbULoz8YZBvSHyPL+i
         KJRTtaMREB5a8QvQyKfA3UwQdCZbaP5VZSkPrsNApq06G/11D2GjzuGOVgGC6Dxl7pJt
         A6Jr+ttIusT+/JAGE3DMji+lcZIT6NzpV6uk1gYrqbtpZCLnByOedz2fQpMQ77Iml8f0
         gJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ciGUDPl4daxVTPCSsv9JO87yt3PVdb6Zm3OOVvC6yPw=;
        b=a4E4l7vtwcuJGbwW+mn1iAYtURab1yuH52orFx+BWnp17X2z3jYtmyG67m0n/olneg
         Q0r8TqJMV0htsad8YHZEdVKsvW0LovTYuOGQ5nDj8FmRXAlYF5tDzsdeUsA/J8cIi1rc
         iuYrKOqadCUA+gbCax81NErsFOH6lROpzpKL+r2Ky/LbyXXJ3vZFMNy7Doe1seis5J4b
         a6D7eWw8ezhXFReXUn2VlJ1PB9ruwDvpgaVzgWlc7UuFWcCvDqjlSQEYiXp6KMU8ygYQ
         8MFmRs0jRoLfmcGg4dp1fuFe8oOx3H+JU/cEGQluRPMbRmy7kiVVXp3vZcN4bvhXHOSw
         IZjw==
X-Gm-Message-State: APjAAAX0mi6gC7tOrOymQ756PZ6vjVsfddbJOiMSg29DNN/P/PEBo7to
        ZizgLBfal45QHWN6zb/X5cc=
X-Google-Smtp-Source: APXvYqzrJplgeDGnDv+YsfxegTmSD0ca0oxceB/4Ln3i+aNIWuJYflVNMHIupY8vP5Drd6YWbJ1FKA==
X-Received: by 2002:a02:2e54:: with SMTP id u20mr16570286jae.5.1568943791641;
        Thu, 19 Sep 2019 18:43:11 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id q3sm380180ioi.68.2019.09.19.18.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 18:43:11 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: release memory on error path
Date:   Thu, 19 Sep 2019 20:42:54 -0500
Message-Id: <20190920014303.31410-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtl819xU_tx_cmd if usb_submit_urb fails the allocated memories should
be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index fe1f279ca368..401561705d9d 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1232,6 +1232,8 @@ short rtl819xU_tx_cmd(struct net_device *dev, struct sk_buff *skb)
 		return 0;
 
 	DMESGE("Error TX CMD URB, error %d", status);
+	dev_kfree_skb(skb);
+	usb_free_urb(tx_urb);
 	return -1;
 }
 
-- 
2.17.1

