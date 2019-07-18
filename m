Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84103C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCFC2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419209;
	bh=XZdhTy0JEJZY3lK6Jn/I1noxcLUvIqAh9WQXu1Larbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OddsL0TuJ4IgoaIbn42idiXQuI3mBB+0t/Xy+ld9Ej68r93XcD4k/RCvuJW2UxYZS
	 oexOCAb6R35FOybERqZy1ugKLORBAotm+FLj3+wg98BAkvyuAuMMHnOLwjHWGZhp9l
	 IIURS3pnIz3o0aUyO4AsQysDzfu83Hx3hOnC2T9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfGRDGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389172AbfGRDGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:06:44 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A9D204EC;
        Thu, 18 Jul 2019 03:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419204;
        bh=XZdhTy0JEJZY3lK6Jn/I1noxcLUvIqAh9WQXu1Larbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xX3wnqLd9UZqgHoQcx+R8D5QGob0mu7IE9kQ2sbs+eUgnme2H3fynkqEjhAZ0CmS0
         4hMfYp69O2zGM73fr7Tr8FQbNKYW/J+KhgA8xV8k6mGKdjXRW+nFujt9659BfjdRTN
         kg2ll2p3bPVKEI1QAw8KPuErStKRRugjqIItOjGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 4.19 06/47] firmware: improve LSM/IMA security behaviour
Date:   Thu, 18 Jul 2019 12:01:20 +0900
Message-Id: <20190718030048.929280831@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>

commit 2472d64af2d3561954e2f05365a67692bb852f2a upstream.

The firmware loader queries if LSM/IMA permits it to load firmware
via the sysfs fallback. Unfortunately, the code does the opposite:
it expressly permits sysfs fw loading if security_kernel_load_data(
LOADING_FIRMWARE) returns -EACCES. This happens because a
zero-on-success return value is cast to a bool that's true on success.

Fix the return value handling so we get the correct behaviour.

Fixes: 6e852651f28e ("firmware: add call to LSM hook before firmware sysfs fallback")
Cc: Stable <stable@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/firmware_loader/fallback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -659,7 +659,7 @@ static bool fw_run_sysfs_fallback(enum f
 	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
 	ret = security_kernel_load_data(LOADING_FIRMWARE);
 	if (ret < 0)
-		return ret;
+		return false;
 
 	return fw_force_sysfs_fallback(opt_flags);
 }


