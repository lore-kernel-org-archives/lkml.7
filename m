Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F90C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3628206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfDOI2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfDOI2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:28:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A30DCC05D3F9;
        Mon, 15 Apr 2019 08:28:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29ED56013A;
        Mon, 15 Apr 2019 08:28:09 +0000 (UTC)
Date:   Mon, 15 Apr 2019 10:28:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf/report: [RFC] Handling OOM in perf report
Message-ID: <20190415082809.GA13124@krava>
References: <20190401142000.17679-1-tmricht@linux.ibm.com>
 <20190409104205.GB29688@krava>
 <06273b1f-faea-5d88-1696-eb686ef47a6c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06273b1f-faea-5d88-1696-eb686ef47a6c@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 15 Apr 2019 08:28:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:17:30AM +0200, Thomas-Mich Richter wrote:

SNIP

> > 
> > 
> > ---
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index b17f1c9bc965..eea247a26ad8 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1933,7 +1933,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> >  		       file_offset + head, event->header.size,
> >  		       event->header.type);
> > -		err = -EINVAL;
> > +		err = skip;
> >  		goto out;
> >  	}
> >  
> > 
> 
> Above patch does not help, you simply return -ENOMEM instead of -EINVAL and processing
> stops with no indication that perf ran out of memory. Bailing out in this case is ok.
> 
> I am fine with your patch, as long as it gives a reason why processing stopped.
> In the GUI it shows on the bottom line the reason:
> 
>   0xf4198 [0x8]: failed to process type: 68 [Cannot allocate memory]

looks good, please post the full patch

thanks,
jirka

> 
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b17f1c9bc965..e89716175588 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>         if (size < sizeof(struct perf_event_header) ||
>             (skip = rd->process(session, event, file_pos)) < 0) {
> -               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> +               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
>                        file_offset + head, event->header.size,
> -                      event->header.type);
> -               err = -EINVAL;
> +                      event->header.type, strerror(-skip));
> +               err = skip;
>                 goto out;
>         }
>  
> [root@m35lp76 perf]#
> -- 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Matthias Hartmann
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
