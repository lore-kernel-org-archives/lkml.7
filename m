Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90263C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBCC2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482911;
	bh=n+Wons8GrY+1VzeMZgkyPKXji48Eh6cjTU8tvUR/bUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gaVV2Ao8ISOwxrwbu11QijpRCHglozZHGeZUPGIzg4X2AQr+VsH/X/TdYsbTW4c0L
	 CvvGR9KyUlFhxKBDurISf35PiKaSES/8GPifCl50bHn9U0GrGW5efuFgaQ5JxcaaGT
	 EuPpP800OZA0hG0p4ot6fIufToEInQn3LTlCj8bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfLDSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbfLDSIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:08:21 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6265B20674;
        Wed,  4 Dec 2019 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482900;
        bh=n+Wons8GrY+1VzeMZgkyPKXji48Eh6cjTU8tvUR/bUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFsB0G0ABE8UEbWk+H0qeS0zgaFMc88tHYbVvOj/1k4BtGiHOonCz7g69cmzgwSk/
         irx3ZxIq6Izo/+CWAVJd/kRrVh48EJKT+8X276GVOnsj1NRcnfjA2ILguBS8m5nT23
         OXDy/nCtaAoOIbHYMEGsxuITJWw94jDnyBTo1Taw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 143/209] net: dev: Use unsigned integer as an argument to left-shift
Date:   Wed,  4 Dec 2019 18:55:55 +0100
Message-Id: <20191204175333.161893781@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f4d7b3e23d259c44f1f1c39645450680fcd935d6 ]

1 << 31 is Undefined Behaviour according to the C standard.
Use U type modifier to avoid theoretical overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 40b830d55fe50..4725a9d9597fc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3522,7 +3522,7 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	if (debug_value == 0)	/* no output */
 		return 0;
 	/* set low N bits */
-	return (1 << debug_value) - 1;
+	return (1U << debug_value) - 1;
 }
 
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
-- 
2.20.1



