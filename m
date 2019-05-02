Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C3CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADDF2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810848;
	bh=8jRcYPH5YkiKRc1omdlCiX2F+0bIR3kxC2mztkj37Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uHGiOazitJK9ZvUE2mWjs+pmLxIe/4zXd6rEPMUWOxszA5/vQw7o22zi5T+yjpTnS
	 w1q3OgeOOO56SQVPaTmELO/HEXPuua6HI48/wIiIQcKAZ2DUNOZjamN/OapKLGV3Pn
	 CxKPqYsQxhwpDwTYZQoxh3qk6RxfCJ3YKuhCq8Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfEBP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfEBP1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:27:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0912081C;
        Thu,  2 May 2019 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810844;
        bh=8jRcYPH5YkiKRc1omdlCiX2F+0bIR3kxC2mztkj37Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1TvPTKzRpj9b15+dZatEVk+TNpVlWeHqUunnN5p+ckHSwbvsX91099GvL00Yolgx
         Q/Q3WTmO1M+Jf1gDnuJT4bfdLSOUj/+hc7F5Fb5fNoUy6NzVGOGFnDXsAfwur+bSpu
         D3BdHnANLhnAjSXeQIwpBLvw4LBfojoQGe/ju76A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 14/72] staging: axis-fifo: add CONFIG_OF dependency
Date:   Thu,  2 May 2019 17:20:36 +0200
Message-Id: <20190502143334.493667656@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1beea6204e2304dd11600791d8dad8e7350af6ad ]

When building without CONFIG_OF, the compiler loses track of the flow
control in axis_fifo_probe(), and thinks that many variables are used
without an initialization even though we actually leave the function
before the first use:

drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_probe':
drivers/staging/axis-fifo/axis-fifo.c:900:5: error: 'rxd_tdata_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (rxd_tdata_width != 32) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:907:5: error: 'txd_tdata_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (txd_tdata_width != 32) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:914:5: error: 'has_tdest' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (has_tdest) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:919:5: error: 'has_tid' may be used uninitialized in this function [-Werror=maybe-uninitialized]

When CONFIG_OF is set, this does not happen, and since the driver cannot
work without it, just add that option as a Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/axis-fifo/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index 687537203d9c..d9725888af6f 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -3,6 +3,7 @@
 #
 config XIL_AXIS_FIFO
 	tristate "Xilinx AXI-Stream FIFO IP core driver"
+	depends on OF
 	default n
 	help
 	  This adds support for the Xilinx AXI-Stream
-- 
2.19.1



