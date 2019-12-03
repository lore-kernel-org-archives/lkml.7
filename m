Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745DAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434162073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414641;
	bh=dPW9hbrxxDEY8iGHzWJEA3C6WLw9z0HxL6tSx0XjRlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pm7nOaX/VS2vprSJaXnQXcmHEduskdCCeraSOpCBlY62mjUvFLkR6u/qCvv5721UW
	 FW9uo+A0tUv+mCWT5gCOYnJHh6ToY1XCu8KcSnrjYleUDGo+iphs0J5NQ13MxEWYod
	 arzPKICAxroVsjZNrmOdvadzwaSNBqQ8PUSAIGN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfLCXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbfLCWmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D7F206EC;
        Tue,  3 Dec 2019 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412938;
        bh=dPW9hbrxxDEY8iGHzWJEA3C6WLw9z0HxL6tSx0XjRlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmLZSv8x4334C/GwkTgPiApYhWd1oewF2JoWVahcsiGIGygefPMO+BrDy5oV+K16b
         S3v7ANQr9z5dbR4s2AW9fUOCjq5SfraARpfbZR6Mk9FazEd17tW1WhArIgCm4IJbNe
         oHMJcXQy0WiWMEbdeahUmpBPcznwDYi1Au3YVjxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 073/135] mm/gup_benchmark: fix MAP_HUGETLB case
Date:   Tue,  3 Dec 2019 23:35:13 +0100
Message-Id: <20191203213027.362378108@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit 64801d19eba156170340c76f70ade743defcb8ce ]

The MAP_HUGETLB ("-H" option) of gup_benchmark fails:

  $ sudo ./gup_benchmark -H
  mmap: Invalid argument

This is because gup_benchmark.c is passing in a file descriptor to
mmap(), but the fd came from opening up the /dev/zero file.  This
confuses the mmap syscall implementation, which thinks that, if the
caller did not specify MAP_ANONYMOUS, then the file must be a huge page
file.  So it attempts to verify that the file really is a huge page
file, as you can see here:

ksys_mmap_pgoff()
{
    if (!(flags & MAP_ANONYMOUS)) {
        retval = -EINVAL;
        if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
            goto out_fput; /* THIS IS WHERE WE END UP */

    else if (flags & MAP_HUGETLB) {
        ...proceed normally, /dev/zero is ok here...

...and of course is_file_hugepages() returns "false" for the /dev/zero
file.

The problem is that the user space program, gup_benchmark.c, really just
wants anonymous memory here.  The simplest way to get that is to pass
MAP_ANONYMOUS whenever MAP_HUGETLB is specified, so that's what this
patch does.

Link: http://lkml.kernel.org/r/20191021212435.398153-2-jhubbard@nvidia.com
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/gup_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index c0534e298b512..8e9929ce64cdb 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -71,7 +71,7 @@ int main(int argc, char **argv)
 			flags |= MAP_SHARED;
 			break;
 		case 'H':
-			flags |= MAP_HUGETLB;
+			flags |= (MAP_HUGETLB | MAP_ANONYMOUS);
 			break;
 		default:
 			return -1;
-- 
2.20.1



