Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D74AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7C52148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128215;
	bh=rjhQagdZWz03Patb6Ca788cwXphIxjDkSeG3fawGThQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMPK+TZM005C9sSSyASvHmea2UHhJQCsvhHADTF4PLjd7sdNG3cjbiOmhqAA/juzt
	 jHVXvY9MFlX8w1rxTsFaTL++1M8mA7Wd63eH9LGis/RplOHIzG6B0Dj6lowX4CPvAr
	 y3xaENgY8+gbqpnYWsbRhkla2lGTziUlyK+IYtEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbfDXRuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390875AbfDXR3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321B120811;
        Wed, 24 Apr 2019 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126991;
        bh=rjhQagdZWz03Patb6Ca788cwXphIxjDkSeG3fawGThQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8sbiNAF7wXgPyaQJ+V9FhrF6innOG3lpAGQrOIA6TH3gSbQZMaWvmSOcjjyqOZTA
         8g024+xROCrnsZjDtngKjwt+w+j+J+FLYAYq3G7oNTL24zr1NAkYc7uopz0X4mLOWH
         aaUlBrcG0Yj/aySwvQDk96OboZR0iQLfPq98IfPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kevin Darbyshire-Bryant <kevin@darbyshire-bryant.me.uk>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 4.19 20/96] sch_cake: Use tc_skb_protocol() helper for getting packet protocol
Date:   Wed, 24 Apr 2019 19:09:25 +0200
Message-Id: <20190424170921.210034778@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit b2100cc56fca8c51d28aa42a9f1fbcb2cf351996 ]

We shouldn't be using skb->protocol directly as that will miss cases with
hardware-accelerated VLAN tags. Use the helper instead to get the right
protocol number.

Reported-by: Kevin Darbyshire-Bryant <kevin@darbyshire-bryant.me.uk>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cake.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1526,7 +1526,7 @@ static u8 cake_handle_diffserv(struct sk
 {
 	u8 dscp;
 
-	switch (skb->protocol) {
+	switch (tc_skb_protocol(skb)) {
 	case htons(ETH_P_IP):
 		dscp = ipv4_get_dsfield(ip_hdr(skb)) >> 2;
 		if (wash && dscp)


