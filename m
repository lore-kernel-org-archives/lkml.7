Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F14C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89894214E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 18:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKISCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 13:02:33 -0500
Received: from orthanc.universe-factory.net ([104.238.176.138]:54930 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfKISCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 13:02:32 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Nov 2019 13:02:31 EST
Received: from localhost.localdomain (unknown [185.216.33.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by orthanc.universe-factory.net (Postfix) with ESMTPSA id 0CD5C1F56B;
        Sat,  9 Nov 2019 18:54:38 +0100 (CET)
From:   Matthias Schiffer <mschiffer@universe-factory.net>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next 0/2] Implement get_link_ksettings for VXLAN and bridge
Date:   Sat,  9 Nov 2019 18:54:12 +0100
Message-Id: <cover.1573321597.git.mschiffer@universe-factory.net>
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
 net/bridge/br_device.c | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.24.0

