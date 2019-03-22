Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C7D204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256115;
	bh=KxXE8HN87I3w5+ZGfSUbJ/9zZt9lp8IloUjB3w/Ncas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lp84Y8jPmAzaUCtDWAGHP6BQuQgJ2qlQO31b8ryUWygiD3ft/hlV+2d++TkekW+Ay
	 q+qvDeuTy5KAL63ogR5XfqnMwzFN0OjvEnGOcLvb2lPKdVVedGNmgTPe3M63pcm9Ea
	 28n9MjA9v8CirtxAp5hkVQqFnFb4CPB7gQuD4Edg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbfCVMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388274AbfCVMBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507672192D;
        Fri, 22 Mar 2019 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256111;
        bh=KxXE8HN87I3w5+ZGfSUbJ/9zZt9lp8IloUjB3w/Ncas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8P7aab2F2nDGof9ypfw5vixWP0BQ3gDzYfYFfiWskOOyXxljaxvZynKMf5rOFHro
         h710HJT4ADDu22D6TnoQzmhgc5aBn5oK4ECJvF4Vzwe1AvE+OYF7oEzEOagSc+nYIL
         +ObnrjXFWeBH1iVqX9fMlOirb79KMgamFFQoZ2M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.19 112/280] stm class: Prevent division by zero
Date:   Fri, 22 Mar 2019 12:14:25 +0100
Message-Id: <20190322111313.682852489@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -553,7 +553,7 @@ static int stm_char_policy_set_ioctl(str
 {
 	struct stm_device *stm = stmf->stm;
 	struct stp_policy_id *id;
-	int ret = -EINVAL;
+	int ret = -EINVAL, wlimit = 1;
 	u32 size;
 
 	if (stmf->output.nr_chans)
@@ -581,8 +581,10 @@ static int stm_char_policy_set_ioctl(str
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


