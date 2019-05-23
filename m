Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6110C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0882186A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639467;
	bh=DJK/MLF8I8/9SV0MixHGtroPi+wrkXjpjj37u+nsvLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r2q/+/hMDCIqHW2Edxg6RBfja+K3Gbm5ad+5334WjAtUfBx9hror3GkaQUBdvqWCb
	 DrKUOVFcMpcKLY69uKGDCTdIfTQb/9Rqh1LLWWRDQCvPF4kfGb7BnfyS478QRgL6AC
	 0AWYsbbiWpIYeYyz/n789PeXR5ooD5xcI0xwTSZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390902AbfEWTY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390868AbfEWTYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:24:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A49921851;
        Thu, 23 May 2019 19:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639460;
        bh=DJK/MLF8I8/9SV0MixHGtroPi+wrkXjpjj37u+nsvLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDcuIiz8sMFUWTRpaNdHSQf5TF2PCY3H0qlcNKEz/7CKIecIhirBuqfw52AWiKtqY
         RTcYTFfAA/qoOFpQSsuVfhKteKsClsuQf0JrxndP4SEPe3xnHLZC7o/y2Cn2LiSeNj
         JBXtAWSpYlIelSVdKiobk5EHaklQqCzIH4HMqSMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.0 096/139] dm crypt: move detailed message into debug level
Date:   Thu, 23 May 2019 21:06:24 +0200
Message-Id: <20190523181733.086735055@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <gmazyland@gmail.com>

commit 7a1cd7238fde6ab367384a4a2998cba48330c398 upstream.

The information about tag size should not be printed without debug info
set. Also print device major:minor in the error message to identify the
device instance.

Also use rate limiting and debug level for info about used crypto API
implementaton.  This is important because during online reencryption
the existing message saturates syslog (because we are moving hotzone
across the whole device).

Cc: stable@vger.kernel.org
Signed-off-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -949,6 +949,7 @@ static int crypt_integrity_ctr(struct cr
 {
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	struct blk_integrity *bi = blk_get_integrity(cc->dev->bdev->bd_disk);
+	struct mapped_device *md = dm_table_get_md(ti->table);
 
 	/* From now we require underlying device with our integrity profile */
 	if (!bi || strcasecmp(bi->profile->name, "DM-DIF-EXT-TAG")) {
@@ -968,7 +969,7 @@ static int crypt_integrity_ctr(struct cr
 
 	if (crypt_integrity_aead(cc)) {
 		cc->integrity_tag_size = cc->on_disk_tag_size - cc->integrity_iv_size;
-		DMINFO("Integrity AEAD, tag size %u, IV size %u.",
+		DMDEBUG("%s: Integrity AEAD, tag size %u, IV size %u.", dm_device_name(md),
 		       cc->integrity_tag_size, cc->integrity_iv_size);
 
 		if (crypto_aead_setauthsize(any_tfm_aead(cc), cc->integrity_tag_size)) {
@@ -976,7 +977,7 @@ static int crypt_integrity_ctr(struct cr
 			return -EINVAL;
 		}
 	} else if (cc->integrity_iv_size)
-		DMINFO("Additional per-sector space %u bytes for IV.",
+		DMDEBUG("%s: Additional per-sector space %u bytes for IV.", dm_device_name(md),
 		       cc->integrity_iv_size);
 
 	if ((cc->integrity_tag_size + cc->integrity_iv_size) != bi->tag_size) {
@@ -1890,7 +1891,7 @@ static int crypt_alloc_tfms_skcipher(str
 	 * algorithm implementation is used.  Help people debug performance
 	 * problems by logging the ->cra_driver_name.
 	 */
-	DMINFO("%s using implementation \"%s\"", ciphermode,
+	DMDEBUG_LIMIT("%s using implementation \"%s\"", ciphermode,
 	       crypto_skcipher_alg(any_tfm(cc))->base.cra_driver_name);
 	return 0;
 }
@@ -1910,7 +1911,7 @@ static int crypt_alloc_tfms_aead(struct
 		return err;
 	}
 
-	DMINFO("%s using implementation \"%s\"", ciphermode,
+	DMDEBUG_LIMIT("%s using implementation \"%s\"", ciphermode,
 	       crypto_aead_alg(any_tfm_aead(cc))->base.cra_driver_name);
 	return 0;
 }


