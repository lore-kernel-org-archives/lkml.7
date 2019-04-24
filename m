Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7862C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC592089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128184;
	bh=xVPnCDpvjq+4f8yvQyjOEVXBiQ/TucphsaCudmWFGGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n25La1dIFudGarAUsiq9a2Ge7VA+4KGp934oVclUSLMF7+rMbAuaOOyIKxZkWo3ZT
	 v/RADiiUqrlcPQGV9ge9fcJlkXfkYvAAZJZcnrOGJsVfvmbTPg9b918dv4U+czU1aS
	 2vBYoJng3DGOauEiNr75xUW/yZmCS2pCMD81NnWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391896AbfDXRtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390961AbfDXRaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BC72054F;
        Wed, 24 Apr 2019 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127018;
        bh=xVPnCDpvjq+4f8yvQyjOEVXBiQ/TucphsaCudmWFGGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTnYm+B+p4JBfi7vMU2uJXTk45BkaHwE5Z6esABGXDqx94Ua0TX6EkAGSRSYRBt7T
         VSJVfsXHM12S6R1b8Hepor1Ivr3IQIKq/EDd+kmyxqZ92QFtoweTGwMlDZT6MdNb4y
         OtS2Q7AfgWgzH9QtstaZVhbGKgCYKSVSFv/5Jy30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/96] net: atm: Fix potential Spectre v1 vulnerabilities
Date:   Wed, 24 Apr 2019 19:09:08 +0200
Message-Id: <20190424170920.075980063@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 899537b73557aafbdd11050b501cf54b4f5c45af ]

arg is controlled by user-space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/atm/lec.c:715 lec_mcast_attach() warn: potential spectre issue 'dev_lec' [r] (local cap)

Fix this by sanitizing arg before using it to index dev_lec.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/atm/lec.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -710,7 +710,10 @@ static int lec_vcc_attach(struct atm_vcc
 
 static int lec_mcast_attach(struct atm_vcc *vcc, int arg)
 {
-	if (arg < 0 || arg >= MAX_LEC_ITF || !dev_lec[arg])
+	if (arg < 0 || arg >= MAX_LEC_ITF)
+		return -EINVAL;
+	arg = array_index_nospec(arg, MAX_LEC_ITF);
+	if (!dev_lec[arg])
 		return -EINVAL;
 	vcc->proto_data = dev_lec[arg];
 	return lec_mcast_make(netdev_priv(dev_lec[arg]), vcc);
@@ -728,6 +731,7 @@ static int lecd_attach(struct atm_vcc *v
 		i = arg;
 	if (arg >= MAX_LEC_ITF)
 		return -EINVAL;
+	i = array_index_nospec(arg, MAX_LEC_ITF);
 	if (!dev_lec[i]) {
 		int size;
 


