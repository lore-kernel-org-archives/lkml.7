Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043992339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g89urCuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfHUF0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:26:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHUF0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:26:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id y9so271731pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AbgNFdtNiAHc3P9dNg3Cl9n2STrQ5D8oYPMR42M6k4o=;
        b=g89urCuDkhMGyZzEXrRZ37obKQXCa1XnlXt/Hk6+A6ohfMQnchNzu0R4bXKm9QgvFf
         /R09pOzrLs7VDW143XnAO9DrtBPp6CPSLBBXKYVhe9E6XevH/qMnrRdlnrtkKSbxz/Xf
         MxyXcENFbtESYyodxxTLAaYsDjgiymLW+s1mQO5Ii1UuzdptKI4CBIIyNIIPWZ1dJV6C
         X47cpnU+VMbC2xW762i8bjEAvX/hJBT6Pngaq/8/NJaw5mSzrUdMRtedkZZzbc70rr8G
         GkwPMZYC7DXMU28a/q/8NRp2p6wzZelT/XogjlYTUiWdbSRz7VOlnxchLAvWnKflSqey
         4vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AbgNFdtNiAHc3P9dNg3Cl9n2STrQ5D8oYPMR42M6k4o=;
        b=CKoLBR+jXaEIMmFKNMltJCKyJ4HMUOiHh6cnYphF+RR9o2wfqEMxE1MNnDKKKpLou+
         FU3GdmoLCOSs+P+W5PwhwnbvJLGVd7xihvNzKlma/qiTirWcLQz0uVodH6XjNdeoRj4r
         VBvuMd4nnXmi0cMt0bUmWXn++1GU9KrnxfrG+mkzX5yH46aF9r6L727w5WCVcIOqHIyW
         idLI3rfsdpY9B9PIEqOY1dj/oycg99csKtWA8K3ODTaw2qIcXYU3frwI7VPIJJ96nrEB
         c5mcngn5reBcNX3sUbABv658MdGwPjVoNkUtOSNbaHjdPUqGOJzhwL3oOjiBpqD02WH/
         XOLQ==
X-Gm-Message-State: APjAAAUgk4BXiVdzCdGPBzf9xiGHEzS7TI4t20kownIh53aF4AwkTIVh
        0HLEObcD4WUgFZUJYoRpcb8isw==
X-Google-Smtp-Source: APXvYqyn2YA8uDjld3bhjyDoV7CO7b/hNWNkRim3P08wu6STtwkFv3KR6GHMDfhcLgB4DPe6jb+8Iw==
X-Received: by 2002:a17:90a:d146:: with SMTP id t6mr3636385pjw.76.1566365183880;
        Tue, 20 Aug 2019 22:26:23 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id o67sm16966864pfb.39.2019.08.20.22.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 22:26:23 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:56:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20190821052621.ftvxivls6tdf6vnx@vireshk-i7>
References: <20190807223111.230846-1-saravanak@google.com>
 <20190807223111.230846-3-saravanak@google.com>
 <20190820061300.wa2dirylb7fztsem@vireshk-i7>
 <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
 <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-19, 15:36, Saravana Kannan wrote:
> On Tue, Aug 20, 2019 at 3:27 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Aug 19, 2019 at 11:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 07-08-19, 15:31, Saravana Kannan wrote:
> 
> > > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +     new_opp->rate = (unsigned long) bw;
> > > > +
> > > > +     ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > > > +     if (!ret)
> > > > +             new_opp->avg_bw = (unsigned long) bw;

Why is this casting required ? If you really want a 64 bit value for bw, then
make it 64 bit in bindings as well, like opp-hz. And then you can simply do:

of_property_read_u32(np, "opp-avg-kBps", &new_opp->avg_bw);


> > >
> > > If none of opp-hz/level/peak-kBps are available, print error message here
> > > itself..
> >
> > But you don't print any error for opp-level today. Seems like it's optional?
> >
> > >
> > > > +
> > > > +     return 0;
> > >
> > > You are returning 0 on failure as well here.
> >
> > Thanks.
> 
> Wait, no. This is not actually a failure. opp-avg-kBps is optional. So
> returning 0 is the right thing to do. If the mandatory properties
> aren't present an error is returned before you get to th end.
> 
> -Saravana

-- 
viresh
