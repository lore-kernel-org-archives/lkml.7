Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626FEC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258DB20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004389;
	bh=Pc7uPvcuM7w2rBzOwHBf9lGobcUqEHEdyQ6mhiTC5U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yruzNlg06fmoea9CbNTRK9oCnNaKLQ/VBr/8m9MrDPhVd0DRA6yHNm5KkrtOa+HAT
	 w7VRVBIUcX8k/vtVmEJKnTv5dl6AVsMPQSdI2jaqJ5ZfvfGozRfOgXUaJe9mrDglAh
	 OKguKEDWlKjc84oRzBFuIsoNwtm7DW46/qvmkZTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgABWdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgABWdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:33:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB1E20863;
        Thu,  2 Jan 2020 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004383;
        bh=Pc7uPvcuM7w2rBzOwHBf9lGobcUqEHEdyQ6mhiTC5U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/HtUHvHcG0KjHdnsIlBbkubj5MJ3dgvIFrB3r3ISaAu8M44205OGLMOLpX2+A452
         MTFg97K4dZptnMvbKAWFl6pXrwILuaTYRyEyiSWRrVs76xgc/Fjw/rk9Ech5zwxxLt
         pB61wE2rlDBQyBzXeR3eq7D0LSL9gojecYqt2cmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 130/171] mfd: mfd-core: Honour Device Trees request to disable a child-device
Date:   Thu,  2 Jan 2020 23:07:41 +0100
Message-Id: <20200102220605.077702643@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

[ Upstream commit 6b5c350648b857047b47acf74a57087ad27d6183 ]

Until now, MFD has assumed all child devices passed to it (via
mfd_cells) are to be registered. It does not take into account
requests from Device Tree and the like to disable child devices
on a per-platform basis.

Well now it does.

Link: https://www.spinics.net/lists/arm-kernel/msg366309.html
Link: https://lkml.org/lkml/2019/8/22/1350

Reported-by: Barry Song <Baohua.Song@csr.com>
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mfd-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 5c8ed2150c8b..fae7bfe7a21a 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -178,6 +178,11 @@ static int mfd_add_device(struct device *parent, int id,
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
+				if (!of_device_is_available(np)) {
+					/* Ignore disabled devices error free */
+					ret = 0;
+					goto fail_alias;
+				}
 				pdev->dev.of_node = np;
 				pdev->dev.fwnode = &np->fwnode;
 				break;
-- 
2.20.1



