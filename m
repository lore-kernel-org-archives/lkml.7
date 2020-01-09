Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2AFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF522073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578602333;
	bh=M8CDogTJyDipdtPyHXeg+qSF4S8u9gAFSKmUcs07zEE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=AKcYM+E6b+sRy0NkX7qHFArFPnWjfj7vpi48iipCo/TajxbAxeJmbufubItdTMzkR
	 Xys1Xlmkv9YoF8tVMy1XWzbtGp2/Ah4cP5/1YY+dlGs6iCoaP8AfIlQS5iqWCZwbGB
	 kRyv0/lacUwCwqpV6s6oVNbASptppakbefvX8e1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgAIUiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbgAIUiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:38:51 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE662072A;
        Thu,  9 Jan 2020 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578602331;
        bh=M8CDogTJyDipdtPyHXeg+qSF4S8u9gAFSKmUcs07zEE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uCGFba4SANXBZtsqM0aOp6iXjz2P/WDcXMWYogdieKPeTntaGkZl+tdUKCgKHXhaW
         ZdS+JRBMXDGR1bbUnfy6d36WJIHDab+lvArZrUGe/pIisQH0BvDfSfKDkMnwZvJ6MF
         iz1+WuyT1sMMcWQ3+fX6ytCcXVb/oJ2lGrUR3WxQ=
Date:   Thu, 9 Jan 2020 21:38:48 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID fixes
In-Reply-To: <nycvar.YFH.7.76.2001092032430.31058@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2001092137460.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm> <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com> <nycvar.YFH.7.76.2001092032430.31058@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020, Jiri Kosina wrote:

> Marcel, will you please send me fixup ASAP? 

Marcel, if you don't insist on fixing this in some other way, I'll push 
something along the lines of patch below to Linus shortly.




From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: hidraw, uhid: Always report EPOLLOUT

hidraw and uhid device nodes are always available for writing so we should 
always report EPOLLOUT and EPOLLWRNORM bits, not only in the cases when 
there is nothing to read.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: be54e7461ffdc ("HID: uhid: Fix returning EPOLLOUT from uhid_char_poll")
Fixes: 9f3b61dc1dd7b ("HID: hidraw: Fix returning EPOLLOUT from hidraw_poll")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hidraw.c | 5 +++--
 drivers/hid/uhid.c   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index f61f2123a755..90265c9fa8eb 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -249,13 +249,14 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 static __poll_t hidraw_poll(struct file *file, poll_table *wait)
 {
 	struct hidraw_list *list = file->private_data;
+	__poll_t mask = EPOLLOUT | EPOLLWRNORM; /* hidraw is always writable */
 
 	poll_wait(file, &list->hidraw->wait, wait);
 	if (list->head != list->tail)
-		return EPOLLIN | EPOLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	if (!list->hidraw->exist)
 		return EPOLLERR | EPOLLHUP;
-	return EPOLLOUT | EPOLLWRNORM;
+	return mask;
 }
 
 static int hidraw_open(struct inode *inode, struct file *file)
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 935c3d0a3b63..8fe3efcb8327 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -766,13 +766,14 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 {
 	struct uhid_device *uhid = file->private_data;
+	__poll_t mask = EPOLLOUT | EPOLLWRNORM; /* uhid is always writable */
 
 	poll_wait(file, &uhid->waitq, wait);
 
 	if (uhid->head != uhid->tail)
-		return EPOLLIN | EPOLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 
-	return EPOLLOUT | EPOLLWRNORM;
+	return mask;
 }
 
 static const struct file_operations uhid_fops = {

-- 
Jiri Kosina
SUSE Labs

