Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF79C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB64222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611233;
	bh=kYRv6X1JijuFRXp3cEKnjfaokBgri1XdSpNc8t1YNv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kz5kc5LgQbw1IES1QTWqRFxAC7ZnAvOdCoN43XqY6kjZKhnenWVSYUkdECOqK9je5
	 qPSMVdCkTVDRcoFEJjtXZnBLmCCDk6rqt2ONKUulFnbDBs+B1/BCu1NpkV4zRGdq0I
	 BvOHi8yGZGGb7IMfIy4fsFyPvxZQBFhv9cfplqSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfKMB52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfKMB5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E738222D3;
        Wed, 13 Nov 2019 01:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610244;
        bh=kYRv6X1JijuFRXp3cEKnjfaokBgri1XdSpNc8t1YNv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4bJMZED7tfQUe5OM23CpHBIhd6RgsU4i1LGw6HbUZAhW54oZvCTOX5GkYIxGryVy
         cGz5EcJy2Nna19j8zVCgqFXZMKSmjY0a2H4Yi2dIPJZ8pLPwHGSpWp3Z+K+RyARzM2
         SoPe0Vhe0+xzkTAR9ysQmluTEopCMmVN3EkNLpxs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.14 043/115] i40e: Use proper enum in i40e_ndo_set_vf_link_state
Date:   Tue, 12 Nov 2019 20:55:10 -0500
Message-Id: <20191113015622.11592-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 43ade6ad18416b8fd5bb3c9e9789faa666527eec ]

Clang warns when one enumerated type is converted implicitly to another.

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:4214:42: warning:
implicit conversion from enumeration type 'enum i40e_aq_link_speed' to
different enumeration type 'enum virtchnl_link_speed'
      [-Wenum-conversion]
                pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
                                                     ~ ^~~~~~~~~~~~~~~~~~~~
1 warning generated.

Use the proper enum from virtchnl_link_speed, which has the same value
as I40E_LINK_SPEED_40GB, VIRTCHNL_LINK_SPEED_40GB. This appears to be
missed by commit ff3f4cc267f6 ("virtchnl: finish conversion to virtchnl
interface").

Link: https://github.com/ClangBuiltLinux/linux/issues/81
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index bdb7523216000..ea42240ddace7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3191,7 +3191,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 		vf->link_forced = true;
 		vf->link_up = true;
 		pfe.event_data.link_event.link_status = true;
-		pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
+		pfe.event_data.link_event.link_speed = VIRTCHNL_LINK_SPEED_40GB;
 		break;
 	case IFLA_VF_LINK_STATE_DISABLE:
 		vf->link_forced = true;
-- 
2.20.1

