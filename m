Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4443C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECE02071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420963;
	bh=8xNOoACWH3K2CUyjJCpoBhrHykxp+H3DVrmXt4ZVvNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0+Thzb2shP9c+URfphynkuIep9Dpmv2aiXJ8aQyugi6BPXOY2IFeJN5YV3XMbS+F
	 RabaJIuFTSf94AOuJ9kWA7bMRE7NuTlNOWMZCz7LiaXyuNEeGTKR/pnoqGr6qF+W99
	 9wjvzCCFBNbwz9/mpV6tWZQHUDhlkbXkCNoMIRb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfKVLJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbfKVLDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28E02073F;
        Fri, 22 Nov 2019 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420602;
        bh=8xNOoACWH3K2CUyjJCpoBhrHykxp+H3DVrmXt4ZVvNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQDkejTbjVfTrYTjrfrQE8dhubSeHZsZPr9d+MuOsqgB4EAuMlf4oNi5Mw/Yeu2Br
         Sl3TL/50vdgw0L/kXdd6MgZQMWBfWNDa2gkvT2SZmB1HvKQICCiqI8twzNPkMxoJgE
         4jI5ccILoilLmnCOc1OFcWZVrR6JujOj9MSHPibY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 161/220] media: cx18: Dont check for address of video_dev
Date:   Fri, 22 Nov 2019 11:28:46 +0100
Message-Id: <20191122100924.323286385@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit eb1ca9a428fdc3f98be4898f6cd8bcb803878619 ]

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
'cx->streams[i].video_dev' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (&cx->streams[i].video_dev)
                ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
1 warning generated.

Check whether v4l2_dev is null, not the address, so that the statement
doesn't fire all the time. This check has been present since 2009,
introduced by commit 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the
work handler for outgoing mailbox commands")

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 0c389a3fb4e5f..e64f9093cd6d3 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
 {
 	int i;
 	for (i = 0; i < CX18_MAX_STREAMS; i++)
-		if (&cx->streams[i].video_dev)
+		if (cx->streams[i].video_dev.v4l2_dev)
 			cancel_work_sync(&cx->streams[i].out_work_order);
 }
 
-- 
2.20.1



