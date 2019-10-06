Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0040A20673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384643;
	bh=IAvCUtQoEkkm/ms8EqboKBC0qzh6TVyhRsg0uyoDaFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fg2KnhmDRsrnVWJKHv6Mclg68QwmTACAYgoxdWXvUdeotW13XF6cdz4W/m+7mlu3y
	 U8jftK7Qoc5YWGR+rXMCH00GpbcNxWq5rkVW4DAFXvRuLnP2lRuZz5p7osxG/09/E7
	 08U+p0oytD9ZaFHOvE5ZBsvJZX7jbFo+fmgdRRBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfJFRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbfJFRdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:33:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 670192087E;
        Sun,  6 Oct 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383221;
        bh=IAvCUtQoEkkm/ms8EqboKBC0qzh6TVyhRsg0uyoDaFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHIYv1WstVnQYcQkitrKdbZKzqCXWjpx51J0wuvDcsoRi9A13Id+N4KBSqGQV1oD9
         UPgyUQX9zv/2xV9ZxmZU4coMlpPUPhL610Kd9HacGrD5bjlwRuWQRZTLEDZraExiLK
         eOEDLbCTVAnKQDbSgEjSJpymkYnO2FEFXOEK8Hjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 024/137] net: sched: cbs: Avoid division by zero when calculating the port rate
Date:   Sun,  6 Oct 2019 19:20:08 +0200
Message-Id: <20191006171211.243512149@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit 83c8c3cf45163f0c823db37be6ab04dfcf8ac751 ]

As explained in the "net: sched: taprio: Avoid division by zero on
invalid link speed" commit, it is legal for the ethtool API to return
zero as a link speed. So guard against it to ensure we don't perform a
division by zero in kernel.

Fixes: e0a7683d30e9 ("net/sched: cbs: fix port_rate miscalculation")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -306,7 +306,7 @@ static void cbs_set_port_rate(struct net
 	if (err < 0)
 		goto skip;
 
-	if (ecmd.base.speed != SPEED_UNKNOWN)
+	if (ecmd.base.speed && ecmd.base.speed != SPEED_UNKNOWN)
 		speed = ecmd.base.speed;
 
 skip:


