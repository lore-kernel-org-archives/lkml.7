Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E67C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72AF20665
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfGQHKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQHKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:10:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC8BB81F1B;
        Wed, 17 Jul 2019 07:10:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32C711001B0E;
        Wed, 17 Jul 2019 07:10:28 +0000 (UTC)
Date:   Wed, 17 Jul 2019 09:10:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Lubashev, Igor" <ilubashe@akamai.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Message-ID: <20190717071027.GG28722@krava>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-3-git-send-email-ilubashe@akamai.com>
 <20190716084744.GB22317@krava>
 <cd2b162a59804cdaa7f4de18c3337aa8@ustx2ex-dag1mb5.msg.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2b162a59804cdaa7f4de18c3337aa8@ustx2ex-dag1mb5.msg.corp.akamai.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 17 Jul 2019 07:10:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 05:01:26PM +0000, Lubashev, Igor wrote:
> I could add another patch to the series for that.  Any suggestion for what capability to check for here?

it's:

	if (geteuid() != 0) {
		pr_err("ftrace only works for root!\n");
		return -1
	}

so I think check for CAP_SYS_ADMIN should be fine in here

jirka

> 
> (There is always an alternative to not check for anything and let the kernel refuse to perform actions that the user does not have permissions to perform.)
> 
> - Igor
> 
> -----Original Message-----
> From: Jiri Olsa <jolsa@redhat.com> 
> Sent: Tuesday, July 16, 2019 4:48 AM
> Subject: Re: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
> 
> On Tue, Jul 02, 2019 at 08:10:04PM -0400, Igor Lubashev wrote:
> > The kernel is using CAP_SYS_ADMIN instead of euid==0 to override
> > perf_event_paranoid check. Make perf do the same.
> 
> I see another geteuid check in __cmd_ftrace,
> perhaps we should cover this one as well
> 
> jirka
