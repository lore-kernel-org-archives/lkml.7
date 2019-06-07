Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA6C28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE14206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbZ4UhtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFGCVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 22:21:45 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43932 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFGCVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 22:21:45 -0400
Received: by mail-yb1-f193.google.com with SMTP id n145so230390ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypCRpLGfpU1UTauZw8qNAOgzbjXvHTif8VBKbvg8Yv0=;
        b=sbZ4UhtQKg5EgRtrg7vRjKJMr8vXoJDJ2sy0wlwAvzzyODxcsgFiYX+gdXWWxxMmc2
         t+dbJScuXiVZQoszVJ4kfPowotE8aLagjUWGrTfUytsiU/fKwNxGIpx/heREknnLhU8G
         bA6s09NdVszAHpONG5qJHWmBAF/l7+nVKgQiskJgH1g1cEaRq5k/3jjkLCak0ttca1gF
         M9LJjLvkeheLN0Imi7fmeNspKiJhpOl1dL6MQrwhEjzynL+ETosKxZfTQbKZcfy4/kC6
         9xnl9C5s8K7ckGISDEJ5xcw+YqRoFw0Dy9VUaoV+zJnC6pWCLCOd0JDFOB9UjbRBKN8n
         fa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypCRpLGfpU1UTauZw8qNAOgzbjXvHTif8VBKbvg8Yv0=;
        b=lY+maruaq+30H4KJhPKrwKwf2V2hH462m7UdMFEoiiCDZ3CNukjsabldUKDb/bxRCg
         aec56q2PJtHRUzZH1uyZem2+H4ZQFjpaWvJzG+qlStR0r52U3j0nU7Pn8XpatLfaNn89
         HGwReKK/AnD+Xe5bsZE925A6WVtBfagaPgL/XIb3XThxk8W7/j0pYofVnW84kI15Ppp6
         mwV47Y6zYkQIi7Ry1oasMX5hoNQrnPNoS0nhdfPeucwuEJjckmgaGlEzSa4YuFU1Poim
         RmL6E1DU9CXd+8UI3b1kzALjm+dj0Dk+M/nkFsO13rlikNDmeVl0KJ88T4rTGlooAUXx
         PeaA==
X-Gm-Message-State: APjAAAXkYQOCDbIQImf5sMjMOtFNdbay84uzlexh30OM9lqnCyWzDVhB
        IZfpjYfHea+UtBwyJTg81nwJ0g==
X-Google-Smtp-Source: APXvYqx8iXRsTTJwXfeqfERnwv6goa9I+YMKIbTRglHzyqAa1kuPeFPIxG0H3RXeycT45RqygpWihw==
X-Received: by 2002:a25:97c6:: with SMTP id j6mr24142048ybo.513.1559874104275;
        Thu, 06 Jun 2019 19:21:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id j14sm215444ywi.7.2019.06.06.19.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 19:21:43 -0700 (PDT)
Date:   Fri, 7 Jun 2019 10:21:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        corbet@lwn.net
Subject: Re: [PATCH] Documentation: coresight: Update the generic device names
Message-ID: <20190607022136.GE5970@leoy-ThinkPad-X240s>
References: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
 <20190603190133.GA20462@xps15>
 <99055755-6525-694e-a15d-5de7318a80da@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99055755-6525-694e-a15d-5de7318a80da@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Jun 06, 2019 at 05:21:19PM +0100, Suzuki K Poulose wrote:
> Hi Mathieu,
> 
> On 03/06/2019 20:01, Mathieu Poirier wrote:
> > Hi Suzuki,
> > 
> > On Thu, May 30, 2019 at 04:11:17PM +0100, Suzuki K Poulose wrote:
> > > Update the documentation to reflect the new naming scheme with
> > > latest changes.
> > > 
> > > Reported-by: Leo Yan <leo.yan@linaro.org>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   Documentation/trace/coresight.txt | 34 +++++++++++++++++++---------------
> > >   1 file changed, 19 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
> > > index efbc832..7b427cf 100644
> > > --- a/Documentation/trace/coresight.txt
> > > +++ b/Documentation/trace/coresight.txt
> > > @@ -326,16 +326,20 @@ amount of processor cores), the "cs_etm" PMU will be listed only once.
> > >   A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
> > >   listed along with configuration options within forward slashes '/'.  Since a
> > >   Coresight system will typically have more than one sink, the name of the sink to
> > > -work with needs to be specified as an event option.  Names for sink to choose
> > > -from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
> > > +work with needs to be specified as an event option.
> > > +On newer kernels the available sinks are listed in sysFS under:
> > > +($SYSFS)/bus/event_source/devices/cs_etm/sinks/
> > > -	root@linaro-nano:~# ls /sys/bus/coresight/devices/
> > > -		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
> > > -		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
> > > -		20070000.etr     20120000.replicator  220c0000.funnel
> > > -		23040000.etm  23140000.etm     23340000.etm
> > > +	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
> > > +	tmc_etf0  tmc_etr0  tpiu0
> > > -	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
> > > +On older kernels, this may need to be found from the list of coresight devices,
> > > +available under ($SYSFS)/bus/coresight/devices/:
> > > +
> > > +	root@localhost:/sys/bus/coresight/devices# ls
> > > +	etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  replicator0  stm0 tmc_etf0  tmc_etr0  tpiu0
> > > +
> > > +	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
> > 
> > On the "older" kernels you are referring to one would find the original naming
> > convention.  Everything else looks good to me.
> 
> True, but do we care what we see there ? All we care about is the location,
> where to find them. I could fix it, if you think thats needed.

IIUC, either the old kernel or newer kernel, both we can find the event
from ($SYSFS)/bus/event_source/devices/cs_etm/sinks/; the only
difference between them is the naming convention.

So the doc can use the same location to find event for both new and
old kernel, and explain the naming convention difference?

Thanks,
Leo Yan
