Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A732C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC42077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431727;
	bh=SU7IFwXxIGchuif/YWTqFR+gv0K9MabXSVyIQP1Gu80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VE0MGZ5aVPliP+vDVufwTN0/cXfLYgiXo1MiKkW+pnd71Ls1S890LyGS689HYT0JA
	 Pn/vvbTz6/9hHFDxMWzXUmywa69wjBBrN1aXWwqi/iE/5fvigKQZY0rBKFcDf+2Vtx
	 zwurAprkLB2SlehjYLoYozHPvVGrEgYvOFn9wv8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgAGVP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgAGVIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC92214D8;
        Tue,  7 Jan 2020 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431289;
        bh=SU7IFwXxIGchuif/YWTqFR+gv0K9MabXSVyIQP1Gu80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2OE10hMwk7r5rdPhksOk+fu4tBeii8+ZIXZZdtAvidGnNKzHwAEs9Z57OXQkWjK+Q
         feMpaq8wSJIMEdrzuhilNb2d0AxIsKtw1+L8uX9/k7bC9HuR9yPlbUwenH8HTqdzD6
         q/yf13wjksAIWHYgmPfPAOGG45yB4dAvbFkkqvN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.19 084/115] xfs: dont check for AG deadlock for realtime files in bunmapi
Date:   Tue,  7 Jan 2020 21:54:54 +0100
Message-Id: <20200107205305.737731060@linuxfoundation.org>
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

From: Omar Sandoval <osandov@fb.com>

commit 69ffe5960df16938bccfe1b65382af0b3de51265 upstream.

Commit 5b094d6dac04 ("xfs: fix multi-AG deadlock in xfs_bunmapi") added
a check in __xfs_bunmapi() to stop early if we would touch multiple AGs
in the wrong order. However, this check isn't applicable for realtime
files. In most cases, it just makes us do unnecessary commits. However,
without the fix from the previous commit ("xfs: fix realtime file data
space leak"), if the last and second-to-last extents also happen to have
different "AG numbers", then the break actually causes __xfs_bunmapi()
to return without making any progress, which sends
xfs_itruncate_extents_flags() into an infinite loop.

Fixes: 5b094d6dac04 ("xfs: fix multi-AG deadlock in xfs_bunmapi")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_bmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5239,7 +5239,7 @@ __xfs_bunmapi(
 		 * Make sure we don't touch multiple AGF headers out of order
 		 * in a single transaction, as that could cause AB-BA deadlocks.
 		 */
-		if (!wasdel) {
+		if (!wasdel && !isrt) {
 			agno = XFS_FSB_TO_AGNO(mp, del.br_startblock);
 			if (prev_agno != NULLAGNUMBER && prev_agno > agno)
 				break;


