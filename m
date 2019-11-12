Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C2C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE420818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKLVMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:12:32 -0500
Received: from orthanc.universe-factory.net ([104.238.176.138]:40918 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbfKLVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:12:32 -0500
Received: from localhost.localdomain (unknown [IPv6:2001:19f0:6c01:100::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by orthanc.universe-factory.net (Postfix) with ESMTPSA id 254DD1F56D;
        Tue, 12 Nov 2019 22:12:30 +0100 (CET)
From:   Matthias Schiffer <mschiffer@universe-factory.net>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next v2 0/2] Implement get_link_ksettings for VXLAN and bridge
Date:   Tue, 12 Nov 2019 22:12:23 +0100
Message-Id: <cover.1573591594.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mesh routing protocol batman-adv (in particular the new BATMAN_V algorithm)
uses the link speed reported by get_link_ksettings to determine a path
metric for wired links. In the mesh framework Gluon [1], we layer VXLAN
and sometimes bridge interfaces on our Ethernet links.

These patches implement get_link_ksettings for these two interface types.
While this is obviously not accurate for bridges with multiple active
ports, it's much better than having no estimate at all (and in the
particular setup of Gluon, bridges with a single port aren't completely
uncommon).


[1] https://github.com/freifunk-gluon/gluon

Matthias Schiffer (2):
  vxlan: implement get_link_ksettings ethtool method
  bridge: implement get_link_ksettings ethtool method

 drivers/net/vxlan.c    | 24 ++++++++++++++++++++++--
 net/bridge/br_device.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.24.0

