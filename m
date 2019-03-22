Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3132054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257570;
	bh=c6vEHRq7td5b5uLcbRzk4Lqczwkpuxb04uhpaeTq4Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mtvDviKhMwtBIwElPeAPohypM9XUFcGGgWm5QJdji8E6xCNdh4IyXVqqQnHqRdQgQ
	 i6xfXyN25dsYAl5Z/Cj3CW+vysPENA3pGzCoiJEwHSkaV6iQZyxd6utGQp8oL/lrGn
	 pZInZkQtG0AOG8bD7h392Zwc1WXZRUfImMNbrZQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfCVM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390694AbfCVMW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEDB2054F;
        Fri, 22 Mar 2019 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257378;
        bh=c6vEHRq7td5b5uLcbRzk4Lqczwkpuxb04uhpaeTq4Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZQKWy5qClSdP6+Fi1Igc3BnciDCnONFyKpyxjcCZHY1a3wD/nwQnS7hipI7Luxfj
         ioTz0vpBNIliCLb4c25lGQ8uhB0VGgOZ1DNzA6ds6WOOSJQ6W1pBQnmscXFkgk4tuc
         2xG2NHQMODmBvU01/TVShZ3JOumIRLkoLO2njVL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 214/238] media: sun6i: Fix CSI regmaps max_register
Date:   Fri, 22 Mar 2019 12:17:13 +0100
Message-Id: <20190322111310.910068499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit d31b282e2c0de9c7fb113516820340251f03a625 upstream.

max_register is currently set to 0x1000. This is beyond the mapped
address range of the hardware, so attempts to dump the regmap from
debugfs would trigger a kernel exception.

Furthermore, the useful registers only occupy a small section at the
beginning of the full range. Change the value to 0x9c, the last known
register on the V3s and H3.

On the A31, the register range is extended to support additional
capture channels. Since this is not yet supported, ignore it for now.

Fixes: 5cc7522d8965 ("media: sun6i: Add support for Allwinner CSI V3s")

Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -793,7 +793,7 @@ static const struct regmap_config sun6i_
 	.reg_bits       = 32,
 	.reg_stride     = 4,
 	.val_bits       = 32,
-	.max_register	= 0x1000,
+	.max_register	= 0x9c,
 };
 
 static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,


