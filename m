Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACAAC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D763205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712986;
	bh=ue8sRECZPNkgdQONQjHTxJ1XRFmgWVYkYyDvdhg2IJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14SjK34j+9riEZIMuzaKTUdXfKC99ZOaVC5zVxnyQOWoiwGS19HyycBqVw0B0X6SN
	 VjfspQ5XzYSKjldvQKeztTI/Ru+y6CuR+9hlDVmyDlyqF016LGnnjSReLCHATUrJQQ
	 jH/rVxIPQkXHbrOXJjq7xZisx/QpiV5z1kE8LC5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfC0SQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388977AbfC0SQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29736217F5;
        Wed, 27 Mar 2019 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710580;
        bh=ue8sRECZPNkgdQONQjHTxJ1XRFmgWVYkYyDvdhg2IJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhT66B2/HPrUjmwlDMN0kGQlH/UqNgAeq6qZclernVNrpfpt8h37PBkfFiV2+Cju2
         zFi8YjcGSwX6ybryNz5pNnPXZteBxgv3Eq2/5uagUwUfMwBtKBcCj+PhpQ4Gr0fM+b
         LKPohHcTt+ggQiDjfCBJfHe25E3aMS9A8z/ii2ZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 187/192] Input: soc_button_array - fix mapping of the 5th GPIO in a PNP0C40 device
Date:   Wed, 27 Mar 2019 14:10:19 -0400
Message-Id: <20190327181025.13507-187-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e9eb788f9442d1b5d93efdb30c3be071ce8a22b1 ]

The Microsoft documenation for the PNP0C40 device aka the
"Windows-compatible button array" describes the 5th GpioInt listed in
the resources as: '5. Interrupt corresponding to the "Rotation Lock"
button, if supported'.

Notice this describes the 5th entry as a button while we sofar have been
mapping it to EV_SW, SW_ROTATE_LOCK. On my Point of View TAB P1006W-232
which actually comes with a rotation-lock button, the button indeed is a
button and not a slider/switch. An image search for other Windows tablets
has found 2 more models with a rotation-lock button and on both of those
it too is a push-button and not a slider/switch.

Further evidence can be found in the HUT extension HUTRR52 from Microsoft
which adds rotation lock support to the HUT, which describes 2 different
usages: "0xC9 System Display Rotation Lock Button" and
"0xCA System Display Rotation Lock Slider Switch" note that switch is seen
as a separate thing here and the non switch wording is an exact match for
the "Windows-compatible button array" spec wording.

TL;DR: our current mapping of the 5th GPIO to SW_ROTATE_LOCK is wrong
because the 5th GPIO is for a push-button not a switch.

This commit fixes this by maping the 5th GPIO to KEY_ROTATE_LOCK_TOGGLE.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 23520df7650f..55cd6e0b409c 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -373,7 +373,7 @@ static struct soc_button_info soc_button_PNP0C40[] = {
 	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true },
 	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false },
 	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false },
-	{ "rotation_lock", 4, EV_SW, SW_ROTATE_LOCK, false, false },
+	{ "rotation_lock", 4, EV_KEY, KEY_ROTATE_LOCK_TOGGLE, false, false },
 	{ }
 };
 
-- 
2.19.1

