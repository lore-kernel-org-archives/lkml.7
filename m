Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8128C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE992054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257367;
	bh=+dvrYU9VdQ8+YCfrgGpKstgi2QgdEJ3LMFY2aLmB1G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o0VDcolwX8FFFmGau5Cf8NF/sF/7FOhwyeYR5XbaFgxqr8wOYCt24ppUi7b71mkbo
	 7J8NX/hpiPb10oxk4y+UCV1tvtdAANAcBufhnnmTEUpCD2RgI/x7u22Dj7JQYCdQsd
	 xaoDxKk/NIdJLFUCTGFahJkKIrn609lNkJtmCYfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391058AbfCVMWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391047AbfCVMWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888022054F;
        Fri, 22 Mar 2019 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257363;
        bh=+dvrYU9VdQ8+YCfrgGpKstgi2QgdEJ3LMFY2aLmB1G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNSEGOgiwCmQlmGgRIIrW09KkeFcWZ6WaJVOQrup+Z8QWVzfaKatuOJ9mCyguLKOR
         +Pcrw3L1w85K5K7XDXy4rAZTH2HH3w5qjigKMBccktmjyh2xJEhucviQm0D9JRrutQ
         6P06tiKVZQzI5kacNhq6cS94rv5MDhu53yLxmoO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH 5.0 210/238] tpm: Unify the send callback behaviour
Date:   Fri, 22 Mar 2019 12:17:09 +0100
Message-Id: <20190322111310.644846037@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

commit f5595f5baa30e009bf54d0d7653a9a0cc465be60 upstream.

The send() callback should never return length as it does not in every
driver except tpm_crb in the success case. The reason is that the main
transmit functionality only cares about whether the transmit was
successful or not and ignores the count completely.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/st33zp24/st33zp24.c |    2 +-
 drivers/char/tpm/tpm-interface.c     |   11 ++++++++++-
 drivers/char/tpm/tpm_atmel.c         |    2 +-
 drivers/char/tpm/tpm_i2c_atmel.c     |    6 +++++-
 drivers/char/tpm/tpm_i2c_infineon.c  |    2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |    2 +-
 drivers/char/tpm/tpm_ibmvtpm.c       |    8 ++++----
 drivers/char/tpm/tpm_infineon.c      |    2 +-
 drivers/char/tpm/tpm_nsc.c           |    2 +-
 drivers/char/tpm/tpm_tis_core.c      |    2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c    |    3 +--
 drivers/char/tpm/xen-tpmfront.c      |    2 +-
 12 files changed, 28 insertions(+), 16 deletions(-)

--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -436,7 +436,7 @@ static int st33zp24_send(struct tpm_chip
 			goto out_err;
 	}
 
-	return len;
+	return 0;
 out_err:
 	st33zp24_cancel(chip);
 	release_locality(chip);
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -230,10 +230,19 @@ static ssize_t tpm_try_transmit(struct t
 	if (rc < 0) {
 		if (rc != -EPIPE)
 			dev_err(&chip->dev,
-				"%s: tpm_send: error %d\n", __func__, rc);
+				"%s: send(): error %d\n", __func__, rc);
 		goto out;
 	}
 
+	/* A sanity check. send() should just return zero on success e.g.
+	 * not the command length.
+	 */
+	if (rc > 0) {
+		dev_warn(&chip->dev,
+			 "%s: send(): invalid value %d\n", __func__, rc);
+		rc = 0;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		goto out_recv;
 
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -105,7 +105,7 @@ static int tpm_atml_send(struct tpm_chip
 		iowrite8(buf[i], priv->iobase);
 	}
 
-	return count;
+	return 0;
 }
 
 static void tpm_atml_cancel(struct tpm_chip *chip)
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -65,7 +65,11 @@ static int i2c_atmel_send(struct tpm_chi
 	dev_dbg(&chip->dev,
 		"%s(buf=%*ph len=%0zx) -> sts=%d\n", __func__,
 		(int)min_t(size_t, 64, len), buf, len, status);
-	return status;
+
+	if (status < 0)
+		return status;
+
+	return 0;
 }
 
 static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -587,7 +587,7 @@ static int tpm_tis_i2c_send(struct tpm_c
 	/* go and do it */
 	iic_tpm_write(TPM_STS(tpm_dev.locality), &sts, 1);
 
-	return len;
+	return 0;
 out_err:
 	tpm_tis_i2c_ready(chip);
 	/* The TPM needs some time to clean up here,
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -467,7 +467,7 @@ static int i2c_nuvoton_send(struct tpm_c
 	}
 
 	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
-	return len;
+	return 0;
 }
 
 static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -139,14 +139,14 @@ static int tpm_ibmvtpm_recv(struct tpm_c
 }
 
 /**
- * tpm_ibmvtpm_send - Send tpm request
- *
+ * tpm_ibmvtpm_send() - Send a TPM command
  * @chip:	tpm chip struct
  * @buf:	buffer contains data to send
  * @count:	size of buffer
  *
  * Return:
- *	Number of bytes sent or < 0 on error.
+ *   0 on success,
+ *   -errno on error
  */
 static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
@@ -192,7 +192,7 @@ static int tpm_ibmvtpm_send(struct tpm_c
 		rc = 0;
 		ibmvtpm->tpm_processing_cmd = false;
 	} else
-		rc = count;
+		rc = 0;
 
 	spin_unlock(&ibmvtpm->rtce_lock);
 	return rc;
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -354,7 +354,7 @@ static int tpm_inf_send(struct tpm_chip
 	for (i = 0; i < count; i++) {
 		wait_and_send(chip, buf[i]);
 	}
-	return count;
+	return 0;
 }
 
 static void tpm_inf_cancel(struct tpm_chip *chip)
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -226,7 +226,7 @@ static int tpm_nsc_send(struct tpm_chip
 	}
 	outb(NSC_COMMAND_EOC, priv->base + NSC_COMMAND);
 
-	return count;
+	return 0;
 }
 
 static void tpm_nsc_cancel(struct tpm_chip *chip)
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -481,7 +481,7 @@ static int tpm_tis_send_main(struct tpm_
 			goto out_err;
 		}
 	}
-	return len;
+	return 0;
 out_err:
 	tpm_tis_ready(chip);
 	return rc;
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -335,7 +335,6 @@ static int vtpm_proxy_is_driver_command(
 static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
-	int rc = 0;
 
 	if (count > sizeof(proxy_dev->buffer)) {
 		dev_err(&chip->dev,
@@ -366,7 +365,7 @@ static int vtpm_proxy_tpm_op_send(struct
 
 	wake_up_interruptible(&proxy_dev->wq);
 
-	return rc;
+	return 0;
 }
 
 static void vtpm_proxy_tpm_op_cancel(struct tpm_chip *chip)
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -173,7 +173,7 @@ static int vtpm_send(struct tpm_chip *ch
 		return -ETIME;
 	}
 
-	return count;
+	return 0;
 }
 
 static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)


