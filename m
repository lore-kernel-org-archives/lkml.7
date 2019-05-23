Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE22206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639626;
	bh=W0f3EHcVEBs8UfuFtMj60PbcCvQ0hwXJbGh92iFhmzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTjvEQnuGxf/O89xqqUwh+LoGD+Fk8zY+/kcund/sracD8Mend/CMJvzPFYcQqUOV
	 e8XMJkn2Lt/kvWr5imngeUWXHJENbLYARtgGxS7EwSvYtxg2uJI669flx/W/VJZczo
	 LVTB/RE1M3FjgUSppnUB2fBQXkRcTimj4nvRL0Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391522AbfEWT1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391496AbfEWT1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A6B206BA;
        Thu, 23 May 2019 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639621;
        bh=W0f3EHcVEBs8UfuFtMj60PbcCvQ0hwXJbGh92iFhmzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BetIprL7AW8TNXHlFSrtoaLUwjOB17uIw3EHpKDZAdAY5Y/5w+fzss82BqyKe28oG
         jVsuO41AELVZcSTzXxob95an3ycJrcvpQnnqGV0JQAyePZHybhorVKW3upd3OoSnY3
         JRwA/dRXAnaximJoT8vTRzePh5BmrSC3wwc34/TU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 5.1 033/122] stm class: Fix channel free in stm output free path
Date:   Thu, 23 May 2019 21:05:55 +0200
Message-Id: <20190523181709.227475548@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

commit ee496da4c3915de3232b5f5cd20e21ae3e46fe8d upstream.

Number of free masters is not set correctly in stm
free path. Fix this by properly adding the number
of output channels before setting them to 0 in
stm_output_disclaim().

Currently it is equivalent to doing nothing since
master->nr_free is incremented by 0.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: stable@vger.kernel.org # v4.4
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -218,8 +218,8 @@ stm_output_disclaim(struct stm_device *s
 	bitmap_release_region(&master->chan_map[0], output->channel,
 			      ilog2(output->nr_chans));
 
-	output->nr_chans = 0;
 	master->nr_free += output->nr_chans;
+	output->nr_chans = 0;
 }
 
 /*


