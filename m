Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ABC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1892217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVT4GlGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfJOLHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:07:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54783 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfJOLHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:07:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so20393388wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VuUr4+h/X4Rmm0vHeI4dMBJqJXRfvzpKCgPKT5JEgtw=;
        b=RVT4GlGRPc+uSEO00fYEZLNbfBzNuGnE9fa37ZNI77V8XAUpNg1HE05VqeekiBo3Gi
         BRV2T/KRo23vxROFUbTcBMks0whDvJdjBQckJ/JFunpVIGLkKx5mUlSqIcXClfsDjHfE
         Gnkv+jEGaTH9dI4x+9Z4mjAxuoBmnVvDVYWlfHbIRYDqkvGoe9j//qzs8JFFllpPddQJ
         dnTwstzLM6CkGDQlTkfrdU/WgyVWu1CjIUWLo0Roy9mV/hQDSavEGb07RK5c4iY1cfFF
         Kulm85ZoOR0CVtKmEphPVcQb5xFD0sD5JZI1NNtpKV+5W6+fblCnnFh1CLf4LK3C+HjA
         V1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuUr4+h/X4Rmm0vHeI4dMBJqJXRfvzpKCgPKT5JEgtw=;
        b=SDncI6RNrbOIgzdX8U7SEsUOsiBm2BxxgLcXbPlbQPF/7524u2WOof8ZDqzfdZFlzR
         eH6Kmt3AZKlz8MASP8bUMGXLJxfuabudgNa199tiOFOAtMphKRYsYQmzjVHS9xBK8h87
         ZjxBAithbeyv8AlJpOoSRyh/sxXv7A5s8ctSkbnKHhTvMIr3hqS35C5jSggfmoBGwoB7
         jb/sugEKO4OcheKzDjsmDmw3pFm0QQwzgBdJ+VENOEvqaEoHXwu/+ZBuY6VfrD9f6opj
         dv9rquzD3jYA4LzaEB4jEACD57PZWY2Zmi71trPANxCpZYz75ibNTbIHhDKM2/9DqyAq
         Mdig==
X-Gm-Message-State: APjAAAVypDPDnP5aOh+LfwMuLqjWHvF5tVJPRAC49VS1aC+iQp84qXoe
        FHqwh7R9udMwCdxUF0occcN7SQ==
X-Google-Smtp-Source: APXvYqzbqmy109GtVZXCHUS7hNR5EW9Vm/lUsQbvX4m35EM+egnogOMTjc5Ifp53d2nALeoZqw/qZg==
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr17825037wma.37.1571137628653;
        Tue, 15 Oct 2019 04:07:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id b130sm33206113wmh.12.2019.10.15.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:07:07 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:07:04 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH] sched/topology: Disable sched_asym_cpucapacity on domain
 destruction
Message-ID: <20191015110704.GB242992@google.com>
References: <20191014114710.22142-1-valentin.schneider@arm.com>
 <20191014121648.GA53234@google.com>
 <CAKfTPtDoBrE=npY_Ay1pucdXsW1yQr1UiaCGq1DXKa2VmNqcUg@mail.gmail.com>
 <fe5977ab-0a70-e705-fcca-246c7dc3d23f@arm.com>
 <20191014135256.GA85340@google.com>
 <2b058430-1951-3d58-ebf4-8195a28ff233@arm.com>
 <c5fec41b-87f1-be4e-475f-69c7394f5467@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5fec41b-87f1-be4e-475f-69c7394f5467@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Oct 2019 at 11:22:12 (+0200), Dietmar Eggemann wrote:
> I still don't understand the benefit of the counter approach here.
> sched_smt_present counts the number of cores with SMT. So in case you
> have 2 SMT cores with 2 HW threads and you CPU hp out one CPU, you still
> have sched_smt_present, although 1 CPU doesn't have a SMT thread sibling
> anymore.

Right, and we want something similar for the asym static key I think.
That is, it should be enabled if _at least one_ RD is asymmetric.

> Valentin's patch makes sure that sched_asym_cpucapacity is correctly set
> when the sd hierarchy is rebuild due to CPU hp.

As mentioned in a previous email, I think this patch is broken in case
you have multiple asymmetric RDs, but counting should fix it, though it
might not be that easy to implement.

> Including the unlikely
> scenario that an asymmetric CPU capacity system (based on DT's
> capacity-dmips-mhz values) turns normal SMT because of the max frequency
> values of the CPUs involved.

I'm not sure what you meant here ?

> Systems with a mix of asymmetric and symmetric CPU capacity rd's have to
> live with the fact that wake_cap and misfit handling is enabled for
> them. This should be the case already today.
>
> There should be no SD_ASYM_CPUCAPACITY flag on the sd's of the CPUs of
> the symmetric CPU capacity rd's. I.e. update_top_cache_domain() should
> set sd_asym_cpucapacity=NULL for those CPUs.
> 
> So as a rule we could say even if a static key enables a code path, a
> derefenced sd still has to be checked against NULL.

Right, that's already true today, and I don't see a possible alternative
to that. Same thing for the EAS static key and the pd list btw.

Thanks,
Quentin
