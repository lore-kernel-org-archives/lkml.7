Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A66421934
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138558;
	bh=kCMA+H6PWTesVdcf96Vk1AJ80aIOsUxZC9L2BQaTz+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H4mfw79XQV3dCXmATG4TEsPavPhGJTFFxTHPXpoMIofRpMwQOijHxH810bhEQkL/4
	 ixnBhW6mQIU+a3M6BMzLDFVFg/NVB9dIfFgw+b2qB0bqHPcK5LYVd/OyZ+apyMdbat
	 v8WO8+ZnXBEi0GUqDLp+KPNwiukmF0HolVmTVtj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDARJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbfDARJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C9F2192D;
        Mon,  1 Apr 2019 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138551;
        bh=kCMA+H6PWTesVdcf96Vk1AJ80aIOsUxZC9L2BQaTz+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cc8G7KgaA4V1qjEXw8ZC0/dxqA55WEw9h7LXPm2gW/ilFtSVEvATczd5PblSuWFN
         ARhfRqXjPwsvJ6uuBLmB/4DCgVlHRKYgBAJPkhmdkBjL6B2/jtBN73pmomsuqGdIqA
         FWqAvPSXIaYJCKtgjdajDiKOPIfth0BJjyqGsxhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wentao Wang <witallwang@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 5.0 100/146] Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc
Date:   Mon,  1 Apr 2019 19:01:52 +0200
Message-Id: <20190401170057.195028258@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


