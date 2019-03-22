Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8725B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254961;
	bh=RMbIgrXY6YkL10Q3w4SyyZG8E/IkVOmVYlnRdB5jCZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mYOcwIIYAvbIvQBBG+KoNLmnEjjnZhTO1ZHGzRfLAIRNiPfx/Y42qKneeGzanD9pF
	 7QLcNF4za4JT5fUdbalEVm42hHpM9Yh0yGBYVuUx1gcOvDQ8XTPpKKyrT+y8GFsPev
	 tiAhS9/NCCwCBt6i31Ix3ReRgBYy3l5OeA1wb/gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfCVLmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbfCVLmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB79F218B0;
        Fri, 22 Mar 2019 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254951;
        bh=RMbIgrXY6YkL10Q3w4SyyZG8E/IkVOmVYlnRdB5jCZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVLhhPov4g2Dnsht7iGYT2sYD7YpPgd8y/wAOog0BauVzo9IfgYuRHa/zUvD61j0h
         qypISoSAR44xiDeDsvo5LUlsy83MdCKENMbnnDlhJ0jtd8KlO2//dSUEdagw+vfKF8
         ZwAmUDlieWiGJtnFdA83n26VpJnrmJ4LmlGcOTW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 042/118] stm class: Prevent division by zero
Date:   Fri, 22 Mar 2019 12:15:14 +0100
Message-Id: <20190322111219.240191515@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit bf7cbaae0831252b416f375ca9b1027ecd4642dd upstream.

Using STP_POLICY_ID_SET ioctl command with dummy_stm device, or any STM
device that supplies zero mmio channel size, will trigger a division by
zero bug in the kernel.

Prevent this by disallowing channel widths other than 1 for such devices.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
CC: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -561,7 +561,7 @@ static int stm_char_policy_set_ioctl(str
 {
 	struct stm_device *stm = stmf->stm;
 	struct stp_policy_id *id;
-	int ret = -EINVAL;
+	int ret = -EINVAL, wlimit = 1;
 	u32 size;
 
 	if (stmf->output.nr_chans)
@@ -589,8 +589,10 @@ static int stm_char_policy_set_ioctl(str
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
 
-	if (id->width < 1 ||
-	    id->width > PAGE_SIZE / stm->data->sw_mmiosz)
+	if (stm->data->sw_mmiosz)
+		wlimit = PAGE_SIZE / stm->data->sw_mmiosz;
+
+	if (id->width < 1 || id->width > wlimit)
 		goto err_free;
 
 	ret = stm_file_assign(stmf, id->id, id->width);


