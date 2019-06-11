Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC22C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8D12186A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279652;
	bh=HrmCyp25Xntii44gNDBqJn4vALmm1XDG9tE9nPjnsiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DB79elkRrYXGwAudTiOi73we3U5XknzdErt96B33YXmCzPuWTl07QgCY2FgG7Owtu
	 HFzbyaHR4gDjNgyWEJVOTc8GaOoGbUdhdAiDoSuBvKRM/eUYOYZVbvHuBBLcgXP9FO
	 Z5UOLMv3w9PyY+pwuVXtX+IuJlfdpl7rED1hqdG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392254AbfFKTAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391540AbfFKTAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06410217D6;
        Tue, 11 Jun 2019 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279649;
        bh=HrmCyp25Xntii44gNDBqJn4vALmm1XDG9tE9nPjnsiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOipStibXUo5AMr7iFf0xLCSgq/OICE9woeENHGk4toMcXx1idXOfMk4zZfhISZ8G
         9XNwSt3uHZkb9cghz7nT7++CiiDd5bLT9TdwpM7AhqEt7gA9R44N0kWxA3FKmwJ8fL
         h7MkfF8zA+Nmjc95sVS+PNgvMry7/hajjS8rz4nY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 25/85] perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated
Date:   Tue, 11 Jun 2019 15:58:11 -0300
Message-Id: <20190611185911.11645-26-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The user probably wants to replace the find text, so select the find
text when the find bar is activated.

That is fairly standard behaviour for search text entry.

Entering text will replace the current text, but using edit keys
(arrows, home, end etc) cancels the selection and enables editing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-23-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 94489cf2ce0e..6e7934f2ac9a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -400,6 +400,7 @@ class FindBar():
 
 	def Activate(self):
 		self.bar.show()
+		self.textbox.lineEdit().selectAll()
 		self.textbox.setFocus()
 
 	def Deactivate(self):
-- 
2.20.1

