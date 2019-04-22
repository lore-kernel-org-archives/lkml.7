Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11794C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA4421906
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962452;
	bh=3thwNhU9wWzxyaOnplzcDqjz1+lmuPcL/tkQJ0lATxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h38LX3zxPZyHqBDy9j3Iuode3vnZ+r3ZqzQl5/DxfOqw/iWAVmTen/sJt0kDQs4vw
	 DmyXWR3++NLAR72P8J+EvkkQFDfe3BQJJG4Ecf9cx3FOvRXIdId/w6mn+MvtG43224
	 1l4P0T4qsb79cFtWVSjMTU0wzBJ8P1wdPCQu2NDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfDVTrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbfDVTr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6C521904;
        Mon, 22 Apr 2019 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962447;
        bh=3thwNhU9wWzxyaOnplzcDqjz1+lmuPcL/tkQJ0lATxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeXvDGoDvRICXEc2p1A7T45SmrC7qznd77EoaB7I/IWg34UK76WeeuF32EFZaVchs
         nx//57eKqOeZpIev6ZgRImEuBPhpKiLq7TvxcNTzk7qW8tyZScRw0h64QdEy7Axvyw
         cvK/uEnszdmJ3PpsuDgmtDPERhmWok1FVdgEYePA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 68/68] leds: trigger: netdev: use memcpy in device_name_store
Date:   Mon, 22 Apr 2019 15:45:16 -0400
Message-Id: <20190422194516.11634-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit 909346433064b8d840dc82af26161926b8d37558 ]

If userspace doesn't end the input with a newline (which can easily
happen if the write happens from a C program that does write(fd,
iface, strlen(iface))), we may end up including garbage from a
previous, longer value in the device_name. For example

# cat device_name

# printf 'eth12' > device_name
# cat device_name
eth12
# printf 'eth3' > device_name
# cat device_name
eth32

I highly doubt anybody is relying on this behaviour, so switch to
simply copying the bytes (we've already checked that size is <
IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
still have to strip a trailing newline.

This is also preparation for future patches.

Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 167a94c02d05..136f86a1627d 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
 		trigger_data->net_dev = NULL;
 	}
 
-	strncpy(trigger_data->device_name, buf, size);
+	memcpy(trigger_data->device_name, buf, size);
+	trigger_data->device_name[size] = 0;
 	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
 		trigger_data->device_name[size - 1] = 0;
 
-- 
2.19.1

