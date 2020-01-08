Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A06C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45CB24672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578482274;
	bh=qmRF5I/eJ6Xufmpf6Fnipis4D/jLuNSSfdkTRh9QjDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dXTnOxymIEguzmfDyumpwwQEnnm0imKZ71cPpN1VH0HFBcSSCmyosGpe3Dz9LU4aj
	 oebhbafBn35FwyEkeXrksL1CYFqcLYptQOuMPpO+pIbYbG48eIp/Zs4N1DBHy8Cphs
	 /sSxbgIRFyKdhCfWz+/KD7JJJhW07rqZ1OJKf+Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgAHLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgAHLRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:17:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBFB2077B;
        Wed,  8 Jan 2020 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578482270;
        bh=qmRF5I/eJ6Xufmpf6Fnipis4D/jLuNSSfdkTRh9QjDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ff56IwXwfuwkzUgXwaXeRvpnnqLHD6SbvYQhn90CxETJYI/g1TnZBRFOscPfedPig
         1K0zOMF+SOAnFx/FB6sUHef9beVrIP+paN9CSX6CwJ64lk5VDZKCiypHXGSqv3RND7
         2X15uMf3KS/EIRW7qXYXOYR1x4PXmCp6vpxRilA0=
Date:   Wed, 8 Jan 2020 12:17:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 103/115] coresight: etb10: Do not call
 smp_processor_id from preemptible
Message-ID: <20200108111719.GA2342287@kroah.com>
References: <20200107205240.283674026@linuxfoundation.org>
 <20200107205308.383005810@linuxfoundation.org>
 <a3f27cf7-f3dc-7829-873b-591a91d8a28a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f27cf7-f3dc-7829-873b-591a91d8a28a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:01:41AM +0000, Suzuki Kuruppassery Poulose wrote:
> Greg,
> 
> On 07/01/2020 20:55, Greg Kroah-Hartman wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > [ Upstream commit 730766bae3280a25d40ea76a53dc6342e84e6513 ]
> > 
> > During a perf session we try to allocate buffers on the "node" associated
> > with the CPU the event is bound to. If it is not bound to a CPU, we
> > use the current CPU node, using smp_processor_id(). However this is unsafe
> > in a pre-emptible context and could generate the splats as below :
> > 
> 
> >   BUG: using smp_processor_id() in preemptible [00000000] code: perf/2544
> > 
> > Use NUMA_NO_NODE hint instead of using the current node for events
> > not bound to CPUs.
> > 
> > Fixes: 2997aa4063d97fdb39 ("coresight: etb10: implementing AUX API")
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: stable <stable@vger.kernel.org> # 4.6+
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Link: https://lore.kernel.org/r/20190620221237.3536-5-mathieu.poirier@linaro.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etb10.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> > index 0dad8626bcfb..0a59bf3af40b 100644
> > --- a/drivers/hwtracing/coresight/coresight-etb10.c
> > +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> > @@ -275,9 +275,7 @@ static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
> >   	int node;
> >   	struct cs_buffers *buf;
> > -	if (cpu == -1)
> > -		cpu = smp_processor_id();
> > -	node = cpu_to_node(cpu);
> > +	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
> 
> Please drop this patch too, from the list as it will break the build
> with undefined "event" variable. I will post a backport soon.

Also now dropped, thanks.

greg k-h
