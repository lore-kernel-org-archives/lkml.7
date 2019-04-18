Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F8C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1C21871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610943;
	bh=mQ2b/31a81MGavEgJgBk0I+S/AhGwY0H5szIEEgdydk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L5TilytrRx8JfBwD6huOJN94IqfqQrN+5ioMzuI4q8Ver4/gmx5IyXdiDPOQVMEsR
	 H5Bm1VjPQ8kPIkbSFlCTCLa/51pp5JXbJpxjE/uYknT1g94/GIalbDFKerSnisSP6B
	 LEim0qK35yLIdQU4m9FgNQj6pzDiNhDdLtf/w50Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfDRSJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391339AbfDRSJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA712186A;
        Thu, 18 Apr 2019 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610938;
        bh=mQ2b/31a81MGavEgJgBk0I+S/AhGwY0H5szIEEgdydk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJX3jUYoRg3ESuPOI5NGzjLm/5+QaZFKB0eSUlG/PkK2BSg77HfbqSO66/vHO7Sba
         xO5pELTAkkGwC3QmeZF1uo0TE/WITOj9ho78N1aBh+Ll0UqduzRNwh0koLHsc5C3cg
         t1mWqPOHmXlbYExA6gSJubxKBahzbtCWnK5CCwng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.9 48/50] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Date:   Thu, 18 Apr 2019 19:57:59 +0200
Message-Id: <20190418160428.166924413@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3d7a850fdc1a2e4d2adbc95cc0fc962974725e88 upstream

The current approach to read first 6 bytes from the response and then tail
of the response, can cause the 2nd memcpy_fromio() to do an unaligned read
(e.g. read 32-bit word from address aligned to a 16-bits), depending on how
memcpy_fromio() is implemented. If this happens, the read will fail and the
memory controller will fill the read with 1's.

This was triggered by 170d13ca3a2f, which should be probably refined to
check and react to the address alignment. Before that commit, on x86
memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
thing (from tpm_crb's perspective) for us so far, but we should not rely on
that. Thus, it makes sense to fix this also in tpm_crb, not least because
the fix can be then backported to stable kernels and make them more robust
when compiled in differing environments.

Cc: stable@vger.kernel.org
Cc: James Morris <jmorris@namei.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index fa0f66809503..d29f78441cdb 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -102,19 +102,29 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	unsigned int expected;
 
-	/* sanity check */
-	if (count < 6)
+	/* A sanity check that the upper layer wants to get at least the header
+	 * as that is the minimum size for any TPM response.
+	 */
+	if (count < TPM_HEADER_SIZE)
 		return -EIO;
 
+	/* If this bit is set, according to the spec, the TPM is in
+	 * unrecoverable condition.
+	 */
 	if (ioread32(&priv->cca->sts) & CRB_CTRL_STS_ERROR)
 		return -EIO;
 
-	memcpy_fromio(buf, priv->rsp, 6);
-	expected = be32_to_cpup((__be32 *) &buf[2]);
-	if (expected > count || expected < 6)
+	/* Read the first 8 bytes in order to get the length of the response.
+	 * We read exactly a quad word in order to make sure that the remaining
+	 * reads will be aligned.
+	 */
+	memcpy_fromio(buf, priv->rsp, 8);
+
+	expected = be32_to_cpup((__be32 *)&buf[2]);
+	if (expected > count || expected < TPM_HEADER_SIZE)
 		return -EIO;
 
-	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
 
 	return expected;
 }
-- 
2.19.1



