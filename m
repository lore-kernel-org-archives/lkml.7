Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C03CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E020862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IptQ09tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfJ3MLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:11:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38561 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfJ3MLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:11:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so2025871wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KF3Q6Ry2pi672mCIagGYcp8Er7u0fxPBRpObcoZz1LM=;
        b=IptQ09tmf85OfJtqqkyGxI//XFf5UywQJx/T9BtlcbWabBceeV067dCwbpx7ZxBvJs
         95c8WU8TghnMJeBj0M6npluutlGv4i38qXknB/XjmP7qY6IbGvnj2zGk+amM046uWpor
         HHD8JABvkxX4U6MN2FS4MeoJllXXBcSPwu8tKFaAN0cE35Sj66yAqVvTQuwheE+PCCoU
         vVonaEa0w5ux6E5mcFPGSrT4GXA9LyMgUc6J4EqW2zcbJXfSTZXTP9aPhVdu7WSHPC+J
         67/hRxKrLPYTDVpH7hPQGxLwBRI275J9i4yUuwu+IfbCVogW/FZIHJoAyBhYF8RZp4Fr
         ZQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KF3Q6Ry2pi672mCIagGYcp8Er7u0fxPBRpObcoZz1LM=;
        b=icXDjjSVio87bVBX4U0K9ltGdMsfidG04qSLWkExwScLdcG9i70nxftvbSUCZMHcMw
         IsWGfeRVRflphprUJr9kH93am/zB+aQ1zDBa/NVzvojQIeSl54+oDu/rXV+7DKdHC7h4
         Q14Orw2AlICnnzY/HZLSknCgq3qzW3vqJ29WfjLYEFZbgQG2zmRMHjj0jZjqmUdGj07G
         yhNoCacXQ6+bUBRnhO7tamW2Ax5pO0i99Y1DdMy/jfXMArMc17IWagZ3U2aiPwWUTDrv
         ZEWgaQKz7THoVOzWWeXP9i1o83WrlENMtUcGaYRZnuX/GXoqxc+EAS5H4zt9UgORm3X4
         HFAg==
X-Gm-Message-State: APjAAAUwikv1ZqKrR6ib4CIpQIVrPDOeITpVrqLuuT7OgAMduWrGysL8
        jQz+Jj/C2uAQtMPNtNGVLyolyw==
X-Google-Smtp-Source: APXvYqw3qHuhJ4CIZF6lkVJumXbY0//FDfsFp4tTfB84cMHqQi9AmLfTn8D8EOl+o7tWh1ALVpVL9w==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr23592181wro.333.1572437465898;
        Wed, 30 Oct 2019 05:11:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a7sm354wrr.89.2019.10.30.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 05:11:05 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:11:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191030121101.GA172224@google.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
 <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
 <20191029203619.GA7607@darkstar>
 <CAKfTPtDFLsn-uSV2ms1qPMMs+2GYWK2jYw8=-2pr_BpBRid6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDFLsn-uSV2ms1qPMMs+2GYWK2jYw8=-2pr_BpBRid6Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 Oct 2019 at 09:04:44 (+0100), Vincent Guittot wrote:
> That's the point of my comment, choosing big cores as default and
> always best choice is far from being obvious.
> And this patch changes the default behavior without study of the
> impact apart from stating that this should be ok

The current behaviour is totally bogus on big.LITTLE TBH, and nobody
uses it as-is. Vendors hack RT a lot for that exact reason.

Right now a RT task gets a random CPU, which on big.LITTLE is
effectively equivalent to selecting a random OPP on SMP. And since RT is
all about predicatbility, I'd argue sticking to the big CPUs for
consistency with the frequency selection policy is the only sensible
default.

So +1 from me for Qais' patch :)

Thanks,
Quentin
