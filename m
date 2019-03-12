Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35094C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE34D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="C6s+cSwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCLNwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:52:32 -0400
Received: from one.firstfloor.org ([193.170.194.197]:54120 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:52:32 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id D199987570; Tue, 12 Mar 2019 14:52:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1552398750;
        bh=6SWTbw50lb1ZItQgBoNK51sNIOTEPw6noz8F1vLVMck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6s+cSwlUqo0/EgxNolKFOnWftU0kiyarE+Liv+sKVldzIC/GxmndTVREI9LvPPo+
         fPOFAy5WQe3jz2Gxy+CrJEpc8bPHiJhON3jfwIm6yI5WybOCk0NTG3LycRbGlaP9ct
         jZEbTpbJi3aAKF0FPZJkcDVfA6MI+b8WYtbFJUGs=
Date:   Tue, 12 Mar 2019 06:52:30 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf, tools, report: Set up samples correctly in
 hierarchy mode
Message-ID: <20190312135230.bmjm4ynzrtwjf7cr@two.firstfloor.org>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-4-andi@firstfloor.org>
 <20190312111259.GA24700@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312111259.GA24700@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:12:59PM +0100, Jiri Olsa wrote:
> On Mon, Mar 11, 2019 at 08:52:24PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > In hierarchy mode the res samples need to be cloned from the parent
> > entry. Copy them in this case. This fixes res sample browsing
> > with --hierarchy.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/util/hist.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 1f230285d78a..dcf24581dfbd 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -437,8 +437,15 @@ static int hist_entry__init(struct hist_entry *he,
> >  	}
> >  
> >  	if (symbol_conf.res_sample) {
> > -		he->res_samples = calloc(sizeof(struct res_sample),
> > -					symbol_conf.res_sample);
> > +		if (he->res_samples) {
> 
> I dont think this leg will ever execute because we don't set
> res_samples in template

I originally thought this too, but ...

The hierarchy mode calls it with a hist entry that is not
a template.

-Andi
