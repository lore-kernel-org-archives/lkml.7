Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C18EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF025206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803567;
	bh=I6jrD+9sEDG0rP0Kpf9ZIM/0DZYLCKuF5SL2Mdn9uKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3syDd/EcF4KfD4Htwl1SCMHMXSGcfLp9aIv1uGZQb+VjtiBx+d+xNWQzGXjtspVh
	 xb4epmKqSXeShtB/hOzNfhPpiU57iCgPKnhpBsZtiNyM0TiFKPHpY5ffq2YtBfEeVd
	 bezesy7OGoJZ4THGLnkADOjtbNU8SZQbX5JIbPc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfHNRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfHNRFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:05:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4852208C2;
        Wed, 14 Aug 2019 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802307;
        bh=I6jrD+9sEDG0rP0Kpf9ZIM/0DZYLCKuF5SL2Mdn9uKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp3lLOU6s4vCPOKqKjcLblL72Zgl/qLbyFLO3GMBQtObjb3q7gDQKzYWuY9ANWczX
         aOIz6HtkyBUei32WL0wTAHuO7Jp2doH7ts4NssPHa2YwJBXHGsgG7DQDR5UeOBWV+S
         3nkYIVX6wCR9wsLrmvzJNV/OgImUa7ZUU0nIQwPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 057/144] scripts/sphinx-pre-install: fix script for RHEL/CentOS
Date:   Wed, 14 Aug 2019 19:00:13 +0200
Message-Id: <20190814165802.219114463@linuxfoundation.org>
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
index 9be208db88d3a..778f3ae918775 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -364,7 +364,7 @@ sub give_redhat_hints()
 	#
 	# Checks valid for RHEL/CentOS version 7.x.
 	#
-	if (! $system_release =~ /Fedora/) {
+	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
 	}
 
-- 
2.20.1



