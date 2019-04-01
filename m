Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3846C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD720879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfDABiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:38:20 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60976 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfDABiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 21:38:19 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 65A1912390AF3130DA29
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 09:38:17 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x311cAox061036
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 09:38:10 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040109381391-7035240 ;
          Mon, 1 Apr 2019 09:38:13 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/7] fix possible object reference leaks in cpufreq
Date:   Mon, 1 Apr 2019 09:37:47 +0800
Message-Id: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-01 09:38:14,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-01 09:38:10,
        Serialize complete at 2019-04-01 09:38:10
X-MAIL: mse01.zte.com.cn x311cAox061036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
returns a node pointer with refcount incremented thus it must be
explicitly decremented after the last usage.

This patch series fix those possible object reference leaks in cpufreq.

Wen Yang (7):
  cpufreq: ap806: fix possible object reference leak
  cpufreq: imx6q: fix possible object reference leak
  cpufreq: kirkwood: fix possible object reference leak
  cpufreq: maple: fix possible object reference leak
  cpufreq/pasemi: fix possible object reference leak
  cpufreq: pmac32: fix possible object reference leak
  cpufreq: ppc_cbe: fix possible object reference leak

 drivers/cpufreq/armada-8k-cpufreq.c |  1 +
 drivers/cpufreq/imx6q-cpufreq.c     |  4 ++--
 drivers/cpufreq/kirkwood-cpufreq.c  | 19 +++++++++++--------
 drivers/cpufreq/maple-cpufreq.c     |  2 +-
 drivers/cpufreq/pasemi-cpufreq.c    |  1 +
 drivers/cpufreq/pmac32-cpufreq.c    |  2 ++
 drivers/cpufreq/ppc_cbe_cpufreq.c   |  1 +
 7 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.9.5

