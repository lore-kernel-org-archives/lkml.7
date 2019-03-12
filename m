Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410696;
	bh=+Fm2dvIz/8hp6dLpXMH5RvWHrZTlAf8ECAbqeAIi7Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YZCtgHdootE651oH84hRxQov6WC8l/Qnm1ihsK2bDTHoUz0w8D7jRGf4+H1MWIPFi
	 2+pIHkWTMCGQ+j73P336wdXr+T7GCTelPa7+enN3Imh+Q/OlftEf5FYEQUm2Uq8ZyO
	 7XBe95xCRJdoY0KKUTXZrr4bjNBBW13uS+2igMDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfCLRLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfCLRL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:29 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE15F214AE;
        Tue, 12 Mar 2019 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410688;
        bh=+Fm2dvIz/8hp6dLpXMH5RvWHrZTlAf8ECAbqeAIi7Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCcAi5TCloFvExR8sb1olfIeYtvvjNX6JrDiO3i7J90GN9BvtxO/AHVi89u3jE9FY
         9kIldGfZw/43fPCH+30IVhl3derTLC2YTvqAt7L3oXO2jJPPD919Xm6IRgpeKxfUFk
         Y5koO/O2BrNZ6RAkVNf8A5Bm4ZtGo3OwI+2bZmuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 5.0 04/25] iscsi_ibft: Fix missing break in switch statement
Date:   Tue, 12 Mar 2019 10:08:42 -0700
Message-Id: <20190312170403.911721947@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit df997abeebadaa4824271009e2d2b526a70a11cb upstream.

Add missing break statement in order to prevent the code from falling
through to case ISCSI_BOOT_TGT_NAME, which is unnecessary.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: b33a84a38477 ("ibft: convert iscsi_ibft module to iscsi boot lib")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/iscsi_ibft.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -542,6 +542,7 @@ static umode_t __init ibft_check_tgt_for
 	case ISCSI_BOOT_TGT_NIC_ASSOC:
 	case ISCSI_BOOT_TGT_CHAP_TYPE:
 		rc = S_IRUGO;
+		break;
 	case ISCSI_BOOT_TGT_NAME:
 		if (tgt->tgt_name_len)
 			rc = S_IRUGO;


