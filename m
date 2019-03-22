Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D1EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072F021900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256906;
	bh=ZbDTmuXI+EN6LGi2WEDBYAqVe+dTVDPZhZ01P9jd7N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aj5E8eGLaU5Lpdn/6cN109aBVOyp8TGyh6rV71VIsbnCy3nEbczpMzGeXW8ZthcPb
	 c1RUgummUM/cLaGX357F6rmy0C5TQOjfodQcyOzPy8ncIJxlXEIcLhOz/XtZNt6BgO
	 3oJP6SWuHNAHSOUtyt+TS0ENemyvAscu0XI/Kn50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbfCVMPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbfCVMPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167842082C;
        Fri, 22 Mar 2019 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256902;
        bh=ZbDTmuXI+EN6LGi2WEDBYAqVe+dTVDPZhZ01P9jd7N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wm4SD4y3pXnQd8DzGbhyOuGVtZ3JuQW+GtYFJSykCTsC+4Io9vLn171GN4nqkZjvn
         xGpb768aGOHQCx6KrPLT6as+/93vw30PVwgQd9/v4cRmyO9MGeajNQvlGN6lTwvH/5
         7RhqFt/FgjXCzPJBvEpMug5sN6T8HmT3xForQHFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 5.0 072/238] mt76: fix corrupted software generated tx CCMP PN
Date:   Fri, 22 Mar 2019 12:14:51 +0100
Message-Id: <20190322111302.852292843@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 906d2d3f874a54183df5a609fda180adf0462428 upstream.

Since ccmp_pn is u8 *, the second half needs to start at array index 4
instead of 0. Fixes a connection stall after a certain amount of traffic

Fixes: 23405236460b9 ("mt76: fix transmission of encrypted management frames")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -309,7 +309,7 @@ void mt76x02_mac_write_txwi(struct mt76x
 		ccmp_pn[6] = pn >> 32;
 		ccmp_pn[7] = pn >> 40;
 		txwi->iv = *((__le32 *)&ccmp_pn[0]);
-		txwi->eiv = *((__le32 *)&ccmp_pn[1]);
+		txwi->eiv = *((__le32 *)&ccmp_pn[4]);
 	}
 
 	spin_lock_bh(&dev->mt76.lock);


