Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10849C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43E621851
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803158;
	bh=LKkqE582/S6sATCM3lFIxeJcT/BwhZU8XuQuYvGVD4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAigblspnZLpII1d8Ip4TzFGQv7eXDYPwDoEmXSs4ieOLrF9pu5jUq+c3CzB1vS2g
	 WSanF/Ajk3ZY51YKA9J90v5PKuNTWS4QFFJnqiK6FckjbDI7SOG+lDGaXfDUpWLDOs
	 Z8GVE1eR0F8p0eOdBHxBDCaGncwPGK8/3qXfawq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfHNRTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbfHNRLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:11:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08622063F;
        Wed, 14 Aug 2019 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802713;
        bh=LKkqE582/S6sATCM3lFIxeJcT/BwhZU8XuQuYvGVD4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIG2V2QMifbgg7ln2rJ/L9sHm91xbl/grrjcJg9a0NGiyL3gXndHPazEpPu50yjUT
         71oXDfwr252ifd8hel1Vl/kSzTFmLTUKr/7+X3MgaB23Ucz353b1M1p4Nqs9lXfE+9
         kr+RtiOUy2oS9gbsnkxjv7FDjOfYXrDU7Qj0D9zA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 88/91] iwlwifi: dont unmap as page memory that was mapped as single
Date:   Wed, 14 Aug 2019 19:01:51 +0200
Message-Id: <20190814165753.938454228@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 87e7e25aee6b59fef740856f4e86d4b60496c9e1 upstream.

In order to remember how to unmap a memory (as single or
as page), we maintain a bit per Transmit Buffer (TBs) in
the meta data (structure iwl_cmd_meta).
We maintain a bitmap: 1 bit per TB.
If the TB is set, we will free the memory as a page.
This bitmap was never cleared. Fix this.

Cc: stable@vger.kernel.org
Fixes: 3cd1980b0cdf ("iwlwifi: pcie: introduce new tfd and tb formats")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -403,6 +403,8 @@ static void iwl_pcie_tfd_unmap(struct iw
 					 DMA_TO_DEVICE);
 	}
 
+	meta->tbs = 0;
+
 	if (trans->cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
 


