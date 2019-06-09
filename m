Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDCC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861120684
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100028;
	bh=dbiKq53ZEdnYqOxVXfRDsv9rp54xWHJH215bvi/pXPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GOzeeaKuX32cLhBd185zaxnc4xc0jPCy5h7nuCvfcTgVAmW0wxIH/n+fE8Q7DUoK8
	 M+UGM2bTmtqr9XiSxquXlcYucsEJdAN/MB1OkK01NCz0zaebIRYsnIpdIFLVL6aKXZ
	 YTfn4F2t/oYZxnBMNmM3gD8kNiJtb3HB61ZiUKfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbfFIRHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbfFIRHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B740206C3;
        Sun,  9 Jun 2019 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560100025;
        bh=dbiKq53ZEdnYqOxVXfRDsv9rp54xWHJH215bvi/pXPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdtfLzkrzi82LyaasF9B/U0eOR9lBW1N0w+2TOI1dSJGUg2m51a/9rWwxavyvxUzc
         +8mVlrVvh4M4JJD8b/Mi73IbedWJwlpFZRmReYeNXMVTuYzu1Awg8pEfbDhXxFz8qk
         O3Low7DRvTbPuBIQQKkzgZRgDIthaahdjEX6UuRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 61/83] media: uvcvideo: Fix uvc_alloc_entity() allocation alignment
Date:   Sun,  9 Jun 2019 18:42:31 +0200
Message-Id: <20190609164133.056739483@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

commit 89dd34caf73e28018c58cd193751e41b1f8bdc56 upstream.

The use of ALIGN() in uvc_alloc_entity() is incorrect, since the size of
(entity->pads) is not a power of two. As a stop-gap, until a better
solution is adapted, use roundup() instead.

Found by a static assertion. Compile-tested only.

Fixes: 4ffc2d89f38a ("uvcvideo: Register subdevices for each entity")

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -868,7 +868,7 @@ static struct uvc_entity *uvc_alloc_enti
 	unsigned int size;
 	unsigned int i;
 
-	extra_size = ALIGN(extra_size, sizeof(*entity->pads));
+	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
 	size = sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
 	     + num_inputs;


