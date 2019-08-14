Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0841C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EEB216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802205;
	bh=5XY1jhNN1PSrUuRz6k03esqUoUOnMp2iMjXslguADsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bIN/5yLMpobKScFonTr0jBmdFewy62i2tcCSDLGe4Z2bAvOgb5czL9h4d7Es5j31H
	 Z+sht8zlPVbxHW78qq2Yw5bDvvEP3OOv1fNhZgOzm1JBjJoXaFi8Es66/xJZgLxiOO
	 iYhGaFJ+tpA8Lbgnt8+JkS+UA15/a1Urs9NiprH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfHNRDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfHNRDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:03:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201B02084D;
        Wed, 14 Aug 2019 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802199;
        bh=5XY1jhNN1PSrUuRz6k03esqUoUOnMp2iMjXslguADsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDSgu6FvHKuL+8FO3nnLJoQZ6CFBN//1N+ABcxHUKc+xtpGQ4n8/Itx74ClyVDmuR
         EKn1ORcVsiK+gXLhOL9AigazwgiTnGEzjaB3oLLbVQjdaaWLWj2zJ9Zcc5bAwXRd5H
         xIEWLVo8icjnZR4+gJOWY2Wc1BXYh05rP9+eoBp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adham Abozaeid <adham.abozaeid@microchip.com>
Subject: [PATCH 5.2 008/144] staging: wilc1000: flush the workqueue before deinit the host
Date:   Wed, 14 Aug 2019 18:59:24 +0200
Message-Id: <20190814165759.834376274@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

commit fb2b055b7e6e44efda737c7c92f46c0868bb04e5 upstream.

Before deinitializing the host interface, the workqueue should be flushed
to handle any pending deferred work

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190722213837.21952-1-adham.abozaeid@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1789,6 +1789,7 @@ void wilc_deinit_host_int(struct net_dev
 
 	priv->p2p_listen_state = false;
 
+	flush_workqueue(vif->wilc->hif_workqueue);
 	mutex_destroy(&priv->scan_req_lock);
 	ret = wilc_deinit(vif);
 


