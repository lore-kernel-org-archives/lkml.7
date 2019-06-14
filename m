Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEFEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2952E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534802;
	bh=PglNUDH2HfuSnyznp5jrWjhtM2p458AuadlDcL74E8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ON3Yd5e5z2lSrgkRHoe79eocOKaJB91411GNHd3nrxtjL/gvya29DOZLMi0MWyQME
	 ekE+H7MIbC8gI3wEf17mEN4f3fc5zQHRCuoVg4wWCNk+V/BuTf/eVkoL8bQJK6ZftY
	 do5UXUEUBa+gMmiiuA1hGR0BgXCFIQ6urYR9idmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfFNRwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=on49LFR2Mxa07GhXxgZ7Axcy6mlw0U0fiTcIyAPkMAk=; b=rzt31j/inNFrKv8Sc+Zzo62oKz
        lfKUKugA+MJJ/ulb/Wl0PQKPeVIb6m+XkvXolvOoqu71dAeClJiTLDgiBrRjML5xB45cqQbktleQv
        aY5yGLeHVh1UedHICNmT84ltb9Ls23PGYj/raKH3MnvwdFmtfZ+yaVEtghIpfBtL6bUZnIJUKsdZV
        EoqSPFFKPc0pN2Igpbk38D151Wq9zo0Xerids4Zq6OIozC1FWQFcv8csdA1lwKm/jYWgw0OfkcjXn
        F0gRS5TiEn8FC9x9rZ54ST9vzwlsByoY+kvny+fE/oTzFBAtV9Syj2pRh0yIRpHFxWOcYM0Wtq6Eb
        JXlLgQcg==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000Pe-KR; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002P6-VW; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 11/16] scripts/get_abi.pl: add a handler for invalid "where" tag
Date:   Fri, 14 Jun 2019 14:52:25 -0300
Message-Id: <1b6ffc81e3c02368eb3e363cdd64acb1d1b87d32.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABI README file doesn't provide any meaning for a Where:
tag. Yet, a few ABI symbols use it. So, make the parser
handle it, emitting a warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 329ace635ac2..c5038a0a7313 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -92,6 +92,12 @@ sub parse_abi {
 				}
 			}
 
+			# Invalid, but it is a common mistake
+			if ($new_tag eq "where") {
+				parse_error($file, $ln, "tag 'Where' is invalid. Should be 'What:' instead", $_);
+				$new_tag = "what";
+			}
+
 			if ($new_tag =~ m/what/) {
 				$space = "";
 				if ($tag =~ m/what/) {
-- 
2.21.0

