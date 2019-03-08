Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25860C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCABF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049496;
	bh=RwmG+HV2hsT2pyDG3B7LZrnl7gx5LK2thaGg8EPGeWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zuKLjd9vtZe4FB9RSuLIZayfMINH5iY6CfBxAFB9BAacrWd5vCV1BOjd5nAW6R6YX
	 yRdyyiDARS1ajX0OzfLkeN+0gV3tHKiyTbYVWcNQGuAqJpu1ZEeD87N1MIPkbZvVoJ
	 zIawTo71IkAWpIUK3vZNte/p45b91gjxWK7xXm2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCHMve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfCHMva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:51:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADA62087C;
        Fri,  8 Mar 2019 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049490;
        bh=RwmG+HV2hsT2pyDG3B7LZrnl7gx5LK2thaGg8EPGeWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RreGmJn01pb2HXfitjMy58Ld7bBgyZxa7zleKrzP6o3QNgeYyNo5Kjf+KLdvT1LnX
         cvo2ZfkY1LevoM7fmNV87NwcCXzQ8o0xSKxCZrHjrATtEbB0eDgkLtukSmomSKOE+n
         0I0ILmuW/+I32aXCmXkyCLunxGoNtQpIK0+PJaUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 19/46] net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6xxx_port_set_duplex
Date:   Fri,  8 Mar 2019 13:49:52 +0100
Message-Id: <20190308124903.487564073@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -190,7 +190,7 @@ int mv88e6xxx_port_set_duplex(struct mv8
 		/* normal duplex detection */
 		break;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_MAC_CTL, reg);


