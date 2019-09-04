Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830EDC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DBB22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620913;
	bh=bORFE6K2QGLqcpSI8tloPJ26KDM+tXzJwoFqYpq1sYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/hQK4Qf1MXmXqU5tWZf4EZBOjHd8MhdnaQu0516i7Q0yavS3v1TUFgk/9f5Ce/lV
	 BPhxlY318EcjMv4jDUOPYJ1e8tgMN0KIKPCW0y4VlSwk0VdlxlHwKIUJN69QluNJAL
	 NtlzKFaeOLSG+B7gLjclknIkiHASiwmDGfL1Flu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbfIDSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfIDSPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:15:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3740022CF7;
        Wed,  4 Sep 2019 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620907;
        bh=bORFE6K2QGLqcpSI8tloPJ26KDM+tXzJwoFqYpq1sYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNF7xSKm3E1VD0bSoYf2nLl2dSvnYc5Qzn14F48CQlbE5ew6P0QHtr5DUCv+JHGdG
         Cdn6Tp/bVYrqAvUZ7ELrBUiOZOoIU/5ZdAqjtvutwvJ2ZuoW0KdVQwBnehrUEm8DlH
         aVfjt6+iM2UfI+v+UMWobFJ1lmofBky/ldc4OBy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.2 103/143] lkdtm/bugs: fix build error in lkdtm_EXHAUST_STACK
Date:   Wed,  4 Sep 2019 19:54:06 +0200
Message-Id: <20190904175318.345521443@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

commit b9bc7b8b1e9e815b231c1ca0b566ee723f480987 upstream.

lkdtm/bugs.c:94:2: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
  pr_info("Calling function with %d frame size to depth %d ...\n",
  ^
THREAD_SIZE is defined as a unsigned long, cast CONFIG_FRAME_WARN to
unsigned long as well.

Fixes: 24cccab42c419 ("lkdtm/bugs: Adjust recursion test to avoid elision")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20190827173619.170065-1-rrangel@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/lkdtm/bugs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -22,7 +22,7 @@ struct lkdtm_list {
  * recurse past the end of THREAD_SIZE by default.
  */
 #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
-#define REC_STACK_SIZE (CONFIG_FRAME_WARN / 2)
+#define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
 #else
 #define REC_STACK_SIZE (THREAD_SIZE / 8)
 #endif
@@ -91,7 +91,7 @@ void lkdtm_LOOP(void)
 
 void lkdtm_EXHAUST_STACK(void)
 {
-	pr_info("Calling function with %d frame size to depth %d ...\n",
+	pr_info("Calling function with %lu frame size to depth %d ...\n",
 		REC_STACK_SIZE, recur_count);
 	recursive_loop(recur_count);
 	pr_info("FAIL: survived without exhausting stack?!\n");


