Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988A820811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049843;
	bh=0ccYZRImOq6k7NzkkZ+OtCHu5TNO2LbskclEdxBBP+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Was6sBm4W+PAgfc4vRRs3MX8kUWqFTHZaWQJDIcitXkcKV8vUzlhgnb5VJie8/6jg
	 Hhigo9UaHNQW2MpC1wfJVkH6aZ6qSA569St0jBcckyBPgeL4ggZDkmlMApL03yy6TE
	 0CY2aO3Se0uslf5Afs9UBLpQA1rr3rd3Q53vLMqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCHM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbfCHM5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:57:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A94320449;
        Fri,  8 Mar 2019 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049838;
        bh=0ccYZRImOq6k7NzkkZ+OtCHu5TNO2LbskclEdxBBP+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhTTWnntOSWyZQO1L+jZFc9Zp3ySdm/8Revxe9EfmWEFWdlO0pu+z0c8a8VxSReRm
         y0h/Df8R3KjNXKhM+ymyxNskTt2GbbpFe0mfVmijUqaGJy1JhC0p/Z9zaSIdi0Qugt
         SdaFi4rk6hhHqAgjOXiYEuqflI7jDKUwkV2MaU68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 36/76] net: dsa: mv88e6xxx: Fix u64 statistics
Date:   Fri,  8 Mar 2019 13:49:48 +0100
Message-Id: <20190308124916.098000309@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 6e46e2d821bb22b285ae8187959096b65d063b0d ]

The switch maintains u64 counters for the number of octets sent and
received. These are kept as two u32's which need to be combined.  Fix
the combing, which wrongly worked on u16's.

Fixes: 80c4627b2719 ("dsa: mv88x6xxx: Refactor getting a single statistic")
Reported-by: Chris Healy <Chris.Healy@zii.aero>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -896,7 +896,7 @@ static uint64_t _mv88e6xxx_get_ethtool_s
 	default:
 		return U64_MAX;
 	}
-	value = (((u64)high) << 16) | low;
+	value = (((u64)high) << 32) | low;
 	return value;
 }
 


