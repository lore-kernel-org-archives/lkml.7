Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5D3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E30221904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126623;
	bh=W8PA7G67EKpIwSMFaf1nl2TzFPpjhfgJa2l3PbalPiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0nr8v3PbMB0ECelgnKnWXV7peLNAJHzm+mf/7WvQBGXG8xg7GVteQ/SNS3SX119MN
	 vYxU9f5up8W3ElC58m7jnBk0Xln8w0tNiXODhyLO9WdjRgh4BjVVCfSbVVh6gx0eyb
	 u1pgfFC4JjpAtwYYzU7CanpCypJGAV3x/jJ8mdSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbfDXRXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbfDXRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C8E21904;
        Wed, 24 Apr 2019 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126617;
        bh=W8PA7G67EKpIwSMFaf1nl2TzFPpjhfgJa2l3PbalPiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgmRs1VQkTgCFXn1o5eg+3J74TOA1RHqxnuQdPgLRr2Kr5gqWOIm6hEoSLNN3ksWU
         ZtVRISlHtWANDb/96rTJGr6N0dsMg+Mze9ZPjdrorrVGtPFEg3zpE9xBD9qcu15Aj6
         SOFbqBHHlODy5bOK5+YkzwSXz07TKmSzze8kRpdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 147/168] tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
Date:   Wed, 24 Apr 2019 19:09:51 +0200
Message-Id: <20190424170931.903594210@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
index dd8f0eb3170a..73f7e0f7e34a 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -65,7 +65,15 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	dev_dbg(&chip->dev,
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



