Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26638C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564753010;
	bh=afVK1GydZ176bB34iu21fcEjLQh5t7y/JRf0921mJLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bfQOHN8GusDI0MOOHnZ31CABg2uY9HJGbZx7qTHAke2URI+6hV6kS2msYfbMslEWP
	 iOCbHQ9Asq7eXEmCv8Pz7fGHLispXGf/FcoWigqwh4pFhLNVJTTkGLPWAwZYcap4Tj
	 +rqfV4yDRLcOHq5f7bZNHhZ6DbEQzS6uforwkNYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436485AbfHBNgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393276AbfHBNUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3B12173E;
        Fri,  2 Aug 2019 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752003;
        bh=afVK1GydZ176bB34iu21fcEjLQh5t7y/JRf0921mJLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDmTGdKh8FK31+ildifU49a7qf83To6FOuxIYNoLqbiWgBqt/HKcHLOtYdNpLnRqv
         8PpapdmdaaUNeQlASk60/zSByqgxoTRFZcP9yS63PHDUC3D3t+084v5TaGyt3dMkGY
         WKb73hwbwf0+N0+lQpXqE3sLXlDY5O+vyybMsEtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 09/76] scripts/sphinx-pre-install: fix script for RHEL/CentOS
Date:   Fri,  2 Aug 2019 09:18:43 -0400
Message-Id: <20190802131951.11600-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

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

