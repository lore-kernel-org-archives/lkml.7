Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8031C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED52133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfJBPOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:14:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49931 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:14:47 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iFgKy-00035s-2J; Wed, 02 Oct 2019 15:14:44 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     libc-alpha@sourceware.org, Jonathan Corbet <corbet@lwn.net>,
        Christian Brauner <christian@brauner.io>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Guillaume Dore <corwin@poussif.eu>, linux-doc@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] Documentation: update about adding syscalls
Date:   Wed,  2 Oct 2019 17:14:37 +0200
Message-Id: <20191002151437.5367-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional information on how to ensure that syscalls with structure
arguments are extensible and add a section about naming conventions to
follow when adding revised versions of already existing syscalls.

Co-Developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 82 +++++++++++++++++++----
 1 file changed, 70 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 1c3a840d06b9..93e0221fbb9a 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -79,7 +79,7 @@ flags, and reject the system call (with ``EINVAL``) if it does::
 For more sophisticated system calls that involve a larger number of arguments,
 it's preferred to encapsulate the majority of the arguments into a structure
 that is passed in by pointer.  Such a structure can cope with future extension
-by including a size argument in the structure::
+by either including a size argument in the structure::
 
     struct xyzzy_params {
         u32 size; /* userspace sets p->size = sizeof(struct xyzzy_params) */
@@ -87,20 +87,56 @@ by including a size argument in the structure::
         u64 param_2;
         u64 param_3;
     };
+    int sys_xyzzy(struct xyzzy_params __user *uarg);
+    /* in case of -E2BIG, p->size is set to the in-kernel size and thus all
+       extensions after that offset are unsupported. */
 
-As long as any subsequently added field, say ``param_4``, is designed so that a
-zero value gives the previous behaviour, then this allows both directions of
-version mismatch:
+or by including a separate argument that specifies the size::
 
- - To cope with a later userspace program calling an older kernel, the kernel
-   code should check that any memory beyond the size of the structure that it
-   expects is zero (effectively checking that ``param_4 == 0``).
- - To cope with an older userspace program calling a newer kernel, the kernel
-   code can zero-extend a smaller instance of the structure (effectively
-   setting ``param_4 = 0``).
+    struct xyzzy_params {
+        u32 param_1;
+        u64 param_2;
+        u64 param_3;
+    };
+    /* userspace sets @usize = sizeof(struct xyzzy_params) */
+    int sys_xyzzy(struct xyzzy_params __user *uarg, size_t usize);
+    /* in case of -E2BIG, userspace has to attempt smaller @usize values
+       to figure out which extensions are unsupported. */
+
+Which model you choose to use is down to personal taste. However, please only
+pick one (for a counter-example, see :manpage:`sched_getattr(2)`).
+
+Then, any extensions can be implemented by appending fields to the structure.
+However, all new fields must be designed such that their zero value results in
+identical behaviour to the pre-extension syscall. This allows for compatibility
+between different-vintage kernels and userspace, no matter which is newer:
+
+ - If the userspace is newer, then the older kernel can check whether the
+   fields it doesn't understand are zero-valued. If they are, then it can
+   safely ignore them (since any future extensions will be backwards-compatible
+   as described above). If they aren't, then the kernel doesn't support the
+   feature and can give an error (``-E2BIG`` is traditional).
+
+ - If the userspace is older, then the kernel can treat all extensions that
+   userspace is unaware of as having their zero-value (and effectively
+   zero-extend the userspace structure when copying it for in-kernel usage).
 
-See :manpage:`perf_event_open(2)` and the ``perf_copy_attr()`` function (in
-``kernel/events/core.c``) for an example of this approach.
+ - If they're the same version, just use the structure as-is.
+
+As with the simpler flag-only syscalls, you must always check that any unknown
+values for flag-like parameters in the passed structure are zeroed.
+
+It is also critical to ensure your syscall handles larger-sized arguments from
+the outset, otherwise userspace will have to do additional (fairly pointless)
+fallbacks for some old kernels. An example where this mistake was made is
+:manpage:`rt_sigprocmask(2)` (where any unknown-sized arguments are
+unconditionally rejected).
+
+To help implement this correctly, there is a helper function
+``copy_struct_from_user()`` which handles the compatibility requirements for
+you. For examples using this helper, see :manpage:`perf_event_open(2)` (which
+uses the embedded-size model) and :manpage:`clone3(2)` (which uses the
+separate-argument model).
 
 
 Designing the API: Other Considerations
@@ -173,6 +209,28 @@ registers.  (This concern does not apply if the arguments are part of a
 structure that's passed in by pointer.)
 
 
+Designing the API: Revisions of syscalls
+-----------------------------------------------
+
+Syscalls that were not designed to be extensible or syscalls that use a flag
+argument for extensions running out of bits (e.g. :manpage:`clone(2)`)
+sometimes need to be replaced.
+
+If the revised syscall provides a superset (or a reasonably large subset, such
+as when a feature that turned out to be a design mistake is dropped) of the
+features of the old syscall it is common practice to give it the same name with
+a number appended. Examples for this include ``dup2``/``dup3``,
+``epoll_create``/``epoll_create1`` and others.
+
+For some syscalls the appended number indicates the number of arguments
+(``accept``/``accept4``) for others the number of the revision
+(``clone``/``clone3``, ``epoll_create``/``epoll_create1``). Recent discussions
+around new syscalls (such as ``clone3``) have pointed to a consensus around
+naming syscalls revisions by appending the number of the revision to the
+syscall name. That means, if you were to post a revised version of the
+``openat`` syscall it should be named ``openat2``.
+
+
 Proposing the API
 -----------------
 
-- 
2.23.0

