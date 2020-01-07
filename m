Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6681AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDCC20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431759;
	bh=zUoUxVZ4HMU1GfpgdVvtlZA8DUP4zKyLlTEL+8c6ZzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MKJxKiRSRfLCcIyIiwxLLUXgUfuQkhNwhHOY8ySRVctHghzGISOP0Df2/3PtZrFlZ
	 FvYRK45ae0JFFqNRc4oZPX4pQdbFAb0xQOuJ2T6xehuIz9jpjtCRTcnyb+0NSRogwn
	 Bzbwx/nGrWC/Co6oDQZkgT+fJAkKrFtBgckaLGl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgAGVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgAGVH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0FAC2087F;
        Tue,  7 Jan 2020 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431248;
        bh=zUoUxVZ4HMU1GfpgdVvtlZA8DUP4zKyLlTEL+8c6ZzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUd10dWNtIpwXUqfx28c1wdkdRN0vBmo5Jo0JDVaLi81OkCaIx1X6vc4XdwtqMwPn
         cOPAH5gW+mCPeXNfJIV/5rFc2W4c8LHg2PJl2CG00Fh8tMeF3Eh7SwYepHMZUrpWIu
         HQsQYd48JKMuzD5xJPYjuQz722pUQCRBqrJVYv04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.19 095/115] fix compat handling of FICLONERANGE, FIDEDUPERANGE and FS_IOC_FIEMAP
Date:   Tue,  7 Jan 2020 21:55:05 +0100
Message-Id: <20200107205307.097213619@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 6b2daec19094a90435abe67d16fb43b1a5527254 upstream.

Unlike FICLONE, all of those take a pointer argument; they do need
compat_ptr() applied to arg.

Fixes: d79bdd52d8be ("vfs: wire up compat ioctl for CLONE/CLONE_RANGE")
Fixes: 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
Fixes: ceac204e1da9 ("fs: make fiemap work from compat_ioctl")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/compat_ioctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1401,10 +1401,11 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned i
 #endif
 
 	case FICLONE:
+		goto do_ioctl;
 	case FICLONERANGE:
 	case FIDEDUPERANGE:
 	case FS_IOC_FIEMAP:
-		goto do_ioctl;
+		goto found_handler;
 
 	case FIBMAP:
 	case FIGETBSZ:


