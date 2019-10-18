Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505C72245D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436553;
	bh=xLXdFi8n6WZrtC00jlEDcjziMRoPWb3Glh6aR0819tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3lrGVouP7R1/62hgPU/2shuiR5mWhw/MW+5GIqNTvaxxLYEy8da1yrP+uIlg7aQo
	 sL57e4MYZO8CYkUropC2j2lzLBk2zyYM3WwSLid9wsBnADjFRbmjGomevJ8gS+X3ar
	 9IY60wRRU1ZHPLa/gTKiCoBekDu7t3EKZELSI44E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbfJRWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388133AbfJRWIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:08:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1200E22459;
        Fri, 18 Oct 2019 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436527;
        bh=xLXdFi8n6WZrtC00jlEDcjziMRoPWb3Glh6aR0819tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAl1+qTaAZ0MuxX+4tORn/TCxGieyB712ofq2JHfkxusJfsypPm6Z/t2FwMvUlhpD
         /YyF4zu+cLO1FHgNvtmO9a8mRlnnlGmKGyFKHWVlz4MuQwwGmozpGgeN/pGZWunNrA
         yIRE61+T933XRikd0sXD8iicDhkmfaX7O0HPyQSg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 33/56] tty: n_hdlc: fix build on SPARC
Date:   Fri, 18 Oct 2019 18:07:30 -0400
Message-Id: <20191018220753.10002-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 47a7e5e97d4edd7b14974d34f0e5a5560fad2915 ]

Fix tty driver build on SPARC by not using __exitdata.
It appears that SPARC does not support section .exit.data.

Fixes these build errors:

`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
`.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 063246641d4a ("format-security: move static strings to const")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 08bd6b965847f..e83dea8d6633a 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -969,6 +969,11 @@ static int __init n_hdlc_init(void)
 	
 }	/* end of init_module() */
 
+#ifdef CONFIG_SPARC
+#undef __exitdata
+#define __exitdata
+#endif
+
 static const char hdlc_unregister_ok[] __exitdata =
 	KERN_INFO "N_HDLC: line discipline unregistered\n";
 static const char hdlc_unregister_fail[] __exitdata =
-- 
2.20.1

