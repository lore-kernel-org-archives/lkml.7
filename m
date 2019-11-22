Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19433C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC23D20656
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419467;
	bh=yghk864Qu3p4uLxrXvRwD8kPFl/idh9sgYH6Bz1/LXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VO3ubz9hJW32olzuYH2ZwNEQzzGkMW+66Que3dw9bseWGGxt53pTxD5V68G/JJ3Qc
	 eN5hUTuP+11P+emYWoyf0tJT46c3ByCApOgBnWwIm7jhXsydNBQrE6cA7L1d/ehnWr
	 ibcz5+PbVtDWYA1eQlmDH5iIPeXbYj4r+l2uzXbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfKVKoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfKVKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:44:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429EF20656;
        Fri, 22 Nov 2019 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419459;
        bh=yghk864Qu3p4uLxrXvRwD8kPFl/idh9sgYH6Bz1/LXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvzWVjvKO0ZYveBauCLDNuPGu/MrFGhFRl1lcAke1bzfp5K3MPNdCpEf1igWnHpb4
         Q0ZGsd6FwJFshirtF59eegtwNCpNDqq/a6xrOo5XJfXxoFaml+JJrNdSn4n2mXIeRS
         edGctmSo7OpfZtcSYWSPmWWDPapxqEvldrMissRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 075/222] component: fix loop condition to call unbind() if bind() fails
Date:   Fri, 22 Nov 2019 11:26:55 +0100
Message-Id: <20191122100908.296435014@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 89b032f2ffd22..08da6160e94dd 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -461,9 +461,9 @@ int component_bind_all(struct device *master_dev, void *data)
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



