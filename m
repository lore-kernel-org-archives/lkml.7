Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A451208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688106;
	bh=9zyKAxeigHwumAxttBRM4JGuddNcttnoVF7+5CAx8Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t+ARB4EACDz2uUnXCV8CPuaY5s0jsA/wX1taR/nDHXoqkDiALstCQipEUMgl32i9V
	 YKw5i9JQudp5uiFGX5s7HWRWW4HZeRa8flAeJ0Ik6B1eYAgMADxBK93IaCDNHuifiX
	 +lB9+auBrGDGBnz7rPGP9Z8MjS2K3SVmH/zCAS7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCDI2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfCDI2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A4F20836;
        Mon,  4 Mar 2019 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688102;
        bh=9zyKAxeigHwumAxttBRM4JGuddNcttnoVF7+5CAx8Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt9JlDvcj13fiG5BkJK2NGYCYaBrMP/gxtY+v+Jlfo+dFXgLmu9ImOVebwYb9eeVj
         9BirrBgX6lClmKhTvLhPYMsYBJmR+RhzpFOQ4DUIH8WsdFmHB03qGoyuisiLD5eQez
         lP2d0+9mn1iEhdYlUAQnJZj/LwRzMNGZLuHtoTCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 04/78] mac80211: Change default tx_sk_pacing_shift to 7
Date:   Mon,  4 Mar 2019 09:21:47 +0100
Message-Id: <20190304081625.700212482@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit 5c14a4d05f68415af9e41a4e667d1748d41d1baf upstream.

When we did the original tests for the optimal value of sk_pacing_shift, we
came up with 6 ms of buffering as the default. Sadly, 6 is not a power of
two, so when picking the shift value I erred on the size of less buffering
and picked 4 ms instead of 8. This was probably wrong; those 2 ms of extra
buffering makes a larger difference than I thought.

So, change the default pacing shift to 7, which corresponds to 8 ms of
buffering. The point of diminishing returns really kicks in after 8 ms, and
so having this as a default should cut down on the need for extensive
per-device testing and overrides needed in the drivers.

Cc: stable@vger.kernel.org
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 net/mac80211/tx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3614,10 +3614,10 @@ void __ieee80211_subif_start_xmit(struct
 		/* We need a bit of data queued to build aggregates properly, so
 		 * instruct the TCP stack to allow more than a single ms of data
 		 * to be queued in the stack. The value is a bit-shift of 1
-		 * second, so 8 is ~4ms of queued data. Only affects local TCP
+		 * second, so 7 is ~8ms of queued data. Only affects local TCP
 		 * sockets.
 		 */
-		sk_pacing_shift_update(skb->sk, 8);
+		sk_pacing_shift_update(skb->sk, 7);
 
 		fast_tx = rcu_dereference(sta->fast_tx);
 


