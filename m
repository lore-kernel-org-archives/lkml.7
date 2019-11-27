Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1219C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7B9215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886927;
	bh=pz831w1FYuAKytC2tJGnO7bVucvEVuEDHUgUhpkzv/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e4CF8evulAUEPzWeKIxdQsfYbuCcwZlNWC7Bx93vN7v64z4Mhga44qa9a9WtwgDQQ
	 mNne3z1WhkRUJVX+BRgo+QJzTrwtv6PQrQv8xz9CEOxVnvIGIFHkOlHvuNwBqpKkKr
	 aYRiOR+f4cBA1msLPIHmmzvd8rbIMZLWwohMvZgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfK0Uf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbfK0UfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:35:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B0A20866;
        Wed, 27 Nov 2019 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886921;
        bh=pz831w1FYuAKytC2tJGnO7bVucvEVuEDHUgUhpkzv/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqdDqzq5ReCtQGGE7fmxegKDM4srWsTXszISUhptd8sRo1jYa1TASk0oaoOxdOgYy
         ETXMYL6Ckp0T8iudkm8EWLFus9sguPkc2F4XJj/hjKseTJwIRu1vYOhMjrtwHOVhB2
         /XZgdU3LFMS9PBsMTWm4KScPvH2RXqeO0JJRjqhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Klocke <philipp97kl@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 044/132] ALSA: i2c/cs8427: Fix int to char conversion
Date:   Wed, 27 Nov 2019 21:30:35 +0100
Message-Id: <20191127202939.896994447@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Klocke <philipp97kl@gmail.com>

[ Upstream commit eb7ebfa3c1989aa8e59d5e68ab3cddd7df1bfb27 ]

Compiling with clang yields the following warning:

sound/i2c/cs8427.c:140:31: warning: implicit conversion from 'int'
to 'char' changes value from 160 to -96 [-Wconstant-conversion]
    data[0] = CS8427_REG_AUTOINC | CS8427_REG_CORU_DATABUF;
            ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~

Because CS8427_REG_AUTOINC is defined as 128, it is too big for a
char field.
So change data from char to unsigned char, that it can hold the value.

This patch does not change the generated code.

Signed-off-by: Philipp Klocke <philipp97kl@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/i2c/cs8427.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index 7e21621e492a4..7fd1b40008838 100644
--- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -118,7 +118,7 @@ static int snd_cs8427_send_corudata(struct snd_i2c_device *device,
 	struct cs8427 *chip = device->private_data;
 	char *hw_data = udata ?
 		chip->playback.hw_udata : chip->playback.hw_status;
-	char data[32];
+	unsigned char data[32];
 	int err, idx;
 
 	if (!memcmp(hw_data, ndata, count))
-- 
2.20.1



