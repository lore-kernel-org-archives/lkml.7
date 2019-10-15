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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79494ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC7920650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sedLu2UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfJOPIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:08:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44209 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:08:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so30986270qth.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FpMq7EcpHQR8/pfyktJU1Qq9chq6W6jLbp0yLXRsZA=;
        b=sedLu2UBGJ7f1OMvFaIVKNIIMbVzxtl8LH1lBiFpdk/HJuxAG6hk5Pi4aVqsgA5xz3
         0SCJkcKtBB7bmEx5fQr1nCoSfnQ7/8MSYAMEPf+K6uG5Xdp7laU9OHH9/b2jrYQHKp+9
         jxBryafS+ajBO3x51OiZKxW+t8LMHedL0oodpKrnhDVrx0RYGT+td9mdFVYZMm0PIZtq
         l6HcZksYu/YSWFWzl4mMfvypMeFx0KR99mJnw68PKcQ/rFawaO8DqAx4akqUa3igVRXG
         C3DS94RRMtoSc3ZUJf3Asg4YWKmy+F/Adga4RZi6q4WccS8+jOx/HOJoy7NgdqGT2CBr
         2YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FpMq7EcpHQR8/pfyktJU1Qq9chq6W6jLbp0yLXRsZA=;
        b=NcdYJ5RYV4mrpm8i/mfSnsKT7HOexhBU1q0wi6ro/ypJoIHwIDAFwAuEpdyGTjkUms
         aaWoFkEzFWPzOwbzjuJp2bahtTA7Fb2m0f4cxusOfliOdBkNx63stpZ/QrqqfmefEbLa
         yQeV9poNnhyJy/ZO+D0YdsJ3N9bzFN5z7KO3kTBXxRKAOwY8c9K325Pc0QiAG+TMv2sM
         Y8MepARkq1kpKiSuofMbwYSyx7XMhAAer21n3ru9u3+ZL1IVMweffKyAaYYqRjhXI4YY
         kPEcarxOJ/3x0CLCw4u7R9Kk9DC2xe5w9u31HTBczkunfr5z9OA/ayGEdYLGdCZ82fiA
         supg==
X-Gm-Message-State: APjAAAVqyH7QGHwBKhESCejnMr3NJVnM6CEUFgI6QneA5zOL3xSDK7MJ
        yP2ikM0jBVrvj9+EJMuOnBM=
X-Google-Smtp-Source: APXvYqyuKnBkDwEoC24CMlezIjGPq/TOSpp7Ly020/bROcoWqrX+xBQAhkivxpTG/kOL0BJ/JAIksA==
X-Received: by 2002:ac8:234e:: with SMTP id b14mr39917731qtb.346.1571152122373;
        Tue, 15 Oct 2019 08:08:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q6sm9491704qkj.108.2019.10.15.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:08:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC07A4DD66; Tue, 15 Oct 2019 12:08:39 -0300 (-03)
Date:   Tue, 15 Oct 2019 12:08:39 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] perf c2c: fix memory leak in build_cl_output()
Message-ID: <20191015150839.GC25820@kernel.org>
References: <4d3c0178-5482-c313-98e1-f82090d2d456@huawei.com>
 <20191015084753.GD10951@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015084753.GD10951@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 15, 2019 at 10:47:53AM +0200, Jiri Olsa escreveu:
> On Tue, Oct 15, 2019 at 10:54:14AM +0800, Yunfeng Ye wrote:
> > There is a memory leak problem in the failure paths of
> > build_cl_output(), so fix it.
> > 
> > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-c2c.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 3542b6a..e69f449 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2635,6 +2635,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
> >  	bool add_sym   = false;
> >  	bool add_dso   = false;
> >  	bool add_src   = false;
> > +	int ret = 0;
> > 
> >  	if (!buf)
> >  		return -ENOMEM;
> > @@ -2653,7 +2654,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
> >  			add_dso = true;
> >  		} else if (strcmp(tok, "offset")) {
> >  			pr_err("unrecognized sort token: %s\n", tok);
> > -			return -EINVAL;
> > +			ret = -EINVAL;
> > +			goto err;
> >  		}
> >  	}
> > 
> > @@ -2676,13 +2678,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
> >  		add_sym ? "symbol," : "",
> >  		add_dso ? "dso," : "",
> >  		add_src ? "cl_srcline," : "",
> > -		"node") < 0)
> > -		return -ENOMEM;
> > +		"node") < 0) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > 
> >  	c2c.show_src = add_src;
> > -
> > +err:
> >  	free(buf);
> > -	return 0;
> > +	return ret;
> >  }
> > 
> >  static int setup_coalesce(const char *coalesce, bool no_source)
> > -- 
> > 2.7.4.3
> > 

-- 

- Arnaldo
