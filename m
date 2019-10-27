Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B7CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECF1205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212295;
	bh=nT/j3F0AN5FiUMGZP3CTaQv7AleDUd0qO4qwvbnEMtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wzBx4z3QE/3cT/7Stt2rkCjQwefu0oWTqhmK9++n9hTZyk/Fp3LX1PhbZOez21VjW
	 cf5wItVVvvrsMSuWAs5bj0vwhFGWSL3bALmQLZnKLOMR8zRKKUsIpxJVxtWnOo390x
	 Ifd0lHB4F4Lq1EzYQgTR3pk8Vo+FYPeOlhSokk6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfJ0VEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbfJ0VD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:58 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B19208C0;
        Sun, 27 Oct 2019 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210237;
        bh=nT/j3F0AN5FiUMGZP3CTaQv7AleDUd0qO4qwvbnEMtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yHzex8bFpkGSn5/BSu6dE3pABStkhOd0GZpGaeCNs1z+8X4SG/5fSoFZQUEWQy2Zy
         iji9nwR3P3b7ABYoErQyXL/r09MIQd3yFyARduYdEnzQ/Xrhzbit8Fat3UGMdOE3PY
         YRLnFPoGw+RK1bMntjycqMEy99ljkhN7JUKiPt8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Paul Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 38/41] xen/netback: fix error path of xenvif_connect_data()
Date:   Sun, 27 Oct 2019 22:01:16 +0100
Message-Id: <20191027203133.755136541@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
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
@@ -620,7 +620,6 @@ err_tx_unbind:
 err_unmap:
 	xenvif_unmap_frontend_rings(queue);
 err:
-	module_put(THIS_MODULE);
 	return err;
 }
 


