Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21ECA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AE421897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4GJ3Yys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409690AbfJRJYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:24:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33354 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394889AbfJRJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:24:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3524025pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v3de0Qp2dEG4v6wLtc+9wSifLlx04TUsULf8ZNOAzfo=;
        b=W4GJ3YysV76ngGFa9Q/MKPTCmrRuklBK8Sig/JFoWCS/GdY4XsthMBFYsf2fazxszF
         078CVXdccd/fbVCPk6zvLKGm0yKvZ5GJmZz0mqTHOX6UvQNT0PNPCvJIawWtuTYFp/qB
         RulOH4AyHToa+0aEtHN3ZzMK3uOaV4aZ34akTt1ZDPXQyurQkSgngCFi5+24L0SG8fCF
         XFMX5fmEw56bqXBuDxlojv1muVzT6HR6by4OV/kDQc9Lo5kbqE3j/+6mlQjSH7Lpw4Ru
         4bZzBUNT3sTopm4+O75Q2Q8kZi6x630VLZLbdGcb+G5JQELAfOL8aiV1qXHBGrKh/HZA
         Yyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3de0Qp2dEG4v6wLtc+9wSifLlx04TUsULf8ZNOAzfo=;
        b=Rq3OihioGNYpsydk7Of8dGB9gcwXL89ElOysU28lgLEIvfIUYg7Oc0PNL730G29nM0
         XBtOE0hpCnsXxl2Mnsdg1ZmEJiCqeRU3JRGB6HUNdhdBea8vzLIvgTBN5+2aruyTQqiN
         Lric9MpcUGiTvF1FpQTuWD9/g+autlUWCQBjC/4HDfFbNPrJEuUg7WOsNCPB3CbB/TrR
         3JPeLSlbENoTTt9ynvS7J9dge4p84qkdM59oFbxfhs+TgCr6Bo9J5Yaft3ixRROyemO0
         Luwmgxbn/rJB3/crc8ks1j0eHZwmX/WN4zooyRsRYV7IMi5o1CscdZX4Nf4hh8FqEPbn
         IYPA==
X-Gm-Message-State: APjAAAUXzokVlyfmkWqEcsbecP46vrOZhvzPnsFkNgO98UHzbscIOEx5
        kL4lZfeOcFj0fw2DvE7SLTF7eQ==
X-Google-Smtp-Source: APXvYqwkH7aDyKc+7ed+bwZ6rBwWDlzPlXO9W/aj0PKz4MD3W9HH+2tq3+dXWpID2Rv3H10HgXzj3A==
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr9751961pjo.68.1571390692245;
        Fri, 18 Oct 2019 02:24:52 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f13sm5441333pgr.6.2019.10.18.02.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:24:50 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:54:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191018092447.2utqazqfob65x4k2@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7>
 <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
 <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
 <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 10:30, Rafael J. Wysocki wrote:
> On Fri, Oct 18, 2019 at 10:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> > > On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > > > that the new min is less than the new max, because the QoS doesn't do
> > > > > that.]
> > > >
> > > > The ->verify() callback does that for us I believe.
> > >
> > > It does in practice AFAICS, but in theory it may assume the right
> > > ordering between the min and the max and just test the boundaries, may
> > > it not?
> >
> > I think cpufreq_verify_within_limits() gets called for sure from
> > within ->verify() for all platforms
> 
> That's why I mean by "in practice". :-)

Hmm, I am not sure if we should really add another min <= max check in
cpufreq_set_policy() as in practice it will never hit :)

-- 
viresh
