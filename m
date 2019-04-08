Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10892C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C72218E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epfTus88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDHOBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:01:32 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38698 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfDHOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:01:32 -0400
Received: by mail-yw1-f65.google.com with SMTP id m207so4950145ywd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=87ry1+exZi+/r/H1mx0oaRyz2ApizjtVLTtMVs6O4KM=;
        b=epfTus88c4eRGhAeKPB+w0UBih0X5+8GOVPdjdeDrOIuawJkAra876VswUDkPrzXrF
         HZTNiUGKFjHK6EliBB7LfVnu7J0YbJ4gRjnRJw9sZn4eyu6XtfKYm1rQM10dUOk5SUhK
         qFOgKLY0E/90a+l+opyE6j2jJpUCsoihkBrcw43HRL5UwF4znQ4fQnXsvdP5SOy/tS8S
         NiITnNxXRlSHZZp7KB4R4sdBaEaWcaIX3eAv0UYF9kxSw2bHw+xwXYeNwL+1usE2pRMP
         z6ybCG6ck+RDO66DAUGOPFouG/rkKzWIZU7wogBnKXOAYFkI7XQG3JWkKpT/wTTKrjPj
         X2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=87ry1+exZi+/r/H1mx0oaRyz2ApizjtVLTtMVs6O4KM=;
        b=EH7HKvqGx+9ZSftSMgXaSUijwX5n7D7C4yVNO5mWKHM0udNFBvHfkzAbZWOT2rZ6O2
         kClHqlKhjuG5fimP4b8Vo2G966mA08IFovxMSFpVBP/hwRJYblIQ+Noo4q/8jgiG93ph
         aVsoMdwWJC7eVHrAoCcJ06CBaA/swv7qhaah5YK+8t3bNCD7lwcAXzKsnj2H6kUZGIq0
         Z3blKZjFTLZCVSxhl92GIp7q+5qbuYbvCjdjwXj4K4QAVUuhcot6KaKVYYOeaMq+uHQT
         4Q+Oq57zebIjQqpBBb2MDw1npetkC/xhtlzA28nqTYWaRAdeyyIPOrE27q9gHiOVxuFW
         JMlQ==
X-Gm-Message-State: APjAAAVO504LoPtzqv8Ky83x7D5Km4wQW2QM6GC94FDUFqLQVN+g+gs3
        cmF01mqcbrjnQK8+8ZOpKjVsag==
X-Google-Smtp-Source: APXvYqwV60OGZXfXmQa9eBA+1B3IhacLaxH+kmOW6+TFCdnaJ58QyKiI6bsfa/3fbPi/PhIPcFpIDA==
X-Received: by 2002:a81:52c2:: with SMTP id g185mr24177643ywb.386.1554732090855;
        Mon, 08 Apr 2019 07:01:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id p3sm2698232ywd.94.2019.04.08.07.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:01:29 -0700 (PDT)
Date:   Mon, 8 Apr 2019 22:01:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        shiwanglai@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
Message-ID: <20190408140115.GA6541@leoy-ThinkPad-X240s>
References: <20190406112145.15184-1-leo.yan@linaro.org>
 <20190406112145.15184-2-leo.yan@linaro.org>
 <b661edd2-5b99-f8f7-b5a5-8e4497043087@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b661edd2-5b99-f8f7-b5a5-8e4497043087@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Apr 08, 2019 at 11:44:56AM +0100, Suzuki K Poulose wrote:
> On 04/06/2019 12:21 PM, Leo Yan wrote:
> > CoreSight uses below bindings for replicator:
> > 
> >    Static replicator, aka. non-configurable replicator:
> >      "arm,coresight-replicator";
> > 
> >    Dynamic replicator, aka. configurable replicator:
> >      "arm,coresight-dynamic-replicator", "arm,primecell";
> > 
> > The compatible string "arm,coresight-replicator" is not an explicit
> > naming to express the replicator is 'static'.  To unify the naming
> > convention, this patch introduces a new compatible string
> > "arm,coresight-static-replicator" for the static replicator; the
> > compatible string "arm,coresight-replicator" is still kept thus we
> > can support the old DT binding, but tag it as obsolete and suggest
> > to use the new compatible string.
> > 
> > As result CoreSight replicator have below bindings:
> > 
> >    Static replicator:
> >      "arm,coresight-replicator"; (obsolete)
> >      "arm,coresight-static-replicator";
> > 
> >    Dynamic replicator:
> >      "arm,coresight-dynamic-replicator", "arm,primecell";
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   Documentation/devicetree/bindings/arm/coresight.txt | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > index f8aff65ab921..f8f794869af2 100644
> > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > @@ -69,7 +69,11 @@ its hardware characteristcs.
> >   	* compatible: Currently supported value is (note the absence of the
> >   	  AMBA markee):
> > -		- "arm,coresight-replicator"
> > +		- Coresight Non-configurable Replicator, the compatible string
> > +		  "arm,coresight-replicator" is obsolete, keep it to support
> 
> To make it more obvious : s/obsolete/OBSOLETE/
> 
> > +		  the old DT bindings:
> > +			"arm,coresight-replicator";
> > +			"arm,coresight-static-replicator";
> 
> nit: I would re-order the compatible strings to show the precedence of
> choice.
> 
> e.g,
> 	- CoreSight non-configurable Replicator
> 		"arm,coresight-static-replicator";
> 		"arm,coresight-replicator"; (OBSOLETE. For
> 			backward compatibility. Will be removed )

The suggestion looks good to me since it's neat.  Will do it.

> Also, please could we put a warning in the driver when we encounter it
> and request to update it ?

Will do.

Thanks for reviewing!
Leo Yan
