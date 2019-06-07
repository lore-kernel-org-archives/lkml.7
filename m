Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E77C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C428420840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1lnQGKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfFGNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:42:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43933 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfFGNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:42:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so2246929qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3WofkuIu9igDLPAQnWn5qFH+FdgRGt2W5dGohyfL5bo=;
        b=n1lnQGKkeKsiGRx9x7uI6LTN+EX3yAuiclsjYtuaV9QgzH5H2R3zrNbiuZAkVmtF5W
         WHntmEZBrSJEVOz7HgVLx+C2H9Ovsr/y7PbdFquDC+wOkaSQQaYPbBY2L49iwXc//rlW
         M2Rfi1KuameCfRdBGip+OvrCA9SXZA4gfspYu5F7ye4Dpg7wSJTd/6dvJ8rKyljga7Al
         7bE7zLDqoe7kMwCol673Fq9oKJW1/iPKomslzazl9QfJIzpD2gag0wSK9OShHlAcXBv2
         sfL81E7/N+KKk5xEDZkPjiB3yaXMKXC5yMRtvM/RxMTMlaWIFTw9VfRhiY/tTQftsXgH
         ECtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WofkuIu9igDLPAQnWn5qFH+FdgRGt2W5dGohyfL5bo=;
        b=h+TiJjxor6rB4ippYwgdg9T15N1zimNpxe283x3VFf7sM3kDQZaMJmul2wLHKzPOIg
         7C4KfMf/FCTIZgxYd8OevRapElKT2Syj+IHt5JfHH1Vvu1fihT5D3BUlhIsyLyp5ZYtX
         HaN0XG/VrWWOH2sM7lkf7Kw1JJ8HdXeGroMyRyqKAq6ov81asjaPTe2yhAWxnxP0uYqk
         0GJL1Gs9FBe6VJHHAjuFi9RMLu/CUkgb2swm3R3jhxIA+MIW/Tg/ts7fDtHrezuROO3k
         iV8Lr/ki4l+IBNTbymZekfx5tXbcTao5Balq7Z0aAmGDEkkBLcskFwJH88R5vEjr9bkk
         +76w==
X-Gm-Message-State: APjAAAU3J9D4RKTAbtnMIXSvHnREY2LcqOoW62yM5ENWbT0vZQ6Je2hC
        B1El+pBHeLr5LRUPe7o5JbNSSg==
X-Google-Smtp-Source: APXvYqzHgv638dIvZYD6LkRLDpzgnhtAJFigmQgwYChIND2SwnM+zmbtS1QVchVJkw/zzaI8x8einA==
X-Received: by 2002:ac8:2cbc:: with SMTP id 57mr44959069qtw.222.1559914968187;
        Fri, 07 Jun 2019 06:42:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id x2sm997287qke.92.2019.06.07.06.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:42:47 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:42:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        corbet@lwn.net
Subject: Re: [PATCH] Documentation: coresight: Update the generic device names
Message-ID: <20190607134239.GH5970@leoy-ThinkPad-X240s>
References: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
 <20190603190133.GA20462@xps15>
 <99055755-6525-694e-a15d-5de7318a80da@arm.com>
 <20190607022136.GE5970@leoy-ThinkPad-X240s>
 <78c98c28-4f3f-825b-18e1-c71fb63a80eb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c98c28-4f3f-825b-18e1-c71fb63a80eb@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, Jun 07, 2019 at 09:40:48AM +0100, Suzuki K Poulose wrote:
> Hi Leo,
> 
> > > > >    A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
> > > > >    listed along with configuration options within forward slashes '/'.  Since a
> > > > >    Coresight system will typically have more than one sink, the name of the sink to
> > > > > -work with needs to be specified as an event option.  Names for sink to choose
> > > > > -from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
> > > > > +work with needs to be specified as an event option.
> > > > > +On newer kernels the available sinks are listed in sysFS under:
> > > > > +($SYSFS)/bus/event_source/devices/cs_etm/sinks/
> > > > > -	root@linaro-nano:~# ls /sys/bus/coresight/devices/
> > > > > -		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
> > > > > -		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
> > > > > -		20070000.etr     20120000.replicator  220c0000.funnel
> > > > > -		23040000.etm  23140000.etm     23340000.etm
> > > > > +	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
> > > > > +	tmc_etf0  tmc_etr0  tpiu0
> > > > > -	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
> > > > > +On older kernels, this may need to be found from the list of coresight devices,
> > > > > +available under ($SYSFS)/bus/coresight/devices/:
> > > > > +
> > > > > +	root@localhost:/sys/bus/coresight/devices# ls
> > > > > +	etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  replicator0  stm0 tmc_etf0  tmc_etr0  tpiu0
> > > > > +
> > > > > +	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
> > > > 
> > > > On the "older" kernels you are referring to one would find the original naming
> > > > convention.  Everything else looks good to me.
> > > 
> > > True, but do we care what we see there ? All we care about is the location,
> > > where to find them. I could fix it, if you think thats needed.
> > 
> > IIUC, either the old kernel or newer kernel, both we can find the event
> > from ($SYSFS)/bus/event_source/devices/cs_etm/sinks/; the only
> > difference between them is the naming convention.
> 
> The cs_etm/sinks was only added with the CPU-wide trace support. So, if someone
> refers to this document alone and then tries to do something on on older kernel,
> which is quite possible for a production device running a stable kernel, {s,}he
> might be surprised.

Okay, understand now.  Thanks for clarification.

> > So the doc can use the same location to find event for both new and
> > old kernel, and explain the naming convention difference?
> 
> My question is really, does the naming convention matter ? What you see
> under the directory is the name. But yes, I am open to add a section to
> explain the fact that we changed the naming scheme, if everyone agrees
> to it.

The naming convention is not important for the developers who are
familiar with CoreSight development; later who is the first time to
access kernel CoreSight modules and don't know the history for naming
scheme, the related documentation will be friendly and reduce the
barrier for using it.

I have no strong opinion for this, seems to me another choice is to
describe the older kernel with old naming scheme, something like below:

On older kernels, this may need to be found from the list of coresight devices,
available under ($SYSFS)/bus/coresight/devices/ with old naming scheme:

    root@linaro-nano:~# ls /sys/bus/coresight/devices/
    	20010000.etf   20040000.funnel  20100000.stm  22040000.etm> Cheers
    	22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu > Suzuki
    	20070000.etr     20120000.replicator  220c0000.funnel
    	23040000.etm  23140000.etm     23340000.etm

    root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program


Thanks,
Leo Yan
