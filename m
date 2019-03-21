Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D72C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB33218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MetRX0Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCUCJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:09:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47055 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUCJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:09:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id c18so4055910otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RXXjFgQ4kSh1haj12ilofiyo5dCddf6sQWZJ/oZ18SM=;
        b=MetRX0FbgGojxiV9ezSD90LNzLmToGT689mQfL9tp+t/yhpHC/VSzkZlL6FKX0zAsm
         oomBN5mYw0/YgEZp2owjkX5wLklEVvvI6RbtrwuzTNQNb9iQ7x4KvJH0Qxd41g+tdgJg
         A7Y7E7Yc8H4sJL5rC4UZ53XTHY+IfslYqhP0IoTPby884gDrkOlsWaKeexn+65gzdnQW
         HGTviFS8n6xsu14gMGozDNONan/fz8mm1740GRylfgB9zvzIUWa0lWD6WuJMe0E3HtVi
         eHmvEhKdnIqibuLD3bbFyqrLfUs4sAm78njn+o43UTmNQ848yNZUcLaDA30NzAB0PQhu
         UTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXXjFgQ4kSh1haj12ilofiyo5dCddf6sQWZJ/oZ18SM=;
        b=f4rlIDYfBwBcRyuAiylx76+adj63lUt8LUAIdbnSlu1/qidwWVoS/BtWeC1XQ43jjE
         IvSgh+cVdTkUut3/hDhGHITpy542cPlAImg6E8zo8+LKIYc1JSigMPmxOXxr+ANj6aQw
         Z/O4DimYpZekjgc83alozCPW0NlldY1JPgdbjVhtJBYapHAbzZbWxutxwMconInsfoOX
         k7yzHwpfkwUgSxeL0J9FTLQAsUP7kSJL+Mo0rYi2+vpU7b9VE2kWutNMFalTeB4eZCfm
         ga93F6Oqa774VtFn9WVpBh3gh/H2ydItjwKr48drDUsSey8J+3aUjlMfsZE2uTRp9kVc
         Jsmw==
X-Gm-Message-State: APjAAAVBd85EoJifZdGDj1TOJ+XZre8kZrXkkAQISekhHEgv8c0Je8Ab
        Rr4drQ9pvTiK8lkYLmlePt+3zA==
X-Google-Smtp-Source: APXvYqzK1u4fDsj7xhNYltQ622yVydefHuO+AjF2PeEID/NAoXV9LdMr2La/0fbBF1Bv8bN5oyT9BA==
X-Received: by 2002:a9d:4d89:: with SMTP id u9mr912146otk.71.1553134169475;
        Wed, 20 Mar 2019 19:09:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id j131sm1482373oia.37.2019.03.20.19.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 19:09:28 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:09:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     shiwanglai@hisilicon.com, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com
Subject: Re: [PATCH v2 2/3] coresight: funnel: Support static funnel
Message-ID: <20190321020922.GA5571@leoy-ThinkPad-X240s>
References: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com>
 <1553085490-42870-3-git-send-email-shiwanglai@hisilicon.com>
 <ecfa879e-9fd9-0815-d2da-bb9870d6ae59@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecfa879e-9fd9-0815-d2da-bb9870d6ae59@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Mar 20, 2019 at 01:52:58PM +0000, Suzuki K Poulose wrote:
> 
> 
> On 20/03/2019 12:38, Wanglai Shi wrote:
> > From: Leo Yan <leo.yan@linaro.org>
> > 
> > Since CoreSight hardware topology can use a 'hidden' funnel in the
> > trace data path, this kind funnel doesn't have register for accessing
> > and is used by default from hardware design perspective.  Below is an
> > example for related hardware topology:
> > 
> >    +------+  +------+
> >    | cpu0 |->| ETM  |-\
> >    +------+  +------+  \-> +--------+  +-----+
> >     ......                 | Funnel |->| ETF |-\    Hidden funnel
> >    +------+  +------+  /-> +--------+  +-----+  \        |
> >    | cpu3 |->| ETM  |-/                          \       V
> >    +------+  +------+                             \-> +--------+
> >                                                       | Funnel |-> ...
> >    +------+  +------+                             /-> +--------+
> >    | cpu4 |->| ETM  |-\                          /
> >    +------+  +------+  \-> +--------+  +-----+  /
> >     ......                 | Funnel |->| ETF |-/
> >    +------+  +------+  /-> +--------+  +-----+
> >    | cpu7 |->| ETM  |-/
> >    +------+  +------+
> > 
> > The CoreSight funnel driver only supports dynamic funnel with
> > registration register resource, thus it cannot support for the static
> > funnel case and it's impossible to create trace data path for this case.
> > 
> > This patch is to extend CoreSight funnel driver to support both for
> > static funnel and dynamic funnel.  For the dynamic funnel it reuses the
> > code existed in the driver, for static funnel the driver will support
> > device probe if without providing register resource and the driver skips
> > registers accessing when detect the register base is NULL.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Will add the tag in next version, and very appreciate you shared me
offline the replicator code for reference!

> > -static const struct amba_id funnel_ids[] = {
> > +static int static_funnel_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +
> > +	pm_runtime_get_noresume(&pdev->dev);
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	/* Static funnel do not have programming base */
> > +	ret = funnel_probe(&pdev->dev, NULL);
> > +
> > +	if (ret) {
> > +		pm_runtime_put_noidle(&pdev->dev);
> > +		pm_runtime_disable(&pdev->dev);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id static_funnel_match[] = {
> > +	{.compatible = "arm,coresight-funnel"},
> 
> There is a potential issue with re-using the "compatible" string
> already reserved for the normal programmable funnel. We may handle
> a programmable funnel as non-programmable one, which is not good.
> 
> Do we need to use "arm,coresight-static-funnel" ?

This suggestion makes sense, will do this.

> Otherwise, looks good to me.

Thanks for reviewing.

Thanks,
Leo Yan
