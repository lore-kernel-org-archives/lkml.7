Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3832C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A01214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412271;
	bh=Z00Wtb1cGyPC4S9wAr3FTIzKZKvKbI0MhynQ/CQrk3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPJrauiaPSFvcxnXtIeWkuAxUrQ9o2+Ghp7pnAX3oWHJ4yfmRhLnMlKQErKmQc9Cb
	 lOAPsR7TYua83UZHwuF25YKfN0pX0Bp4WVgdAWvUmOSU0KJqGfFMOS410R3y3Tq9qn
	 4fp6PBPcvg6GAp00S8dDRPkoFLjFcd3jHwqsPKLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfCLRQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbfCLRPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:45 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB802184C;
        Tue, 12 Mar 2019 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410945;
        bh=Z00Wtb1cGyPC4S9wAr3FTIzKZKvKbI0MhynQ/CQrk3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2HZqWnNHIMRSi6QnEFeh06ggJgm6gg6Jc9POn0i3TrA4WjLkQBjC4TpfNjtbsLUjg
         RjmCU+pKh6yRhemuG8UJ7ZT7W/gF7K37xWI5Y8lP61rNxrM4IQCuDebw9zU+C+JPyK
         Kazv1a7a8LiDqCULUjCvoLqvLnYca0yZPcBET5pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 009/135] net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6xxx_port_set_duplex
Date:   Tue, 12 Mar 2019 10:07:36 -0700
Message-Id: <20190312170342.015514741@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit c6195a8bdfc62a7cecf7df685e64847a4b700275 ]

When testing another issue I faced the problem that
mv88e6xxx_port_setup_mac() failed due to DUPLEX_UNKNOWN being passed
as argument to mv88e6xxx_port_set_duplex(). We should handle this case
gracefully and return -EOPNOTSUPP, like e.g. mv88e6xxx_port_set_speed()
is doing it.

Fixes: 7f1ae07b51e8 ("net: dsa: mv88e6xxx: add port duplex setter")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -165,7 +165,7 @@ int mv88e6xxx_port_set_duplex(struct mv8
 		/* normal duplex detection */
 		break;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_MAC_CTL, reg);


