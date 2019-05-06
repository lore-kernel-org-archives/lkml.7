Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD70214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153728;
	bh=385CK5g0kpK3lqPM3QqwDpj3sUCE0y8wLuVdT640+NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gre39kzP1ReI14SAifXt+vgJq24oZw6eH3YnLva5RvkQHgLAqktnm8nLPlQ8/jpTZ
	 c0i7NskWiC5T9pwP7QqbpUh+aBNeDLQoiwa6/VbuqfU7K8f1o35i+D6D9IYZywlZ+m
	 svbZWOUZPhGebAehbKb675tu1RofCm0m/oWm4YCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfEFOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfEFOmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970B221479;
        Mon,  6 May 2019 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153724;
        bh=385CK5g0kpK3lqPM3QqwDpj3sUCE0y8wLuVdT640+NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdjBNjfmVbrEl1QKBRQs5k0uBD5y63PfTzjTj+k9zuub/hIUpUZjD1iGK5e8YGJzR
         vGrBjThXoNBkZXEn8kNU1uEluBbEd20nI21Si2TXSBYDeXm/XB8qaAGykyfUNlyavU
         2F9vF5umbKvEFwbSx3Ea33msRnXHWGRdE8GQp+gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 73/99] clk: qcom: Add missing freq for usb30_master_clk on 8998
Date:   Mon,  6 May 2019 16:32:46 +0200
Message-Id: <20190506143100.745505322@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

commit 0c8ff62504e3a667387e87889a259632c3199a86 upstream.

The usb30_master_clk supports a 60Mhz frequency, but that is missing from
the table of supported frequencies.  Add it.

Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) driver)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/qcom/gcc-msm8998.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -1101,6 +1101,7 @@ static struct clk_rcg2 ufs_axi_clk_src =
 
 static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	F(60000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
 	F(120000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
 	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
 	{ }


