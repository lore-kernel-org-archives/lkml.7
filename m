Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D06C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8362E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCGJCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:02:00 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCGJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:02:00 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDhQt-1hCZjv0PiR-00Akoh; Thu, 07 Mar 2019 10:01:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/select: avoid clang stack usage warning
Date:   Thu,  7 Mar 2019 10:01:36 +0100
Message-Id: <20190307090146.1874906-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fHbTah3fz7WH6MIb/uyJkiMRtUkJq94xINrPv3mqYq0WpEmPXA6
 57c4lGYafQ6Z29pxGltyEkAkHd2lzkRWUUs5AxaCpVb16diE/ppftcd5Xlqi1G+YN72yUBz
 L4VQNr/dUcvOb04V4ZEHSVLcx4BCP9KVk2kHU+ayVn+nDvvjQ+zDXFjgV5uWbP2F1coNQD1
 lSP/D7BtDpsqxgIb+BqgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kzJk6NlwIrQ=:nIfv0Nj1msgRnH5vMlj8MG
 DPXm7o7HIAWLEQarTsssNudmTdjappWe6On0qJPjZuXN+4TSgPbzbmidbKKafvFCNaos0iICx
 naJCHKUkYmbeleSsZ6terzMciYiuOzWTFWGKQP8PDiAfnqDgQViV2DVlB/d2y3sT9F+VPWHix
 IbtvHTMzUvgnRJLeVnQPXJRpepxQQyQPaI8iZx+o0KjkRq/IFr2KbkqFN0yGIAfNBOh/owgW9
 2vHt5afPNoPnkQRrQzaYBPS69bzrhHFZ8FNKgDyCndM4WvkAdDxziU6xKjR4VRbxrOdpV3qMc
 o8nFEep2cRlJeg5C+/+vXS1cPC6Ao5+/UKDkn+pTlfBmtVu8RkWi++SJC98wx9wvuzdXhDEVR
 PEqDtm9vUwtIc8BsW1biSpO8xBZ57hlQVQGw/T2tYj4VeGSoAbdBdpKx7qrFZKNz1VrJa6Qxm
 HdY4hCSEFd0OKW62FuPj3wJ6gXPzMIAz9VPvMVG9jSU7ZtboxS7t1LYWhFzl8K18fFSrk2+0u
 Lc1aFgLHeGM91orEo+w20Rkd4Iiii4cTDoD1wk+KWJjFHvwiVMFiss8uWBBcgLRgUC+HlN8Ji
 xZMTw+GkFo17Xhb1I/OJvQaIPk/iGqJNcMyrdMHXxwmHCIvTUQdF+WdHO0nd3iLfTCmZNIp9c
 IclhxM7+luawbQH+6SDPbwB+NJoynY0DJEaDk+CXexUYODqYA/MwMOHNuGEuFIOWhHYtgXjz2
 tqdwh1f1NgCemIysG1Ss5hH3oSAUpoF7WSf6uQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The select() implementation is carefully tuned to put a sensible amount
of data on the stack for holding a copy of the user space fd_set,
but not too large to risk overflowing the kernel stack.

When building a 32-bit kernel with clang, we need a little more space
than with gcc, which often triggers a warning:

fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,

I experimentally found that for 32-bit ARM, reducing the maximum
stack usage by 64 bytes keeps us reliably under the warning limit
again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/poll.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/poll.h b/include/linux/poll.h
index 7e0fdcf905d2..1cdc32b1f1b0 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -16,7 +16,11 @@
 extern struct ctl_table epoll_table[]; /* for sysctl */
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
+#ifdef __clang__
+#define MAX_STACK_ALLOC 768
+#else
 #define MAX_STACK_ALLOC 832
+#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
-- 
2.20.0

