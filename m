Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37572080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381414;
	bh=MQsWj7qNwLokbOm9Aub8S2S/DyKPqKOXDHxvQCqmaY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T5677lvNrpbETWZv0KMQz3ezdgg9YgMChnpEhc5G+d1WKNN2/LB5pKQs77iLa2lzL
	 4c6NhGfYtRSTeBIy4vz1VcrD95jaaiUsxJHO2mE9+jAKbHr8HBkhZ2C1G8m9W6WKYj
	 /5Q1Pbg5yrPXwMPQp6AcjbXbtdZ1u5hSChfCTdwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLCN4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLCN4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:56:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5018F206DF;
        Tue,  3 Dec 2019 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381410;
        bh=MQsWj7qNwLokbOm9Aub8S2S/DyKPqKOXDHxvQCqmaY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oreWFIBRlUggiWy6WbMtFRSqXWuJQ/RAmVfJI8zL6BcRFtxmFXSWiEV/w5WWC9Puf
         anABBrtBSpR9GAi7vPsQag6qOLzXv3iUw5yn21gdK4k009Xyug1SunZGE1HUbw10/V
         JOZBBpMTsMOORzpIrS9uttxPwwB8V6ov9mhpNVo8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/23] perf machine: Fill map_symbol->maps in append_inlines() to fix segfault
Date:   Tue,  3 Dec 2019 10:55:55 -0300
Message-Id: <20191203135606.24902-13-acme@kernel.org>
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

I forgot to fill in the map_symbol->maps field in append_inlines() which
then makes code down the line segfault when trying to deref it.

It doesn't make any sense to have an addr_location with its 'map' member
not NULL while its 'maps' is NULL, after all al->maps is where al->map
is in.

It is done that way so that we don't have to have in each 'struct map' a
pointer to the 'struct maps' it is in, as we had in the past when we
would have 'map->mg', before 'struct maps' was combined with 'struct
map_groups', because there was always a one-to-one relationship for
these structs.

This fixes a segfault when processing DWARF callgraphs in 'perf report'.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 08f6680e627e ("perf tools: Add a 'struct map_groups' pointer to 'struct map_symbol'")
Link: http://lore.kernel.org/lkml/20191129160631.GD26963@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 416d174d223c..c8c5410315e8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2446,6 +2446,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		struct map_symbol ilist_ms = {
+			.maps = ms->maps,
 			.map = map,
 			.sym = ilist->symbol,
 		};
-- 
2.21.0

