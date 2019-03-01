Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F852087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfCAK0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:26:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13657 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAK0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:26:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B5F3310FB92;
        Fri,  1 Mar 2019 10:26:47 +0000 (UTC)
Received: from krava (ovpn-204-247.brq.redhat.com [10.40.204.247])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3AD10620CA;
        Fri,  1 Mar 2019 10:26:45 +0000 (UTC)
Date:   Fri, 1 Mar 2019 11:26:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, tonyj@suse.com, nasastry@in.ibm.com
Subject: Re: [PATCH] perf c2c: Fix c2c report for empty numa node
Message-ID: <20190301102644.GC2979@krava>
References: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
 <20190228161231.GB8674@krava>
 <20190228162208.GC8674@krava>
 <9ee9ca23-bb29-2038-5fe3-d52bcf4cd049@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee9ca23-bb29-2038-5fe3-d52bcf4cd049@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 01 Mar 2019 10:26:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:35:39PM +0530, Ravi Bangoria wrote:
> 
> On 2/28/19 9:52 PM, Jiri Olsa wrote:
> > how about attached change (untested)?
> 
> LGTM. Would you mind sending a patch.

attached, please test on your system

thanks,
jirka

---
Ravi Bangoria reported that we fail with empty
numa node with following message:

  $ lscpu
  NUMA node0 CPU(s):
  NUMA node1 CPU(s):   0-4

  $ sudo ./perf c2c report
  node/cpu topology bugFailed setup nodes

Fixing this by detecting empty node and keeping
its cpu set empty.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/n/tip-dyq5jo6pn1j3yqavb5ukjwwu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4272763a5e96..9e6cc868bdb4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2056,6 +2056,12 @@ static int setup_nodes(struct perf_session *session)
 		if (!set)
 			return -ENOMEM;
 
+		nodes[node] = set;
+
+		/* empty node, skip */
+		if (cpu_map__empty(map))
+			continue;
+
 		for (cpu = 0; cpu < map->nr; cpu++) {
 			set_bit(map->map[cpu], set);
 
@@ -2064,8 +2070,6 @@ static int setup_nodes(struct perf_session *session)
 
 			cpu2node[map->map[cpu]] = node;
 		}
-
-		nodes[node] = set;
 	}
 
 	setup_nodes_header();
-- 
2.17.2

