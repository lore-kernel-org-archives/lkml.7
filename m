Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA09C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC54C2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfJNIsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbfJNIsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:48:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F11ACC049E36;
        Mon, 14 Oct 2019 08:48:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 04A921001B08;
        Mon, 14 Oct 2019 08:48:11 +0000 (UTC)
Date:   Mon, 14 Oct 2019 10:48:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 3/3] perf tools: Make 'struct map_shared' truly shared
Message-ID: <20191014084811.GA9700@krava>
References: <20191013151427.11941-1-jolsa@kernel.org>
 <20191013151427.11941-4-jolsa@kernel.org>
 <20191014031054.GJ9933@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014031054.GJ9933@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 14 Oct 2019 08:48:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 08:10:54PM -0700, Andi Kleen wrote:
> On Sun, Oct 13, 2019 at 05:14:27PM +0200, Jiri Olsa wrote:
> > Andi reported that maps cloning is eating lot of memory and
> > it's probably unnecessary, because they keep the same data.
> > 
> > Changing 'struct map_shared' to be a pointer inside 'struct map',
> > so it can be shared on fork. Changing the map__clone function to
> > actually share 'struct map_shared' for cloned maps.
> > 
> > The 'struct map_shared' carries its own refcnt counter, which is
> > incremented when it's assigned to new 'struct map' and decremented
> > when 'struct map' gets deleted in map__delete (its refcnt is 0).
> > 
> > This 'maps sharing' seems to save lot of heap for reports with
> > many forks/cloned mmaps (over 60% in example below).
> 
> The one case I wasn't sure about is with JIT support. So if
> a map gets modified with fixup/start from /tmp/perf-%d 
> in one process, would it impact the other too?

there are cases we do the fixup for maps and we clone
the map fully in those cases, but not sure now what JIT
does.. I'll check the JIT path

thanks,
jirka

> 
> We may need a COW operation for this (hopefully rare) case.
> 
> -Andi
