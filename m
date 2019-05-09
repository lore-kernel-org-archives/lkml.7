Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E124C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE220656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428280;
	bh=w5ymQl7lHM1mS1Q4LCFLffre3cuHotjrwiYmGOLvaco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WFKml6qtWu3+5sXJSwVpIXOmJA+XOr1d2OMZPM8fdKjLanx+xC0itNJmyBEIfpqvz
	 8vo8IF3qCgRHGj9dlqr6d+ILITIl7lmPO9VqyPs1XgY5OxGgu0j11Kbw4JhEszg/MC
	 eOfgFAbvifqwZ/0ClkbTE3Pv46SewG/MdD+neEcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfEIS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfEISxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:53:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C413217F9;
        Thu,  9 May 2019 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428023;
        bh=w5ymQl7lHM1mS1Q4LCFLffre3cuHotjrwiYmGOLvaco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYDdozm+iMfmo31B8i62zB28Coc66JfLDm74PvanmW5LpQkuGipKHF8hxNzLA2oe4
         zCIdCfww8VERc5efRNy06Yfpou41LR31msGR0Nxiwoawmwf3zmT9hu8JWvoBB6wyOC
         0TKhwNwb4FrNDhYClyQnUi9IKEphj+G7jSzoxLpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.0 93/95] i3c: Fix a shift wrap bug in i3c_bus_set_addr_slot_status()
Date:   Thu,  9 May 2019 20:42:50 +0200
Message-Id: <20190509181315.703849416@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 476c7e1d34f2a03b1aa5a924c50703053fe5f77c upstream.

The problem here is that addr can be I3C_BROADCAST_ADDR (126).  That
means we're shifting by (126 * 2) % 64 which is 60.  The
I3C_ADDR_SLOT_STATUS_MASK is an enum which is an unsigned int in GCC
so shifts greater than 31 are undefined.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i3c/master.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -385,8 +385,9 @@ static void i3c_bus_set_addr_slot_status
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~(I3C_ADDR_SLOT_STATUS_MASK << (bitpos % BITS_PER_LONG));
-	*ptr |= status << (bitpos % BITS_PER_LONG);
+	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
+						(bitpos % BITS_PER_LONG));
+	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)


