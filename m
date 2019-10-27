Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4326DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1103D208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210724;
	bh=adTvinB5qHUTQOXdWUAnUTJQLeswb/Ob77yEnh7asBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gTXJrvbnE59EJYV7vUAiAwPFfH9NoCpgQY9aHoIrXX7gJn0zfx37nkz6AyftAazMs
	 I7+iuL7cBUOXzplAITAmAEUakgt8vV3pJOrEbjy93kWKt3OyfBmecoJuh1GAWLfMhF
	 vj9Ex/jnfCfg3tIVC+LQDhP7uY/kSnTK/AT3ESBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfJ0VMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfJ0VL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:59 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE970205C9;
        Sun, 27 Oct 2019 21:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210718;
        bh=adTvinB5qHUTQOXdWUAnUTJQLeswb/Ob77yEnh7asBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAO7N4K9Gkx/P3EW2Ng19Jz5dywotZObGHM4algbQCZ5y3pomiz51evns3/3WaGUN
         q7raaSaTA/3wB4UB78A5E3B/PXXVKkYa+DOR5cSg7Ky+0ZYPbtEXF/wtZRbbCVQnTt
         P1W2uctGvSr3wR2yoQ87JoUQuuO54rzGHAFh39rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Paul Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 113/119] xen/netback: fix error path of xenvif_connect_data()
Date:   Sun, 27 Oct 2019 22:01:30 +0100
Message-Id: <20191027203349.706116869@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
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
@@ -718,7 +718,6 @@ err_unmap:
 	xenvif_unmap_frontend_data_rings(queue);
 	netif_napi_del(&queue->napi);
 err:
-	module_put(THIS_MODULE);
 	return err;
 }
 


