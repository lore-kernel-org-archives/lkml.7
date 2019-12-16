Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67042C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C64420700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519842;
	bh=Fd7ChdYtx6FGdMpsIhsq6sadR6GKedj+dYkI6xfVanY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZXcoQA1lj2swFk3XActxA1IKMRJl2yGPgpw/kzd18620zqs7dwDzwtFH74M1dlAEE
	 +XD1bHcC2tGlLvpUQg/3zYg4r2axZPn1p/t/oTMRTL7kfJEU5zXAdZs+Rh3OvKSBWA
	 hJp/AJpG3W73vnD33Mg/vr1wpto8P0QYueziISVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfLPSKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbfLPSKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:10:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 249E7206B7;
        Mon, 16 Dec 2019 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519837;
        bh=Fd7ChdYtx6FGdMpsIhsq6sadR6GKedj+dYkI6xfVanY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYgaNzf6f31wGO6Sgk4zCJQz8UaORVX+Hj3wvVv+H52HW3ZfBx8WBKEJU6jCq473R
         nT6zXXcj0tRkbgEvpU4vU3wFiIjqiKQRk6vq9Yp//RFKKd/Nbww8O/9EbyKgGxre9F
         4uY8FDROySz5z7su4pNXCl+0mV2DWg23b7I2d8YI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.3 090/180] cpuidle: teo: Ignore disabled idle states that are too deep
Date:   Mon, 16 Dec 2019 18:48:50 +0100
Message-Id: <20191216174834.567028096@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 069ce2ef1a6dd84cbd4d897b333e30f825e021f0 upstream.

Prevent disabled CPU idle state with target residencies beyond the
anticipated idle duration from being taken into account by the TEO
governor.

Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.1+ <stable@vger.kernel.org> # 5.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/governors/teo.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -266,6 +266,13 @@ static int teo_select(struct cpuidle_dri
 
 		if (s->disabled || su->disable) {
 			/*
+			 * Ignore disabled states with target residencies beyond
+			 * the anticipated idle duration.
+			 */
+			if (s->target_residency > duration_us)
+				continue;
+
+			/*
 			 * If the "early hits" metric of a disabled state is
 			 * greater than the current maximum, it should be taken
 			 * into account, because it would be a mistake to select


