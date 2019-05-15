Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D78C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18398216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918272;
	bh=M2A9iqhs/KVUvfAoeL7RgXhLq80Db758QtOaHvcXZro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFeTgNRYNW0i3f6EM2uOt6yGQJXP0dLvsbYOoDJDXq6Ew8Y1aww7NPiS9rAt1BYpI
	 UgYlktVwpPKqANdELEFFbp4q5WAdv9GnQ4Q9H3BezVJsBUqVYlPmxv2tCjdgolb1xe
	 xKTjmpHd0hz8FhZewHVvp1tolz/GYOfyRD+OOodk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfEOLEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfEOLE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:04:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B022E2084F;
        Wed, 15 May 2019 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918266;
        bh=M2A9iqhs/KVUvfAoeL7RgXhLq80Db758QtOaHvcXZro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKbr4ltNPoHZ+Ep7GjIYp1ewWz4SxLeB3KbhV6g0n8XP6vnKhQfC+6TjrLjHt3L2U
         mhNNAbG2pvGdf2v8wbQz277KstYExDcTRpDqd0Hcw6CVqMQAGXke7ovJUsAQAAPKxp
         wbHervbi/10ifjsiPzecxyV1LtlCWLwCc8aFYNSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com,
        Ben Hutchings <ben@decadent.org.uk>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 066/266] slip: make slhc_free() silently accept an error pointer
Date:   Wed, 15 May 2019 12:52:53 +0200
Message-Id: <20190515090724.672954939@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit baf76f0c58aec435a3a864075b8f6d8ee5d1f17e upstream.

This way, slhc_free() accepts what slhc_init() returns, whether that is
an error or not.

In particular, the pattern in sl_alloc_bufs() is

        slcomp = slhc_init(16, 16);
        ...
        slhc_free(slcomp);

for the error handling path, and rather than complicate that code, just
make it ok to always free what was returned by the init function.

That's what the code used to do before commit 4ab42d78e37a ("ppp, slip:
Validate VJ compression slot parameters completely") when slhc_init()
just returned NULL for the error case, with no actual indication of the
details of the error.

Reported-by: syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com
Fixes: 4ab42d78e37a ("ppp, slip: Validate VJ compression slot parameters completely")
Acked-by: Ben Hutchings <ben@decadent.org.uk>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/slip/slhc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -153,7 +153,7 @@ out_fail:
 void
 slhc_free(struct slcompress *comp)
 {
-	if ( comp == NULLSLCOMPR )
+	if ( IS_ERR_OR_NULL(comp) )
 		return;
 
 	if ( comp->tstate != NULLSLSTATE )


