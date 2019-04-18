Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040F220643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611732;
	bh=3C36l92cNG6sEqy6ZrrElWb6yU8msoO9Dr083m4+WJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yqCf5Dpx3/GFmnRgC4kKp+EEC2Ep9VTqGfSAn+nyuN1P+SyGxm7KkXNiU6+evQfPL
	 zqnCqt0Jjiu9Z/tVMs4P5BM1lHfcBl/xeuiOR4QkNcOyBx3BuY9fUGvfPrhkMk0VLv
	 kAZZZQTFrgWD3LnERTMm4/Iviza55c0EWdGIIU10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404037AbfDRSWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391622AbfDRSHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F992186A;
        Thu, 18 Apr 2019 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610841;
        bh=3C36l92cNG6sEqy6ZrrElWb6yU8msoO9Dr083m4+WJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLPswaht+TG3Gl4VaOX060+1EfCNWutax3r5baxqIgPbCTL8/Zfi4cCToS/0QUX5v
         GkWK/oqYJ4/dK52AbDyzt1jNPNHI/S3zCUMTY3RZkdQx48rWDs5i2PLtXfd1jXTB2D
         QeCJiKzxrQm9HIBkbOuq+1warDJoGTwULGBU0ZIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/50] tools/power turbostat: return the exit status of a command
Date:   Thu, 18 Apr 2019 19:57:23 +0200
Message-Id: <20190418160424.278403172@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2a95496634a017c19641f26f00907af75b962f01 ]

turbostat failed to return a non-zero exit status even though the
supplied command (turbostat <command>) failed.  Currently when turbostat
forks a command it returns zero instead of the actual exit status of the
command.  Modify the code to return the exit status.

Signed-off-by: David Arcari <darcari@redhat.com>
Acked-by: Len Brown <len.brown@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5ec2de8f49b4..b4c5d96e54c1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3691,6 +3691,9 @@ int fork_it(char **argv)
 		signal(SIGQUIT, SIG_IGN);
 		if (waitpid(child_pid, &status, 0) == -1)
 			err(status, "waitpid");
+
+		if (WIFEXITED(status))
+			status = WEXITSTATUS(status);
 	}
 	/*
 	 * n.b. fork_it() does not check for errors from for_all_cpus()
-- 
2.19.1



