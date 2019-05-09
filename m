Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B3BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B72177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl0al5x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfEITBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:01:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfEITBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:01:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so4458311wro.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znktgt9VAxZtl5Sx4z7TO/jr0xKMmuIs7fpVDxU9Ui8=;
        b=Hl0al5x1tNLkahcrz/UHVJUHwwFtbgDsLoCTioo3uSylSO9x8Vhwyk7iirJ+/xuyUn
         5b/RmUF//kBQx3n76ytWAXaL2Ey2BU3oRYxw3comU+SPg54Sisq+HZyFdPBDSFrGIKVe
         tROCuCTXS4xtbof+isuvVJGBUswpWKqT2gEHKsrivc6IGmTa3ls8LNFk2RVMLTZA+ElP
         oXw5VourzCBsFZZjIThNDImU09Jse0T9/FcUIEDXTzlIHMD4aQ7YyW7F/Vzi6NdDiw0S
         dvStwejSpTolgPOs8jDS/XNrUw7IlNaqSzzpwC3soJsGaYfidjlqMpEFxhXg6n10GgNd
         EQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=znktgt9VAxZtl5Sx4z7TO/jr0xKMmuIs7fpVDxU9Ui8=;
        b=jfOLUQr68I3oP10pwvAGYNM3pQ1BP57CRggjwcPjWeSxng2Qr/k0fXxYaOldxFJz/2
         07/nciTwbs7y6kO4DIjwd4RTTGdLlJGy7OHMysN1kUuL+ogrIfcMnK6COAN6BZvIeA7T
         A3yy533DZH5S/09j/qoinDUsOvu5G60CL0l90Sr3tWJW7GuSpFqq8D68eJTf0LeLEG8u
         XAeZpOk1x6GbslIt1W/Y/Uk0cxc2tLAGprfLuMO0vpEbQt69H6NTzaqdeBStOfjWc2/O
         hfKPuIagX6DSqAmEsB2ytgNmRXFeBNWptk6sxlIbFjLx0narQ0IJzxSJitLJY39Mnq0T
         Zm7Q==
X-Gm-Message-State: APjAAAVl5dPx0LGqyWREBKRnnCmTBtxL6aVkjwdq7Dg/D9Oysv58TU0t
        K7to7QEOqI7LMFjIvxwOsFlouxaU
X-Google-Smtp-Source: APXvYqz6sSWIBbQal1X5SDH0dmQ7YMhim8YsrSgjGVqks72xI43LlNr2kQu/JZb072EWB+bhkzRytw==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr4495648wrv.303.1557428503764;
        Thu, 09 May 2019 12:01:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j1sm2833671wrt.52.2019.05.09.12.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:01:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/3] habanalabs: remove redundant memory clear
Date:   Thu,  9 May 2019 22:01:34 +0300
Message-Id: <20190509190135.5634-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509190135.5634-1-oded.gabbay@gmail.com>
References: <20190509190135.5634-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver allocates memory for fence object with GFP_ZERO flag, so there
is no need to explicitly write 0 to the allocated object after the
allocation.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 756921c52cf7..a2459cb106dd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2823,8 +2823,6 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 		return -ENOMEM;
 	}
 
-	*fence_ptr = 0;
-
 	goya_qman0_set_security(hdev, true);
 
 	cb = job->patched_cb;
-- 
2.17.1

