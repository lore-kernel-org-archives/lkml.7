Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E83205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413531;
	bh=mBox29ZS+KeRX3W+894sJ9H+K2crJMPQIhX8PNVcFXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3YBOM/e33FAWLZ4AT+cgniWQWQTw0ReAGrRIz12gfUveZoP+nwcNVdYjB4/FTRMg
	 4UyjwHSb9rNKwmHyftdkaT6zGMgxPfBIMsTJm3BLrtDG4iK8JTEur4r87Fb2/tZ0cI
	 /+A5zh2ce8wV/ZiXzY0pusZDQ54JZOCknGqs2EqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfCLR6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfCLRNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:39 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96F02184E;
        Tue, 12 Mar 2019 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410818;
        bh=mBox29ZS+KeRX3W+894sJ9H+K2crJMPQIhX8PNVcFXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LC994rmcOZhyhaoiiPDDRS4FH8sMa19emDrIhy5XzCPhOwSRPJNqbpOHwAnlub2MQ
         zuecxZzk4Z9eRLgddsQNpncxuZkBc5vujbMjA+WujpIBkogp7pSreOcyNCa3+Y+Q/h
         5jdtloqDwLWTfXRhgNAi2dfQ6MVJD0sGROoAwCD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.20 151/171] iscsi_ibft: Fix missing break in switch statement
Date:   Tue, 12 Mar 2019 10:08:51 -0700
Message-Id: <20190312170400.537118906@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


