Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5914C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D00C217AB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887417;
	bh=5Z8syyPxu+RIe5Hu9MJdInqhpQxBkHwU4Q6mZlg2V8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Am4MntSHEK2jV/KM4xIOOjM7eMPLfUzBC/mZ7hNjSeEuQXSg2Ubf7gS3JtY5CncPo
	 QH7InYRp+OuhosoXLi8cOmfjI2/+C/2mBH3YP5pX9TkQVrk3NMA8bl21fTC3MCCOAO
	 L2WBNUDq6lXA3eLpcDokXuvsPs/Zj0JnI2QHWhis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfK0Ung (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbfK0Une (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:43:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120DF217D7;
        Wed, 27 Nov 2019 20:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887413;
        bh=5Z8syyPxu+RIe5Hu9MJdInqhpQxBkHwU4Q6mZlg2V8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYjHONjm4PC1Z/dJYnt40OrmJcOXLEG9mbauVSFEd3HA5S6LSVXP/Qx39AJf7rfee
         GdMNAYb5au4cU8WGDMFhd9SRamEZOqxtzIBkNpeqAdnShtdEvX7DLZ1AGRpAloHwKF
         N+wVFwoMZuOXXv5bZ12GZtl44B3adx2nZ/4XSozs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 100/151] dlm: dont leak kernel pointer to userspace
Date:   Wed, 27 Nov 2019 21:31:23 +0100
Message-Id: <20191127203039.370564169@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.ws>

[ Upstream commit 9de30f3f7f4d31037cfbb7c787e1089c1944b3a7 ]

In copy_result_to_user(), we first create a struct dlm_lock_result, which
contains a struct dlm_lksb, the last member of which is a pointer to the
lvb. Unfortunately, we copy the entire struct dlm_lksb to the result
struct, which is then copied to userspace at the end of the function,
leaking the contents of sb_lvbptr, which is a valid kernel pointer in some
cases (indeed, later in the same function the data it points to is copied
to userspace).

It is an error to leak kernel pointers to userspace, as it undermines KASLR
protections (see e.g. 65eea8edc31 ("floppy: Do not copy a kernel pointer to
user memory in FDGETPRM ioctl") for another example of this).

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 9ac65914ab5b0..57f2aacec97f5 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -700,7 +700,7 @@ static int copy_result_to_user(struct dlm_user_args *ua, int compat,
 	result.version[0] = DLM_DEVICE_VERSION_MAJOR;
 	result.version[1] = DLM_DEVICE_VERSION_MINOR;
 	result.version[2] = DLM_DEVICE_VERSION_PATCH;
-	memcpy(&result.lksb, &ua->lksb, sizeof(struct dlm_lksb));
+	memcpy(&result.lksb, &ua->lksb, offsetof(struct dlm_lksb, sb_lvbptr));
 	result.user_lksb = ua->user_lksb;
 
 	/* FIXME: dlm1 provides for the user's bastparam/addr to not be updated
-- 
2.20.1



