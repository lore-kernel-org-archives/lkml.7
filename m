Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47248C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D301218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253659;
	bh=5em/hWVJj8a/ps1CgDWg89vBP224+tMO7uguVUMSDQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLXF76AW6nBHvxNb0Ocy/z4JjR/FFxe23WflgUY60mAW5GRCAo+NPhCL6hld2tz6m
	 x7QsGv/mBqbNbqgVBPDjwFejiCpDTCjQ7q4NsYrjb7vM2wa5nlwuLnuiaZvjcupf0M
	 vIBMy4sfpuGGQbgeAihrL8zuKOah55GWaKFd4nL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfCVLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfCVLUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:20:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CBB21917;
        Fri, 22 Mar 2019 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253655;
        bh=5em/hWVJj8a/ps1CgDWg89vBP224+tMO7uguVUMSDQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQxFQkOLi6zfIEvrsJ1jwpFA7LsMZ1JCTiZ8ARJYMhP3He4kvjR6H76QX4Jy7ukd+
         tRQpSwn8qG2rfEBcshDbrjI7m7/phsL+NlKXvZeORarvVFv5ls3/V/stliqWv6nA5i
         E4gbk1e8kL6g0gBeO6J/eQnJSsvcrqiHjfsSygeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 031/134] usb: gadget: Potential NULL dereference on allocation error
Date:   Fri, 22 Mar 2019 12:14:04 +0100
Message-Id: <20190322111212.005243655@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit df28169e1538e4a8bcd8b779b043e5aa6524545c ]

The source_sink_alloc_func() function is supposed to return error
pointers on error.  The function is called from usb_get_function() which
doesn't check for NULL returns so it would result in an Oops.

Of course, in the current kernel, small allocations always succeed so
this doesn't affect runtime.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_sourcesink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 45b41d1cfd19d..ecfd9e71a0d50 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -1149,7 +1149,7 @@ static struct usb_function *source_sink_alloc_func(
 
 	ss = kzalloc(sizeof(*ss), GFP_KERNEL);
 	if (!ss)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ss_opts =  container_of(fi, struct f_ss_opts, func_inst);
 
-- 
2.19.1



