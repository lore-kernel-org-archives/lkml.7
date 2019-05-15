Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897DAC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380F206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922480;
	bh=cojdEcKVyMFsp3ri+D74PvTZpIkZ3NN4+MtpwMSOhjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s4P0FopIa8rHWp7a6W3nWt8UCluEtQuKtDjZ6K3fWwnQiz1kuO/ax3DxDtLUnRKGW
	 pQHbO9Ha5AkzMq7V/cteOtRfKeHWhujAbyGiFmbM2Km4dbER5YpdUIdpqk+tzJAWBr
	 RdrGbew67S4i/+XNuaEIosApbQy6IWNhR/n4Nr6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfEOMOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfEOLEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:04:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6B12084F;
        Wed, 15 May 2019 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918253;
        bh=cojdEcKVyMFsp3ri+D74PvTZpIkZ3NN4+MtpwMSOhjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZukzLAp854AjRMkqnKM8CM+SKxCbqQpFPxyszxECzVM5bJcERHogfzDzOlnwkmrV
         kF1vqYdk1bGDqAYWf/ovJIsgYbxwrM5ab4xnnphYnGooyJDHrjvwCYCATRREUA9tga
         G7zblCrFBL4GsePvEb+dhj6tfQrTGBoTLYoGBjyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 062/266] powerpc/fsl: Update Spectre v2 reporting
Date:   Wed, 15 May 2019 12:52:49 +0200
Message-Id: <20190515090724.537118336@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@nxp.com>

commit dfa88658fb0583abb92e062c7a9cd5a5b94f2a46 upstream.

Report branch predictor state flush as a mitigation for
Spectre variant 2.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -213,8 +213,11 @@ ssize_t cpu_show_spectre_v2(struct devic
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
 			seq_buf_printf(&s, "(hardware accelerated)");
-	} else
+	} else if (btb_flush_enabled) {
+		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+	} else {
 		seq_buf_printf(&s, "Vulnerable");
+	}
 
 	seq_buf_printf(&s, "\n");
 


