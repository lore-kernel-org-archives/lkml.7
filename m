Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D52C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2DB2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjN7fK1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgAGLa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:30:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47007 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgAGLa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:30:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so23085394pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CFy1pR/mUKifsWanixLIxsRfu8vBAo/7nQcugx7uxF4=;
        b=zjN7fK1aycPlWKKwWN804iiRxLL3zkh44PacYSS1Q7i8cXOLQExAkv/+jGikURk2OV
         xusZ6d2MQSt158IDRrPFcLMs7xoCGniBbKqytmHsX+HK609m1jlkquPDNLnmMmC+Zmf5
         xwW2G4wYjQOTOOjNI0uH1gd9Wle5ETNUIO6xBDH7Obywjokb9CxuUlJxbEfg4EIsqJJ2
         fnBS9rScJp2whRqAWlNrWbVDz5xYQTDAku2k//1nhMXn/KdqtUX98zV1X1DP9M/D2OL0
         fDwvjGut3XvrC2dj5/rmfGnm4mnteSl91ct3uRCGC8C8zvoPULmJojj5KUYmzCWJlBe3
         Mo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CFy1pR/mUKifsWanixLIxsRfu8vBAo/7nQcugx7uxF4=;
        b=JUiDdIVTuOSXnP2yEc3LdERAljabKo0GxXxOgzgwT4/NCfs4wO+pyQ96isp3CtHQil
         ljdVwXX6EBgxdcVU83PMTX6le2+supafTUVBwqwbb/rde17PJQaCdCSlvhW0Z4fuIZgl
         jyMji/5hEBPTLAN+S3An/gsvdp4hR/ll1Hi7J7qWsyfwQZy/DcnMbQ7ovvUMov8Lu0J7
         7B9xz3LT4WdZZcLTLuzDp58pOs8vr/UEoo9uJK48qaGO74nmF+JPuwWwMI+04WWGvmm/
         eCMHPzQZywT/kdkFuxfiTcffa1pK8atV/t99IyRr7c161hFWYKsu5/NGGShFa/BwhMbB
         r2/A==
X-Gm-Message-State: APjAAAVqJHOuPmsRDW5xYrsdadBfrq685iB7COcwFt601npyORU1yaMk
        luBXiWMLyltgBIjBcHWsKIrfsg==
X-Google-Smtp-Source: APXvYqydidMoNbGIWOCdA5fNBoB4E7vhZzPi4AiT8kkWtX1b+GY1VrUNPsOHU1LXVK0LCROFRxiJeg==
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr48910582pjd.77.1578396658380;
        Tue, 07 Jan 2020 03:30:58 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id 68sm75907796pge.14.2020.01.07.03.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 03:30:57 -0800 (PST)
Date:   Tue, 7 Jan 2020 17:00:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200107113055.d4ebweisve73yf3m@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
 <20200107095834.GB3515@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107095834.GB3515@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-20, 10:58, Michał Mirosław wrote:
> On Tue, Jan 07, 2020 at 12:11:29PM +0530, Viresh Kumar wrote:
> > On 03-01-20, 20:36, Michał Mirosław wrote:
> > > Per CPU screenful of backtraces is not really that useful. Replace
> > > WARN with a diagnostic discriminating common causes of empty OPP table.
> > But why should a platform have an OPP table in DT where none of them works for
> > it ? I added the warn intentionally here just for that case.
> 
> Hmm. I guess we can make it WARN_ON_ONCE instead of removing it

I am not sure this will get triggered more than once normally anyway, isn't it ?

> , but I
> don't think the backtrace is ever useful in this case.

Hmm, I am less concerned about backtraces than highlighting problem in a serious
way. The simple print messages are missed many times by people and probably
that's why I used a WARN instead.

> Empty table can
> be because eg. you run old DT on newer hardware version.

Hmm, but then a big warning isn't that bad as we need to highlight the issue to
everyone as cpufreq won't be working. isn't it ?

> This is why
> it's still communicated via dev_err().

-- 
viresh
