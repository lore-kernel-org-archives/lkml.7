Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA960C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14F8206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520479;
	bh=D4XvgHEeCS0KzbBgydQLZIYD/5a0d+mwsPG0HseOUWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mO03yb5QvB2a5qcnEW40pSW+0acMygpqy6YVFdXJhspiKNIAqEDaz6D4dw/z8tjs5
	 esfXAurrk7sUS0CvoqPOz7s1U89xOchRQwV6RAiXyTJAaljw3FPE1rltBjEerKRhFz
	 /W7ro90JwsAnD9CwleJDCtwLQq9XdhaNcNN5SLvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbfLPSVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbfLPSVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:21:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1AD206EC;
        Mon, 16 Dec 2019 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520475;
        bh=D4XvgHEeCS0KzbBgydQLZIYD/5a0d+mwsPG0HseOUWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3LGvuYstDHlk5gzk1xYIutaajFH1+c4ISw4/cVQSSu/tJtigYBVjwAddhI2AijM8
         hpCLFvulL+a0SDTU/Bn7gx/Km8mfSdaG9/EhW4RVrlXoBB+KtIXAf5qjb8OC/Y0O+J
         Pji5bvmT8lXwUl+shp05ra1ICphp1BUZxtYKSZag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.4 168/177] firmware: qcom: scm: Ensure a0 status code is treated as signed
Date:   Mon, 16 Dec 2019 18:50:24 +0100
Message-Id: <20191216174850.054624167@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit ff34f3cce278a0982a7b66b1afaed6295141b1fc upstream.

The 'a0' member of 'struct arm_smccc_res' is declared as 'unsigned long',
however the Qualcomm SCM firmware interface driver expects to receive
negative error codes via this field, so ensure that it's cast to 'long'
before comparing to see if it is less than 0.

Cc: <stable@vger.kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/qcom_scm-64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -150,7 +150,7 @@ static int qcom_scm_call(struct device *
 		kfree(args_virt);
 	}
 
-	if (res->a0 < 0)
+	if ((long)res->a0 < 0)
 		return qcom_scm_remap_error(res->a0);
 
 	return 0;


