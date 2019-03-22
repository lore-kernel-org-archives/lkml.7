Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C50EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DCD21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255695;
	bh=qwV1H9GlxX4/W8hiEqdbYRzOcH9r99BXRC8tI1KBc6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TqvyxxtfMTH/AuUzH8B5QwsveC1SdC/ir37otelDrSHtoBxEP5V41uguRxF/GBmF1
	 umz+J7dOybCBrIS4dWQ79LuPanTAEdLNqY7TlW9BmuNwQWewYfsUzg4BdE8ic8ZLzP
	 F0OBMIR1gPrQdId4dCzc87Ty04eRiAitIccikYAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfCVLyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732725AbfCVLyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A3E62192B;
        Fri, 22 Mar 2019 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255688;
        bh=qwV1H9GlxX4/W8hiEqdbYRzOcH9r99BXRC8tI1KBc6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7OTMbKi+rbUS+6QnEGk2OjcQf5ttqUsC3kmeIbXbvHbVB4qT4RU3iChkwMqHX9+1
         /P61ab+0c60M6zwfovQv/hmkc/O/UZ/3rfX+ks7eCw1/FQPFwErixL0aCszUcza/1z
         VMOVQU4VWlLdqlMcBPe6WkUtbasyh0tINUMackE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 168/183] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Date:   Fri, 22 Mar 2019 12:16:36 +0100
Message-Id: <20190322111254.068617618@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

commit 3d7a850fdc1a2e4d2adbc95cc0fc962974725e88 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_crb.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -288,19 +288,29 @@ static int crb_recv(struct tpm_chip *chi
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
 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
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


