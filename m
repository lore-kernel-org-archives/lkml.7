Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603CBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273532053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414011;
	bh=knPiU9Z33BDFBqO1Ya+HUVMK2VX5SuMulA+xeidNTJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HNn2T5qyTd6/FcYYKaH3Kj2/Xb0RdARYVaeDCtaJkFcRF2J5d2Dy1SQWW2qOIz8IT
	 BDCfeuI3GWwWNyiINIZSe7qxenKlcHTHTDnWn/tzIpHAmjqjTM4+qocJZXqOClVY4G
	 mYK99KX7AfMcKcIaoLMqoaxFeOTcbf82v3gIPVsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfLCXAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbfLCW6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A76A20865;
        Tue,  3 Dec 2019 22:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413902;
        bh=knPiU9Z33BDFBqO1Ya+HUVMK2VX5SuMulA+xeidNTJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdeE2/yVipX8+CcCR/dd7syWqnec4x9qa2sXpIZZUE9GwBdThOm/+9gC7xgFszs5u
         ct7kLSTvzO4QKuagnIX9GPI8frAv0vslyjntmDw9netU0/m+n2L05RQce3xvAHq8DI
         gXhI+JQNvHat6E1m+WUNypje7oqDfnTjbKuEVSfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.19 307/321] media: stm32-dcmi: fix check of pm_runtime_get_sync return value
Date:   Tue,  3 Dec 2019 23:36:13 +0100
Message-Id: <20191203223443.116655234@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

commit ab41b99e7e55c85f29ff7b54718ccbbe051905e7 upstream.

Start streaming was sometimes failing because of pm_runtime_get_sync()
non-0 return value. In fact return value was not an error but a
positive value (1), indicating that PM was already enabled.
Fix this by going to error path only with negative return value.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/stm32/stm32-dcmi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -584,9 +584,9 @@ static int dcmi_start_streaming(struct v
 	int ret;
 
 	ret = pm_runtime_get_sync(dcmi->dev);
-	if (ret) {
-		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync\n",
-			__func__);
+	if (ret < 0) {
+		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync (%d)\n",
+			__func__, ret);
 		goto err_release_buffers;
 	}
 


