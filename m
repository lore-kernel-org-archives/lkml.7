Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C455C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B023400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495629;
	bh=H4Rj6tTPIzPoLVGEq5y6QZ/GhwVjv6rZLX6w8eMJ3r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2eiDHEwMPXPLzVCJUaRmTdEL12xQcNB2RLb04Imrww0d5lLVaF1P/FEon8+M9fJF
	 hXan3t1PsJ6BGYLNBD4XZH8kWICzK5LeR+IHbrSFjvpad2rPcfpF2RWbZYjjetVVGC
	 e953QrgIs6S9TBm1eUz6Nm/qTesAiZTOkHwCzZHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392470AbfHVRk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404075AbfHVRYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:07 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA5C023406;
        Thu, 22 Aug 2019 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494646;
        bh=H4Rj6tTPIzPoLVGEq5y6QZ/GhwVjv6rZLX6w8eMJ3r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcYs8FxrvjgVj6BhTP3HtQwAS8ufap6t8WlnPNVC9UAtKPg2+W6PCFewmw8aJCNNs
         z9lXHc1jTXR7kwZ59S1KKejLQvFbrGKzHtpFv3N4jTRLQoG3QVrwFxo6WrZYeiA7KU
         5+esTXFb53x91NIpPn4FpC5kc6BKrzS7m7uJVaEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 040/103] iwlwifi: dont unmap as page memory that was mapped as single
Date:   Thu, 22 Aug 2019 10:18:28 -0700
Message-Id: <20190822171730.425398224@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
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
@@ -439,6 +439,8 @@ static void iwl_pcie_tfd_unmap(struct iw
 					 DMA_TO_DEVICE);
 	}
 
+	meta->tbs = 0;
+
 	if (trans->cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
 


