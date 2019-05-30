Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C8C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191525041
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189108;
	bh=CSdObxmxmp8l1cFga4GAwgnZxIW80MVnHARyIn9Jhp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZ3O/yOehZak9kAyrHEmC+Nee/+h/KZkOtvsA0bRpOoot8v9GjwTNwzHQ1J9UwUA/
	 CVDfpHy/Li80qtMrFprjVgx6KYXY8zYwGB8758HOfs4WNFE60c2gFKSnu3GV03L4HN
	 tNEf3bIvosnYJpXmAp+Yz8ecX9eeE8zQLvr23Qa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfE3DRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbfE3DOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:09 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CEA24547;
        Thu, 30 May 2019 03:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186048;
        bh=CSdObxmxmp8l1cFga4GAwgnZxIW80MVnHARyIn9Jhp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvFO6CLIXYVZHd2Jf7Gs8ssgETFoZTst5ZBTclLK1lPB9dNADNp6lST7VB6/fv+Ev
         FZ3dgwh0agSFnKuW0GJKb7XuO0d7DBSl27oM+63SJNKTZwaNYVFA+tA84+yf7MbaHT
         ilZrSOuZO3d974rmr+IKeDHSkip0mFDl5n9lm1Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 143/346] media: stm32-dcmi: fix crash when subdev do not expose any formats
Date:   Wed, 29 May 2019 20:03:36 -0700
Message-Id: <20190530030548.380053259@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 33dfeb62e23c31619d2197850f7e8b50e8cc5466 ]

Do not access sd_formats[] if num_of_sd_formats is zero, ie
subdev sensor didn't expose any formats.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 918e49f27c7ed..a33d497bd5b71 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -811,6 +811,9 @@ static int dcmi_try_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f,
 
 	sd_fmt = find_format_by_fourcc(dcmi, pix->pixelformat);
 	if (!sd_fmt) {
+		if (!dcmi->num_of_sd_formats)
+			return -ENODATA;
+
 		sd_fmt = dcmi->sd_formats[dcmi->num_of_sd_formats - 1];
 		pix->pixelformat = sd_fmt->fourcc;
 	}
@@ -989,6 +992,9 @@ static int dcmi_set_sensor_format(struct stm32_dcmi *dcmi,
 
 	sd_fmt = find_format_by_fourcc(dcmi, pix->pixelformat);
 	if (!sd_fmt) {
+		if (!dcmi->num_of_sd_formats)
+			return -ENODATA;
+
 		sd_fmt = dcmi->sd_formats[dcmi->num_of_sd_formats - 1];
 		pix->pixelformat = sd_fmt->fourcc;
 	}
-- 
2.20.1



