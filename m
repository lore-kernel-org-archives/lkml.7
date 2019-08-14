Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC64C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A85206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803463;
	bh=o1HknKAktox50Lr8eByWnXdw3nOw0WtDlgNr12VKcBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zptaLh3Uvy/ee2DsNvQssNvH+/sMYavUxYF6zeFdt10Ujg8Pfy9ARkI4UDXup9myR
	 /fmjoah54nd6FKraOpErr2NxbApf0WXvdhmU9jOrFKIpSYB7fcjavm2SK+DPtqsFqR
	 L4DgD4aHaw62vyKEkUJ2QT2cn9UeznlEtN8FGKXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfHNRYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbfHNRGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:06:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A4D2084D;
        Wed, 14 Aug 2019 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802398;
        bh=o1HknKAktox50Lr8eByWnXdw3nOw0WtDlgNr12VKcBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDeGtsTnxRbSJuAHgBfYodnSKJ4e30j1aobUhQU9iySx/mS6VxDZWQEYYJ7MbBeMN
         wWkB+RqKmGa2Q+e/9rfKAnSs/lFiNqs4VgHwUfRZoA1k5lg1KJ+OicJhocJnTOK+mg
         crUnw0G5NVq3/riIqlQVaOXlqC2/Xp75okKdJkgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 110/144] test_firmware: fix a memory leak bug
Date:   Wed, 14 Aug 2019 19:01:06 +0200
Message-Id: <20190814165804.513117773@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d4fddac5a51c378c5d3e68658816c37132611e1f ]

In test_firmware_init(), the buffer pointed to by the global pointer
'test_fw_config' is allocated through kzalloc(). Then, the buffer is
initialized in __test_firmware_config_init(). In the case that the
initialization fails, the following execution in test_firmware_init() needs
to be terminated with an error code returned to indicate this failure.
However, the allocated buffer is not freed on this execution path, leading
to a memory leak bug.

To fix the above issue, free the allocated buffer before returning from
test_firmware_init().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Link: https://lore.kernel.org/r/1563084696-6865-1-git-send-email-wang6495@umn.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 83ea6c4e623cf..6ca97a63b3d6b 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -886,8 +886,11 @@ static int __init test_firmware_init(void)
 		return -ENOMEM;
 
 	rc = __test_firmware_config_init();
-	if (rc)
+	if (rc) {
+		kfree(test_fw_config);
+		pr_err("could not init firmware test config: %d\n", rc);
 		return rc;
+	}
 
 	rc = misc_register(&test_fw_misc_device);
 	if (rc) {
-- 
2.20.1



