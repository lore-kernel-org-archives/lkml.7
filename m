Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3221655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504840AbfIXMDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439102AbfIXMDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:03:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C420810CC1EE;
        Tue, 24 Sep 2019 12:03:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id EE3C710013D9;
        Tue, 24 Sep 2019 12:03:46 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:03:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] perf tools: Support single perf.data file
 directory
Message-ID: <20190924120346.GC10113@krava>
References: <20190916085646.6199-1-adrian.hunter@intel.com>
 <20190916085646.6199-2-adrian.hunter@intel.com>
 <20190923213427.GB12521@krava>
 <766e6c36-c03f-0d9c-2983-565eb6a897bb@intel.com>
 <20190924111232.GA10113@krava>
 <9b283364-0d58-40c0-80ff-b01c31cafd0f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b283364-0d58-40c0-80ff-b01c31cafd0f@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 24 Sep 2019 12:03:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 02:51:28PM +0300, Adrian Hunter wrote:
> On 24/09/19 2:12 PM, Jiri Olsa wrote:
> > On Tue, Sep 24, 2019 at 12:12:25PM +0300, Adrian Hunter wrote:
> >> On 24/09/19 12:34 AM, Jiri Olsa wrote:
> >>> On Mon, Sep 16, 2019 at 11:56:45AM +0300, Adrian Hunter wrote:
> >>>> Support directory output that contains a regular perf.data file. This is
> >>>> preparation for adding support for putting a copy of /proc/kcore in that
> >>>> directory.
> >>>>
> >>>> Distinguish the multiple file case from the regular (single) perf.data file
> >>>> case by adding data->is_multi_file.
> >>>
> >>> SNIP
> >>>
> >>>>  static int open_file_read(struct perf_data *data)
> >>>>  {
> >>>>  	struct stat st;
> >>>> @@ -302,12 +312,17 @@ static int open_dir(struct perf_data *data)
> >>>>  {
> >>>>  	int ret;
> >>>>  
> >>>> -	/*
> >>>> -	 * So far we open only the header, so we can read the data version and
> >>>> -	 * layout.
> >>>> -	 */
> >>>> -	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> >>>> -		return -1;
> >>>> +	if (perf_data__is_multi_file(data)) {
> >>>> +		/*
> >>>> +		 * So far we open only the header, so we can read the data version and
> >>>> +		 * layout.
> >>>> +		 */
> >>>> +		if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> >>>> +			return -1;
> >>>> +	} else {
> >>>> +		if (asprintf(&data->file.path, "%s/perf.data", data->path) < 0)
> >>>> +			return -1;
> >>>> +	}
> >>>
> >>
> >> Thanks for replying :-)
> >>
> >>> first, please note that there's support for perf.data directory code,
> >>> but it's not been enabled yet, so we can do any changes there without
> >>> breaking existing users
> >>>
> >>> currently the logic is prepared to have perf.data DIR_FORMAT feature
> >>> to define the layout of the directory
> >>>
> >>> it'd be great to have just single point where we get directory layout,
> >>> not checking on files names first and checking on DIR_FORMAT later
> >>
> >> Ok, but what are you suggesting?  Naming the data file "header" seems a bit
> >> counter-intuitive in this case.
> > 
> > don't know ;-)
> 
> So what about calling it "data" instead of "header"?

ok, it actualy contains data in threaded record as well,
so no problem there..

> 
> > 
> > but I'd like to have one way of finding out the directory layout
> > 
> > the code for threaded record uses DIR_FORMAT feature value
> > to ensure the directory contains the expected files, which
> > is data file with 'data.<cpu>' name for every cpu
> > 
> >>
> >>>
> >>> also the kcore will be beneficial for other layouts,
> >>> so would be great to make it somehow optional/switchable
> >>
> >> In these patches it is, because it is not related to the DIR_FORMAT.
> >>
> >>> one of the options could be to have DIR_FORMAT feature as the source
> >>> of directory layout and it'd have bitmask of files/dirs (like kcore_dir)
> >>> available in the directory
> >>
> >> Is there an advantage to making optional files/dirs part of the format?
> >> i.e. if they are there, use them otherwise don't.
> > 
> > ok, that might work, but please make that somehow explicit/visible
> > what files/directories are possible in the directory, so we could
> > easily see them and add new ones
> 
> At the moment, what can exist is what can be removed i.e. see
> rm_rf_perf_data().  Will that do?

ok, but also please some comments in data.h and perf.data doc update ;-)

jirka
