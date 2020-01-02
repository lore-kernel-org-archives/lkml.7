Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F2C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D09222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004005;
	bh=acmRMlViayMjg+TGBcAMp3fREFhCF9WtXzdHfgDleL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UVy+WRA+XnNbmdweljhYXdQPvweAVKnV6I87/Rmc3/mYop5KGRqzbMPhEVGYU/nTJ
	 w+Ku6Ult9DqGV7LLEMjTO+PfGYMX3hTYYaIXnjiXp+6ON0kaB37rrw9X6o3TpNE2td
	 v/VZemiJFOZBeEKAi2USKThzuS4N6N5NSvpcW9Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgABW0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgABW0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19A724649;
        Thu,  2 Jan 2020 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004000;
        bh=acmRMlViayMjg+TGBcAMp3fREFhCF9WtXzdHfgDleL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVc5KjLMxk6POJwQ/LEZetWqh0NTX8uXnpN4C+nYvbRTlNC6hx+u2KzF9PsfY1tXS
         HMUQev0X23YVE57E5i6J2XmoGuhtK7oEpALsgojgclwmM1QS4snhd2wZVcHf9QnDz6
         jgy9cW4/OY6Vo/Mc05dkUY8yo5pUz4dGmTFE2hP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Siddharth Chandrasekaran <csiddharth@vmware.com>
Subject: [PATCH 4.14 62/91] filldir[64]: remove WARN_ON_ONCE() for bad directory entries
Date:   Thu,  2 Jan 2020 23:07:44 +0100
Message-Id: <20200102220441.560177243@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit b9959c7a347d6adbb558fba7e36e9fef3cba3b07 upstream.

This was always meant to be a temporary thing, just for testing and to
see if it actually ever triggered.

The only thing that reported it was syzbot doing disk image fuzzing, and
then that warning is expected.  So let's just remove it before -rc4,
because the extra sanity testing should probably go to -stable, but we
don't want the warning to do so.

Reported-by: syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com
Fixes: 8a23eb804ca4 ("Make filldir[64]() verify the directory entry filename is valid")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Siddharth Chandrasekaran <csiddharth@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/readdir.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -92,9 +92,9 @@ EXPORT_SYMBOL(iterate_dir);
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


