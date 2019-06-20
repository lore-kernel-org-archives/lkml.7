Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA099C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DF02085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051447;
	bh=MKRc9+RDngvnVz52hlGDYY+KaYMWxlc05G9WTy6Zzlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SG+nEXTQz+AKNR9ecDGv+d1whLf0+wwDbkIuMSYGNLuFr3IVX3oA6f7m/TVZge+Iq
	 e/zi9jGy0i4h0T15BT/vlSkRAcepdpY/+XDAJElRVVv0S/zW1qtMNzVKYv+ztFfSDc
	 rK7fyUNkb8jxSqfy8qYLeC7Qvk0ixZLo0GCBWs9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfFTRYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:24:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbfFTRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86TkPPpFJuPy6eZbgDCbTxzixd78qAKph70hSGg4B2A=; b=Zh8ChdpjsyoRdr5MI8wxvQhrc/
        r7TNo/xgDdhHJg/JELsFNSjsYg+skhi5iJDyewwBsIcf88Knfwxjf92QGbNI7pqfCTkOPGc3r51I8
        l/jXQdDFz0p7MH72ON/ttQ0DqDkQFk4v++0GnVOaj3H5+4ERT5K7MhrgwTNzZeq824agJ1sWMuRhi
        NOfnDUhZOFubAFRJrTmy7CXxbMFNdbVGdcRC/jtRBK2CZB/9rwK2OBsuyOCZ4q3OvjBFBj6mL4+Fq
        gKGpelt6p62b9D/NIdH0MuzvdoFe2/8RsASaruDT2lrLkckmIM7eN3S2G+Pfjv2RTaHT39kuZLx8r
        kw9oyMqA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rs-8b; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mK-0000E2-2F; Thu, 20 Jun 2019 14:23:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 21/22] scripts/get_feat.pl: handle ".." special case
Date:   Thu, 20 Jun 2019 14:23:13 -0300
Message-Id: <59a9078408e4c4bf593c60af48e30ddfee845354.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status ".." Means that the feature can't be implemented
on a given architecture.

The problem is that this doesn't show anything at the
output, so replace it by "---", with is a markup for a long
hyphen.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_feat.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 401cbc820caa..79d83595addd 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -141,6 +141,8 @@ sub parse_feat {
 				$max_size_arch = length($a);
 			}
 
+			$status = "---" if ($status =~ m/^\.\.$/);
+
 			$archs{$a} = 1;
 			$arch_table{$a} = $status;
 			next;
-- 
2.21.0

