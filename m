Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4DCC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDFA2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573165266;
	bh=o/q0uASjJnBVaAfXrJkzJZuhoIg5oq6iWOmQ1ROAA0I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Lxzdv3PBX6ZIM8CFm55BgNAwDERAdlvCRU/75TViy+4g4CJpJUohUJVkVE5HmOl0d
	 gyS8EtxKHBQPs8//gZ5Y9mLq5F4k8YQucgvRD7XL1A0NotOXpC1VEbu47Cv52Y5MNc
	 2XijuYRrS/6p2tZdibXAD+G3iJK1Q8V3zVpYQ1ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKGWVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfKGWVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:21:05 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF4A206C3;
        Thu,  7 Nov 2019 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573165264;
        bh=o/q0uASjJnBVaAfXrJkzJZuhoIg5oq6iWOmQ1ROAA0I=;
        h=From:To:Cc:Subject:Date:From;
        b=CgwqdvpxFsYFx12bPiJSAYNr8E+vT5BSY7bZLFBBgW79yCMnmfg8oz9CqenvyXZHT
         muvgLNiW2RIlaUpPF0niXHW/0E5DGj7maM5/Lta4Su2saJMIqfrq4LUvBcslhfalM0
         rgcPlMplJkcgKk7ZRpqxk2Q6X2wphJGkYQl4hHhg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] drm: replace magic nuumbers
Date:   Thu,  7 Nov 2019 16:20:45 -0600
Message-Id: <20191107222047.125496-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

amdgpu and radeon do a bit of mucking with the PCIe Link Control 2
register, some of it using hard-coded magic numbers.  The idea here is to
replace those with #defines.

I haven't signed off on these because the first one actually changes the
bits involved because the existing code looks like it might have a typo.
But I have no way to know for sure.

I don't intend the Target Link Speed patch to change anything, so it should
be straightforward to review.

Bjorn Helgaas (2):
  drm: replace Compliance/Margin magic numbers with PCI_EXP_LNKCTL2
    definitions
  drm: replace Target Link Speed magic numbers with PCI_EXP_LNKCTL2
    definitions

 drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/si.c  | 18 +++++++++++-------
 drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
 include/uapi/linux/pci_regs.h    |  2 ++
 5 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

