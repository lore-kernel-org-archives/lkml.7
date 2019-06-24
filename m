Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C6DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A331E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371536;
	bh=B8haucdH0Bac5XxjC19HYszcAgma7sNI2LLJyXDiMss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ySLIHr5Z/gA0sIWep8X2zp1ICBqZ8yrIe91TNUXIYujoMiDiCWEi1KU3dHUTxuu9c
	 TXCcdTcUdwLFMkdVmw5cDKhTH18HgEGMxwYN0myiNBe8vOydOy04pvM/IQQTSEN/1c
	 BYFb6MgJos44TojZ2tP8iH7y5wtCoeHUxSVy2tnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfFXKPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbfFXKOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:14:44 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEC9205C9;
        Mon, 24 Jun 2019 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371284;
        bh=B8haucdH0Bac5XxjC19HYszcAgma7sNI2LLJyXDiMss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esuQWnoSLb11kZY7VkZljHEGPv5sVZd5YZKAnYE7jXmbtTKBh98fj3QZaqJ7lduG1
         DMVvkIQLRIzH0p0tL0NaAoTsDupfHvIUrxAFKMfDFJ1oo6NtTbkvM5J7crntMjl2yZ
         R6cZ/PIB3hkoU8j9sE1PyWmIczwLmSdxc7akCTek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 065/121] mdesc: fix a missing-check bug in get_vdev_port_node_info()
Date:   Mon, 24 Jun 2019 17:56:37 +0800
Message-Id: <20190624092324.129228105@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 80caf43549e7e41a695c6d1e11066286538b336f ]

In get_vdev_port_node_info(), 'node_info->vdev_port.name' is allcoated
by kstrdup_const(), and it returns NULL when fails. So
'node_info->vdev_port.name' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/mdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 9a26b442f820..8e645ddac58e 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -356,6 +356,8 @@ static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
 
 	node_info->vdev_port.id = *idp;
 	node_info->vdev_port.name = kstrdup_const(name, GFP_KERNEL);
+	if (!node_info->vdev_port.name)
+		return -1;
 	node_info->vdev_port.parent_cfg_hdl = *parent_cfg_hdlp;
 
 	return 0;
-- 
2.20.1



