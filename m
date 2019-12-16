Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A39C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D4121739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520226;
	bh=zJCOqmJyuSeJGxNNSUsgQII3CyhLR6EHjhTErZkdbLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MobJiMZlfBrxPCBn2YSWK5LbwaGrMRBAiDuX9rtD7ySx/BxUz8NAco4Cchgo8U4OL
	 J3QJneXOzwIeCNIKISGnf6Rqex0zoJ0AqP+OA9N1D3c7s/PmURW0LfhDxQX2VamOWH
	 Y7WqCs9prjcIbgA/gcKuSV0d16tCg01gZdr7vLyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfLPSRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbfLPSQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C275206EC;
        Mon, 16 Dec 2019 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520218;
        bh=zJCOqmJyuSeJGxNNSUsgQII3CyhLR6EHjhTErZkdbLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBQcbfuvBVamgj+S6Pf9kHQ5Qt9lVz9+wQPyoAntTy/FOoZkK81FnM2DM8cNFPR0l
         OERc/8wEn/OX8wjaw9RIGndwRvEPDeqybZJh9bbYIbTKpcbFgzXnPYMxx4/Xjb3bBh
         9azV8bo4OxKAbdkJaA8XerFekzXIm4W+Ga3yTdx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        linux-usb@vger.kernel.org,
        =?UTF-8?q?Heikki=20Krogerus=C2=A0?= 
        <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.4 064/177] usb: typec: fix use after free in typec_register_port()
Date:   Mon, 16 Dec 2019 18:48:40 +0100
Message-Id: <20191216174832.699676929@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit 5c388abefda0d92355714010c0199055c57ab6c7 upstream.

We can't use "port->sw" and/or "port->mux" after it has been freed.

Fixes: 23481121c81d ("usb: typec: class: Don't use port parent for getting mux handles")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: stable <stable@vger.kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20191126140452.14048-1-wenyang@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/class.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1592,14 +1592,16 @@ struct typec_port *typec_register_port(s
 
 	port->sw = typec_switch_get(&port->dev);
 	if (IS_ERR(port->sw)) {
+		ret = PTR_ERR(port->sw);
 		put_device(&port->dev);
-		return ERR_CAST(port->sw);
+		return ERR_PTR(ret);
 	}
 
 	port->mux = typec_mux_get(&port->dev, NULL);
 	if (IS_ERR(port->mux)) {
+		ret = PTR_ERR(port->mux);
 		put_device(&port->dev);
-		return ERR_CAST(port->mux);
+		return ERR_PTR(ret);
 	}
 
 	ret = device_add(&port->dev);


