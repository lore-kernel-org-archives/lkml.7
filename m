Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B9CC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9082073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBCJy3n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfGIELV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:11:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37814 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIELV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:11:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so6059995plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oOuUz+FlHTzsKdyIwxlWP47pZojF/z/4N0aGvHihUoc=;
        b=QBCJy3n/IsXOXSkT2G9+znZVCta8Z9LYVi+3YLoUhzfEw/REetxlgmPfsVlhXocYTx
         FB4dleMynxuwjccxlEXLwrZayDdIA2DB9uJ34uxDq5jD456yy4HBflIdIpsUaHt75f+4
         TQNxpHr57XPUpcs83JQRTRTHXFU8WIL7F4XKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oOuUz+FlHTzsKdyIwxlWP47pZojF/z/4N0aGvHihUoc=;
        b=plomNkciYXLitTVRnSK/RKqKo3XfQfGuP02QF3oCO2hnYvVmdII2l0kDTqDMj0Hdr8
         BCflYbwjXx2YUiHGnJemi7+uwrMd3oy7tk1zWiW0mNNYfLVXgGllbPUTzy1nABTzR5l9
         MYMUrHSz/riZHGLSqSLjGnG0E/2Llt1Y3W8Pu58NlR47qnqkBHi8viMV7iUc2a0XCrnu
         YnAOLEWimN7YSO3lMx+45lAAejta6dvqqo1Kg+SzkS2QzQFRBK+5k93MxtpuJ24zEg6X
         AI59wHVRWQsyVlMnQqqgiWk97b760uwvAHc71Lg7LBg1fpSB/ySowRgr6T9W8YH+vOYf
         iEGA==
X-Gm-Message-State: APjAAAUTm7YlkPuV0aPYWTc8dyz1s2HddyUyYowvipdsdxdwdwFlM3sm
        s3bdXKleExV9t6j3JnE8mzzsQw==
X-Google-Smtp-Source: APXvYqwq4yED1slh/ExnhkeQMDtp+eMAAq39flfajBVlOIJLfPdx60EjvhIjBvhgNXRf+ngxf7z3VQ==
X-Received: by 2002:a17:902:f087:: with SMTP id go7mr29282672plb.330.1562645480525;
        Mon, 08 Jul 2019 21:11:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k16sm18943186pfa.87.2019.07.08.21.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 21:11:19 -0700 (PDT)
Date:   Mon, 8 Jul 2019 21:11:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Norbert Manthey <nmanthey@amazon.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [GIT PULL] pstore updates for v5.3-rc1
Message-ID: <201907082110.3C6AF83FA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v5.3-rc1. Details below...

Thanks!

-Kees

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.3-rc1

for you to fetch changes up to 4c6d80e1144bdf48cae6b602ae30d41f3e5c76a9:

  pstore: Fix double-free in pstore_mkfile() failure path (2019-07-08 21:04:42 -0700)

----------------------------------------------------------------
pstore improvements

- Improve backward compatibility with older Chromebooks (Douglas Anderson)
- Refactor debugfs initialization (Greg KH)
- Fix double-free in pstore_mkfile() failure path (Norbert Manthey)

----------------------------------------------------------------
Douglas Anderson (1):
      pstore/ram: Improve backward compatibility with older Chromebooks

Greg Kroah-Hartman (1):
      pstore: no need to check return value of debugfs_create functions

Norbert Manthey (1):
      pstore: Fix double-free in pstore_mkfile() failure path

 fs/pstore/ftrace.c | 18 ++----------------
 fs/pstore/inode.c  | 13 ++++++-------
 fs/pstore/ram.c    | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 23 deletions(-)

-- 
Kees Cook
