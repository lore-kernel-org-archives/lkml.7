Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8EACA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A537E217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904816;
	bh=b/ZixkpuVhOueuW0CeDByS/LFt+SqUvWTGbS8dfFALk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S9e2/TblISz3OA1z9pYHGAOR3SJnsg9qnOzcjw8FSOg/LR4XiIYJ6pll7iwuzBCdA
	 pg0Gw1EFvSedrBA5bU+DRYKtzkCcujtNQtkH5MoKoT9uaNtjFhiuShfKLZ3pq5EjEz
	 /LzWYdmOG6fOGj5vhd8PSPBiH7fLUKNIKe8pxgzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbfKDWAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388794AbfKDWAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:00:13 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C82217F4;
        Mon,  4 Nov 2019 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904812;
        bh=b/ZixkpuVhOueuW0CeDByS/LFt+SqUvWTGbS8dfFALk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWR7wRFsoey3E/P4KMuge1MzHMQji2rD/aLjx76on7ahY0wrfig2mHdvQ1KDWc2cG
         UwUYxpfqeaMeqT3QUwNgalWYgo7WirEZwyrvRZHOGIdcP6xHPKpwo2wMWyxdb/m5DI
         TW3B/TvRJQ+RLcpj43YkUdG7K0WucmU388Wyzg1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/149] tty: n_hdlc: fix build on SPARC
Date:   Mon,  4 Nov 2019 22:44:30 +0100
Message-Id: <20191104212142.026305860@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index bb63519db7ae4..c943716c019e4 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -968,6 +968,11 @@ static int __init n_hdlc_init(void)
 	
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



