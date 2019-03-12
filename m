Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749052087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411817;
	bh=b9F0UTbAkXSmU3NLcxTbpVzg0h98nFWCULdu2iQYbtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/6o0EpU8wpLGgxIPOg+3BNeduAPRaeag8lmMmnCyAekarlgpaZ1bbh5Hm07GAyAf
	 J1JcjS5wkHCtLvEhlXExUK1p1qU+CncQMOyzg3J1dk++05NKKbi+G/5Jc0+XKS4Yk8
	 /WN4WGYGUoQWKWsGuJnM9EBojVLOEV/24h5bjoxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfCLRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfCLRRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:18 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C07C2087C;
        Tue, 12 Mar 2019 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411037;
        bh=b9F0UTbAkXSmU3NLcxTbpVzg0h98nFWCULdu2iQYbtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trfVzt3XBZai+2PxRJkxY5KUCvvXDg8zvjKewh4/oQa3/UmnzH7Ljxq1k18eKm1Yx
         M3c5yXkRAL3/3pX7LUsy+nKbIQDVgKFkM5VMa8OG1g+Jgomjt2tygHWz+m8Z7MNqs8
         PY1pH0/inW8AqFtS+b7UbPz8Zsy4Fzvvjn9i+bwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/96] net: dsa: mv88e6xxx: Fix u64 statistics
Date:   Tue, 12 Mar 2019 10:09:34 -0700
Message-Id: <20190312171035.774825697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -798,7 +798,7 @@ static uint64_t _mv88e6xxx_get_ethtool_s
 		if (s->sizeof_stat == 8)
 			_mv88e6xxx_stats_read(chip, s->reg + 1, &high);
 	}
-	value = (((u64)high) << 16) | low;
+	value = (((u64)high) << 32) | low;
 	return value;
 }
 


