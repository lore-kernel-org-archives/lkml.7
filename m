Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFFB2182B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbfHBNat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404243AbfHBNao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:30:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43EB030833B0;
        Fri,  2 Aug 2019 13:30:44 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id D93985C22F;
        Fri,  2 Aug 2019 13:30:40 +0000 (UTC)
Date:   Fri, 2 Aug 2019 15:30:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Keeping <john@metanate.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf unwind: fix libunwind when tid != pid
Message-ID: <20190802133039.GE27223@krava>
References: <20190729172430.14880-1-john@metanate.com>
 <20190729172430.14880-2-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729172430.14880-2-john@metanate.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 13:30:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:24:30PM +0100, John Keeping wrote:
> Commit e5adfc3e7e77 ("perf map: Synthesize maps only for thread group
> leader") changed the recording side so that we no longer get mmap events
> for threads other than the thread group leader.
> 
> When a file recorded after this change is loaded, the lack of mmap
> records mean that unwinding is not set up for any other threads.

sry I dont' follow what's the problem here, could you please
describe the scenrio where the current code is failing in
more details

> 
> Following the rationale in that commit, move the libunwind fields into
> struct map_groups and update the libunwind functions to take this
> instead of the struct thread.  This is only required for
> unwind__finish_access which must now be called from map_groups__delete
> and the others are changed for symmetry.
> 
> Note that unwind__get_entries keeps the thread argument since it is
> required for symbol lookup and the libdw unwind provider uses the thread
> ID.

SNIP

> @@ -59,37 +59,31 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
>  		return 0;
>  	}
>  out_register:
> -	unwind__register_ops(thread, ops);
> +	unwind__register_ops(mg, ops);
>  
> -	err = thread->unwind_libunwind_ops->prepare_access(thread);
> +	err = mg->unwind_libunwind_ops->prepare_access(mg);
>  	if (initialized)
>  		*initialized = err ? false : true;
>  	return err;
>  }
>  
> -void unwind__flush_access(struct thread *thread)
> +void unwind__flush_access(struct map_groups *mg)
>  {
> -	if (!dwarf_callchain_users)
> -		return;

why did you remove this check?

> -
> -	if (thread->unwind_libunwind_ops)
> -		thread->unwind_libunwind_ops->flush_access(thread);
> +	if (mg->unwind_libunwind_ops)
> +		mg->unwind_libunwind_ops->flush_access(mg);
>  }
>  
> -void unwind__finish_access(struct thread *thread)
> +void unwind__finish_access(struct map_groups *mg)
>  {
> -	if (!dwarf_callchain_users)
> -		return;

why did you remove this check?

thanks,
jirka
