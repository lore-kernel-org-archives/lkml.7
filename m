Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D13FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8FC20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu0T8FGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391795AbfJPNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:09:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33057 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391745AbfJPNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:09:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so36013576qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZhTaYtsLx+a5EpmkY94WkZ9hPBq508AcKkHBaEnPCA=;
        b=Cu0T8FGJ6kLXP3UbJ6UyQTlpRZMcddVVsMqf+CXaPIFKNaa3SmKXabDL4uSoSsbB5J
         OfvBF6SVdRYuXCV7tGsab5Cm06gDzBCD1Xa/eZMK85xtI7aYfGGmm5sf8hLOsTHdliEv
         UImPBHWKIN98ABSJjq9MUYA0qo5+AXUJJQMoVSlYqBrU017STGhWHejQDruKEuMcwhTf
         KTGnNh+zNsZcacihn/PWSznQCCm+GbLd5202xswDdNirrTI/Mm+8Lb/LA7br1aLH6weX
         Kr7CDRCMAGkFYi1x4N09HEshL3hJ5V4j5/tsg+7HOyF4ZEzRnNZHkd/eRm0uyWvb4PJm
         SPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZhTaYtsLx+a5EpmkY94WkZ9hPBq508AcKkHBaEnPCA=;
        b=uhfNwVjoz+rqLHKXzlbivbjNjAZTc2GO4lTKW6xkqtjQcy/zZQNwFcQ4ud/Zbl2gP+
         4Cisvqm+Bb/7h3AHVsFsCXfwAsYFkub4O5qDoKTOoapHTUuwi2XI1n9Ity7BKHfqsW+H
         W3h9yznqq9vFKSKQZvzeEU0i7MibpCzsLvNpR85tBlqp3sNTXWAb3vvY15i4z8IJ96L8
         B0VIyIeQY3tYjPSq8zDA+tOzoe34RBAhrUtm6sxc6uY7gzPLL7F3DN0wkXjcattdFZmD
         1T0jEYirWFQSEJdTkX939L4xkM8mKvceTncx0typ1U60KmZONa2wtI/4lZu6oXwNPHf+
         Cvzw==
X-Gm-Message-State: APjAAAXb7XX4PYohb8xcTaMccacUYO8mJZO84IN6HNalEW8885/BtBbn
        xyfzo7dOqwbsA3Tw0Z27K1M=
X-Google-Smtp-Source: APXvYqwlfQzqTUHN8ZaAVE22Go1TVmFvFNJI971sUsvva5uip9UQK0u7AjDPw2w1CdEv3wI8zCzMMQ==
X-Received: by 2002:a0c:b4d2:: with SMTP id h18mr41527592qvf.208.1571231364310;
        Wed, 16 Oct 2019 06:09:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g26sm11242851qtq.88.2019.10.16.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:09:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B902C4DD66; Wed, 16 Oct 2019 10:09:21 -0300 (-03)
Date:   Wed, 16 Oct 2019 10:09:21 -0300
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] perf kmem: Fix memory leak in compact_gfp_flags()
Message-ID: <20191016130921.GC22835@kernel.org>
References: <f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com>
 <20191016130403.GA22835@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016130403.GA22835@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2019 at 10:04:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Oct 16, 2019 at 04:38:45PM +0800, Yunfeng Ye escreveu:
> > The memory @orig_flags is allocated by strdup(), it is freed on the
> > normal path, but leak to free on the error path.
> 
> Are you using some tool to find out these problems? Or is it just visual
> inspection?

Anyway, applied after adding this to the commit log message:

Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")

- Arnaldo
 
> - Arnaldo
>  
> > Fix this by adding free(orig_flags) on the error path.
> > 
> > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> > ---
> >  tools/perf/builtin-kmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index 1e61e353f579..9661671cc26e 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
> >  			new = realloc(new_flags, len + strlen(cpt) + 2);
> >  			if (new == NULL) {
> >  				free(new_flags);
> > +				free(orig_flags);
> >  				return NULL;
> >  			}
> > 
> > -- 
> > 2.7.4.3
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
