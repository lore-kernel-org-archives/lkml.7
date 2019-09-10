Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9AC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16772089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="fpvMXxNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbfIJRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:50:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2144 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfIJRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568137806; x=1599673806;
  h=from:to:subject:date:message-id;
  bh=Wd9BZT5mhRC+sg3kUmT7XieFg+66hTOzR6acJxYycRM=;
  b=fpvMXxNxROPiuqHc6OaNsC6r80Q2gQVCulklEOs4Zk4b6P6UtIaKuMHL
   lubrGH+2QCx13K+85PRMuuvkonA5mnNRQLleHH8EzR4DNYfftoHRqd/qI
   L3EVOUTfX3aDW3l2C3WEBYDQeiuyuKepmFl/Z8Sz4w8eDeLi8WpwjNQiR
   I=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="701858127"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Sep 2019 17:49:38 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id B5062A24F8;
        Tue, 10 Sep 2019 17:49:35 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x8AHnXLb023806;
        Tue, 10 Sep 2019 19:49:33 +0200
Received: (from sironi@localhost)
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id x8AHnXi2023801;
        Tue, 10 Sep 2019 19:49:33 +0200
From:   Filippo Sironi <sironi@amazon.de>
To:     sironi@amazon.de, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: iommu/amd: Flushing and locking fixes
Date:   Tue, 10 Sep 2019 19:49:20 +0200
Message-Id: <1568137765-20278-1-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce patches to take the domain lock whenever we call
functions that end up calling __domain_flush_pages.  Holding the domain lock is
necessary since __domain_flush_pages traverses the device list, which is
protected by the domain lock.

The first patch in the series adds a completion right after an IOTLB flush in
attach_device.

