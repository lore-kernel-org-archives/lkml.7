Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EBC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BDC20833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482951;
	bh=2HhXux3UgyzTgTzC9CWGxVny0zbkSdgUsNwkVpdPeZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M/DUlg5NPWWR5mi4PaiY6hoYrXHZwf1nn1XanQwlB3/+bOfIyNGFl5TnrUg9ztfJl
	 G9gqnMv7qRzjIPDL+JRSkgHG5Pb+7NkyNTfhf81idyAE9TdTZDP/u8G+qYmSyyftAg
	 3HXG6cJgeGv1vkaTiT68sGhwY4BzyNGBYgyeLOK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfLDSJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730997AbfLDSJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:09:05 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D8920675;
        Wed,  4 Dec 2019 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482945;
        bh=2HhXux3UgyzTgTzC9CWGxVny0zbkSdgUsNwkVpdPeZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nz7sap94DqMNhzcfEZVt+03Rt/HFHE0YitYDO69KD4rLVttNvjax1V2puBVVlceM2
         HR8CD6BpgISqQIvggOI4D0JoVhrqFA8sfOuDR9q/iyzToRYviNgcHriNr3df0vmRsb
         QeCkCSN8fMzDCTpnE5z8KpuSkChKnYYhMg++pGcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lionel Debieve <lionel.debieve@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.14 199/209] crypto: stm32/hash - Fix hmac issue more than 256 bytes
Date:   Wed,  4 Dec 2019 18:56:51 +0100
Message-Id: <20191204175337.184460827@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

commit 0acabecebc912b3ba06289e4ef40476acc499a37 upstream.

Correct condition for the second hmac loop. Key must be only
set in the first loop. Initial condition was wrong,
HMAC_KEY flag was not properly checked.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/stm32/stm32-hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -361,7 +361,7 @@ static int stm32_hash_xmit_cpu(struct st
 		return -ETIMEDOUT;
 
 	if ((hdev->flags & HASH_FLAGS_HMAC) &&
-	    (hdev->flags & ~HASH_FLAGS_HMAC_KEY)) {
+	    (!(hdev->flags & HASH_FLAGS_HMAC_KEY))) {
 		hdev->flags |= HASH_FLAGS_HMAC_KEY;
 		stm32_hash_write_key(hdev);
 		if (stm32_hash_wait_busy(hdev))


