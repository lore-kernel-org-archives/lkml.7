Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7217EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB3521928
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962501;
	bh=2/RoXA2xob5p0lq65gKFrobjUzdOxgF7Gu6qHKEDJks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4AoKJAblfAzIJII37FyQA+DZ8ocptfQubqay//9y7HxW4467D/K83sUxlVyiOmU8
	 /Xh5+LK0K6Jab2meuvt+vymPe4q1t9fveMwcfb0bDfihXdFMmf7y6qSCsxXSCrEjK6
	 RSbXwJXNAv+hKY92W140HeuPvDO9vrpPzcZkzzxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfDVTsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbfDVTsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF564218FE;
        Mon, 22 Apr 2019 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962495;
        bh=2/RoXA2xob5p0lq65gKFrobjUzdOxgF7Gu6qHKEDJks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dO+BEWbW8//9wHHQTLIKb3z5p2MilFEOl17KchZwTSANL7Ofs1++DLnSX4TdAlP7X
         DhEshBJaO8xYo4m/Xx19S6iArxehOsuDSEHjEZXoOh2xqQAgrctsOpuseQw5OC1utz
         moX2ZOr77BZNozPko1977A7MOnkvD8BvyNJ83oe4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 20/43] staging: rtl8712: uninitialized memory in read_bbreg_hdl()
Date:   Mon, 22 Apr 2019 15:47:04 -0400
Message-Id: <20190422194727.12495-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 22c971db7dd4b0ad8dd88e99c407f7a1f4231a2e ]

Colin King reported a bug in read_bbreg_hdl():

	memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);

The problem is that "val" is uninitialized.

This code is obviously not useful, but so far as I can tell
"pcmd->cmdcode" is never GEN_CMD_CODE(_Read_BBREG) so it's not harmful
either.  For now the easiest fix is to just call r8712_free_cmd_obj()
and return.

Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/rtl8712/rtl8712_cmd.c | 10 +---------
 drivers/staging/rtl8712/rtl8712_cmd.h |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index 0104aced113e..ccda04e916c5 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -159,17 +159,9 @@ static u8 write_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
 
 static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	u32 val;
-	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj	*pcmd);
 	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
 
-	if (pcmd->rsp && pcmd->rspsz > 0)
-		memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
-	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
-	if (!pcmd_callback)
-		r8712_free_cmd_obj(pcmd);
-	else
-		pcmd_callback(padapter, pcmd);
+	r8712_free_cmd_obj(pcmd);
 	return H2C_SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.h b/drivers/staging/rtl8712/rtl8712_cmd.h
index 67e9e910aef9..d10a59d4a550 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.h
+++ b/drivers/staging/rtl8712/rtl8712_cmd.h
@@ -152,7 +152,7 @@ enum rtl8712_h2c_cmd {
 static struct _cmd_callback	cmd_callback[] = {
 	{GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
 	{GEN_CMD_CODE(_Write_MACREG), NULL},
-	{GEN_CMD_CODE(_Read_BBREG), &r8712_getbbrfreg_cmdrsp_callback},
+	{GEN_CMD_CODE(_Read_BBREG), NULL},
 	{GEN_CMD_CODE(_Write_BBREG), NULL},
 	{GEN_CMD_CODE(_Read_RFREG), &r8712_getbbrfreg_cmdrsp_callback},
 	{GEN_CMD_CODE(_Write_RFREG), NULL}, /*5*/
-- 
2.19.1

