Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62DC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557D52173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558581011;
	bh=i7OmAEri2XXUQOZ0KjmiRSCkDrvmgqHW0j7tnVzAPPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1g/lXyw6mXIFQb7YGeyNkArHCLvuMnCVncEfeeqJhpCX6ahmRs0ByudH9SP0Kv2bI
	 vu1UHSqvBP3/6Te4HAEYt/HfytubiH9KD5tN67wzvoXJ5ghnGLMbG13PHQbYnStega
	 M2DPyKxVs9FBkDEXosVFdFnNeT6280A1Won6uXw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfEWDKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 23:10:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40293 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWDKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 23:10:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so2321919pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5wjdetJzCblRZKgz8G97TYJJmRpcSdI9wVdjybuMxn0=;
        b=RT3zqwV7CSCZljjogtPUDZEiepXHH0xA/FgePa+xFTGM1qOxeJf4/EbyagkjVQPiC4
         qN9ErLEY74axdbOcmv9SHGdQTejVrg0Yz6NYHM/mwhPXkPFDykc+ZqYrnUjP5qDn+sbS
         0f0JlMxQC1fPsiu77qriPMWC08liY91nUJKjkP9cECQ4fVJ5OiHZ0gS4gQVDhZnh7JZk
         6PLYxbS+na6CpIhLf2opgdveJqPnnl5ttESOarHuQyYr6fJLpvlEJnN1efAy0mfHU/Qo
         t6L+heofgyo76V7PYPawBzAj2LKqV0Wp6FPQ3pFUzwMhEmkf2hTtjivgpFFp84MaVwoh
         ACzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wjdetJzCblRZKgz8G97TYJJmRpcSdI9wVdjybuMxn0=;
        b=gr94IJRc1VR2WHRAY0EQY2ZwoRjOy7ow52q1BMrQgdLWOAYcxvowlruGFMiVgmafM+
         UFNcyPVu+VOztxLtFXvkj+g2p0tqeMj3euiCPbs5/zufGHSEtdrAMNRVnz1m6NdkUMnz
         uO8lMQVvQdRsB3Mnqu8ukl35WruV4hffdU8QFe6gJfcKzKyT6G9LNwS/7rmUCZo+DoNV
         G4HWoA+goqKnEWsDQmnRv8bVJW1PqitvWM0FXAD0NRjREodz/1RZ4juWPy4kth9cCa90
         HDXP+vyyqDBRsUWmRv4ewoMco+ZVn/W8p4f5mHbgWYeZ/f66NRYf3UmIolfLtZYiqQUG
         kzJw==
X-Gm-Message-State: APjAAAUL59PeWT0iAJiy3yXSvbA9B4cTufPaFvAdvLrWsMJ5nimPIvjH
        dn82MRIL8ZajlBPUNoAdlyg=
X-Google-Smtp-Source: APXvYqwnd0KdCeiQBHxGpQ7WzlE0yTgWHO2HLYTJNQ29DA1LaWxa5NL0mj4AYN6AJIukQ13fDPF2dA==
X-Received: by 2002:aa7:9212:: with SMTP id 18mr28349362pfo.120.1558581009311;
        Wed, 22 May 2019 20:10:09 -0700 (PDT)
Received: from google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id c16sm29231876pfd.99.2019.05.22.20.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 20:10:08 -0700 (PDT)
Date:   Thu, 23 May 2019 12:10:02 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 01/12] perf tools: Separate generic code in
 dso__data_file_size
Message-ID: <20190523031001.GD196218@google.com>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-2-jolsa@kernel.org>
 <20190513194754.GB3198@kernel.org>
 <20190513200015.GA2064@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513200015.GA2064@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On Mon, May 13, 2019 at 10:00:15PM +0200, Jiri Olsa wrote:
> On Mon, May 13, 2019 at 04:47:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 08, 2019 at 03:19:59PM +0200, Jiri Olsa escreveu:
> > > Moving file specific code in dso__data_file_size function
> > > into separate file_size function. I'll add bpf specific
> > > code in following patches.
> > 
> > I'm applying this patch, as it just moves things around, no logic
> > change, but can you please clarify a question I have after looking at
> > this patch?
> >  
> > > Link: http://lkml.kernel.org/n/tip-rkcsft4a0f8sw33p67llxf0d@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/dso.c | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > index e059976d9d93..cb6199c1390a 100644
> > > --- a/tools/perf/util/dso.c
> > > +++ b/tools/perf/util/dso.c
> > > @@ -898,18 +898,12 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
> > >  	return r;
> > >  }
> > >  
> > > -int dso__data_file_size(struct dso *dso, struct machine *machine)
> > > +static int file_size(struct dso *dso, struct machine *machine)
> > >  {
> > >  	int ret = 0;
> > >  	struct stat st;
> > >  	char sbuf[STRERR_BUFSIZE];
> > >  
> > > -	if (dso->data.file_size)
> > > -		return 0;
> > > -
> > > -	if (dso->data.status == DSO_DATA_STATUS_ERROR)
> > > -		return -1;
> > > -
> > >  	pthread_mutex_lock(&dso__data_open_lock);
> > >  
> > >  	/*
> > > @@ -938,6 +932,17 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
> > >  	return ret;
> > >  }
> > >  
> > > +int dso__data_file_size(struct dso *dso, struct machine *machine)
> > > +{
> > > +	if (dso->data.file_size)
> > > +		return 0;
> > > +
> > > +	if (dso->data.status == DSO_DATA_STATUS_ERROR)
> > > +		return -1;
> > > +
> > > +	return file_size(dso, machine);
> > > +}
> > 
> > 
> > So the name of the function suggests we want to know the
> > "data_file_size" of a dso, then the logic in it returns _zero_ if a
> > member named "dso->data.file_size" is _not_ zero, can you please
> > clarify?
> > 
> > I was expecting something like:
> > 
> > 	if (dso->data.file_size)
> > 		return dso->data.file_size;
> > 
> > I.e. if we had already read it, return the cached value, otherwise go
> > and call some other function to get that info somehow.
> 
> we keep the data size in dso->data.file_size,
> the function just updates it
> 
> the return code is the error code.. not sure,
> why its like that, but it is ;-)
> 
> maybe we wanted separate size and error code,
> because the size needs to be u64 and we use
> int everywhere.. less casting

Maybe we can rename it to dso__update_file_size().

Thanks,
Namhyung
