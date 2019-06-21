Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60595C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B25C2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561120357;
	bh=nhFYBYno8vtkxl2tJ62NIHblTTQnAPtPnGhO5YU6Cr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TbJoA0UwsJal3hxM3BFn+0Ot1JCCAGIEeHCxz0D5P4BKaHz0L63jJCYB1kWS6P3Zu
	 l29Y4R+k8Ox7MbxzT1E03WI+x4/9ScEHgM29MQrBRtHHK9kpRTUGjgKmdvqAJkGHB/
	 2/uEjx9QgVwcp+O6x/TIcKgzLL4cyoOnV+F+Snwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfFUMcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:32:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfFUMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GwuJAUByrQHMk1PQs8rz13IEKJH89ptQrCnqtIM5oaA=; b=u4VAe4Nf+MiE1NBAc6SEbTy/07
        GqtBqa5KWo6qlVxnKbuZiCXhv7HQIAdIIy9chEJHKFadB9v0bbOApiCFvjzzNiLTWOlOwcc4ehIjp
        hGAgk+f21xX4y36oDXBwIpQ18VoFlY3rNWh2MSnBAFsXXqQyJgBVe3e4Ju8H2fSNSnAPo/Egt2W/J
        CLhKcKpRKgoWYYjcAdqJHcSwlaIz3Ct/eNAF0yT6f6uUHIkfFPZqPE6QMiOH9gb6TaQUp1rjsIOOt
        KdIoSsISulO14KbAB9dQt0A8r0CYmEXdRc0gm7/RH1+EdznLlI3JGMMQIT8M6/r7RCTXTCdLvPRAa
        V3f0k2HQ==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIiA-0003xL-Di; Fri, 21 Jun 2019 12:32:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heIi7-0001F3-SK; Fri, 21 Jun 2019 09:32:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 3/6] ABI: README: specify that files should be ReST compatible
Date:   Fri, 21 Jun 2019 09:32:03 -0300
Message-Id: <9b471e98b065280f13ad7fa8d9ec128787f21cd9.1561118631.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561118631.git.mchehab+samsung@kernel.org>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we plan to remove the escaping code from the scripts/get_abi.pl,
specify at the ABI README file that the content of the file should
be ReST compatible.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/README | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/README b/Documentation/ABI/README
index 3121029dce21..8bac9cb09a6d 100644
--- a/Documentation/ABI/README
+++ b/Documentation/ABI/README
@@ -32,7 +32,7 @@ The different levels of stability are:
 	layout of the files below for details on how to do this.)
 
   obsolete/
-  	This directory documents interfaces that are still remaining in
+	This directory documents interfaces that are still remaining in
 	the kernel, but are marked to be removed at some later point in
 	time.  The description of the interface will document the reason
 	why it is obsolete and when it can be expected to be removed.
@@ -58,6 +58,14 @@ Users:		All users of this interface who wish to be notified when
 		be changed further.
 
 
+Note:
+   The fields should be use a simple notation, compatible with ReST markup.
+   Also, the file **should not** have a top-level index, like::
+
+	===
+	foo
+	===
+
 How things move between levels:
 
 Interfaces in stable may move to obsolete, as long as the proper
-- 
2.21.0

