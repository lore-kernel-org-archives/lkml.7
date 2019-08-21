Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765BC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6926C22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NEk9AynO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="dcgieLOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfHUDFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:05:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61449 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:05:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A761C8A379;
        Tue, 20 Aug 2019 23:05:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=ZxI
        vURfUzxLnUYB5+/O/lnXeBNQ=; b=NEk9AynOWdAxhHEuaamwmAc21DxGkHvXtCh
        pzwGh86mluDnSOY3Dzz6GOnjmQ1XTk0UjjsKvcBDLVOXn/YkJ/1x8Cuu2eXWCQP6
        TPmAXfeTapUZLTjZPaU6mmAOcoKFiKOMzcjSMh2MeLVHxsj75LuVDrJJStd2drlV
        eZNxeKow=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0C378A378;
        Tue, 20 Aug 2019 23:05:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=te5ob5bTW6G+hGs7rK8exIibfwxyTydfDdqrb9ueLpE=;
 b=dcgieLOwVE+O+fjR1wqEF9tKvkvrFWIpY+j/QXVPFhrlKt02NjdyV4yROcjLrI2xVBzzzMdOnZ9GVOkJVxJjSMGt2lBZ9H2cQOOwFdqvZsKX6rJ7bBMNtPp3OLXZWurPUi2kWkefNbBrzvu401CB2X6pQmoDKhkgMUuvBTBMk/M=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8E4D18A377;
        Tue, 20 Aug 2019 23:05:44 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B60702DA0465;
        Tue, 20 Aug 2019 23:05:42 -0400 (EDT)
Date:   Tue, 20 Aug 2019 23:05:42 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] __div64_const32(): improve the generic C version
Message-ID: <nycvar.YSQ.7.76.1908202301490.19480@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 91098A5C-C3C0-11E9-B86D-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's rework that code to avoid large immediate values and convert some
64-bit variables to 32-bit ones when possible. This allows gcc to
produce smaller and better code. This even produces optimal code on
RISC-V.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726fdac..33358245b4 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -178,7 +178,8 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 	uint32_t m_hi = m >> 32;
 	uint32_t n_lo = n;
 	uint32_t n_hi = n >> 32;
-	uint64_t res, tmp;
+	uint64_t res;
+	uint32_t res_lo, res_hi, tmp;
 
 	if (!bias) {
 		res = ((uint64_t)m_lo * n_lo) >> 32;
@@ -187,8 +188,9 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 		res = (m + (uint64_t)m_lo * n_lo) >> 32;
 	} else {
 		res = m + (uint64_t)m_lo * n_lo;
-		tmp = (res < m) ? (1ULL << 32) : 0;
-		res = (res >> 32) + tmp;
+		res_lo = res >> 32;
+		res_hi = (res_lo < m_hi);
+		res = res_lo | ((uint64_t)res_hi << 32);
 	}
 
 	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
@@ -197,10 +199,12 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 		res += (uint64_t)m_hi * n_lo;
 		res >>= 32;
 	} else {
-		tmp = res += (uint64_t)m_lo * n_hi;
+		res += (uint64_t)m_lo * n_hi;
+		tmp = res >> 32;
 		res += (uint64_t)m_hi * n_lo;
-		tmp = (res < tmp) ? (1ULL << 32) : 0;
-		res = (res >> 32) + tmp;
+		res_lo = res >> 32;
+		res_hi = (res_lo < tmp);
+		res = res_lo | ((uint64_t)res_hi << 32);
 	}
 
 	res += (uint64_t)m_hi * n_hi;
