Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA108C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86043227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLRUkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38924 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so2738344qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYhWk9A+WoXMXCHtGdQqG3zbhIals/Q0OXKZBLbp2XQ=;
        b=QmiTNlu8jt60arhUq6Vijn1eKRufa4lMPb71FIpggvRBA8SwJkZj7IQX7jPSa0Mf0+
         hejwR+qSJtPESHkIQsfVsbCoSij3MewLzVbpjyiySrAX7Iped/S9vBbST7RGEOvZKOx1
         jUkwbdU59oqG40dtFPXeLoRguIJQbsVY2XllTKByb/NV2cMsUBwvmOu9bcD2gGc1urKN
         rN7zUjzR8Lno5RPKzvelPX16LGSRpEIW0z3d30rL54NZlKE4fAWCRYPpaQqZ4+8EdM3k
         t5a+TcdPRRQz1DNAbfn8mM3DeYiVPMVySeEyVzCZq2MtJ5bs05LAeS739bMsjX6KvCxG
         RhKQ==
X-Gm-Message-State: APjAAAWrMT16KNL7dj4MoLg56mY0tiT2xEYbOUXllliWZ4/T03NPpKND
        F2qaKOmUlIbZTB4Tj+ufgeo=
X-Google-Smtp-Source: APXvYqw3gDszwrtCiXihMuBAD84OtqA8ZYseLupbuLXdLkRVMBBZpca33S3DGFVq1RH54+FnZgca2w==
X-Received: by 2002:a37:3ce:: with SMTP id 197mr4779532qkd.454.1576701604480;
        Wed, 18 Dec 2019 12:40:04 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:04 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/24] console/dummycon: Remove bogus depends on from DUMMY_CONSOLE
Date:   Wed, 18 Dec 2019 15:39:39 -0500
Message-Id: <20191218204002.30512-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit [1] consolidated console configuration in
drivers/video/console, DUMMY_CONSOLE has always been enabled, since the
dependency is always satisfied.

There is no point in trying to allow it to be configured out, since
(a) it's tiny, and (b) if VT_CONSOLE is enabled, we must have a working
console driver by the time con_init(vt.c) runs, and only dummycon is
guaranteed to work (vgacon may be configured in, but that doesn't mean
we have a VGA device).

So just remove the fake dependency.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit?id=31d2a7d36d6989c714b792ec00358ada24c039e7

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/video/console/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index c10e17fb9a9a..70c10ea1c38b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -93,7 +93,6 @@ config SGI_NEWPORT_CONSOLE
 
 config DUMMY_CONSOLE
 	bool
-	depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y 
 	default y
 
 config DUMMY_CONSOLE_COLUMNS
-- 
2.24.1

