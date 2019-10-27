Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75228CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2CC2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211798;
	bh=fVWoBwwgNEWgoLCEhrftmkxkEqC7gx7en4NeMZ6wa74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZywwklBDGRpP6fV4ee0vtZ7Vgk8jm2RL8aW5SXwxP62ZuB2jjQ+dD/XqSEL+vRXo6
	 ZOgiq8h1PalmrBmu38vw9Asuy8EeojsWB+VQKgYHbi7TXGgTUPecd9lZhdke8sY185
	 UqrhNB9ypR1xMhjHvLVVOlRoLoqQmYhES3KGFXIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfJ0VTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731509AbfJ0VTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:19:44 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B0C21850;
        Sun, 27 Oct 2019 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211183;
        bh=fVWoBwwgNEWgoLCEhrftmkxkEqC7gx7en4NeMZ6wa74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMqa/DrpC7tr8BwLFu7bRuVwIHZvZBIaiISlIRbrPiqd1FjIFu+BuRhJOvuLwn757
         HBWikz+ih9zK2DJvDQmrKWczydljI+dcIlH/wpNGHiHjY0W5WBLe1gxQ9LigaxIlnM
         9U47vkn/awMoiqF5//sIug6re8fzlYxhd7Oi04UA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 061/197] filldir[64]: remove WARN_ON_ONCE() for bad directory entries
Date:   Sun, 27 Oct 2019 21:59:39 +0100
Message-Id: <20191027203354.961446977@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit b9959c7a347d6adbb558fba7e36e9fef3cba3b07 ]

This was always meant to be a temporary thing, just for testing and to
see if it actually ever triggered.

The only thing that reported it was syzbot doing disk image fuzzing, and
then that warning is expected.  So let's just remove it before -rc4,
because the extra sanity testing should probably go to -stable, but we
don't want the warning to do so.

Reported-by: syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com
Fixes: 8a23eb804ca4 ("Make filldir[64]() verify the directory entry filename is valid")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/readdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 6e2623e57b2e8..d26d5ea4de7b8 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -105,9 +105,9 @@ EXPORT_SYMBOL(iterate_dir);
  */
 static int verify_dirent_name(const char *name, int len)
 {
-	if (WARN_ON_ONCE(!len))
+	if (!len)
 		return -EIO;
-	if (WARN_ON_ONCE(memchr(name, '/', len)))
+	if (memchr(name, '/', len))
 		return -EIO;
 	return 0;
 }
-- 
2.20.1



