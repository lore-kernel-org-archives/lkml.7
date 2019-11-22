Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83152C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC2D20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418724;
	bh=n0hSoyCt+a7Qwm0d+IWQ9s8PCzkBt2QJMIFcCIC1V2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C4JvRw7sibipk7C3qgmT2OKcEbwJ08nnFClpwu13CCuSUxgdPHHH2rORGq2KKwbok
	 UEkpv74THMTCPgG/jmvsj8zT/AuZ1aqKE/aDaiWENTnubTzrg61hu9Ecye3V9mDJq8
	 YSv2hhQ2Yt1v2c6xXYiMurl3eQS2BWPw+XuM+ppk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKVKcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfKVKcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0484820715;
        Fri, 22 Nov 2019 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418719;
        bh=n0hSoyCt+a7Qwm0d+IWQ9s8PCzkBt2QJMIFcCIC1V2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EondXoHLyf943iKGsndX4/pwBN7fDTg2Bj3qPts08NxB2LoF8keLF7PztO/SPH6YS
         iaOJ6ognajkG9AA5VyPJlwYP6RN6lgoWFmjSG3jyLcBowbbasMrExXXacpLStlnjsP
         2eXAmaIipM1UzaAQ7rFd1Z4WmTBFGZsVGkt/qkNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+b6c55daa701fc389e286@syzkaller.appspotmail.com
Subject: [PATCH 4.4 005/159] Input: ff-memless - kill timer in destroy()
Date:   Fri, 22 Nov 2019 11:26:36 +0100
Message-Id: <20191122100709.380164428@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit fa3a5a1880c91bb92594ad42dfe9eedad7996b86 upstream.

No timer must be left running when the device goes away.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-and-tested-by: syzbot+b6c55daa701fc389e286@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1573726121.17351.3.camel@suse.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/ff-memless.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -501,6 +501,15 @@ static void ml_ff_destroy(struct ff_devi
 {
 	struct ml_device *ml = ff->private;
 
+	/*
+	 * Even though we stop all playing effects when tearing down
+	 * an input device (via input_device_flush() that calls into
+	 * input_ff_flush() that stops and erases all effects), we
+	 * do not actually stop the timer, and therefore we should
+	 * do it here.
+	 */
+	del_timer_sync(&ml->timer);
+
 	kfree(ml->private);
 }
 


