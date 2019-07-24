Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5481C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BD1229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997011;
	bh=UxYvXnkdRDbNmoHxr3kNaNh8LHIa6c+iKXd+dyTranE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKpdaAr09CUpjWhBzEABmC+rceVgJVV7Xx8xwYoUzy+fsurG/bD1UNt4wfkgyzUOa
	 YK44r98ntdMhQt/rkDg7VzGcq1/lt6W6PFqrKALuRRRb5WEVe9acU0Jn9A7MmGjqRI
	 2l5ivypBqXRvspuELAj7fyCUq1IBeWYckj7GbZ+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbfGXTgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfGXTgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:36:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CA1214AF;
        Wed, 24 Jul 2019 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997005;
        bh=UxYvXnkdRDbNmoHxr3kNaNh8LHIa6c+iKXd+dyTranE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuJxCnlNO1Mc3HlImkA2KcWx5mWDRgfSkxqGMILkpf3mRcykDj5Hqw7R49WxR/SId
         J+oZ070sIa6dXtkTPC1BLdhLWntW1DnVuYJODaxg7bNhIGAMi1vKWjraz86zO80Y1O
         QAj2gDfq1QyBVQ9BdcnRkemBR/splZZKN7OMYV50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.2 289/413] Input: alps - fix a mismatch between a condition check and its comment
Date:   Wed, 24 Jul 2019 21:19:40 +0200
Message-Id: <20190724191756.923211294@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 771a081e44a9baa1991ef011cc453ef425591740 upstream.

In the function alps_is_cs19_trackpoint(), we check if the param[1] is
in the 0x20~0x2f range, but the code we wrote for this checking is not
correct:
(param[1] & 0x20) does not mean param[1] is in the range of 0x20~0x2f,
it also means the param[1] is in the range of 0x30~0x3f, 0x60~0x6f...

Now fix it with a new condition checking ((param[1] & 0xf0) == 0x20).

Fixes: 7e4935ccc323 ("Input: alps - don't handle ALPS cs19 trackpoint-only device")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/alps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2876,7 +2876,7 @@ static bool alps_is_cs19_trackpoint(stru
 	 * trackpoint-only devices have their variant_ids equal
 	 * TP_VARIANT_ALPS and their firmware_ids are in 0x20~0x2f range.
 	 */
-	return param[0] == TP_VARIANT_ALPS && (param[1] & 0x20);
+	return param[0] == TP_VARIANT_ALPS && ((param[1] & 0xf0) == 0x20);
 }
 
 static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)


