Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B766C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140442;
	bh=LzvC5VRBjmjmKTbE5imCl7oZm/kPCH34Vr5ihQgkshY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qiBKLUB+2kZJms6AX4ACb7rQqX7Or2kA+hWvbyVPjvNXhnou6lWRw1AsQKJrrWxMD
	 F65LySb+7/RDUXNY4j26OG+E2FoFQOP/9NCmy5xchzSIuvs8niHbtnFJMInpv8Vfhr
	 UG05tj7r7GsH0cJ96f52BjjvI64FbBPWUhGMUTK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfDARkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733001AbfDARjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D6E205C9;
        Mon,  1 Apr 2019 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140342;
        bh=LzvC5VRBjmjmKTbE5imCl7oZm/kPCH34Vr5ihQgkshY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Grni4XBkdYmp3/azl84MG3eQNctNhNhqcVRnm+iqNa39/NaZmwBa4sGT4b8rG3uG8
         gD+niYOaFg61gabaYRFy3sIKSYy9kE+QVz/kBVfPcQ8UGAWJSVOY7W32Ps7yIs2/NW
         uWlr9igrRZ7Zy86IlNBTKhnUZwAOf1/394tEXOU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wentao Wang <witallwang@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 3.18 44/50] Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc
Date:   Mon,  1 Apr 2019 19:03:27 +0200
Message-Id: <20190401170045.947832011@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

From: Wentao Wang <witallwang@gmail.com>

commit 3ec8002951ea173e24b466df1ea98c56b7920e63 upstream.

Echo "" to /sys/module/kgdboc/parameters/kgdboc will fail with "No such
device” error.

This is caused by function "configure_kgdboc" who init err to ENODEV
when the config is empty (legal input) the code go out with ENODEV
returned.

Fixes: 2dd453168643 ("kgdboc: Fix restrict error")
Signed-off-by: Wentao Wang <witallwang@gmail.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/kgdboc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -148,8 +148,10 @@ static int configure_kgdboc(void)
 	char *cptr = config;
 	struct console *cons;
 
-	if (!strlen(config) || isspace(config[0]))
+	if (!strlen(config) || isspace(config[0])) {
+		err = 0;
 		goto noconfig;
+	}
 
 	kgdboc_io_ops.is_console = 0;
 	kgdb_tty_driver = NULL;


