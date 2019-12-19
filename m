Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53645C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782144;
	bh=i5XtLVMmI+2dJcN0KwB7A+BvEXbQvtvFuu2za7XVIY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RhAtCtKYfMYuDUciglFTMQpd5qdjhp2rG9zq1E8ua+gOtuyoZgt8DtsgeqaFXm8Jn
	 znyx5Dxd8V2STeQC8LhEcvOwk1nUbNi8MQlhPS0h5vFmXg6h7o5BsYYGfCVQ9laSbf
	 iwVdU/xCwxC12lGRGa5clEuvXev3f7d7famQ591E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfLSSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfLSStc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B63C24684;
        Thu, 19 Dec 2019 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781371;
        bh=i5XtLVMmI+2dJcN0KwB7A+BvEXbQvtvFuu2za7XVIY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHoJmzx8qKJ6/9ni0BTvpw5SVKoABdRVu6uDiCBla2ZKjLHzPcuEgvVRim6wplzHy
         Ei+xx21PXhPgGZ9sz+tRfJxiTUAWfl72/AZ4cQjIyTWxV/S+DqYjZ3O0JPwgoKSbmO
         CRJM+VOdnf+y7CdviAT2+l9QXZY8Oy2hQizxUJqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.9 167/199] firmware: qcom: scm: Ensure a0 status code is treated as signed
Date:   Thu, 19 Dec 2019 19:34:09 +0100
Message-Id: <20191219183224.710329574@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
@@ -158,7 +158,7 @@ static int qcom_scm_call(struct device *
 		kfree(args_virt);
 	}
 
-	if (res->a0 < 0)
+	if ((long)res->a0 < 0)
 		return qcom_scm_remap_error(res->a0);
 
 	return 0;


