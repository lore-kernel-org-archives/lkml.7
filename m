Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6FF218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697099;
	bh=9pTsZgJYKzYaJpGRoPCHOlQj6CAvL14Yhn+Sb4cz79E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tkv6SEyraY4UV8MNTwccxCvIUqVfAhgsFwckGXD43j8v1Ws2WnZ7He1R9fmN4mbQS
	 kYptldJ4XuGYso+FABmOcsxfiU2S6S7rPLeMN4VkXTdtr4bR6FI0ku4okcPVn9i8a7
	 CwFymFSHvklF26WL0dQWtbiFGgU42zNFEh3AAtKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbfJJIo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfJJIot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:44:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0E521929;
        Thu, 10 Oct 2019 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697089;
        bh=9pTsZgJYKzYaJpGRoPCHOlQj6CAvL14Yhn+Sb4cz79E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fG8GX85lPMbWkNYGN41gqH7mJYywsF/vm4rSJENVoj2NXmkE740/rxgNLXTVJ4j04
         enJYS+61kWttx3iAHPdHprA/ZWtvjed5+m3SXdD/VintUP/X8J6xIYCVXmlRqyij8a
         QGJKrWNCVUnE6grSkx0Sul3Gij5l9Ibw4AUSuuDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 015/114] powerpc/mce: Schedule work from irq_work
Date:   Thu, 10 Oct 2019 10:35:22 +0200
Message-Id: <20191010083551.274985599@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Santosh Sivaraj <santosh@fossix.org>

commit b5bda6263cad9a927e1a4edb7493d542da0c1410 upstream.

schedule_work() cannot be called from MCE exception context as MCE can
interrupt even in interrupt disabled context.

Fixes: 733e4a4c4467 ("powerpc/mce: hookup memory_failure for UE errors")
Cc: stable@vger.kernel.org # v4.15+
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190820081352.8641-2-santosh@fossix.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/mce.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -45,6 +45,7 @@ static DEFINE_PER_CPU(struct machine_che
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
+static void machine_check_ue_irq_work(struct irq_work *work);
 void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
@@ -52,6 +53,10 @@ static struct irq_work mce_event_process
         .func = machine_check_process_queued_event,
 };
 
+static struct irq_work mce_ue_event_irq_work = {
+	.func = machine_check_ue_irq_work,
+};
+
 DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
 
 static void mce_set_error_info(struct machine_check_event *mce,
@@ -208,6 +213,10 @@ void release_mce_event(void)
 	get_mce_event(NULL, true);
 }
 
+static void machine_check_ue_irq_work(struct irq_work *work)
+{
+	schedule_work(&mce_ue_event_work);
+}
 
 /*
  * Queue up the MCE event which then can be handled later.
@@ -225,7 +234,7 @@ void machine_check_ue_event(struct machi
 	memcpy(this_cpu_ptr(&mce_ue_event_queue[index]), evt, sizeof(*evt));
 
 	/* Queue work to process this event later. */
-	schedule_work(&mce_ue_event_work);
+	irq_work_queue(&mce_ue_event_irq_work);
 }
 
 /*


