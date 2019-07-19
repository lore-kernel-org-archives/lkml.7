Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA9C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0AB2189F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508796;
	bh=BQz8KjtbQ5pipuq7bQLDsW55O1T1dwOXaBRQq797aEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCoQs56HaBrvVZdlhJEI/k5rsAr4BBiqpBdtFXtm7AoHh//Zdl6HR6k8EYY8XxtzH
	 yEMq6CUUirIx/UPxtWmIaBHhibgk6pQbpo+xjSqLVGUbKh1o1qaK/F0mS+8/gvu6wJ
	 J3kx67kIJ9p9D+5ni219rW8+/9r+HBWc0UzLTRJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfGSD7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfGSD7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:59:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9302121851;
        Fri, 19 Jul 2019 03:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508790;
        bh=BQz8KjtbQ5pipuq7bQLDsW55O1T1dwOXaBRQq797aEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tp2yy9yBHhnf4aEqqNWI2aXjGJ5SthJybbrMhVCRTH0lKFJOIakeSmeYnjalhOZJP
         BzqyDAQyyI0gU1SwYql5jvUKfk39b2wKP4rwwOPPDMhg5/0U0ZsK3+oUC7bZOL/WDO
         gwJ0LLmI79jAJDgZKwt+Yn9yIN0W9vIt/twK1Rvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 090/171] iio: iio-utils: Fix possible incorrect mask calculation
Date:   Thu, 18 Jul 2019 23:55:21 -0400
Message-Id: <20190719035643.14300-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 208a68c8393d6041a90862992222f3d7943d44d6 ]

On some machines, iio-sensor-proxy was returning all 0's for IIO sensor
values. It turns out that the bits_used for this sensor is 32, which makes
the mask calculation:

*mask = (1 << 32) - 1;

If the compiler interprets the 1 literals as 32-bit ints, it generates
undefined behavior depending on compiler version and optimization level.
On my system, it optimizes out the shift, so the mask value becomes

*mask = (1) - 1;

With a mask value of 0, iio-sensor-proxy will always return 0 for every axis.

Avoid incorrect 0 values caused by compiler optimization.

See original fix by Brett Dutro <brett.dutro@gmail.com> in
iio-sensor-proxy:
https://github.com/hadess/iio-sensor-proxy/commit/9615ceac7c134d838660e209726cd86aa2064fd3

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index a22b6e8fad46..7399eb7f1378 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -156,9 +156,9 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			*be = (endianchar == 'b');
 			*bytes = padint / 8;
 			if (*bits_used == 64)
-				*mask = ~0;
+				*mask = ~(0ULL);
 			else
-				*mask = (1ULL << *bits_used) - 1;
+				*mask = (1ULL << *bits_used) - 1ULL;
 
 			*is_signed = (signchar == 's');
 			if (fclose(sysfsfp)) {
-- 
2.20.1

