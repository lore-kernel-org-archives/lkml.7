Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687ED205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212207;
	bh=P5TbDHn4L8lp7SJMwGX8ysHqwlmcFsq8WwQEoWNuwV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dE9ZyjvNn/TUBiZqWdiiIAJASdbDZT9EKgWjA7HCk9OfkHsS+L7nioNAqVXHllaIw
	 RF/7/2/jL8lYxo3+1955GYhG8NQu2vVa2v6gznRER6VGo9HEmVWiMzGmJrvCDT/K9Z
	 djE/q93YIHoCHxXvdUPkPdOT9abc9tkhH2x7B86M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfJ0VGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfJ0VGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:06:20 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94E9214AF;
        Sun, 27 Oct 2019 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210380;
        bh=P5TbDHn4L8lp7SJMwGX8ysHqwlmcFsq8WwQEoWNuwV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQEp1udP1XmstkZoazwqCEE8cFJJgNCUUyfEnOY7uw0QvATCe8fw44ro+nfz49qD6
         6FHP/E+sJkO1w65t/4jDywNggZrdDAMIiSDUsH+Att9IdOalhGprPvGcV2/mIotMCS
         dJUnyUWvrc1EpnXqY7nMT0PUT2cQQ8udjSejYqI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Paul Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 46/49] xen/netback: fix error path of xenvif_connect_data()
Date:   Sun, 27 Oct 2019 22:01:24 +0100
Message-Id: <20191027203203.808402034@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit 3d5c1a037d37392a6859afbde49be5ba6a70a6b3 upstream.

xenvif_connect_data() calls module_put() in case of error. This is
wrong as there is no related module_get().

Remove the superfluous module_put().

Fixes: 279f438e36c0a7 ("xen-netback: Don't destroy the netdev until the vif is shut down")
Cc: <stable@vger.kernel.org> # 3.12
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netback/interface.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -706,7 +706,6 @@ err_unmap:
 	xenvif_unmap_frontend_data_rings(queue);
 	netif_napi_del(&queue->napi);
 err:
-	module_put(THIS_MODULE);
 	return err;
 }
 


