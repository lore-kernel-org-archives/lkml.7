Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA8CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8EF21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="XlDpXknG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKBSkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 14:40:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45945 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKBSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 14:40:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so12791814wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qdnCZdWddclGH/M82OOZNX5o0Sz7VcqJqLNhFXWogM=;
        b=XlDpXknG0rjKQ/6mwcKMyp9x19gH4LAkQpksTprJA7GF90xwpCjLaPqUBAZZm1Ruq+
         wIJ8x7oQoSriDliGfFsBJFmjk0iF2TbAnqM+MVrBcvzaYmchiGeJs4/J9JUvfRdGxMe0
         HwC+Xx9mfivXgzuIb6/++gavMi1gRePTXZK9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qdnCZdWddclGH/M82OOZNX5o0Sz7VcqJqLNhFXWogM=;
        b=l1aK8ejTpW8Y0cDcXWs3APyh8dGdA7drReRJ14m3mb837t1XrbyA6akiJyA8PQBQZK
         0evmGLLnMUp5nqKMpxH9Khhs5xGKZBNehNH5yeobRFdjq51iw0xEUeqQscSUevFtqT4B
         GI6NM2PPHlCmGNc4UuQP9OlqZGQ/D1w5osHm8HzYcSxb7vrUDRM/DxQ1u3J3GGwb70jZ
         V4uvvHprI/IcD0LaHeCg74jyf17N7j/vk0DwNqwJqOoKLAVvElwWLcKIKpSd22Z1W+Xd
         vkit2sDN7WnuREn4Xuc3/zNBhsbHED1Wz0nsngh79lPgpw+ho+G/AYEdx2iyzZpIVRcx
         BZ3g==
X-Gm-Message-State: APjAAAV1JVykMvU/IZbPWgo2z32NgeGAD9aB7g+tZm7P9fTmwppzZ+Fb
        1u5/QWYb56H/7ejyskEx+j8xnw==
X-Google-Smtp-Source: APXvYqxVHNDgIw1CEvYiU+IQ8nERCitTwJtlTtr9h7hKHNVLgcMvE92IqO+CF9nOD2DjxZSZe/Mz7A==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr12611320wrq.352.1572720033399;
        Sat, 02 Nov 2019 11:40:33 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.245])
        by smtp.gmail.com with ESMTPSA id u4sm3202638wrq.22.2019.11.02.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 11:40:32 -0700 (PDT)
From:   Louis Taylor <louis@kragniz.eu>
To:     mchehab@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] scripts/sphinx-pre-install: fix Arch latexmk dependency
Date:   Sat,  2 Nov 2019 18:45:11 +0000
Message-Id: <20191102184511.82011-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Arch Linux, latexmk is installed in the texlive-core package.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 scripts/sphinx-pre-install | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 68385fa62ff4..470ccfe678aa 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -520,6 +520,7 @@ sub give_arch_linux_hints()
 		"dot"			=> "graphviz",
 		"convert"		=> "imagemagick",
 		"xelatex"		=> "texlive-bin",
+		"latexmk"		=> "texlive-core",
 		"rsvg-convert"		=> "extra/librsvg",
 	);
 
-- 
2.23.0

