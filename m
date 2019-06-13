Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B529C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D395F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442235;
	bh=bumPwjUYm3KbL5tQQxLWSkjwkzOdzcWPzdKnPfV+b6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n6EnoFNVbPy7ZKLjyNmX6738nHAjGzq0eIfAn3Eu0GuY1HtJNPhoIS+b1oHvWDryH
	 czBraHNCWme2MpfdBD7LyT+zwXxvDwfdc34gfVPLEKqcOFNjq5vgyCRM911x3cYpIJ
	 nOwpb5FD9udY3x1Q/YAoOm+tKs97tPvl3++Pkvxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbfFMQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbfFMInu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:43:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AAA32063F;
        Thu, 13 Jun 2019 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415430;
        bh=bumPwjUYm3KbL5tQQxLWSkjwkzOdzcWPzdKnPfV+b6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCsiuTd0jGxj06PtqMor9Ux6AFDfQRIuCQJaO1LbZUY+iu+g4+qknTr+a94/6biHQ
         uDCfhy6WYEUe8WQfv4kjpwQvCfGvZWi2zDTf4lqIYsB88Jdm/se6yB8ttV2pkNtly1
         cvMjiWAP3467qwNhQpExFsgnd0ab9IazOrrEIHiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/118] ice: Add missing case in print_link_msg for printing flow control
Date:   Thu, 13 Jun 2019 10:34:02 +0200
Message-Id: <20190613075650.090753020@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 203a068ac9e2722e4d118116acaa3a5586f9468a ]

Currently we aren't checking for the ICE_FC_NONE case for the current
flow control mode. This is causing "Unknown" to be printed for the
current flow control method if flow control is disabled. Fix this by
adding the case for ICE_FC_NONE to print "None".

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index db1543bca701..875f97aba6e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -652,6 +652,9 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	case ICE_FC_RX_PAUSE:
 		fc = "RX";
 		break;
+	case ICE_FC_NONE:
+		fc = "None";
+		break;
 	default:
 		fc = "Unknown";
 		break;
-- 
2.20.1



