Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A4520673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfIWPJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfIWPJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:09:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3168A308424C;
        Mon, 23 Sep 2019 15:09:49 +0000 (UTC)
Received: from krava (unknown [10.40.205.167])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C56060BEE;
        Mon, 23 Sep 2019 15:09:44 +0000 (UTC)
Date:   Mon, 23 Sep 2019 17:09:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 10/73] libperf: Add perf_mmap struct
Message-ID: <20190923150943.GA19642@krava>
References: <20190913132355.21634-1-jolsa@kernel.org>
 <20190913132355.21634-11-jolsa@kernel.org>
 <20190923150533.GG16544@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923150533.GG16544@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 23 Sep 2019 15:09:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:05:33PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 13, 2019 at 03:22:52PM +0200, Jiri Olsa escreveu:
> > Add the perf_mmap to libperf.
> > 
> > The definition is added into:
> > 
> >   include/internal/mmap.h
> > 
> > which is not to be included by users, but shared
> > within perf and libperf.
> 
> > diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
> > new file mode 100644
> > index 000000000000..8d10559dee49
> > --- /dev/null
> > +++ b/tools/perf/lib/include/internal/mmap.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LIBPERF_INTERNAL_MMAP_H
> > +#define __LIBPERF_INTERNAL_MMAP_H
> > +
> > +#include <linux/refcount.h>
> > +#include <linux/compiler.h>
> > +#include <stdlib.h>
> > +#include <stdbool.h>
> 
> So you're doing this with high granularity, cool! But then you should
> take care not to add unnecessary stuff here, i.e. these four headers are

yea, they will be needed for added fields in following patches

> not necessary at this point in the series, I'm removing them and adding
> as they become necessary.

ok, thanks

jirka
