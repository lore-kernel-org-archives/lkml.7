Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6279BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D512183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368850;
	bh=N76NJacwlt3I5/RosT1SY5cweye0dMDIM21iYnpw7ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NHKHPxj+v6WHplH/T8gOQp0lTUZ/sKDgey1iMjVavQHd6i8KMEsbuLU55Q/+7WCVd
	 rRpuIurkh7bwAmJoLo+iw9junUlvwuYGcXFalnHXj4Srf0FahikFDxnG5+i0XAMc3M
	 qYs9WKatf/0BKNsdEdJ8Uyojb8DCoq8h+cYaeEcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbfDDJH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731959AbfDDJHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F7E218FF;
        Thu,  4 Apr 2019 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368842;
        bh=N76NJacwlt3I5/RosT1SY5cweye0dMDIM21iYnpw7ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5Cj69OHlFeD4C9LnpKCfQNr9HEuONlCimK1pyu3ArsF+ZRS9CCW3IV8B4fCfVvsJ
         peA0SFB+u/fjXdfKUuTrgGh8zXY9ax9kLFEDoUFU/VpVO4wCP0TwWIsYE6LUO1DRzl
         wO2suqNgfedbJjNS2+q5r5Cw6uo56Iz+Yq0TCM4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 182/187] Input: soc_button_array - fix mapping of the 5th GPIO in a PNP0C40 device
Date:   Thu,  4 Apr 2019 10:48:39 +0200
Message-Id: <20190404084611.694946820@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



