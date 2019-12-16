Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81748C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE0921582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519270;
	bh=i5XtLVMmI+2dJcN0KwB7A+BvEXbQvtvFuu2za7XVIY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1hPjoKR/LA22NLPvvj/pjxMrlBB2n8Ch+WFtEqParaD+gefR8RWqK4oTqU+0Id3L
	 wNHw0AKBd5X9sVighU/t6lknhtsp5NPFTcTehJsbGq7KYaJZwMMWCh+ngwxiX17smX
	 8+UDg3vn3wXQsSBqArrwTwSP70tlhg+LaqENNSVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfLPSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbfLPSBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:01:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9622206B7;
        Mon, 16 Dec 2019 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519265;
        bh=i5XtLVMmI+2dJcN0KwB7A+BvEXbQvtvFuu2za7XVIY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzXn33OydXPL9nArm/C2siV3VEDZ4Dm7gp0BGBYanXTorMm9OoY6ogHrQ8rTu8ZHj
         hs8jJzcdmSlplLE5X1P/qBaORAYzPrLFzgjlRA+dKqVazV3cZH5LfIE0hsLxoLHDoB
         oFgCi64K7Fy4GiVYylrYi+fCVoJ4hCZZlXCsNfFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.14 262/267] firmware: qcom: scm: Ensure a0 status code is treated as signed
Date:   Mon, 16 Dec 2019 18:49:48 +0100
Message-Id: <20191216174917.142951136@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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


