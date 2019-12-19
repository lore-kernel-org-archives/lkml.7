Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A5C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029CC206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782166;
	bh=Bn0If5Wk3WW9HZ9OqrXH4CvWfVZAr01tMjmEe3qSPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J7e8Qrtf1oc2B5ay0UX5xUwG//s+T6PR9jd4507chjWZB+O/G71QtSlwWI7YMf+83
	 vSSerKcepQqQF70ZF00cd47AHu+dS9kVgkaiI0l1BBVJ4Y+SLf9pbihoHTY3+YHN3M
	 JBJ6jB61gI62T8sWEndx0lZxBevH3ZAvX4ZyFB2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfLSStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbfLSStK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C462465E;
        Thu, 19 Dec 2019 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781349;
        bh=Bn0If5Wk3WW9HZ9OqrXH4CvWfVZAr01tMjmEe3qSPy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcPaXiVV2wLNG/xi2UvLOOPXuKQO4vpqO1j98s0mWja7mp8JYXbOD38pabDud++tI
         q4pg91Rm3Rsu267K/Fyugme7ulfcL8e/TnR/ZcogAGJdVYpjKOcuqyLu1VXpveE8w5
         vLvtPjmS22aCU6oHlxdwWc0Ee5lPiLlS7Zwddqpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Siddharth Kapoor <ksiddharth@google.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 185/199] Revert "regulator: Defer init completion for a while after late_initcall"
Date:   Thu, 19 Dec 2019 19:34:27 +0100
Message-Id: <20191219183225.914268543@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 8b8c8d69b1a31004517d4c71a490f47bdf3405a2 which is
commit 55576cf1853798e86f620766e23b604c9224c19c upstream.

It's causing "odd" interactions with older kernels, so it probably isn't
a good idea to cause timing changes there.  This has been reported to
cause oopses on Pixel devices.

Reported-by: Siddharth Kapoor <ksiddharth@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/core.c |   42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4452,7 +4452,7 @@ static int __init regulator_init(void)
 /* init early to allow our consumers to complete system booting */
 core_initcall(regulator_init);
 
-static int regulator_late_cleanup(struct device *dev, void *data)
+static int __init regulator_late_cleanup(struct device *dev, void *data)
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 	const struct regulator_ops *ops = rdev->desc->ops;
@@ -4501,9 +4501,18 @@ unlock:
 	return 0;
 }
 
-static void regulator_init_complete_work_function(struct work_struct *work)
+static int __init regulator_init_complete(void)
 {
 	/*
+	 * Since DT doesn't provide an idiomatic mechanism for
+	 * enabling full constraints and since it's much more natural
+	 * with DT to provide them just assume that a DT enabled
+	 * system has full constraints.
+	 */
+	if (of_have_populated_dt())
+		has_full_constraints = true;
+
+	/*
 	 * Regulators may had failed to resolve their input supplies
 	 * when were registered, either because the input supply was
 	 * not registered yet or because its parent device was not
@@ -4520,35 +4529,6 @@ static void regulator_init_complete_work
 	 */
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
-}
-
-static DECLARE_DELAYED_WORK(regulator_init_complete_work,
-			    regulator_init_complete_work_function);
-
-static int __init regulator_init_complete(void)
-{
-	/*
-	 * Since DT doesn't provide an idiomatic mechanism for
-	 * enabling full constraints and since it's much more natural
-	 * with DT to provide them just assume that a DT enabled
-	 * system has full constraints.
-	 */
-	if (of_have_populated_dt())
-		has_full_constraints = true;
-
-	/*
-	 * We punt completion for an arbitrary amount of time since
-	 * systems like distros will load many drivers from userspace
-	 * so consumers might not always be ready yet, this is
-	 * particularly an issue with laptops where this might bounce
-	 * the display off then on.  Ideally we'd get a notification
-	 * from userspace when this happens but we don't so just wait
-	 * a bit and hope we waited long enough.  It'd be better if
-	 * we'd only do this on systems that need it, and a kernel
-	 * command line option might be useful.
-	 */
-	schedule_delayed_work(&regulator_init_complete_work,
-			      msecs_to_jiffies(30000));
 
 	return 0;
 }


