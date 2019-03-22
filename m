Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B91C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456F220850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255457;
	bh=bcV6Xfx1q3NRzH6cEqe2gzmO0p7bpEcf+yFC3U9k5RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WlbCRCMBT8zeIEbIHcmKTmtaTOy57lQPK0yI8Hi/GajcBMuTMNurIl3B0mg9u7D7l
	 IeCQa1Zdb//Y4PlXvUjz+gpH7jby02ud5FnxN6PhAVrSdg5+4BQqZfYPzpZ4NtvEUq
	 K4feFZ7+VX2KN77cKnpeaJW65fgFZ6Q4FW2zot1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfCVLuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbfCVLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95BE2082C;
        Fri, 22 Mar 2019 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255452;
        bh=bcV6Xfx1q3NRzH6cEqe2gzmO0p7bpEcf+yFC3U9k5RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzvP32pwPd6KjmM6fyaUoEHaT+hUdvmjYSnMZ/8XbnpkKYOIoZvyRBzVaQd+iFNQX
         4W7ysTyEDkqcaHgeygezVamYlgr+5BPgfFOMpamlWzLN225aJLnabN/V1BKpiygUV7
         TgHhNBRLWqwVP5Qaye5YfbkP3/VLXHe9Bg0fCHXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 077/183] crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling
Date:   Fri, 22 Mar 2019 12:15:05 +0100
Message-Id: <20190322111247.308821064@linuxfoundation.org>
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit eaf46edf6ea89675bd36245369c8de5063a0272c upstream.

The NEON MAC calculation routine fails to handle the case correctly
where there is some data in the buffer, and the input fills it up
exactly. In this case, we enter the loop at the end with w8 == 0,
while a negative value is assumed, and so the loop carries on until
the increment of the 32-bit counter wraps around, which is quite
obviously wrong.

So omit the loop altogether in this case, and exit right away.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: a3fd82105b9d1 ("arm64/crypto: AES in CCM mode using ARMv8 Crypto ...")
Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/aes-ce-ccm-core.S |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/crypto/aes-ce-ccm-core.S
+++ b/arch/arm64/crypto/aes-ce-ccm-core.S
@@ -74,12 +74,13 @@ ENTRY(ce_aes_ccm_auth_data)
 	beq	10f
 	ext	v0.16b, v0.16b, v0.16b, #1	/* rotate out the mac bytes */
 	b	7b
-8:	mov	w7, w8
+8:	cbz	w8, 91f
+	mov	w7, w8
 	add	w8, w8, #16
 9:	ext	v1.16b, v1.16b, v1.16b, #1
 	adds	w7, w7, #1
 	bne	9b
-	eor	v0.16b, v0.16b, v1.16b
+91:	eor	v0.16b, v0.16b, v1.16b
 	st1	{v0.16b}, [x0]
 10:	str	w8, [x3]
 	ret


