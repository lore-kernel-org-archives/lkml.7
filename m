Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CB92341C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495356;
	bh=Hx/oTr1LiKPxSvknHAXUYWhatBWqSa8VofgNXmS2oX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMbQac6SVgDmrQnvoHQkgWAt2Lg1CRbU8Fv5XPmM9tePrNUwNx5AgDQ8y2ub7BzYh
	 UFzHrj6v2mTnvSekeT9F2vh0qkf/qgEQ4ca598FVlkzZnnxrmqaABnwI6p9LLd2sI6
	 yuBLbEyfKfZ06olurgHBQVdy6rtbRWJOaWfbFyJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391799AbfHVRZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404135AbfHVRYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:36 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D8C2341C;
        Thu, 22 Aug 2019 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494675;
        bh=Hx/oTr1LiKPxSvknHAXUYWhatBWqSa8VofgNXmS2oX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuZDDF84xSO4Ef5ZaWa+Mfs9KwrYqn0mZwGerh95P5n22YaEhZ/Np8B1yMYFJCYO6
         Xj5CnTmb6GlmL5PdyaFC6ZnOCKlIzBZ/CeaKInCRwV/qEomnh5yXv4psAKWdfk66xI
         25+44ge+dN6Df/K1k/jmDH1oFWw9X1qPP0eNRLn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3499a83b2d062ae409d4@syzkaller.appspotmail.com,
        Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 19/71] net: usb: pegasus: fix improper read if get_registers() fail
Date:   Thu, 22 Aug 2019 10:18:54 -0700
Message-Id: <20190822171728.426732549@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kirjanov <kda@linux-powerpc.org>

commit 224c04973db1125fcebefffd86115f99f50f8277 upstream.

get_registers() may fail with -ENOMEM and in this
case we can read a garbage from the status variable tmp.

Reported-by: syzbot+3499a83b2d062ae409d4@syzkaller.appspotmail.com
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/pegasus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -285,7 +285,7 @@ static void mdio_write(struct net_device
 static int read_eprom_word(pegasus_t *pegasus, __u8 index, __u16 *retdata)
 {
 	int i;
-	__u8 tmp;
+	__u8 tmp = 0;
 	__le16 retdatai;
 	int ret;
 


