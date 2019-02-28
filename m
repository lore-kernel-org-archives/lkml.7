Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E885C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36C218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfB1QWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfB1QWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:22:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 105F0CF630;
        Thu, 28 Feb 2019 16:22:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 507AC1001DEA;
        Thu, 28 Feb 2019 16:22:09 +0000 (UTC)
Date:   Thu, 28 Feb 2019 17:22:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, tonyj@suse.com, nasastry@in.ibm.com
Subject: Re: [PATCH] perf c2c: Fix c2c report for empty numa node
Message-ID: <20190228162208.GC8674@krava>
References: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
 <20190228161231.GB8674@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228161231.GB8674@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 28 Feb 2019 16:22:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 05:12:31PM +0100, Jiri Olsa wrote:
> On Thu, Feb 28, 2019 at 09:07:19PM +0530, Ravi Bangoria wrote:
> > perf c2c report fails if system has empty numa node(0 cpus):
> > 
> >   $ lscpu
> >   NUMA node0 CPU(s):   
> >   NUMA node1 CPU(s):   0-4
> > 
> >   $ sudo ./perf c2c report 
> >   node/cpu topology bugFailed setup nodes
> > 
> > Fix this.
> > 
> > Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---
> >  tools/perf/util/cpumap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 383674f448fc..517c3f37c613 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -261,7 +261,7 @@ struct cpu_map *cpu_map__dummy_new(void)
> >  	struct cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
> >  
> >  	if (cpus != NULL) {
> > -		cpus->nr = 1;
> > +		cpus->nr = 0;
> 
> you can't do this, there's one item in the map, nr needs to
> reflect that.. it breaks 'perf test' badly
> 
> so the node is empty.. we need to teach c2c to work with that
> I'll check


how about attached change (untested)?

but I wonder there are some other hidden
bugs wrt empty node

jirka


---
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
