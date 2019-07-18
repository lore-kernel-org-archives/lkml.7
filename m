Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67432C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342621871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419649;
	bh=KKKMov8CfIyqKpdpy8gKJhF3FLqYcO/YSEMQo+fuiiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v715W4urvBjGCqQkGJ1LLKFruO/KclKXXF8maPdu8z0MH1vO5Kwb95Qvr2hwtNR2e
	 IrhtEW6m2mLhshQQ4yjBP4MFOUI0yfPvrULyTlEyPSYb9O60RmHnCgIrH5PpiX7tfo
	 JahVbQNya5IGVC/8Z5bymazkCIVmGZp7Nlej9ZjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbfGRDOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391212AbfGRDOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:00 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F0E21850;
        Thu, 18 Jul 2019 03:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419639;
        bh=KKKMov8CfIyqKpdpy8gKJhF3FLqYcO/YSEMQo+fuiiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kraskuiMOMnN+7HRR06r5SY6IsjhnKMRk0L3lnWK9XzwTaIIbchVVth+bW6H3pu3f
         Q/j7iyRumupbhCjO8RlQniFqWySmXLH8SJQGjsjHIdVHeDTm5Za2oRlHrDO6yspU/a
         Ec3E9ebiwfmj0MTq6kYJH8t5kNWvYPoim9lcEc+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.9 35/54] staging: comedi: dt282x: fix a null pointer deref on interrupt
Date:   Thu, 18 Jul 2019 12:02:05 +0900
Message-Id: <20190718030052.160246123@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit b8336be66dec06bef518030a0df9847122053ec5 upstream.

The interrupt handler `dt282x_interrupt()` causes a null pointer
dereference for those supported boards that have no analog output
support.  For these boards, `dev->write_subdev` will be `NULL` and
therefore the `s_ao` subdevice pointer variable will be `NULL`.  In that
case, the following call near the end of the interrupt handler results
in a null pointer dereference:

	comedi_handle_events(dev, s_ao);

Fix it by only calling the above function if `s_ao` is valid.

(There are other uses of `s_ao` by the interrupt handler that may or may
not be reached depending on values of hardware registers.  Trust that
they are reliable for now.)

Note:
commit 4f6f009b204f ("staging: comedi: dt282x: use comedi_handle_events()")
propagates an earlier error from
commit f21c74fa4cfe ("staging: comedi: dt282x: use cfc_handle_events()").

Fixes: 4f6f009b204f ("staging: comedi: dt282x: use comedi_handle_events()")
Cc: <stable@vger.kernel.org> # v3.19+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/dt282x.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/dt282x.c
+++ b/drivers/staging/comedi/drivers/dt282x.c
@@ -566,7 +566,8 @@ static irqreturn_t dt282x_interrupt(int
 	}
 #endif
 	comedi_handle_events(dev, s);
-	comedi_handle_events(dev, s_ao);
+	if (s_ao)
+		comedi_handle_events(dev, s_ao);
 
 	return IRQ_RETVAL(handled);
 }


