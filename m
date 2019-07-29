Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786C9C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418AE2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428596;
	bh=kmZ8SCMy3V/pCmyfialFvVI13iYmV8PUXdgOiXJ6ZMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYpL1BvfbXJcAU4cO6beTbzZbx4raytDi0RhQLoPYOXNoCnyHjIcDowa4lpuNQ8wW
	 FinMjl2DEw5Q92IJUotwd0hPAQK5s9IEbgcd0INrGzb3tv/fSS7QU6tbDTEee4rd4S
	 vxRZ9kAbDNM+K0BlB/9HR4m9HlhPirQvuhALdCIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfG2T3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbfG2T3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:29:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4516E21655;
        Mon, 29 Jul 2019 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428593;
        bh=kmZ8SCMy3V/pCmyfialFvVI13iYmV8PUXdgOiXJ6ZMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6wPkGdzDEEsmeQKG1kg/0Mc2/NRTcrvND5qDucfjr0B2WWrzGgtM5i8vfql4KiQj
         +HCoq4cgIITAOVb+H+8c65Fbeopet1TNrmPomudwAmq1bNjTDXOVNen0LngsxwRF78
         NBFV7pEelJKac23MyDUUZFiub6bxzyEII+nBP8Qc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        Gary R Hook <ghook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 125/293] crypto: ccp/gcm - use const time tag comparison.
Date:   Mon, 29 Jul 2019 21:20:16 +0200
Message-Id: <20190729190834.164865318@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cfir Cohen <cfir@google.com>

commit 538a5a072e6ef04377b180ee9b3ce5bae0a85da4 upstream.

Avoid leaking GCM tag through timing side channel.

Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Cfir Cohen <cfir@google.com>
Acked-by: Gary R Hook <ghook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-ops.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -832,7 +832,8 @@ static int ccp_run_aes_gcm_cmd(struct cc
 			goto e_tag;
 		ccp_set_dm_area(&tag, 0, p_tag, 0, AES_BLOCK_SIZE);
 
-		ret = memcmp(tag.address, final_wa.address, AES_BLOCK_SIZE);
+		ret = crypto_memneq(tag.address, final_wa.address,
+				    AES_BLOCK_SIZE) ? -EBADMSG : 0;
 		ccp_dm_free(&tag);
 	}
 


