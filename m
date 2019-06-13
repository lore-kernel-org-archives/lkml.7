Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B964C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACAE2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443040;
	bh=f/qvrBr26RcusG1yuVHygYjdApuT8X2YNkthe7HnCQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xRFJbks0ksk0lmo5N6eGpg7Oni6iYHxA77vcpoPEn9MGSZ6zwBo2FCHt5/ReRTOl0
	 adgrZrGMpFdSuafwmfMBcB9JYgSPDI9DA7+UsQPMEw+MmfaQhqHm7rqjJK2l72s1AI
	 SlsjbOCaJCwDndds+W/cHsHi8v0v60daNqP2FBO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391328AbfFMQXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731012AbfFMIhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96A720851;
        Thu, 13 Jun 2019 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415057;
        bh=f/qvrBr26RcusG1yuVHygYjdApuT8X2YNkthe7HnCQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWJUq5fKgeGCQX/oRMs10pwBxf7FnPPKcghyHESCNqoUkpVbFy8vkZLjMWWg2nwYq
         kGhlqQWOmn3wV2opXS6CTsxkWr/4P2f6POdwnKq4UEmoawMk0dCbKPmuJAUjAc9j1p
         dk2K1gFzZN5GY04pDYMIJEgedz7xRSFLkldi+PRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 44/81] nfsd: allow fh_want_write to be called twice
Date:   Thu, 13 Jun 2019 10:33:27 +0200
Message-Id: <20190613075652.537185641@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0b8f62625dc309651d0efcb6a6247c933acd8b45 ]

A fuzzer recently triggered lockdep warnings about potential sb_writers
deadlocks caused by fh_want_write().

Looks like we aren't careful to pair each fh_want_write() with an
fh_drop_write().

It's not normally a problem since fh_put() will call fh_drop_write() for
us.  And was OK for NFSv3 where we'd do one operation that might call
fh_want_write(), and then put the filehandle.

But an NFSv4 protocol fuzzer can do weird things like call unlink twice
in a compound, and then we get into trouble.

I'm a little worried about this approach of just leaving everything to
fh_put().  But I think there are probably a lot of
fh_want_write()/fh_drop_write() imbalances so for now I think we need it
to be more forgiving.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index be6d8e00453f..85f544007311 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -117,8 +117,11 @@ void		nfsd_put_raparams(struct file *file, struct raparms *ra);
 
 static inline int fh_want_write(struct svc_fh *fh)
 {
-	int ret = mnt_want_write(fh->fh_export->ex_path.mnt);
+	int ret;
 
+	if (fh->fh_want_write)
+		return 0;
+	ret = mnt_want_write(fh->fh_export->ex_path.mnt);
 	if (!ret)
 		fh->fh_want_write = true;
 	return ret;
-- 
2.20.1



