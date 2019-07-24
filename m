Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10937C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DA021880
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033564;
	bh=cD9rrDxEyc0yZkzD6bSEDLpUywUmGpNUOh7GXJ8xpX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MF4yWjfHfWVE4bC7yP73skpbK1HYq1Rt14bR66ZQr7SbKmuIhy6o/YomhyDVtkwsY
	 qnBBRE7k+uO2NFGdEU2BZc3RB3ApQSR+WCgoMdtndgEx29AXc2qGlJ+oJSg4foinMJ
	 HO31U7W7k3vSnz7wSVnYAwVC/DW6KZVOgI6JRFnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGYFqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405294AbfGYFqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:46:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992D921850;
        Thu, 25 Jul 2019 05:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033560;
        bh=cD9rrDxEyc0yZkzD6bSEDLpUywUmGpNUOh7GXJ8xpX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBO5JTIDIur6HCYlyFPaJpIb7EfR+hXz9lGaEGQgRp6w+Oz8u+XWAEaAL/N9EJr3I
         pxhNZcYz4+S1w3shlwoDQLBU2Rd8h3kKvTUt3/7vHRErnJYmnnqqtAsCu91sNinEQA
         qOnhZTJxgOzhzVfmGa3dA585io8CvV4lsmFPPXLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 213/271] KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
Date:   Wed, 24 Jul 2019 21:21:22 +0200
Message-Id: <20190724191713.333646712@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <like.xu@linux.intel.com>

commit 6fc3977ccc5d3c22e851f2dce2d3ce2a0a843842 upstream.

If a perf_event creation fails due to any reason of the host perf
subsystem, it has no chance to log the corresponding event for guest
which may cause abnormal sampling data in guest result. In debug mode,
this message helps to understand the state of vPMC and we may not
limit the number of occurrences but not in a spamming style.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/pmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -131,8 +131,8 @@ static void pmc_reprogram_counter(struct
 						 intr ? kvm_perf_overflow_intr :
 						 kvm_perf_overflow, pmc);
 	if (IS_ERR(event)) {
-		printk_once("kvm_pmu: event creation failed %ld\n",
-			    PTR_ERR(event));
+		pr_debug_ratelimited("kvm_pmu: event creation failed %ld for pmc->idx = %d\n",
+			    PTR_ERR(event), pmc->idx);
 		return;
 	}
 


