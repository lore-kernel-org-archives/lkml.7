Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED0CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCF32133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383113;
	bh=xwr8Gf+ZGbLNOhIHlpy1MgCwANMR3tLyATZ+L+siVIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lSWbILn8m/Cw8Yw/AnkMDGB736Mj2573CWZO7j+Jjmaz2PdGmMEFNtfw1kGXJlUoG
	 vsfPwUTb/9aq3WgGsV7GffDShWqfo4BM3VJ+jzZBtPNeZ/WKR7/9RBoEeHt/Gp5ESW
	 NQH2R8sBspBh6gdfIRtOF3d8HBsup06VhLRuYZhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfJFRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfJFRbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:31:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB3B21479;
        Sun,  6 Oct 2019 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383108;
        bh=xwr8Gf+ZGbLNOhIHlpy1MgCwANMR3tLyATZ+L+siVIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qc9437Gx7P+XPhxMDWvw245ccppvWjRvl2xw5i6a8Ea/XfZB3lVZa5pEvvAfTMeD9
         6KNighCRHMdBlRGC6vjyPnzkMs08FxUpNR0ACGue04EYE0MTeKZtfC7SMMpqIUEYhe
         cM1S8KE3kHRM5TVKQ3MyvVU5/S4N1Z9O0teUC6PA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/106] pstore: fs superblock limits
Date:   Sun,  6 Oct 2019 19:20:42 +0200
Message-Id: <20191006171140.714722041@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>

[ Upstream commit 83b8a3fbe3aa82ac3c253b698ae6a9be2dbdd5e0 ]

Leaving granularity at 1ns because it is dependent on the specific
attached backing pstore module. ramoops has microsecond resolution.

Fix the readback of ramoops fractional timestamp microseconds,
which has incorrectly been reporting the value as nanoseconds.

Fixes: 3f8f80f0cfeb ("pstore/ram: Read and write to the 'compressed' flag of pstore").

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Jeff Layton <jlayton@kernel.org>
Cc: anton@enomsg.org
Cc: ccross@android.com
Cc: keescook@chromium.org
Cc: tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 316c16463b20f..015d74ee31a03 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -162,6 +162,7 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
 	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
 		   (time64_t *)&time->tv_sec, &time->tv_nsec, &data_type,
 		   &header_length) == 3) {
+		time->tv_nsec *= 1000;
 		if (data_type == 'C')
 			*compressed = true;
 		else
@@ -169,6 +170,7 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
 	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
 			  (time64_t *)&time->tv_sec, &time->tv_nsec,
 			  &header_length) == 2) {
+		time->tv_nsec *= 1000;
 		*compressed = false;
 	} else {
 		time->tv_sec = 0;
-- 
2.20.1



