Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6781C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F8920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gk/bIEEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDHFju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:39:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36241 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfDHFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:39:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so6912625pfn.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeXTOdEN46OFd7SZCXNZeXsWAHnluoB7uLr8j/NwDm8=;
        b=gk/bIEEbjMai6V7l5MpyLBnHADc1FkVB5PiQ0bTC1krOAUjiHZQyz4hQMTeyixai2z
         qqU+/EGUNWFIL3b7H70hmc16XIgDGQubW2NjbuFeXxOW71MKar55/B41TbfTdDGEgzKo
         Us66Jat4af0sBQG1/uqb+RmqX93QQ+jVhKe+KmQIUCB9/WPqGIv03kBPHG1AGIcWS6A7
         CK10hMj8K6x83181Ufb3VYR9JXI/SvASurz6DpJ6X7Vi2/hfMxFtOF1rNv+bmYseiogk
         yFGD0MZ0RfLuP1U5HgNhiNQsozFReElWjsPGqOwdu54P9eZJpEdcvp/iqE/+4ALKIRPc
         Mfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeXTOdEN46OFd7SZCXNZeXsWAHnluoB7uLr8j/NwDm8=;
        b=l7R9h5qarBZVYqTjljj8GDc9OWuw23JCabASZtzSEExOdDAxQW466pKxT6VKZ8oDvn
         BmNc45Gg/Ha37qdkV7iT+m1TCadCc99+J4xoGqyNvcocRie1EKNSlWFKoygmM0YYfG2+
         oRKHJyc8/RatzVjYGv9TeujH4IEvYogn7I/z2kN7nhIgxuqpqYH+SwqcF4++q3w9HpO1
         JjTnU1od1GbkeF8mYbYA4pWHNyj7oeY/r62SuSETRpu/N4VcJLwL6pUs5x3WNfDU+k1Y
         hIvTmo566D62eezMF0QWAfAWni8LBaTiARcS1PseqV5eSHDTIYHI1oaNnOvmXAppD4Xf
         9SKA==
X-Gm-Message-State: APjAAAVUaTdvn07HjNf/5VOeNOKsfLRpjFKgOFZuma62T8aofsOpyEH1
        ZH2weO/GD81ukFsy/tYqW2u5eg==
X-Google-Smtp-Source: APXvYqwcMP5b5Ldbip3dMvnJVh4anVChIki/ZaC6A3dWsOkRcX2v2/0pm15StQkS78T9EjVaLTVFdA==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr26369260pgv.57.1554701988771;
        Sun, 07 Apr 2019 22:39:48 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id o5sm91102232pfa.135.2019.04.07.22.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:39:47 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:09:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Kyle Lin <linkyle0915@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Use lock by stat to replace global spin
 lock
Message-ID: <20190408053944.wcz2pblevccyftmg@vireshk-i7>
References: <20190325072933.215946-1-linkyle0915@gmail.com>
 <20190326184346.GY112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326184346.GY112750@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-19, 11:43, Matthias Kaehlcke wrote:
> On Mon, Mar 25, 2019 at 03:29:33PM +0800, Kyle Lin wrote:
> > Stats is updated by each policy, using the lock by stat can
> > reduce the contention.
> > 
> > Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index e2db5581489a..17beb1bc7e16 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  
> > -static DEFINE_SPINLOCK(cpufreq_stats_lock);
> >  
> >  struct cpufreq_stats {
> >  	unsigned int total_trans;
> > @@ -23,6 +22,7 @@ struct cpufreq_stats {
> >  	unsigned int state_num;
> >  	unsigned int last_index;
> >  	u64 *time_in_state;
> > +	spinlock_t lock;        /*spinlock for stats update*/
> 
> nit: not sure if the comment adds much value. If it stay there it
> needs a blank after '/*' and another before '*/'

Just drop the comment please.

-- 
viresh
