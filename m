Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA85C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CF421900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126089;
	bh=E5VgPwQf/BXx3c/AFb0hdG4Bbg5q/LJAYvA2TINy27k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jGbH3HOFQ1gS69Ydm4hx6CdGp85D3e2UXdXgQq+4UgmjL1Hfpm+wn4XrL27I121AT
	 Zil2DyzXCsJC8xlJxZTwqdq13TIATuk+pbWTkqUsOD4dqNuh/hHirDFNg5CQxSHndE
	 1/wEIe0BjQWq732PJXrC6pY/Gth4LWnWIROSdkjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfDXROs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388108AbfDXROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:44 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF71206BA;
        Wed, 24 Apr 2019 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126083;
        bh=E5VgPwQf/BXx3c/AFb0hdG4Bbg5q/LJAYvA2TINy27k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BttJ2DVhRD+yPiQptstlmOIV9RBj/7vy6zh1dFgCXELphfLF/0mTOKvp3tJGmTNdb
         G16rV6j6wfxjLajasWb6U+jvIUhIO+zALIkbVoQ5YKs5+2Bv2291+sjuw/U7npHxrk
         N0fBR8Jx7A+gUJszhngby7CgcOqg6Ip2tXiuhxqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 089/104] tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
Date:   Wed, 24 Apr 2019 19:09:46 +0200
Message-Id: <20190424170908.975484628@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 442601e87a4769a8daba4976ec3afa5222ca211d upstream

Return -E2BIG when the transfer is incomplete. The upper layer does
not retry, so not doing that is incorrect behaviour.

Cc: stable@vger.kernel.org
Fixes: a2871c62e186 ("tpm: Add support for Atmel I2C TPMs")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_i2c_atmel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 503a85ae176c..0ea430cc606f 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -65,7 +65,15 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	dev_dbg(chip->dev,
 		"%s(buf=%*ph len=%0zx) -> sts=%d\n", __func__,
 		(int)min_t(size_t, 64, len), buf, len, status);
-	return status;
+
+	if (status < 0)
+		return status;
+
+	/* The upper layer does not support incomplete sends. */
+	if (status != len)
+		return -E2BIG;
+
+	return 0;
 }
 
 static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-- 
2.19.1



