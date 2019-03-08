Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B5FC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BB2208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049476;
	bh=Sy4UbLyDmS1wYLWAdAIpfi7b8Uz/5/Clvllosf084qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Df1TVrjMxgliZvY9UcnNwtPtOposvTnAQJT2BXfLWMosEmzjNbpxaa/PAXu+9RVEQ
	 WlaeF59fUm064p/l0NSJSdmOrJqxn7E1dup+Bnu7cR2ZUTUQenU9qpPPOuUinOJeTM
	 2bzm8xdShhxEPKqbrYE9Jml9Cf50W4DH5/m4jrgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCHMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfCHMvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:51:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361972085A;
        Fri,  8 Mar 2019 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049470;
        bh=Sy4UbLyDmS1wYLWAdAIpfi7b8Uz/5/Clvllosf084qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEicbfpxkZIU39dQS5bZ4hEQf878es35NAcx4oIuA0ICMoNWQzhVtg5ZItM6WivAr
         SCwDBfUf6xH9aGyvvW0+APbuT6rfSUTM0X1T/jVm83fVZ7yyl3vHe3oaXsZ79bZyQQ
         Vq3Zie9vS37CYKvmGrOv1DBr8IbOWrPd7QvMo2Uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 5.0 13/46] staging: wilc1000: fix to set correct value for vif_num
Date:   Fri,  8 Mar 2019 13:49:46 +0100
Message-Id: <20190308124903.105184268@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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
@@ -1086,8 +1086,8 @@ int wilc_netdev_init(struct wilc **wilc,
 		vif->wilc = *wilc;
 		vif->ndev = ndev;
 		wl->vif[i] = vif;
-		wl->vif_num = i;
-		vif->idx = wl->vif_num;
+		wl->vif_num = i + 1;
+		vif->idx = i;
 
 		ndev->netdev_ops = &wilc_netdev_ops;
 


