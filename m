Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C339204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962915;
	bh=19qmPjkyLSjQvQWSREO99nPbeh3BmjzdC2OKMM8Hxdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iXhThAUQROqmBALVvJuSG4uRm5vP1cAKkBXIL+38j+1FpOWMaVI71e0MBzvBqUbs0
	 L236B7b86+UONhJRQU7qYhcVkx61qFhEOyiF6J6Z35FavdxMlXlfngVTlC/SWULdX3
	 QHjy5OM9BPNGJFzNAyMKTuMmnJUgszItHfBE4VPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfDVTt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbfDVTtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:49:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC4F72175B;
        Mon, 22 Apr 2019 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962563;
        bh=19qmPjkyLSjQvQWSREO99nPbeh3BmjzdC2OKMM8Hxdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8mUJzKPLDtKW+jlX8UeGqgr6QkQGP2xITN4JBDv0W0KIr5sWt4CZL3nggR1+Xlvv
         NQqcnXh2k2NF4YKqMIf6LpgAplHTb650KtHkBU0GspK67Hljmlfyw3zLaObERjjY/+
         dUgUS/K4qj9kreAscLRzDnyWSX+IFGFOl3VR22lc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.9 16/29] staging: rtl8712: uninitialized memory in read_bbreg_hdl()
Date:   Mon, 22 Apr 2019 15:48:35 -0400
Message-Id: <20190422194848.13049-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194848.13049-1-sashal@kernel.org>
References: <20190422194848.13049-1-sashal@kernel.org>
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
index 9f61583af150..41b667c8385c 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -158,17 +158,9 @@ static u8 write_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
 
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

