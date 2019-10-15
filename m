Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46486C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CA320650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKhxFd2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbfJOPHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:07:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44014 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfJOPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:07:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so19468432qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JnrO8Q/mQ8bS0Pg4xIcWlJoLATdRivt0YIh5sSGgDqo=;
        b=jKhxFd2sEHRoVhgBbENiKMUknbSZmVzX7lzqmyRaR5FVQs0CK0WyPu2mJkJOO3zUpg
         k6o9OONapmCQwtw3vHqD+tT3lQJzF5QmzR9iA7UNLi8FGoeZAuY2EVVfH6O/fwhnsjV5
         tJUQ0agzGDaB6vXt1gKWvD1sQuKg3hwYQL30nGGYKBHoXzpJZoCaVlRuvMGs9J9B51S3
         +4sm6zQksTgzN8WBX/0aZIbEMkuZDVKnIOOwRA8UZ5wm+DZbg711wIihxGQz6ZkZYpqM
         qGOS8DXS2Su58SBQ8p9yv9cpplXzQJA5UoYwCFfciuhQTPjWsnRmoLj/15dqgqw6X2rD
         BVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnrO8Q/mQ8bS0Pg4xIcWlJoLATdRivt0YIh5sSGgDqo=;
        b=QbC5HliJOAdeLqYEh+jUGKYBnW6hOKmI3tFD0GN/2WKtivWqBH0W8Pvau0iIu2Nl6v
         wKufps5QZPL/FcyZJILfTTQY79nAZ+/TEtlI2Z2fywJ9q3u2T3WDOIWKEBSNXvhuSYBo
         E/8Jsf5jkKA4kYVffHypXGpgbkSmXRsRdPpN3sBNOXzd6byK8QACORbkNfqyse23NXRt
         D0kDrMmZRz42b1P25RToYd1ZLxgg6MUw7Q4Tq5epFyFl3h0+U7Jsc/+Mlki/Uau5P1BL
         IuVLfyVpY/PFzJ/d5OEjbESIGSE7gM9C0ebi6wLI8qP9UeL38OqAY0eS/nOnf2m1gLL3
         37Ww==
X-Gm-Message-State: APjAAAXJuhAjyYze1VCg9qSScyYqCCQ+vko9p1vLTTfPq5K45uR9iF/o
        /P1sjQsQJJyWZiH/iiBzivg=
X-Google-Smtp-Source: APXvYqyqwUxyBh9jJnurI8HkxL8q2Rfhty19l7EQqvsBPkIiHnrih6g3JBAOZZHkEWyVo5995GQeHQ==
X-Received: by 2002:a37:74f:: with SMTP id 76mr35643948qkh.80.1571152056189;
        Tue, 15 Oct 2019 08:07:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c26sm13659530qtk.93.2019.10.15.08.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:07:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E6F34DD66; Tue, 15 Oct 2019 12:07:32 -0300 (-03)
Date:   Tue, 15 Oct 2019 12:07:32 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix mode setting in copyfile_mode_ns()
Message-ID: <20191015150732.GB25820@kernel.org>
References: <20191007070221.11158-1-adrian.hunter@intel.com>
 <20191007104747.GA6919@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007104747.GA6919@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 07, 2019 at 12:47:47PM +0200, Jiri Olsa escreveu:
> On Mon, Oct 07, 2019 at 10:02:21AM +0300, Adrian Hunter wrote:
> > slow_copyfile() opens the file by name, so "write" permissions must not
> > be removed in copyfile_mode_ns() before calling slow_copyfile().
> > 
> > Example:
> > 
> >  Before:
> >   $ sudo chmod +r /proc/kcore
> >   $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
> >   $ tools/perf/perf buildid-cache -k /proc/kcore
> >   Couldn't add /proc/kcore
> > 
> >  After:
> >   $ sudo chmod +r /proc/kcore
> >   $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
> >   $ tools/perf/perf buildid-cache -v -k /proc/kcore
> >   kcore added to build-id cache directory /home/ahunter/.debug/[kernel.kcore]/37e340b1b5a7cf4f57ba8de2bc777359588a957f/2019100709562289
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/copyfile.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
> > index 3fa0db136667..47e03de7c235 100644
> > --- a/tools/perf/util/copyfile.c
> > +++ b/tools/perf/util/copyfile.c
> > @@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
> >  	if (tofd < 0)
> >  		goto out;
> >  
> > -	if (fchmod(tofd, mode))
> > -		goto out_close_to;
> > -
> >  	if (st.st_size == 0) { /* /proc? do it slowly... */
> >  		err = slow_copyfile(from, tmp, nsi);
> > +		if (!err && fchmod(tofd, mode))
> > +			err = -1;
> >  		goto out_close_to;
> >  	}
> >  
> > +	if (fchmod(tofd, mode))
> > +		goto out_close_to;
> > +
> >  	nsinfo__mountns_enter(nsi, &nsc);
> >  	fromfd = open(from, O_RDONLY);
> >  	nsinfo__mountns_exit(&nsc);
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
