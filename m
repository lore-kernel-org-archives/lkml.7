Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA9C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD032085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051524;
	bh=uPweYfsISwDJSPQwx5Q0u8DIkJH3enVg1PPEgVyVCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1/AUYlvyc312zUedBgB9h7FZ2134HbH8RBZzMA805f9gRo8AgKuhDjRa7NOROo15
	 znk6CYTAMXYmjfTdH3hrscf577Cdd6Wg9TyRxnGgV4eHdH5wM9iccdHSxrpIuAPTT9
	 0mcHTuE5h780FabaXO07FBb2V4jvUOt3Ofdzu6Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfFTRZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:25:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rO3bjQzjDxRANZzkYcNidTwoC5hB1Y63PVyrEzCq1+c=; b=qWGjF9nZfVmfvK40xnJaTBGHPu
        3hkxr6WoLtuXlPqyrAcAv16dQo9PNA0NOSbXAh7jdvpqsoDgA1AScMs10OKnGfjMjF1JKE7d2Inqi
        7A+702KeHiZEYgQlpoxZA93NHthspl/UYdQ4ymmgh/pupq8t1smDtSMXXQltURuXTsboHHurGdOYa
        8qCxwV9yB5pdZ+LglViQCV0v2InfBKJuu/68LkbtFYcvDbqXgKVZaVyrLDTO1kH7dbND4XVdNbYyU
        ZjrxfLyadtEMcG7ypzmJDeWbDfN1G3cLdfIgsKV5QTYeLsMAwHnDX727okkVLwQrf4AZn6QqQDIMS
        aKYdVLQA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rx-9X; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000DC-Ok; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/22] scripts/get_abi.pl: fix parse issues with some files
Date:   Thu, 20 Jun 2019 14:23:01 -0300
Message-Id: <485e3e80bbddc4e144bc1d110f980ace092c5e1c.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
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

