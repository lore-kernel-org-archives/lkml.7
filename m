Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E8D2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122149;
	bh=M1vlaAi5suffo46HsoG0DnNlWRvEJ7Gma9/swqx3m3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JK8jrAvypJaRJ/e0FJUaUg2oL6V2KvFGia4gg80NjW+H3e589tJA4wj6C5JfEDeM/
	 pGABLdMXw2EvqKBsdlPSs+jlOERW171yIbi+ILI5KERziNoU8NjgkB714P22eadpSh
	 SQqEDiZMtqBXA/Tx+/cFBx0q/IBopOBtKDo9IkBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393278AbfJCRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732358AbfJCQnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:43:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2032070B;
        Thu,  3 Oct 2019 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120985;
        bh=M1vlaAi5suffo46HsoG0DnNlWRvEJ7Gma9/swqx3m3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Xyt/2rG7KgJ5y/MtOdm/J1drHP8C/05xc5cDMaqSnmyMa0e2fzg+TJSaySdUzFKD
         KdDGtA9H2lNTUhhEjRzg97xvOIfYFjWPPk6ZqT9Ew8MufFPaUvrfPrkuZSl4q6/zOO
         yMN+QXkfNyCFfXZJXhuZZoujXe15OvZwgueJzAgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 104/344] perf config: Honour $PERF_CONFIG env var to specify alternate .perfconfig
Date:   Thu,  3 Oct 2019 17:51:09 +0200
Message-Id: <20191003154550.468326116@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 61a461fcbd62d42c29a1ea6a9cc3838ad9f49401 ]

We had this comment in Documentation/perf_counter/config.c, i.e. since
when we got this from the git sources, but never really did that
getenv("PERF_CONFIG"), do it now as I need to disable whatever
~/.perfconfig root has so that tests parsing tool output are done for
the expected default output or that we specify an alternate config file
that when read will make the tools produce expected output.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")
Link: https://lkml.kernel.org/n/tip-jo209zac9rut0dz1rqvbdlgm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/perf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 97e2628ea5dd1..d4e4d53e8b44b 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -441,6 +441,9 @@ int main(int argc, const char **argv)
 
 	srandom(time(NULL));
 
+	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
+	config_exclusive_filename = getenv("PERF_CONFIG");
+
 	err = perf_config(perf_default_config, NULL);
 	if (err)
 		return err;
-- 
2.20.1



