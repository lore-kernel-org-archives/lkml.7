Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46558C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105A62075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010982;
	bh=CYvkzKEU1nyUw5Pdr5OI8fZUul+Ab5odDtLyQv/4T6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3ghWokbcOOHL6pHYPanM0GQrbNYn8/4kgEdxWeKaDmZe3ilxI+48zTqwysG5wnIh
	 asIe59oOa9aYp/fj5pivutRCmfCpkRpvDIA07fvSpWnmjeaX+wboGe466ENAtnfmYr
	 y6OBwhfRk91T5TiBURbxGGLJiTtd4/kMAvlY4SJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfHENGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbfHENGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:06:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB20206C1;
        Mon,  5 Aug 2019 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010369;
        bh=CYvkzKEU1nyUw5Pdr5OI8fZUul+Ab5odDtLyQv/4T6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNGvRM+1Ftjzh4iqC9UtE640eNnDoxsxKX/QjgHxMJxu8+SyUV6R0+kYaWTS0s7mh
         Ermz9+k2CREUYyFpPO4xD4EuUFrTmyUL90lsZDbVl8h1v4em3Mt4iOr80KIHNF+gJb
         7balmMkZLuTtgq/xmMjo+yURCZA4usAcHoupe+J8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "stable@vger.kernel.org, Miguel Ojeda" 
        <miguel.ojeda.sandonis@gmail.com>, Rolf Eike Beer <eb@emlix.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 4.9 39/42] Backport minimal compiler_attributes.h to support GCC 9
Date:   Mon,  5 Aug 2019 15:03:05 +0200
Message-Id: <20190805124929.606014897@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

This adds support for __copy to v4.9.y so that we can use it in
init/exit_module to avoid -Werror=missing-attributes errors on GCC 9.

Link: https://lore.kernel.org/lkml/259986242.BvXPX32bHu@devpool35/
Cc: <stable@vger.kernel.org>
Suggested-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -54,6 +54,22 @@ extern void __chk_io_ptr(const volatile
 
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


