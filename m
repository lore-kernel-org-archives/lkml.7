Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2115C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9793A217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427435;
	bh=EMkLnOSZMMv4MZEje/xzNx+RTKH8T3X3TlZQylSguD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMhdH0V2tMYfITER5bPytwjQEZf8zH/gaI6nAICevnq/AtGrKDF8gyox16SgTeIH9
	 IgynaAYYoODVtwdE3qbfjDKaAMg6mvfHUk0f5r+3TdaAzCDDseYxvoJCkRJZb3xbLx
	 315OSdvEcNuev3H2XmfK9jT0haJeeE864JIi9+PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEISnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfEISny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:43:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583F5217D6;
        Thu,  9 May 2019 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427433;
        bh=EMkLnOSZMMv4MZEje/xzNx+RTKH8T3X3TlZQylSguD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7np3zoS8rBPT1P3eZryS1orGXOBDUx4m1HMLiQ2PXMVkFDPdfOZTCnq9CV72dWrf
         Wrc4IUsUonvvyaDERQKLeo9mLrFn8YmtJv1zW0eaOW61cx/iIu4LPNOqrEy2fsgtP7
         qNWcfIP3xHQ3AO217yMeWYdD7MkI7RM74XK0+TCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, chenxiang <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ewan Milne <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Tomas Henzl <thenzl@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 01/28] scsi: libsas: fix a race condition when smp task timeout
Date:   Thu,  9 May 2019 20:41:53 +0200
Message-Id: <20190509181250.038627221@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181247.647767531@linuxfoundation.org>
References: <20190509181247.647767531@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

commit b90cd6f2b905905fb42671009dc0e27c310a16ae upstream.

When the lldd is processing the complete sas task in interrupt and set the
task stat as SAS_TASK_STATE_DONE, the smp timeout timer is able to be
triggered at the same time. And smp_task_timedout() will complete the task
wheter the SAS_TASK_STATE_DONE is set or not. Then the sas task may freed
before lldd end the interrupt process. Thus a use-after-free will happen.

Fix this by calling the complete() only when SAS_TASK_STATE_DONE is not
set. And remove the check of the return value of the del_timer(). Once the
LLDD sets DONE, it must call task->done(), which will call
smp_task_done()->complete() and the task will be completed and freed
correctly.

Reported-by: chenxiang <chenxiang66@hisilicon.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/libsas/sas_expander.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -47,17 +47,16 @@ static void smp_task_timedout(unsigned l
 	unsigned long flags;
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
-	if (!(task->task_state_flags & SAS_TASK_STATE_DONE))
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+		complete(&task->slow_task->completion);
+	}
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
-
-	complete(&task->slow_task->completion);
 }
 
 static void smp_task_done(struct sas_task *task)
 {
-	if (!del_timer(&task->slow_task->timer))
-		return;
+	del_timer(&task->slow_task->timer);
 	complete(&task->slow_task->completion);
 }
 


