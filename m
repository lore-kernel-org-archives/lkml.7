Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F51C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B5215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888453;
	bh=ArEb2f18QmJygKaaZnogCTVHbEhcpUrues3qVydbb7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hcZBRe0XckN1VWCokFz756hrMQIbs4qPp40hA/ZQelXmEQT5CSALAntFEf5pPLDEY
	 uvKlLhaGWJSshHUwpE06YFInqAHUuq/SwWKV2DPrQ5q7GqTnK9XIErG8l/0/wjb1vR
	 7YF4hRdVa5j0Di+qCNSeVDYrYBO0wuJeYYnV6N5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfK0VAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbfK0VAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:00:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE4A21556;
        Wed, 27 Nov 2019 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888448;
        bh=ArEb2f18QmJygKaaZnogCTVHbEhcpUrues3qVydbb7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yeuFFZmuaVdChBWWDW5wPM3gai0fZp9kvzwZLn9M4Bh/j+LdCbIdpNEk7l1iyI4ao
         VdkGxu8pkXlY/zD9NcIg/fTPLDFEI8/9lpALJUXeiq2S5elS+LOs50jp5HOTiRUJXm
         d3sNKus0QlD/6jQ/4h5Bgc4MSA++SD8XCpC7+AG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/306] selftests: watchdog: Fix error message.
Date:   Wed, 27 Nov 2019 21:29:46 +0100
Message-Id: <20191127203124.986247152@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



