Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE26C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EEC212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922409;
	bh=fODzMbhwNCnU9KZWF0dDSMSCfi+Kpxj4SJk1wz8uYx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIMxMR3so1UIup4svNDoyTAXAVZNOq388PZVK5FxDHmV/NKkL4kcImpJoey6Jg11b
	 lud4wso2HOo418u2vHmSedEA3ezu1sTLYkUw1ciiPGP0dcFO+HQNW6dHE3S4jlb3tw
	 RxoVMS7tFTmu/LNSGY1jKdZOv5bdS/u02Os6duhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfFGPqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbfFGPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2172147A;
        Fri,  7 Jun 2019 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922402;
        bh=fODzMbhwNCnU9KZWF0dDSMSCfi+Kpxj4SJk1wz8uYx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnhWR2OpPI4vleykwtki9CHaRiMxBDrC/WdsGFj+A8BoLGgeH2uAQMWVzg7aKBNbD
         t9DXL6C45MaG2FzTb9zI9yYVTgM7Bk5QIeN8mY0xZwGzPJlfMToJWJFGq90Eu8mnyF
         p21iwzgQrQDuRKv4qJ1dS7JVE33w1CDS3v7KAcUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.19 73/73] media: uvcvideo: Fix uvc_alloc_entity() allocation alignment
Date:   Fri,  7 Jun 2019 17:40:00 +0200
Message-Id: <20190607153856.880547199@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
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
@@ -914,7 +914,7 @@ static struct uvc_entity *uvc_alloc_enti
 	unsigned int size;
 	unsigned int i;
 
-	extra_size = ALIGN(extra_size, sizeof(*entity->pads));
+	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
 	size = sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
 	     + num_inputs;


