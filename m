Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0643C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA0B2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+yJI8Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfFZGco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:32:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZGco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:32:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so692272pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9J7yY9IsrBjV9EwZIoxYx67Urs2h76Y56lMom2HrjYs=;
        b=s+yJI8TbDA7PKV+ouYYkLagx/LFxocWciWiULrNzoYQm5O1SbTRcK4YjEZFyGdFdT5
         j3hKvUukpK0YltEl5SxhVY0CWvF+G9UEC2AkevJ/aHMjlqv9s5/CUrrzyqaVRv+UmVuy
         Et20GJpdEVATdDIkdoOLDHg8cINl68c1JUTC+bznZARtqx4RtmfBomFG/cFihjIFEvyN
         zBA276uuWti68dC7MSKLB9NgxinAfY4VbDEG5z8JtpDphh4N6nECvtoAziEfo4/4Gvjg
         Gx9M/UoyZnxbIPZOVhjeijVq+khqfRmE3+O4JXkLz4W9r1Snc5lmnLtzg6n8Stv9CfjC
         2rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9J7yY9IsrBjV9EwZIoxYx67Urs2h76Y56lMom2HrjYs=;
        b=Kmfn8WuwyBvHGpF7ss7cpqoCA+VmSDBktsQwmBKjwv450Z56xwsb8f/8PiRm9zhzS3
         6Amn8PEBx70RJ52q61f/hKIcRJBJa9DpwiAVreVpzT0nRbYDmG+CcRarURu34h9keW/W
         4uJpI8kizqNRmV/RWOAYPqTjxoShAcpYGGu1m+NJFPwDX5H04/2oMbcEooXoSmdIoEd3
         BbQZOdkkb2VDOWA9ZV6OkE1f+YHfkyjDllrgowltVsLPi2U7MIZHrfiB2jom/WSX41Tr
         YD92GxZ+YBndhGg4jB1aO0qAsHPOavXftek42bSiDcb9hGuCXLBwKXERtx/D5Z8UypqL
         od/g==
X-Gm-Message-State: APjAAAXHbffhc3pR+JSKB4pFXv6sglaFy5gnWWu9ces2EniJhVUaERBU
        uN7OXqwV+NmSOu2p0grSYrG+Tw==
X-Google-Smtp-Source: APXvYqxvT6JezWFulmTNsMvZc+jUaV+8gqbTrwljamAEg/tB5vfYQJIk22XCfFhYxEqwGdu015Js1Q==
X-Received: by 2002:a17:90a:d595:: with SMTP id v21mr2696932pju.34.1561530763408;
        Tue, 25 Jun 2019 23:32:43 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id v27sm2215398pgn.76.2019.06.25.23.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 23:32:42 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:02:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190626063240.kgdiy7xsz4mahrdr@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
 <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
 <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
 <20190625052227.3v74l6xtrkydzx6w@vireshk-i7>
 <CAGETcx_v05PfscMi2qiYwHRMLryyA_494+h+kmJ3mD+GOjjeLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_v05PfscMi2qiYwHRMLryyA_494+h+kmJ3mD+GOjjeLA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 22:29, Saravana Kannan wrote:
> No, the CPUs will be the "parent" and the cache will be the "child".
> CPU is a special case when it comes to the actual software (not DT) as
> we'll need the devfreq governor to look at all the CPUfreq policies to
> decide the cache frequency (max of all their requirements).
> 
> I think "master" and "slave" would have been a better term as the
> master device determines its frequency using whatever means and the
> "slave" device just "follows" the master device.

Okay, so to confirm again this is what we will have:

- CPUs are called masters and Caches are slaves.

- The devfreq governor we are talking about takes care of changing
  frequency of caches (slaves) and chooses a target frequency for
  caches based on what the masters are running at.

- The CPUs OPP nodes will have required-opps property and will be
  pointing to the caches OPP nodes. The CPUs may already be using
  required-opps node for PM domain performance state thing.


Now the problem is "required-opp" means something really *required*
and it is not optional. Like a specific voltage level before we can
switch to a particular frequency. And this is how I have though of it
until now. And this shouldn't be handled asynchronously, i.e. required
OPPs must be set while configuring OPP of a device.

So, when a CPU changes frequency, we must change the performance state
of PM domain and change frequency/bw of the cache synchronously. And
in such a case "required-opps" can be a very good fit for this use
case.

But with what you are trying to do it is no longer required-opp but
good-to-have-opp. And that worries me.

-- 
viresh
