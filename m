Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB8AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFCC20675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127480;
	bh=Z38Q4RplQPvZdRj9T13BK59Dr2zpud/8AU35EjdsxFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u0R9tl9CD9qzJVPuGDqVfh9rBrcJsJ1vMriuKyr93UJ0MOpnOeetxUR7eeVdaNaMb
	 jgN0Qc1b3/0Y1ULC0rZG0jCdyDrGZ/DlW4D+9ANpwp4Ryk8cTJHDV1x4IBUEo2oWR0
	 X5VBEOLWEla+dFBpBbGEOeGEemYkOfVMz6Smtupc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfDXRh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392294AbfDXRhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2562054F;
        Wed, 24 Apr 2019 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127474;
        bh=Z38Q4RplQPvZdRj9T13BK59Dr2zpud/8AU35EjdsxFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1DJ3Km9n5eNvBcWVc/gW10vt9JQ/La4Bmh0wzVS5TMGggpmx1QEemVl4Hh3E8uy1
         UaZx0M6H5P1EUyWLg9RDN3AxvKfbKTlWETtNWQCeaNyCMo7PYTEf+q5LB4UKuKVSko
         vJYD6wdaYsoNUt/35QU1DmF9ItZG44gdwDKZZ94o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 104/115] tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
Date:   Wed, 24 Apr 2019 19:10:40 +0200
Message-Id: <20190424170930.802843924@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 442601e87a4769a8daba4976ec3afa5222ca211d ]

Return -E2BIG when the transfer is incomplete. The upper layer does
not retry, so not doing that is incorrect behaviour.

Cc: stable@vger.kernel.org
Fixes: a2871c62e186 ("tpm: Add support for Atmel I2C TPMs")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_i2c_atmel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 32a8e27c5382..cc4e642d3180 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -69,6 +69,10 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	if (status < 0)
 		return status;
 
+	/* The upper layer does not support incomplete sends. */
+	if (status != len)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.19.1



