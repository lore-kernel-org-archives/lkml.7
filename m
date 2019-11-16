Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75210C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8621823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920643;
	bh=ArEb2f18QmJygKaaZnogCTVHbEhcpUrues3qVydbb7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QPTj1acTSAUpYPOVA28OA4302GkBQ+ye8RMBxfYuKoZM7pnbSPQv/e2E2FSGUhJse
	 cYoS121DxjidOVjGtqH5dyht4Nzb6cNawXTJd1NBGZXzBOtOxQbEvHI3VwEYw/pE2q
	 K2/iMgaUiDsyUpOr3zjtgeouQyHGIXP/tlCAPr/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfKPQKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfKPPsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:53 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5373D20729;
        Sat, 16 Nov 2019 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919332;
        bh=ArEb2f18QmJygKaaZnogCTVHbEhcpUrues3qVydbb7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU2TBljMJ4nwDOGXsj+/KRFmq5RdW5FH45L69CwCKMI8XLS9maEJ/eY0ZCpMCKajr
         ZxEnu5IEYUcb4KZ20Ul16j7miKqRvsmMHiqzKkL+UPj0/Llp5xBfjbBiDF/gazYyeC
         GmE8w9QS/HUvJ5DacIYqhSWOqjss5Ojvte9YZVMs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 073/150] selftests: watchdog: Fix error message.
Date:   Sat, 16 Nov 2019 10:46:11 -0500
Message-Id: <20191116154729.9573-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Hoemann <jerry.hoemann@hpe.com>

[ Upstream commit 04d5e4bd37516ad60854eb74592c7dbddd75d277 ]

Printf's say errno but print the string version of error.
Make consistent.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index e029e2017280f..f1c6e025cbe54 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -109,7 +109,7 @@ int main(int argc, char *argv[])
 				printf("Last boot is caused by: %s.\n", (flags != 0) ?
 					"Watchdog" : "Power-On-Reset");
 			else
-				printf("WDIOC_GETBOOTSTATUS errno '%s'\n", strerror(errno));
+				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
 			break;
 		case 'd':
 			flags = WDIOS_DISABLECARD;
@@ -117,7 +117,7 @@ int main(int argc, char *argv[])
 			if (!ret)
 				printf("Watchdog card disabled.\n");
 			else
-				printf("WDIOS_DISABLECARD errno '%s'\n", strerror(errno));
+				printf("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
 			break;
 		case 'e':
 			flags = WDIOS_ENABLECARD;
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 			if (!ret)
 				printf("Watchdog card enabled.\n");
 			else
-				printf("WDIOS_ENABLECARD errno '%s'\n", strerror(errno));
+				printf("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
 			break;
 		case 'p':
 			ping_rate = strtoul(optarg, NULL, 0);
@@ -139,7 +139,7 @@ int main(int argc, char *argv[])
 			if (!ret)
 				printf("Watchdog timeout set to %u seconds.\n", flags);
 			else
-				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
+				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
 			break;
 		default:
 			usage(argv[0]);
-- 
2.20.1

