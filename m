Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E082087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049602;
	bh=DEvJLhke1gtSRp/oaZajCb/LzKi5B79Or5g233Rz9RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K+lG+Yitoe4xfZye30AuR/QhpwjFkx78wjJD7vW1saFms2/g5yc03GlSIM2UPpi0b
	 szeoe6coSh3FqaoRqcvlyENwWQIKTCZIQlajTVgn1Daq9RXUZQoHFD77DfNQwWqDMz
	 LMdX0yTk2Eoi8B5i0CnJVu6WUo7c/EwMWcNnXdVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfCHMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfCHMxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4D62085A;
        Fri,  8 Mar 2019 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049597;
        bh=DEvJLhke1gtSRp/oaZajCb/LzKi5B79Or5g233Rz9RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amW6UteDreBpaqFVpOTiktjmp5lWiN5DhsytD2ZLmlsKe+R+VWLtpvz0Kr9PhIR3G
         LPN9PdKDKzXSWXgPhtUgssdDSMz0rkqbBWOcLgKu0WuBTR/MUyHszPHyl7mkifT86Q
         fdOYcf7VXQkD9ZQlhujMGRD/VtQRA+v6jqjxmHJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.0 41/46] Revert "selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config"
Date:   Fri,  8 Mar 2019 13:50:14 +0100
Message-Id: <20190308124904.889660310@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

From: Luis Chamberlain <mcgrof@kernel.org>

commit d2b284d356e9758d2bafd505d482e3c9433ef424 upstream.

This reverts commit 7492902e8d22b568463897fa967c0886764cf034.

The commit tried to address an issue discovered by Dan where he got
a message saying:

'usermode helper disabled so ignoring test'.

Dans's commit is forcing CONFIG_FW_LOADER_USER_HELPER_FALLBACK but just
having CONFIG_FW_LOADER_USER_HELPER suffices to emulate the_FALLBACK
functionality.

Dan's commit is trying to fix an issue which is hidden from a previous
commit. That issue will be addressed properly next.

Fixes: 7492902e8d22 ("selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/firmware/config |    1 -
 1 file changed, 1 deletion(-)

--- a/tools/testing/selftests/firmware/config
+++ b/tools/testing/selftests/firmware/config
@@ -1,6 +1,5 @@
 CONFIG_TEST_FIRMWARE=y
 CONFIG_FW_LOADER=y
 CONFIG_FW_LOADER_USER_HELPER=y
-CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y


