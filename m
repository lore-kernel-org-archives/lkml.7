Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D5EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59FA2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431447;
	bh=34/IyFqFPD/e0Yuum+sb4oDXj/l6OoAwcd75+zSUQN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKt0+sqGMuXa9nY0YsESTCOJIyntz/mHvglXTj4l2t8LOg/kDn8ES5WMAzh24cKbA
	 RAvkxJU7S31f5sLOqKPLwH5GlysSffSpsy3kuX2tosSHfAMtQ6djhr/YEM1ZC7V4WR
	 Zq8L2Dx40MMFTFRdryC6zR6CkjFNDhdELz4D+z+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgAGVKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbgAGVKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:10:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5618F2072A;
        Tue,  7 Jan 2020 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431441;
        bh=34/IyFqFPD/e0Yuum+sb4oDXj/l6OoAwcd75+zSUQN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfLZ4aWHZewakwvKZ9IbtoYTOBfDkpb/PTUxc1oAVwygG+zIIRK6PgIL4zxXOgbt7
         DfYz5FemFGMaePrtJYBwN09hiBYx3X3Uz2x6xKD7ILAQk6/WQeA1mibx0/8RK84e7D
         LWFjp7h1R5FxjAeeg3DUl8GdO1+jwNNtjtrecZgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 57/74] media: usb: fix memory leak in af9005_identify_state
Date:   Tue,  7 Jan 2020 21:55:22 +0100
Message-Id: <20200107205221.831602162@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 2289adbfa559050d2a38bcd9caac1c18b800e928 upstream.

In af9005_identify_state when returning -EIO the allocated buffer should
be released. Replace the "return -EIO" with assignment into ret and move
deb_info() under a check.

Fixes: af4e067e1dcf ("V4L/DVB (5625): Add support for the AF9005 demodulator from Afatech")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/af9005.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -985,8 +985,9 @@ static int af9005_identify_state(struct
 	else if (reply == 0x02)
 		*cold = 0;
 	else
-		return -EIO;
-	deb_info("Identify state cold = %d\n", *cold);
+		ret = -EIO;
+	if (!ret)
+		deb_info("Identify state cold = %d\n", *cold);
 
 err:
 	kfree(buf);


