Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E0EC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFC6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429774;
	bh=JjSn7E8NOcXhxNkF6xu/DWhQxbmtqDQN5Q/q+1angIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVcbNez6JRCODAFHsOY63Xk8T8aJaLdaNhQy9GTkPBuFIp6V14ect0qs2DeKz3/z9
	 tfeKeZkzNMUIqa7dFESFMd4ysE3lpU4NifYAtue4cEzGCPo80V93nPrvVR0hzUKdjF
	 k/iJbDbGr7PcOz+7lb5E9H6S66dw7a/gTAMic91s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfG2Tt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfG2TtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:49:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609952171F;
        Mon, 29 Jul 2019 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429762;
        bh=JjSn7E8NOcXhxNkF6xu/DWhQxbmtqDQN5Q/q+1angIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLCFZ/2Bj5YB+Am0egIwCdvbQLRWNNOAjzYvf/EaGYCM+d2bEALE4pIj8zyLeeLQb
         BQAiPY1+ywACXMmmDW3yN0OUMQ9MVKk1ZzVUIUd5esItNU9QqxWGI4kCLyxDJhjcjz
         9daetLb1JfiCI0TCBAwbVwWHwr7/BgCZjaL0oW0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 088/215] iio: iio-utils: Fix possible incorrect mask calculation
Date:   Mon, 29 Jul 2019 21:21:24 +0200
Message-Id: <20190729190754.684061423@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



