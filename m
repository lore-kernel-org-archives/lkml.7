Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72630C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E7520856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495961;
	bh=yo7f+q1QbQwbGiU+1mAHtPu9a7FxJ6ekTojdAJIKf1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBbH6cJOXeqejOTPrwrwXWEZpZMoMc9VNG+tUS8wFUp73/RVvaJhwpWBaddGDQdtX
	 tJQT62pQ0+jL3jHlxUYRha6b1wcBlCdy4QqKdbIIIZZbqKevctNkc/kZtKVI8iYOD8
	 yR0YZF6Bu8gFTKnAEpUlsDddThXBSgpIslga2cd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbfHVRW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391655AbfHVRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:54 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E023123406;
        Thu, 22 Aug 2019 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494573;
        bh=yo7f+q1QbQwbGiU+1mAHtPu9a7FxJ6ekTojdAJIKf1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr4Cr93MZN1HTxogH4D1jPu+83egL9xRKpBhd8ZeWA26rDI6LIVSfzaIaThIZqggc
         WRNiCz4lj/bz+o7w0q2nNoM4pLG9CzVAMlU/x33/bofjxoxqb9dQ8aje9xoSRQg+C3
         QM/CAw/VnXLbQdTXd0ObpfEoooawuP31C0qL2454=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rolf Eike Beer <eb@emlix.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 63/78] Backport minimal compiler_attributes.h to support GCC 9
Date:   Thu, 22 Aug 2019 10:19:07 -0700
Message-Id: <20190822171833.857641411@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for __copy to v4.9.y so that we can use it in
init/exit_module to avoid -Werror=missing-attributes errors on GCC 9.

Link: https://lore.kernel.org/lkml/259986242.BvXPX32bHu@devpool35/
Cc: <stable@vger.kernel.org>
Suggested-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ed772311ec1fb..5508011cc0c79 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -52,6 +52,22 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 
 #ifdef __KERNEL__
 
+/*
+ * Minimal backport of compiler_attributes.h to add support for __copy
+ * to v4.9.y so that we can use it in init/exit_module to avoid
+ * -Werror=missing-attributes errors on GCC 9.
+ */
+#ifndef __has_attribute
+# define __has_attribute(x) __GCC4_has_attribute_##x
+# define __GCC4_has_attribute___copy__                0
+#endif
+
+#if __has_attribute(__copy__)
+# define __copy(symbol)                 __attribute__((__copy__(symbol)))
+#else
+# define __copy(symbol)
+#endif
+
 #ifdef __GNUC__
 #include <linux/compiler-gcc.h>
 #endif
-- 
2.20.1



