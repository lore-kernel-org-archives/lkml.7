Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C01215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPwKAAIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgACNgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:36:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727508AbgACNgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578058611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QFlBo3vDQPLBWeq0dezqO4Vx5uH3VhVUt1aFOP/rzk=;
        b=gPwKAAIUfKV7nR8FBgzNtcWDi+e1aWV3o2uDO7ym5j3vC7U2oB9m8VcRjJ6mYNPzneLj/o
        1KFWwX+r3jQW7x6mLqmKrjJVkm1vw4XHGGwbrf+QLyyE2lYMXDQCt21LoB8/bRMPoHFwER
        HHT9cztt8ROgv6vuYAxcGTH2O1D7dZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-NmkAFACQM6SdShNifj5NLg-1; Fri, 03 Jan 2020 08:36:48 -0500
X-MC-Unique: NmkAFACQM6SdShNifj5NLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D2B4477;
        Fri,  3 Jan 2020 13:36:45 +0000 (UTC)
Received: from krava (ovpn-205-10.brq.redhat.com [10.40.205.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5495C7BFBD;
        Fri,  3 Jan 2020 13:36:43 +0000 (UTC)
Date:   Fri, 3 Jan 2020 14:36:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] tools lib traceevent: How to do library versioning being
 in the Linux kernel source?
Message-ID: <20200103133640.GD9715@krava>
References: <20200102122004.216c85da@gandalf.local.home>
 <20200102234950.GA14768@krava>
 <20200102185853.0ed433e4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102185853.0ed433e4@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 06:58:53PM -0500, Steven Rostedt wrote:
> On Fri, 3 Jan 2020 00:49:50 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > Should we move libtraceevent into a stand alone git repo (on
> > > kernel.org), that can have tags and branches specifically for it? We
> > > can keep a copy in the Linux source tree for perf to use till it  
> > 
> > so libbpf 'moved' for this reason to github repo,
> > but keeping the kernel as the true/first source,
> > and updating github repo when release is ready
> > 
> > libbpf github repo is then source for fedora (and others)
> > package
> 
> Ah, so perhaps I should follow this? I could keep it a kernel.org repo
> (as I rather have it there anyway).

sounds good, and if it works out, we'll follow you with libperf :-)

if you want to check on the libbpf:
  https://github.com/libbpf/libbpf

there might be some syncs scripts worth checking

jirka

> 
> We can have the tools/lib/traceevent be the main source, but then just
> copy it to the stand alone for releases.
> 
> Sudip, would this work for you too? (and yes, I plan on acking that
> patch for the -ldl change, after looking at it a little bit more).
> 
> -- Steve
> 

