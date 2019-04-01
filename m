Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365AEC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F130120830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141061;
	bh=hAgtolaIUmgX1DZVg7qfPFqY1YaYrUmW2jDJLwauytA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7t1nLmzhD3Cog574IdKKeEiN4I0ZetMNZ906jHgAR9DIP/m3s50xSZ8eRH3sHR2F
	 zAgYT4DCPm0GgQ4vx4q+G1FzqxQzCjQS0LNKGQMA7HAWDHiEpJs0rzr078GMMpDpUI
	 qqqNRkvuCaBnOXFzmZRLjm+vgHnKMjOO6QMagnx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfDAR2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732779AbfDAR2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13BF120830;
        Mon,  1 Apr 2019 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139703;
        bh=hAgtolaIUmgX1DZVg7qfPFqY1YaYrUmW2jDJLwauytA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcOl7BkbRosE+Ti5EpJE6Kk6sORXXvpcN5ieC4mHjblY0JqD7gyT9iOcHt75kU+VC
         ojcyF6XJm2r+DhqkZ8rZ/emk+mbm/bRb30as1WwS3WcrqVAzwXNYjQEV+8QnfANC56
         zbLAy4gf/T4uYobHpUNcF1xuVvBYcMBmpSfkDcHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 4.9 46/56] usb: common: Consider only available nodes for dr_mode
Date:   Mon,  1 Apr 2019 19:03:02 +0200
Message-Id: <20190401170106.423420568@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 238e0268c82789e4c107a37045d529a6dbce51a9 upstream.

There are cases where multiple device tree nodes point to the
same phy node by means of the "phys" property, but we should
only consider those nodes that are marked as available rather
than just any node.

Fixes: 98bfb3946695 ("usb: of: add an api to get dr_mode by the phy node")
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/common/common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -148,6 +148,8 @@ enum usb_dr_mode of_usb_get_dr_mode_by_p
 
 	do {
 		controller = of_find_node_with_property(controller, "phys");
+		if (!of_device_is_available(controller))
+			continue;
 		index = 0;
 		do {
 			if (arg0 == -1) {


