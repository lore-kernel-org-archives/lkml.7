Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F8CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EF02083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbfJNUkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:40:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730188AbfJNUkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B731308FBB1;
        Mon, 14 Oct 2019 20:40:35 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id A097C60BE2;
        Mon, 14 Oct 2019 20:40:33 +0000 (UTC)
Date:   Mon, 14 Oct 2019 22:40:32 +0200
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
Message-ID: <20191014204032.GC15890@krava>
References: <20191013151427.11941-1-jolsa@kernel.org>
 <20191013151427.11941-4-jolsa@kernel.org>
 <20191014031054.GJ9933@tassilo.jf.intel.com>
 <20191014192049.GB15890@krava>
 <20191014194619.GS9933@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014194619.GS9933@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 14 Oct 2019 20:40:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:46:19PM -0700, Andi Kleen wrote:
> > > We may need a COW operation for this (hopefully rare) case.
> > 
> > so the jitted mmaps are inserted into the data file
> > and processed during report where they can overload
> > existing maps - thats detected before addition in:
> > 
> >   thread__insert_map
> >     map_groups__fixup_overlappings
> >       - which uses COW way -> map__clone(map, false);
> >         to create new map
> > 
> > other fixups to maps are being done only for kernel maps,
> > where we dont have a problem, because there's only one copy
> 
> I assume the same is true for /tmp/perf-* processing?
> 

perf-*.map processing adds only symbol for dso,
it does not touch maps, so we're fine

  dso__load -> dso__load_perf_map

jirka
