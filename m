Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378B5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9221841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534813;
	bh=uPweYfsISwDJSPQwx5Q0u8DIkJH3enVg1PPEgVyVCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z0emtOaROza6e+4jZKlyJ5PNOWRK5MPWgnaPF2wA9oMfU4uronvkkOCnLavmXVj4+
	 ZIt/7WpoOuqYNifBlc3BtcqBg6G7HxxiFUM3PAYEKLAxdDUzF2EQK67DAxCMqYn1HR
	 tQrB9kCRr+ngaOc5qtq/yclYe9J+g5ydGRHUGLDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfFNRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rO3bjQzjDxRANZzkYcNidTwoC5hB1Y63PVyrEzCq1+c=; b=NUw6NxIreLD9FKP4unfrcSMyu4
        fF1aKdoVRZFT/ogLyMwcwtX8omVt4DLNIVnutihYh2mC86CB++GxD+zmYgt5PjfwZUNTCYK3jPKZQ
        wvyFGoGgZ/uAvrpRxGLNWdQdqpc8yI9P6iInRTfIsBobblD1bxRuLMYUGonW+h7dZg84MHT+yRATL
        BJi+hPVuFShs8HVTtLxweBK1DyFUIjZK3XqtK+9L5TR2efgafSuzVyKgS0gBwV1mXS4utaS/57viR
        JbQs5OQIlt4ZT9OD4Zs+6jqszltBBRc7A0cNNxGWKMx+PpNkzvkOJQvo8XFwPu5CSwflxV1UaaaYI
        H9Uq+mjQ==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000Pc-K2; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002Oy-Tx; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/16] scripts/get_abi.pl: fix parse issues with some files
Date:   Fri, 14 Jun 2019 14:52:23 -0300
Message-Id: <485e3e80bbddc4e144bc1d110f980ace092c5e1c.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few files are failing to parse:

	Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
	Documentation/ABI/testing/sysfs-class-pktcdvd
	Documentation/ABI/testing/sysfs-bus-nfit

On all three files, the problem is that there is a ":" character
at the initial file description.

Improve the parse in order to handle those special cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 7d454e359d25..116f0c33c16d 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -87,7 +87,7 @@ sub parse_abi {
 					# New "tag" is actually part of
 					# description. Don't consider it a tag
 					$new_tag = "";
-				} else {
+				} elsif ($tag ne "") {
 					parse_error($file, $ln, "tag '$tag' is invalid", $_);
 				}
 			}
@@ -110,7 +110,7 @@ sub parse_abi {
 				next;
 			}
 
-			if ($new_tag) {
+			if ($tag ne "" && $new_tag) {
 				$tag = $new_tag;
 
 				if ($new_what) {
-- 
2.21.0

