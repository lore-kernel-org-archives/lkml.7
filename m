Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4BC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22BF2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428637;
	bh=ma8d3dNEYqZtZeIzdvGhKY/Cc3YnapHQl95VPRiT/sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L6K7hTpZSpg0x/uL+oIlfMc0sjQt4fdXgXiLMes6cemvroNCyGkn/xconKeakJo8+
	 SPvz99ae1DFOPkdImn/6m64dakBJ3QRg+2Vg7SR/mGyfgEc64+Q+ExjYdsUyb+8YV7
	 DQG3Sx5RnBL3ZTDsTjVgVPq//fd1I3EQhtM2XMXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfG2Tag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbfG2Tac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:30:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494412070B;
        Mon, 29 Jul 2019 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428631;
        bh=ma8d3dNEYqZtZeIzdvGhKY/Cc3YnapHQl95VPRiT/sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQffh8+0+9j3UJJ0ySvSEj7QHwfP60dLv0MCUGSJL6eJ+HBlAM/YMHAwONFdNTRFX
         8WvGtI47+8hfrsQYjtj1z07MnXdCmcSQ5+MaEPGeVJ4WD+pB82wsu9QjFA4y4oAHIJ
         mhiOYUTofrKG5lq+HQ/3oFPk2TQ8JGCgGa8UhywU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 136/293] pnfs/flexfiles: Fix PTR_ERR() dereferences in ff_layout_track_ds_error
Date:   Mon, 29 Jul 2019 21:20:27 +0200
Message-Id: <20190729190834.971956927@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 8e04fdfadda75a849c649f7e50fe7d97772e1fcb upstream.

mirror->mirror_ds can be NULL if uninitialised, but can contain
a PTR_ERR() if call to GETDEVICEINFO failed.

Fixes: 65990d1afbd2 ("pNFS/flexfiles: Fix a deadlock on LAYOUTGET")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # 4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -306,7 +306,7 @@ int ff_layout_track_ds_error(struct nfs4
 	if (status == 0)
 		return 0;
 
-	if (mirror->mirror_ds == NULL)
+	if (IS_ERR_OR_NULL(mirror->mirror_ds))
 		return -EINVAL;
 
 	dserr = kmalloc(sizeof(*dserr), gfp_flags);


