Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1189BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA562082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947343;
	bh=OU5sRkIuCfKQiVSPfsr9XsoOMgGbWeD8aZXvsxeh+Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NtmeJew00uchFe5uJdycGRilTM37pTd52eV3trdV4YBlwDbMmCV8opKpbGYuG/aRw
	 8FYSvzk06ZfNizpY0OdIr8JT24knBMdUBa2IsR9pNyGyLgTpkV4yNPssn8a6xBUFMn
	 K8J+vRJ8obbQB/fKoZC+v6cu0RxQrnewDM+yDuN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfIHMur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbfIHMuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:35 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B222D218AC;
        Sun,  8 Sep 2019 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947035;
        bh=OU5sRkIuCfKQiVSPfsr9XsoOMgGbWeD8aZXvsxeh+Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucVqttKA8ZJqHYHY6hZWPF8jFPUbP9oqzazcxyBKWsvFThun2POZOvElUxQ8ANmmt
         tvsRGLuBY4EHqP+VFQ5OpfKhffKJd3b5hN39F+H6dJEnYB63SXMGy+vCsYgW/EyCJL
         XWL4Z2lFUrTfUZvOpeZbMOuJCrKesFf96wWrN2WY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 09/94] nfp: flower: handle neighbour events on internal ports
Date:   Sun,  8 Sep 2019 13:41:05 +0100
Message-Id: <20190908121150.697700293@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit e8024cb483abb2b0290b3ef5e34c736e9de2492f ]

Recent code changes to NFP allowed the offload of neighbour entries to FW
when the next hop device was an internal port. This allows for offload of
tunnel encap when the end-point IP address is applied to such a port.

Unfortunately, the neighbour event handler still rejects events that are
not associated with a repr dev and so the firmware neighbour table may get
out of sync for internal ports.

Fix this by allowing internal port neighbour events to be correctly
processed.

Fixes: 45756dfedab5 ("nfp: flower: allow tunnels to output to internal port")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -329,13 +329,13 @@ nfp_tun_neigh_event_handler(struct notif
 
 	flow.daddr = *(__be32 *)n->primary_key;
 
-	/* Only concerned with route changes for representors. */
-	if (!nfp_netdev_is_nfp_repr(n->dev))
-		return NOTIFY_DONE;
-
 	app_priv = container_of(nb, struct nfp_flower_priv, tun.neigh_nb);
 	app = app_priv->app;
 
+	if (!nfp_netdev_is_nfp_repr(n->dev) &&
+	    !nfp_flower_internal_port_can_offload(app, n->dev))
+		return NOTIFY_DONE;
+
 	/* Only concerned with changes to routes already added to NFP. */
 	if (!nfp_tun_has_route(app, flow.daddr))
 		return NOTIFY_DONE;


