Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183BEFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5821D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213375;
	bh=djqdZXlQ3iLn+R5cPJY6lBtwWI+0PBuh+RGdpxjWQW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hSqwEMa/IysCP9pPP99Apd48KRsaShkgKEvlQuT8eryzoIv11fJevAurhTZ/wBTf6
	 8VdOm7l0TI2tDMimYMFGnb9YHZxr+QkwA4TZ3Wdze01/l6lYhpAA63S9oT0mDKqvf9
	 NS6T+MmzCShbYQXnlfteNgAW41FMnSJ5vblIlcj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbfKHLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390178AbfKHLmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72726222C4;
        Fri,  8 Nov 2019 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213369;
        bh=djqdZXlQ3iLn+R5cPJY6lBtwWI+0PBuh+RGdpxjWQW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZIOEDyC6AJAwK3W543q3K597i97S+BES0FeHyC/ckl9wjEWW+KRKATtfBYQSLxZo
         rUU1gh7p3bb8KrpQyp/W9mvOH3bOGXNLrYSXYhtjFs7EmaQIhDqlSjWJl7eGiIKpQG
         JGMjPLlwhw+lFcl5S1lVwvl/I91rLdrserTGUKbg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Banajit Goswami <bgoswami@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 196/205] component: fix loop condition to call unbind() if bind() fails
Date:   Fri,  8 Nov 2019 06:37:43 -0500
Message-Id: <20191108113752.12502-196-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Banajit Goswami <bgoswami@codeaurora.org>

[ Upstream commit bdae566d5d9733b6e32b378668b84eadf28a94d4 ]

During component_bind_all(), if bind() fails for any
particular component associated with a master, unbind()
should be called for all previous components in that
master's match array, whose bind() might have completed
successfully. As per the current logic, if bind() fails
for the component at position 'n' in the master's match
array, it would start calling unbind() from component in
'n'th position itself and work backwards, and will always
skip calling unbind() for component in 0th position in the
master's match array.
Fix this by updating the loop condition, and the logic to
refer to the components in master's match array, so that
unbind() is called for all components starting from 'n-1'st
position in the array, until (and including) component in
0th position.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/component.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 8946dfee4768e..e8d676fad0c95 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -536,9 +536,9 @@ int component_bind_all(struct device *master_dev, void *data)
 		}
 
 	if (ret != 0) {
-		for (; i--; )
-			if (!master->match->compare[i].duplicate) {
-				c = master->match->compare[i].component;
+		for (; i > 0; i--)
+			if (!master->match->compare[i - 1].duplicate) {
+				c = master->match->compare[i - 1].component;
 				component_unbind(c, master, data);
 			}
 	}
-- 
2.20.1

