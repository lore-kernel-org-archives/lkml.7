Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AB720811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfC2SKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:10:49 -0400
Received: from namei.org ([65.99.196.166]:59226 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfC2SKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:10:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2TIAmPw001059;
        Fri, 29 Mar 2019 18:10:48 GMT
Date:   Sat, 30 Mar 2019 05:10:48 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security: yama fix for v5.1
Message-ID: <alpine.LRH.2.21.1903300509370.689@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull this fix for the Yama LSM by Jann Horn.


The following changes since commit 8c7ae38d1ce12a0eaeba655df8562552b3596c7f:

  afs: Fix StoreData op marshalling (2019-03-28 08:54:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1

for you to fetch changes up to 1aa176ef5a451adc0546d5aaa3fb107975c786b7:

  Yama: mark local symbols as static (2019-03-28 10:02:29 -0700)

----------------------------------------------------------------
Jann Horn (1):
      Yama: mark local symbols as static

 security/yama/yama_lsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

---
commit 1aa176ef5a451adc0546d5aaa3fb107975c786b7
Author: Jann Horn <jannh@google.com>
Date:   Wed Mar 27 17:21:42 2019 -0700

    Yama: mark local symbols as static
    
    sparse complains that Yama defines functions and a variable as non-static
    even though they don't exist in any header. Fix it by making them static.
    
    Co-developed-by: Mukesh Ojha <mojha@codeaurora.org>
    Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
    Signed-off-by: Jann Horn <jannh@google.com>
    [kees: merged similar static-ness fixes into a single patch]
    Link: https://lkml.kernel.org/r/20190326230841.87834-1-jannh@google.com
    Link: https://lkml.kernel.org/r/1553673018-19234-1-git-send-email-mojha@codeaurora.org
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: James Morris <james.morris@microsoft.com>

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 57cc60722dd3..efac68556b45 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -206,7 +206,7 @@ static void yama_ptracer_del(struct task_struct *tracer,
  * yama_task_free - check for task_pid to remove from exception list
  * @task: task being removed
  */
-void yama_task_free(struct task_struct *task)
+static void yama_task_free(struct task_struct *task)
 {
 	yama_ptracer_del(task, task);
 }
@@ -222,7 +222,7 @@ void yama_task_free(struct task_struct *task)
  * Return 0 on success, -ve on error.  -ENOSYS is returned when Yama
  * does not handle the given option.
  */
-int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
+static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5)
 {
 	int rc = -ENOSYS;
@@ -401,7 +401,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
  *
  * Returns 0 if following the ptrace is allowed, -ve on error.
  */
-int yama_ptrace_traceme(struct task_struct *parent)
+static int yama_ptrace_traceme(struct task_struct *parent)
 {
 	int rc = 0;
 
@@ -452,7 +452,7 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
 static int zero;
 static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
-struct ctl_path yama_sysctl_path[] = {
+static struct ctl_path yama_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "yama", },
 	{ }
