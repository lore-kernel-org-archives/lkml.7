Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F2EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26412075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfE1JAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfE1JAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43EDD31760ED;
        Tue, 28 May 2019 09:00:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id C4ED41001E80;
        Tue, 28 May 2019 09:00:14 +0000 (UTC)
Date:   Tue, 28 May 2019 11:00:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf header: Add die information in CPU topology
Message-ID: <20190528090014.GF27906@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 28 May 2019 09:00:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:41:19PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> With the new CPUID.1F, a new level type of CPU topology, 'die', is
> introduced. The 'die' information in CPU topology should be added in
> perf header.
> 
> To be compatible with old perf.data, the patch checks the section size
> before reading the die information. The new info is added at the end of
> the cpu_topology section, the old perf tool ignores the extra data.
> It never reads data crossing the section boundary.
> 
> The new perf tool with the patch can be used on legacy kernel. Add a
> new function check_x86_die_exists() to check if die topology
> information is supported by kernel. The function only check X86 and
> CPU 0. Assuming other CPUs have same topology.

[jolsa@dell-r440-01 perf]$ sudo ./perf stat -e cycles --per-die -a -I 1000
#           time die cpus             counts unit events
     1.000526089 S0-D0          20          6,828,029      cycles
     1.000526089 S1-D0          20          2,609,924      cycles
     2.002578005 S0-D0          20          5,280,361      cycles


the title is shifted from the values

jirka
