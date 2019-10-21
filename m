Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663DFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383952084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyPjwNMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfJUOD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:03:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44389 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfJUOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:03:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id z22so652978qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yJ6NWK3+y47qJNKwndVXDj2/ATwqUtToUepvPqRakG8=;
        b=jyPjwNMlkEEAsLGVntxHWlJqyTw+GwheMjNwe+AXOj/cW4Gsn1GWOeYKsnr1GH5J5R
         ThFHUWTGRF02yFNs7v1vygAc5P0a0m0fb+Ycp+dkKCxLkc1mQuRQ6ErzOZLek2V2hB7w
         U9qH2958zSq1Nl+rQNsr/KkmbgyLCEcRwwu5HmoHb+jwdLeiV41Zt80/e3+UKJ//T5Ly
         TGEji88aBps7KSkstG3bEeRHCq3Oz8WjxHRd/0mzv0H9TbAWb82ccB2BKmlUfj2Gmb2y
         zbhqmqpDk+4EyPtWg9+0TX0o3e/nPhx8Z8P3R/Qgsi3JmBv5UCDJOiBqoEy/pw+bN3JS
         NICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJ6NWK3+y47qJNKwndVXDj2/ATwqUtToUepvPqRakG8=;
        b=uk1XyWYg95oUgbBTD8lVnZAK/kX5Jsq00PPfUSsvqM/tX2AwEkqOFYun37AmbKQu73
         XDsGXqdCw0T2M/1/64tdiCyOZR4gViC3u0PD1cR/mFkF+hHUVekzaso3RUN5HlBCIu+O
         5y6kPHEJrw2ZBYJHWF99B8PUN804ZsZ+WnKl0pwLuxo9brf738gNtiHB2nlghwBfGT+l
         bJPxTMPNXRfHhqH9UrBRGpr3nf4fJssle1Tsy46mH+wYXII3gagBOqSybuSlUwj4wvNq
         BB9O93agJedliIlv6dM6F3NkA30PGt1Kiuvjmt3z3C3FJzAU69pt783JXr9jYqq8cuQk
         mXXw==
X-Gm-Message-State: APjAAAWKCugt3PIYn36vct3TIQqEVfcXrArwFD/PRxLNmCbUTBpqOMok
        4N6dPBOamIU5vL8SGRECPZk=
X-Google-Smtp-Source: APXvYqycTbsexlHoaLbUyPcVYizLiGVdIA549WORSKuNn+5b/TZy5eZhixWALOIWpAj3P1LhcKaS7g==
X-Received: by 2002:ac8:6957:: with SMTP id n23mr4563039qtr.305.1571666606788;
        Mon, 21 Oct 2019 07:03:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c126sm8691040qkd.13.2019.10.21.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:03:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D455C4035B; Mon, 21 Oct 2019 11:03:23 -0300 (-03)
Date:   Mon, 21 Oct 2019 11:03:23 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf tools: Support single perf.data file directory
Message-ID: <20191021140323.GC10039@kernel.org>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-5-adrian.hunter@intel.com>
 <20191007112027.GD6919@krava>
 <2340d60c-e8a6-2333-06ce-77076c912a1c@intel.com>
 <a2853fa8-a2e8-8e17-132c-0d47b8129eff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2853fa8-a2e8-8e17-132c-0d47b8129eff@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 21, 2019 at 03:42:39PM +0300, Adrian Hunter escreveu:
> On 7/10/19 3:06 PM, Adrian Hunter wrote:
> > On 7/10/19 2:20 PM, Jiri Olsa wrote:
> >> On Fri, Oct 04, 2019 at 11:31:20AM +0300, Adrian Hunter wrote:
> >>
> >> SNIP
> >>
> >>>  	u8 pad[8] = {0};
> >>>  
> >>> -	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
> >>> +	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
> >>>  		off_t file_offset;
> >>>  		int fd = perf_data__fd(data);
> >>>  		int err;
> >>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> >>> index df173f0bf654..964ea101dba6 100644
> >>> --- a/tools/perf/util/data.c
> >>> +++ b/tools/perf/util/data.c
> >>> @@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
> >>>  	DIR *dir;
> >>>  	int nr = 0;
> >>>  
> >>> +	/*
> >>> +	 * Directory containing a single regular perf data file which is already
> >>> +	 * open, means there is nothing more to do here.
> >>> +	 */
> >>> +	if (perf_data__is_single_file(data))
> >>> +		return 0;
> >>> +
> >>
> >> cool, I like this approach much more than the previous flag
> > 
> > Yes it is much nicer.  Thanks for your direction on that.
> > 
> >>
> >> any change you (if there's repost) or Arnaldo
> >> could squeeze in indent change below?
> > 
> > Sent a patch, to be applied before these.
> > 
> 
> That is:
> 
> "[PATCH] perf session: Fix indent in perf_session__new()"

Done it as a separate patch, etc.
 
> Any comments on this patch set Arnaldo?

-- 

- Arnaldo
