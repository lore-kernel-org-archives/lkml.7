Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D7C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BCD20644
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947383;
	bh=fbuhbY+84QNU6mdKZxyLD88VMblL578XwdT02sU+kjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0NupSSacQO7sRytCfxlx7WkWG+QVtwyWkvZAshOxEqtc7I+XiMPiTyBukHBOIey54
	 kEo72W8fmMA29N1C7a9ZQGO4tBUJNakrn/7cqkocBRFm+KZyhdatjjSfOyVbvV9N9c
	 sNo+Ou7Zela8uk9T7o3UyXFVyzosOdWNPLZR4Ng4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfIHMtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731624AbfIHMtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:40 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0C521A4C;
        Sun,  8 Sep 2019 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946980;
        bh=fbuhbY+84QNU6mdKZxyLD88VMblL578XwdT02sU+kjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itYqEfw2H0lOYyk6KfsBcsdQRIvs7OulkDyNwbDlLrd4ACySQJ4YmjxzfEWwFi3bq
         KzW7TcdqRaB7AiL/O7+nVeBp6nALeQy23WGW/HITnNHh9ZrdO4X/GyMSJav+a3O/4J
         gppUxWIZJxJpXM7AGJLq3TApQIC1bucueEXLi1PY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 16/94] net: dsa: tag_8021q: Future-proof the reserved fields in the custom VID
Date:   Sun,  8 Sep 2019 13:41:12 +0100
Message-Id: <20190908121150.897345047@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit bcccb0a535bb99616e4b992568371efab1ab14e8 ]

After witnessing the discussion in https://lkml.org/lkml/2019/8/14/151
w.r.t. ioctl extensibility, it became clear that such an issue might
prevent that the 3 RSV bits inside the DSA 802.1Q tag might also suffer
the same fate and be useless for further extension.

So clearly specify that the reserved bits should currently be
transmitted as zero and ignored on receive. The DSA tagger already does
this (and has always did), and is the only known user so far (no
Wireshark dissection plugin, etc). So there should be no incompatibility
to speak of.

Fixes: 0471dd429cea ("net: dsa: tag_8021q: Create a stable binary format")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_8021q.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -28,6 +28,7 @@
  *
  * RSV - VID[9]:
  *	To be used for further expansion of SWITCH_ID or for other purposes.
+ *	Must be transmitted as zero and ignored on receive.
  *
  * SWITCH_ID - VID[8:6]:
  *	Index of switch within DSA tree. Must be between 0 and
@@ -35,6 +36,7 @@
  *
  * RSV - VID[5:4]:
  *	To be used for further expansion of PORT or for other purposes.
+ *	Must be transmitted as zero and ignored on receive.
  *
  * PORT - VID[3:0]:
  *	Index of switch port. Must be between 0 and DSA_MAX_PORTS - 1.


