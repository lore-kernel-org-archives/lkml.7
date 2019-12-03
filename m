Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BE5207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381470;
	bh=tWcjEHHLpVhKLX1B5i7zG6hngQtT0ckeiqNvl9ldcOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mqiX8WNnhM5j736jXogSWyheIMhFh/c2pfbpAv4FyWPEiCjwkUbh2FKq1Xr2eM+TJ
	 9pAv8YcPlbZ7AFoaO+KVrCGPk2YDJAbxQAghVR+lVD0ugTRoJyR5WGR0uuRAdM5CnK
	 ldAoQyEdkAvS0bORKewKx1nwfALYrKSRiARF8n4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfLCN5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfLCN5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:03 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD47206DF;
        Tue,  3 Dec 2019 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381423;
        bh=tWcjEHHLpVhKLX1B5i7zG6hngQtT0ckeiqNvl9ldcOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCkmWrMy4q89f33BGKb7EL/5VYpvsiGS+5pB7zS0kLn/Z8hfxZ55YC0UZ4nVF3eL8
         GqszEYqBSxzmSUtSo0hUQpw4E267M+WdjG8Pta4PqLVD1tV5A1mcLCc878X/N3dSBC
         ETyh7ubN2wtmkh+LCOGvzaI9uubMOfy0Tpb6iEug=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 16/23] tools headers uapi: Sync linux/stat.h with the kernel sources
Date:   Tue,  3 Dec 2019 10:55:59 -0300
Message-Id: <20191203135606.24902-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  3ad2522c64cf ("statx: define STATX_ATTR_VERITY")

That don't trigger any changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/stat.h' differs from latest version at 'include/uapi/linux/stat.h'
  diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h

At some point we wi'll beautify structs passed in pointers to syscalls
and then we'll need to have tables for these defines, for now update the
file to silence the warning as this file is used for doing this type of
number -> string translations for other defines found in these file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-thcy60dpry5qrpn7nmc58bwg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 7b35e98d3c58..ad80a5c885d5 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -167,8 +167,8 @@ struct statx {
 #define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
 #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
-
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.21.0

