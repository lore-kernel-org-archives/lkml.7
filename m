Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049C02087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049631;
	bh=UT43P2M2h2VV/sVCbWxPfMYnXbAhsz2Hg3Bk+qy1ysA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjeLca6NFoSoRjWj5h1f3yeRGTUJFVowF/WFVICeHPs8o+rj6yVdiqYuA7Z683Pej
	 ftDXkDb6GoOgvz6VENcWFhyZ59WnPRuOZmMAR6CWOzAWZD8Oglf4lvbe+ORcktdG8E
	 bb+lNH0cMgkTPI2iDPOvaRd2eDE0MxXTTOnevKPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCHMxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfCHMxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7678F20684;
        Fri,  8 Mar 2019 12:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049626;
        bh=UT43P2M2h2VV/sVCbWxPfMYnXbAhsz2Hg3Bk+qy1ysA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKCr0HSp9QbuwHMeg1PEvEh/3pLPM6nFeWQF2MxNFdnfA1G8xLl4qVC2C8VfF5lZD
         Y3YHAWaPjnMg+vNkOKeUvBgliicLGWVN8Gk/VtCh8tkZm09rC+HG1pl6k1jDvQm9W7
         N7HjMjKEChZ3XuYwuvMkSo5+d3XHGbrLwweyiOhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.20 14/76] staging: wilc1000: fix to set correct value for vif_num
Date:   Fri,  8 Mar 2019 13:49:26 +0100
Message-Id: <20190308124915.283271571@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

From: Ajay Singh <ajay.kathat@microchip.com>

commit dda037057a572f5c82ac2499eb4e6fb17600ba3e upstream.

Set correct value in '->vif_num' for the total number of interfaces and
set '->idx' value using 'i'.

Fixes: 735bb39ca3be ("staging: wilc1000: simplify vif[i]->ndev accesses")
Fixes: 0e490657c721 ("staging: wilc1000: Fix problem with wrong vif index")
Cc: <stable@vger.kernel.org>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/linux_wlan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -1104,8 +1104,8 @@ int wilc_netdev_init(struct wilc **wilc,
 		vif->wilc = *wilc;
 		vif->ndev = ndev;
 		wl->vif[i] = vif;
-		wl->vif_num = i;
-		vif->idx = wl->vif_num;
+		wl->vif_num = i + 1;
+		vif->idx = i;
 
 		ndev->netdev_ops = &wilc_netdev_ops;
 


