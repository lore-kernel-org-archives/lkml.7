Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E413BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2757218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vAoXC9yU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfCUG07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:26:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfCUG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:26:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L6OfgY181106;
        Thu, 21 Mar 2019 06:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=nknWE0hl2mfj+qFjf9RtsFTgpGYHShwg+O55cZCCp2s=;
 b=vAoXC9yUytx84NNr75lnJj3/6gAq8Cz3OyAmWRg/21obf25DMylvFGL3lyEpBrYWE9BT
 5HtUZ0QtS58z4mXFsalhCvPK8RG/NI58Eb+2Qt6OqySAv7lgynSDPXOsZuwgEj/zcK2O
 71PlwxbLDojXGx6au1uUbViUNlYPQfmJ5wgXOesAnxsAqS4R6tdUI4J8i3/RlaeEFbZS
 DAnLM7CScdC4pj3h6p5Xs5/Orlpe6hWFazsYKjs9zQLQTPio1utLA81Lew6qMhGAzEgf
 BMGrr1g9f3yyB+5IRulO7R6vdXHr+igJ5KZ7tRcVEyVLMQA1jUo8/sbkKUNNkL2iVQDc Ug== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r8rjuxnt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 06:26:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2L6QmoN010830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 06:26:48 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2L6QlGE015559;
        Thu, 21 Mar 2019 06:26:47 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 23:26:46 -0700
Date:   Thu, 21 Mar 2019 09:26:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: uninitialized memory in read_bbreg_hdl()
Message-ID: <20190321062638.GA21489@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320085858.GF2202@kadam>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=776 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/staging/rtl8712/rtl8712_cmd.c | 10 +---------
 drivers/staging/rtl8712/rtl8712_cmd.h |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.h b/drivers/staging/rtl8712/rtl8712_cmd.h
index 92fb77666d44..1ef86b8c592f 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.h
+++ b/drivers/staging/rtl8712/rtl8712_cmd.h
@@ -140,7 +140,7 @@ enum rtl8712_h2c_cmd {
 static struct _cmd_callback	cmd_callback[] = {
 	{GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
 	{GEN_CMD_CODE(_Write_MACREG), NULL},
-	{GEN_CMD_CODE(_Read_BBREG), &r8712_getbbrfreg_cmdrsp_callback},
+	{GEN_CMD_CODE(_Read_BBREG), NULL},
 	{GEN_CMD_CODE(_Write_BBREG), NULL},
 	{GEN_CMD_CODE(_Read_RFREG), &r8712_getbbrfreg_cmdrsp_callback},
 	{GEN_CMD_CODE(_Write_RFREG), NULL}, /*5*/



diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index 1920d02f7c9f..8c36acedf507 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -147,17 +147,9 @@ static u8 write_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
 
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
 
-- 
2.17.1
