Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C38CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7121A222C4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211611;
	bh=ZxgU/YgKJ6fIPV5HOHALJbrAr0Tnr4KLl5w4qmP1CEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J57cNTN4FX3eGeJmi74AO+NsWTedkQgDW/XGwcjeTnnTaDqQXtdh+qu1XDPJQwRLp
	 3IhGnDimiDc5nrp0ilgIUz2EWGh5ZsKPmaN11WZEFPNxNgPCp5MnzI6Jr9GE4ctWAm
	 MhZPjRBuJ8axxtkryAIZrum3+Tjke2C8ohp1fT/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfJ0V0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732841AbfJ0V0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:26:00 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE41B21D80;
        Sun, 27 Oct 2019 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211560;
        bh=ZxgU/YgKJ6fIPV5HOHALJbrAr0Tnr4KLl5w4qmP1CEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqpOG4881ltMl+IxgQxVEtLhVgkpnyjPfy2Mogyh6NaCANHqp0+CPgDn90M8mg+6M
         aMmEZRRB4ZT+7sQPAG82bAiLNTqFHpcvyWlrNBgJlpn1NuxY7y9AfDCRPO78xRl9At
         F/BjKgW26Cj/bOePuxfhuYh7KYXEqpfWVZBGh0UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.3 195/197] of: reserved_mem: add missing of_node_put() for proper ref-counting
Date:   Sun, 27 Oct 2019 22:01:53 +0100
Message-Id: <20191027203407.014246162@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Goldsworthy <cgoldswo@codeaurora.org>

commit 5dba51754b04a941a1064f584e7a7f607df3f9bc upstream.

Commit d698a388146c ("of: reserved-memory: ignore disabled memory-region
nodes") added an early return in of_reserved_mem_device_init_by_idx(), but
didn't call of_node_put() on a device_node whose ref-count was incremented
in the call to of_parse_phandle() preceding the early exit.

Fixes: d698a388146c ("of: reserved-memory: ignore disabled memory-region nodes")
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: stable@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/of_reserved_mem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -324,8 +324,10 @@ int of_reserved_mem_device_init_by_idx(s
 	if (!target)
 		return -ENODEV;
 
-	if (!of_device_is_available(target))
+	if (!of_device_is_available(target)) {
+		of_node_put(target);
 		return 0;
+	}
 
 	rmem = __find_rmem(target);
 	of_node_put(target);


