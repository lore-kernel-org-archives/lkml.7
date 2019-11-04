Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD50CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FCA217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905162;
	bh=pvimibEjAyXqsfHKR7k5YuuvTWdfplcgN9pW/WPSVwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gmubNBkKJ5xNem6YojCK7ZGFR0lgNoFF+X9ukul2QQ+MVHgQqlRx/8cYnt6Hv5/iJ
	 TWsD1fe0gk3SFfcvaT1Mh6FFQ6aPcL6pjowh/UirQeVJAhvyeThf+3Sy2oIDdA15jK
	 x5/9YX5Snzw/pV4hRrJjdZ21OzEXAnUeeWULBQdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbfKDWGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388887AbfKDWFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:05:49 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBFE20650;
        Mon,  4 Nov 2019 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905149;
        bh=pvimibEjAyXqsfHKR7k5YuuvTWdfplcgN9pW/WPSVwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqg/t9PI2wo27kvEA9XNh6C6F266w9U3FDZRBQT18+pipLvJqkaG6dd9PwNNd0PR7
         x6u0+C283dBTKMYwVIsxiE9W9RFYEerudAZWTm9p72BiZk+V3Ruusml9kaHFu4Xwhv
         1P95voIpliRw599PVkgx6aOk6jab4APF81l96/xI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Austin Kim <austindh.kim@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 044/163] fs: cifs: mute -Wunused-const-variable message
Date:   Mon,  4 Nov 2019 22:43:54 +0100
Message-Id: <20191104212143.434057464@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austindh.kim@gmail.com>

[ Upstream commit dd19c106a36690b47bb1acc68372f2b472b495b8 ]

After 'Initial git repository build' commit,
'mapping_table_ERRHRD' variable has not been used.

So 'mapping_table_ERRHRD' const variable could be removed
to mute below warning message:

   fs/cifs/netmisc.c:120:40: warning: unused variable 'mapping_table_ERRHRD' [-Wunused-const-variable]
   static const struct smb_to_posix_error mapping_table_ERRHRD[] = {
                                           ^
Signed-off-by: Austin Kim <austindh.kim@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/netmisc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index ed92958e842d3..657f409d4de06 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -117,10 +117,6 @@ static const struct smb_to_posix_error mapping_table_ERRSRV[] = {
 	{0, 0}
 };
 
-static const struct smb_to_posix_error mapping_table_ERRHRD[] = {
-	{0, 0}
-};
-
 /*
  * Convert a string containing text IPv4 or IPv6 address to binary form.
  *
-- 
2.20.1



