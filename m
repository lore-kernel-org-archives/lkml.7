Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFDFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B05214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2Pgj+AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfJJXYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:24:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35088 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfJJXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:24:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so3553932plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMqmNRh9/WRVuOhxmgeAss8KGdVZEWgP1gvN19lsOqw=;
        b=X2Pgj+AXTV2Ft841aCpOcTDGSCdqRW7jKxi/A0JNfzkCvRnBRTlgiBPSQlnSB+smXf
         KM/0N/YQd1W8z5kju+9JLAHVI1pfeWN/BEzNRrEERIuWwD3BkBcqvXop0Shui4yPMLqZ
         D7f/vZRRKSScbxm9PdqjdsYfiYl9R3gEC2Gak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMqmNRh9/WRVuOhxmgeAss8KGdVZEWgP1gvN19lsOqw=;
        b=SSwfNFdi1x2TYMLIMGRUuZ6sXmBnxP+8ucifLvqN6jCktIcNhecYUWhZXcF63YQ1A0
         /VtaS9+kZ537K1Qy6rFIe4gCLwYPJhAaX7duOIu7pUAy77etOcKAXkPuum933H/sVo0U
         loXocPZbdW0n2na4IWTUhhqmPe7s/t6sKjXAc9N9xxxFAQY/UO17vPIEbrrbv1kbpHMh
         rbxgx7EN4dHEPBLBpXbzg1GwaV+R5JwMp6bTbVIeXNG0LCmifIJrmt3asB7TkmIbStZm
         KxvkrpiKeOG7ZoaJlDR67M+rcpoGG6/Wa3v6Hzb8AAVF9M3koEJGZjTVvSZMjGIk1prs
         hTQA==
X-Gm-Message-State: APjAAAVYf8allsJ0Oyr2Wzev/jgLggvLsEx1zmG38M+A9AcBjvaokzwP
        XesivQGq5x+Q1Uxref4V0fAmKA==
X-Google-Smtp-Source: APXvYqzr5TEKsgP0lOS7AdzCh27u/YbVsT+Ij4ZMEVcIou1HxRIVeL6D9p3wjllIloBGYMby8gU1TQ==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr12067901pll.40.1570749839357;
        Thu, 10 Oct 2019 16:23:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2sm6645331pff.154.2019.10.10.16.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:23:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/4] include: Remove FIELD_SIZEOF() and sizeof_field() macros
Date:   Thu, 10 Oct 2019 16:23:45 -0700
Message-Id: <20191010232345.26594-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010232345.26594-1-keescook@chromium.org>
References: <20191010232345.26594-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

The common function used to find struct member size is sizeof_member().
Remove the now unused FIELD_SIZEOF() and sizeof_field() macros.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-5-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 9 ---------
 include/linux/stddef.h | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d83d403dac2e..d67020250d75 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -79,15 +79,6 @@
  */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
-/**
- * FIELD_SIZEOF - get the size of a struct's field
- * @t: the target struct
- * @f: the target struct's field
- * Return: the size of @f in the struct definition without having a
- * declared instance of @t.
- */
-#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
-
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index ecadb736c853..74b5e644d50a 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -19,14 +19,6 @@ enum {
 #define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
 #endif
 
-/**
- * sizeof_field(TYPE, MEMBER)
- *
- * @TYPE: The structure containing the field of interest
- * @MEMBER: The field to return the size of
- */
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-
 /**
  * sizeof_member(TYPE, MEMBER) - get the size of a struct's member
  *
-- 
2.17.1

