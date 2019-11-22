Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B5BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C0B20726
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452203;
	bh=XhNv7iixGGYfrnwFrZP69LTjw0pSmMl69WAWUf+8ME4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rvE4BSUleF0YeRts9NoENKg0K+aedmXP+6HYvjNEVk3d3aZJaujrl+6tvgT/cLbO
	 NroYhuK6byCWxb5kNK/M54JN53tL2rSolFTbjiWCtSHUJDnneq+eqIZC1z0owvJc03
	 FN5yINaqJlZidQ8U5YtA1oBJwtRHavnZnC2fXtrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKVTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfKVTt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:49:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCB220658;
        Fri, 22 Nov 2019 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452197;
        bh=XhNv7iixGGYfrnwFrZP69LTjw0pSmMl69WAWUf+8ME4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIupUgpwRbiFPBIbFknnWeJn5bNabWw9+ufe1n4UCACMom+Y72cZecQsX6PYSkdhU
         6a1wOk1n0UcvqEJRQW/o285ReJjyZa2i8u6DOEhBl/IuMNiCaMtSk7li8QtIt0xQFL
         snzwxfiwek99BORRQWlEq3RN9OGhNr7MgocE5dDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 21/21] Input: synaptics - enable RMI mode for X1 Extreme 2nd Generation
Date:   Fri, 22 Nov 2019 14:49:31 -0500
Message-Id: <20191122194931.24732-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194931.24732-1-sashal@kernel.org>
References: <20191122194931.24732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit 768ea88bcb235ac3a92754bf82afcd3f12200bcc ]

Just got one of these for debugging some unrelated issues, and noticed
that Lenovo seems to have gone back to using RMI4 over smbus with
Synaptics touchpads on some of their new systems, particularly this one.
So, let's enable RMI mode for the X1 Extreme 2nd Generation.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://lore.kernel.org/r/20191115221814.31903-1-lyude@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7db53eab70121..1962db0431dea 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -180,6 +180,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN009b", /* T580 */
+	"LEN0402", /* X1 Extreme 2nd Generation */
 	"LEN200f", /* T450s */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
-- 
2.20.1

