Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED9C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE64206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620355;
	bh=457wAsHnS0YTQGp7Sfq5g+YU6k6qJwEx4S3MVVzBvWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YY/x4zQc8YUAqYcZTf1cR9f4Jyoig8IOV6tuMYWEOu0qd8tCEY5gSee3cJm9jJDRD
	 FDR/ywXoalFYk3vIZb2b7xw914InacapN78P+hIUItVAsd4w2EvORu5se8iWrOdPpe
	 asO1Xa7b7Ud5Rv6Natu9fTptG8lELjThcEQLKZa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfIDSFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389331AbfIDSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:05:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0238E206B8;
        Wed,  4 Sep 2019 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620350;
        bh=457wAsHnS0YTQGp7Sfq5g+YU6k6qJwEx4S3MVVzBvWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2GQ/Z0UpuSdqWe+fNHtHgcxw65G99epV9qgwwFai3/1RqXjw1BPT1QdmCRc1ETtf
         Vro0/sQdWTf7jvuMTHqfAr0z0yHD0PhJcKiBGUZaWDztaPtcnamIxIaH4yUdpDl9sF
         7JhXe+ieZHiTWbPSRvIHaEw0FdExINWmmzIc6JAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adrian Vladu <avladu@cloudbasesolutions.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: [PATCH 4.19 25/93] tools: hv: fix KVP and VSS daemons exit code
Date:   Wed,  4 Sep 2019 19:53:27 +0200
Message-Id: <20190904175305.539240373@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b0995156071b0ff29a5902964a9dc8cfad6f81c0 ]

HyperV KVP and VSS daemons should exit with 0 when the '--help'
or '-h' flags are used.

Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 2 ++
 tools/hv/hv_vss_daemon.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index d7e06fe0270ee..0ce50c319cfd6 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1386,6 +1386,8 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 		case 'h':
+			print_usage(argv);
+			exit(0);
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index b133001727623..c2bb8a3601777 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -229,6 +229,8 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 		case 'h':
+			print_usage(argv);
+			exit(0);
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
-- 
2.20.1



