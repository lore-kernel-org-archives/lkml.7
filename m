Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48866C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14715216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802160;
	bh=Tt2EqeaocrgyBp4xquR/jMgpydrdFvFboGMgsd9PDgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVFOBZYrtWKYe21xbjFS6vKF0844aOVLkt/tPQJ2PtmIsiA/z1RhOh2l+zr6N+W3I
	 DxRU60Uoe3JDNdFr0FkyLYDGuh+i1TUhYEQQsQtEcR9XT27AunFnEKtxV/gRGSNrfh
	 VWN88kB3Ye7NmO6NIOhHBv2LaZx054ksEhBPuY00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfHNRCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbfHNRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:02:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE97214DA;
        Wed, 14 Aug 2019 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802155;
        bh=Tt2EqeaocrgyBp4xquR/jMgpydrdFvFboGMgsd9PDgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0Lt7H/1vL9vPipNyWw933GAqnsgb2PZxN8vBN5nf36SB0KJ+TjajArKO4GBSlk9t
         +0evR3Np0HIv2+h2elxjrYmeuPaArtnG8DydSHY2DbFyM2p2XOZZsxgF1hjKU6XnFB
         4wPojqtq1URapxWCFENCPprQ6gjhzsrNZT4JTp5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gavin Li <git@thegavinli.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.2 016/144] usb: usbfs: fix double-free of usb memory upon submiturb error
Date:   Wed, 14 Aug 2019 18:59:32 +0200
Message-Id: <20190814165800.583805711@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Li <git@thegavinli.com>

commit c43f28dfdc4654e738aa6d3fd08a105b2bee758d upstream.

Upon an error within proc_do_submiturb(), dec_usb_memory_use_count()
gets called once by the error handling tail and again by free_async().
Remove the first call.

Signed-off-by: Gavin Li <git@thegavinli.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190804235044.22327-1-gavinli@thegavinli.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/devio.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1788,8 +1788,6 @@ static int proc_do_submiturb(struct usb_
 	return 0;
 
  error:
-	if (as && as->usbm)
-		dec_usb_memory_use_count(as->usbm, &as->usbm->urb_use_count);
 	kfree(isopkt);
 	kfree(dr);
 	if (as)


