Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964CB216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfG2PlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:41:01 -0400
Received: from mail.monom.org ([188.138.9.77]:49950 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388120AbfG2Pk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:40:56 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 0EAC45006EC;
        Mon, 29 Jul 2019 17:40:51 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id D47805005D6;
        Mon, 29 Jul 2019 17:40:50 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4.4 0/2] vmstat backports
Date:   Mon, 29 Jul 2019 17:40:44 +0200
Message-Id: <20190729154046.8824-1-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Second attempt on this topic [1]:

"""
Upstream commmit 0eb77e988032 ("vmstat: make vmstat_updater deferrable
again and shut down on idle") was back ported in v4.4.178
(bdf3c006b9a2). For -rt we definitely need the bugfix f01f17d3705b
("mm, vmstat: make quiet_vmstat lighter") as well.

Since the offending patch was back ported to v4.4 stable only, the
other stable branches don't need an update (offending patch and bug
fix are already in).
"""

Though I missed a dependency as Jon noted[2]. The missing patch is
587198ba5206 ("vmstat: Remove BUG_ON from vmstat_update"). I've tested
this on a Tegra K1 one board which exposed the bug. With this should
be fine.

While at it, I looked on all relevant changes for
vmstat_updated(). These two patches are the only relevant changes
which are missing. It seems almost all changes from mainline have made
it back to v4.

Could you please queue the above patches for v4.4.y?

Thanks,
Daniel

[1] https://lore.kernel.org/stable/20190513061237.4915-1-wagi@monom.org
[2] https://lore.kernel.org/stable/f32de22f-c928-2eaa-ee3f-d2b26c184dd4@nvidia.com


Christoph Lameter (1):
  vmstat: Remove BUG_ON from vmstat_update

Michal Hocko (1):
  mm, vmstat: make quiet_vmstat lighter

 mm/vmstat.c | 80 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

-- 
2.20.1
