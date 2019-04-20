Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC62C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470552186A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfDTIsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 04:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfDTIsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 04:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAAA488307;
        Sat, 20 Apr 2019 08:48:22 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4579A1001DD1;
        Sat, 20 Apr 2019 08:48:19 +0000 (UTC)
Date:   Sat, 20 Apr 2019 10:48:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Thomas Backlund <tmb@mageia.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 5.0 05/93] perf data: Dont store auxtrace index for
 directory data file
Message-ID: <20190420084818.GA16414@krava>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160437.573320142@linuxfoundation.org>
 <bda0be31-de84-50dc-e2f7-eed766bd542f@mageia.org>
 <20190419132527.GB17719@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419132527.GB17719@sasha-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 20 Apr 2019 08:48:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:25:27AM -0400, Sasha Levin wrote:
> On Thu, Apr 18, 2019 at 10:28:47PM +0300, Thomas Backlund wrote:
> > Den 18-04-2019 kl. 20:56, skrev Greg Kroah-Hartman:
> > > [ Upstream commit cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810 ]
> > > 
> > > We can't store the auxtrace index when we store into multiple files,
> > > because we keep only offset for it, not the file.
> > > 
> > > The auxtrace data will be processed correctly in the 'pipe' mode.
> > > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Stephane Eranian <eranian@google.com>
> > > Link: http://lkml.kernel.org/r/20190308134745.5057-3-jolsa@kernel.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  tools/perf/builtin-record.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index 882285fb9f64..3fd154f1701b 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -386,7 +386,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
> > >  	size_t padding;
> > >  	u8 pad[8] = {0};
> > > -	if (!perf_data__is_pipe(data)) {
> > > +	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
> > >  		off_t file_offset;
> > >  		int fd = perf_data__fd(data);
> > >  		int err;
> > > 
> > 
> > 
> > This breaks the build with:
> > 
> > builtin-record.c: In function 'record__process_auxtrace':
> > builtin-record.c:389:36: warning: implicit declaration of function
> > 'perf_data__is_dir'; did you mean 'perf_data__is_pipe'?
> > [-Wimplicit-function-declaration]
> >  if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
> >                                    ^~~~~~~~~~~~~~~~~
> > 
> > Looks like it depends atleast on:
> > 
> > commit ec65def1045e4c7817b7f741a86dadae82877a93
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Fri Mar 8 14:47:35 2019 +0100
> > 
> >    perf data: Support having perf.data stored as a directory
> > 
> > 
> > Maybe better to drop it.
> 
> I've dropped it, thanks!

yes, no harm to drop this one if the perf_data__is_dir is not backported

jirka
