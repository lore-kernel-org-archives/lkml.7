Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F762146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk9ax0xA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfLROUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:20:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33760 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfLROUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:20:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id z16so1311079pfk.0;
        Wed, 18 Dec 2019 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uuW/6iCy7ecNdnidN2Pk7EDOQ/h19itMrsd0ZjDBvfw=;
        b=Hk9ax0xAmpljwKiCyzVihzVRkfJ2DqkR9dAMwSAUpqRR4ZYglUNHxHisS4poCqocD4
         wqmcS2jqGuOODoAF1qO3jQ30L4H06eimDUPLJ0f+y2cXwTCG9EiJ9qZat9Wwi8wzCSaW
         llWv59Tf9xS4sw+wm7Z58YoGTvOCoB7x7gBx96mVdC46q+nBmntP+rINoVO+elyEc4lP
         scQZRAjfC7tQ2m9CA4EEW7zxtOC9IXuXfh3Mcqno8EMdHSgoZZrdkxS9ijutHYAeIwSp
         E0J3pxisOFbP3jjDpwWh3fBVrBZQU0WShSShrl2N0KZL7MpQnvT9OxsN40krUYAP2jii
         OtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuW/6iCy7ecNdnidN2Pk7EDOQ/h19itMrsd0ZjDBvfw=;
        b=hwX2O81vGB43WNVgOMnJK4jxqzZleUW747ADhMQmF5xwq4k5lxpNIudhOjRQmwT3aa
         P/+CLzZHcQMwuh6ngJgV3+lZYfow03zUDU/apIH1FhdLIRPhI0PIkE6isL0pFtQvSNNU
         XtQ/rrLpZaaP0BW9+3bhMRkn1VF9dNEtR9jo/E+LAqjXigKDWSg6ZDDB/dCbotbJnQeZ
         7Y+1bi+D2LbFSdt2I181vPNtJbDeSVMhtC+Lc7loZXSEATA/JGmty9oSIZ1aYPS/vzFH
         hOkaigwe1VYNepu/k8UeGdc4y8PrYUrUa6bvE5+jKXxZWr6wsH91QHgAsYHWrj15d9n3
         xSAA==
X-Gm-Message-State: APjAAAUbw9I9hhiSgOTunjr0xgMj782O6BmAD8K6mh8VZqwRLea7G37C
        5TjUigeP/oXLArjTnBrM+Xj3B38X
X-Google-Smtp-Source: APXvYqwivTFZwXqvn2cFuZnC04jwYiLnsEZviVjW/PGwhCbFzgfGZRzdEHWuE0evhiv7W0vSpWLx9g==
X-Received: by 2002:a63:d411:: with SMTP id a17mr3503015pgh.333.1576678813164;
        Wed, 18 Dec 2019 06:20:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b22sm3661270pfd.63.2019.12.18.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:20:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5EBBC40352; Wed, 18 Dec 2019 11:20:10 -0300 (-03)
Date:   Wed, 18 Dec 2019 11:20:10 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Message-ID: <20191218142010.GD13395@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090707.GF19062@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218090707.GF19062@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 18, 2019 at 10:07:07AM +0100, Jiri Olsa escreveu:
> On Tue, Dec 17, 2019 at 11:48:28AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> >  
> > @@ -1098,7 +1097,6 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
> >  	if (!kmap)
> >  		return -1;
> >  
> > -	kmap->kmaps = &machine->kmaps;
> >  	maps__insert(&machine->kmaps, map);
> >  
> >  	return 0;
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index fdd5bddb3075..a2cdfe62df94 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -223,7 +223,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >   * they are loaded) and for vmlinux, where only after we load all the
> >   * symbols we'll know where it starts and ends.
> >   */
> > -struct map *map__new2(u64 start, struct dso *dso)
> > +struct map *map__new2(u64 start, struct dso *dso, struct maps *kmaps)

> hum, how about map__new? kernel maps could go throught that as well, right?

Nope, I even thought about renaming map__new2() to map__new_kmap() as
only it is used to create kernel/modules maps, as is stated above in the
comment just before map__new2().

map__new() is only called from machine__process_mmap_event() and machine__process_mmap2_event()
and only after checking if it is not a kernel "mmap":

        if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
            sample->cpumode == PERF_RECORD_MISC_KERNEL) {
                ret = machine__process_kernel_mmap_event(machine, event);
		if (ret < 0)
                        goto out_problem;
                return 0;
	...
	map = map__new(...);

- Arnaldo
