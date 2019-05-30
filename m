Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E02CC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6F1244F1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185928;
	bh=o2y8YLycyyCjFf/NQIgXgw4I54SvPPf4QrE6X38uT9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVWlfk13Tif8EKxWTt5as8Z8HisOa8r5mhXQax7hbVWrCJWrswzq26ELfahcq6rJ9
	 ZABsWpGoDVFiwv9XozmyqLmzrIacAlD8yN+RNnwEd8QDben2K6eMDGk8viBPaM5yZt
	 AKDXvw8L7c6EIjHC4pglcMBRGJBiD8k3SzZr0vV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfE3DMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbfE3DKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:43 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C90324482;
        Thu, 30 May 2019 03:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185842;
        bh=o2y8YLycyyCjFf/NQIgXgw4I54SvPPf4QrE6X38uT9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrYxtPu11wP4eRfh/f3zPi2JLuaBl4rO6D+N1QroE0jFMOh2khJz50tyu3taoPAZG
         uWorsVOsY1Mh/IscLyuRosloZX3RZA6Nl9UXKg5H1RVLRdEgQvYSnMBxZscgSbsOCT
         sL5BW7dWoeAG9LsT07RpYLMNhkGU0xOyiVEPk3JM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 160/405] media: pvrusb2: Prevent a buffer overflow
Date:   Wed, 29 May 2019 20:02:38 -0700
Message-Id: <20190530030549.235437861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c1ced46c7b49ad7bc064e68d966e0ad303f917fb ]

The ctrl_check_input() function is called from pvr2_ctrl_range_check().
It's supposed to validate user supplied input and return true or false
depending on whether the input is valid or not.  The problem is that
negative shifts or shifts greater than 31 are undefined in C.  In
practice with GCC they result in shift wrapping so this function returns
true for some inputs which are not valid and this could result in a
buffer overflow:

    drivers/media/usb/pvrusb2/pvrusb2-ctrl.c:205 pvr2_ctrl_get_valname()
    warn: uncapped user index 'names[val]'

The cptr->hdw->input_allowed_mask mask is configured in pvr2_hdw_create()
and the highest valid bit is BIT(4).

Fixes: 7fb20fa38caa ("V4L/DVB (7299): pvrusb2: Improve logic which handles input choice availability")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 2 ++
 drivers/media/usb/pvrusb2/pvrusb2-hdw.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 446a999dd2ce1..2bab4713bc5b9 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -666,6 +666,8 @@ static int ctrl_get_input(struct pvr2_ctrl *cptr,int *vp)
 
 static int ctrl_check_input(struct pvr2_ctrl *cptr,int v)
 {
+	if (v < 0 || v > PVR2_CVAL_INPUT_MAX)
+		return 0;
 	return ((1 << v) & cptr->hdw->input_allowed_mask) != 0;
 }
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.h b/drivers/media/usb/pvrusb2/pvrusb2-hdw.h
index 25648add77e58..bd2b7a67b7322 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.h
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.h
@@ -50,6 +50,7 @@
 #define PVR2_CVAL_INPUT_COMPOSITE 2
 #define PVR2_CVAL_INPUT_SVIDEO 3
 #define PVR2_CVAL_INPUT_RADIO 4
+#define PVR2_CVAL_INPUT_MAX PVR2_CVAL_INPUT_RADIO
 
 enum pvr2_config {
 	pvr2_config_empty,    /* No configuration */
-- 
2.20.1



