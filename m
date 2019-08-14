Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3293420665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803225;
	bh=H8FDFP5X2a7P0bd89NP2CiZd3e6i1VPxp7ZnyfTSNKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6HkoTW7pLYqica66RhPE86jbk3vGxYX0PpFIGDWWZ6k9TT+GO/amQ0otGmxIJv9X
	 2XFjTX9z+L7xDhI9lRiH4FI4+YRuHOEiYxcHjqcg2JSyNJx+KgIVjTSiROhOXA1y+/
	 d6tRx8gMjBKaLacLEvmNxBSIGmtny1vEzsNSdv/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfHNRUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbfHNRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:10:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959382084D;
        Wed, 14 Aug 2019 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802649;
        bh=H8FDFP5X2a7P0bd89NP2CiZd3e6i1VPxp7ZnyfTSNKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyzLzKsDd1rBqAq/LZi/9s5jc6MMJYK82JXR5+VQjvHj33Imwx9ZeSwmts01nTaWR
         9BSddmqoCioqy5td8VYnt44UxPYWlXfAwWaz9cla8vPSWQl6KhTuuKfzCd7YGyimpw
         Z9conbC4/uVzMQ0WvGeVNIuePu63R6Wj8I3TQqpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/91] scripts/sphinx-pre-install: fix script for RHEL/CentOS
Date:   Wed, 14 Aug 2019 19:01:01 +0200
Message-Id: <20190814165751.278778611@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b308467c916aa7acc5069802ab76a9f657434701 ]

There's a missing parenthesis at the script, with causes it to
fail to detect non-Fedora releases (e. g. RHEL/CentOS).

Tested with Centos 7.6.1810.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 067459760a7b0..3524dbc313163 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -301,7 +301,7 @@ sub give_redhat_hints()
 	#
 	# Checks valid for RHEL/CentOS version 7.x.
 	#
-	if (! $system_release =~ /Fedora/) {
+	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
 	}
 
-- 
2.20.1



