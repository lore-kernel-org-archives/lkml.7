Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215DEC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECADC21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932547;
	bh=8+INYItTilmh3es4jWep5jCA9gWHpE6Zhh3TUkxqR0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+7Hasnw8f+uvhCuTF/Y/x3aLG6EUt+Z1PQ4dMsE6HsV5nF2VYDlpVrCyryLonBxb
	 gAQf1LOdjM4UN0X50+ufVrXRpENG+sPeTu/00rPKes42c/z9HJg9jeeBzZc1QAdOCF
	 nO78kbMwMJU2D6Pq2HKtDbRWdBoyMPNhSV61TIP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393239AbfISWHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391364AbfISWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:07:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB89218AF;
        Thu, 19 Sep 2019 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930849;
        bh=8+INYItTilmh3es4jWep5jCA9gWHpE6Zhh3TUkxqR0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmLGskLf7HlhzLzlLK8q+2kR7iQHQAC+6uhW5f3O7n+8lP6+CsmtVQbZuG3gMrjQF
         H1iVNmW7nwYUjPOb8Bxae5pdoIKym08MG4oSk8kLuEEsJQAUh/YdY6F6y7pY7qbC9B
         wnuyPk8ENoXo6cw+enygAS9xvGF+JjTLq8GgGxeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabien Dessenne <fabien.dessenne@st.com>,
        Pavel Machek <pavel@ucw.cz>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.2 009/124] media: stm32-dcmi: fix irq = 0 case
Date:   Fri, 20 Sep 2019 00:01:37 +0200
Message-Id: <20190919214819.509846815@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

commit dbb9fcc8c2d8d4ea1104f51d4947a8a8199a2cb5 upstream.

Manage the irq = 0 case, where we shall return an error.

Fixes: b5b5a27bee58 ("media: stm32-dcmi: return appropriate error codes during probe")

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/stm32/stm32-dcmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1702,7 +1702,7 @@ static int dcmi_probe(struct platform_de
 	if (irq <= 0) {
 		if (irq != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Could not get irq\n");
-		return irq;
+		return irq ? irq : -ENXIO;
 	}
 
 	dcmi->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);


