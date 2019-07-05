Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E1EC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF178216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBjNqDX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfGEK4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:56:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34083 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfGEK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:56:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so8887551ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3xu1/speEFCXSiXRSbZnm/9GE/p4iKFv14b8BpRdtlY=;
        b=CBjNqDX9T61gMaoe+QPElnfl8CkVihscPQPnXFHq+5WOvBvzuqdgkoCZExRLCS7XNE
         9wYMkpeQbScEbsMiCJM08uevfE66FrwmfFRShozpl3Ozv1kg4wGITJACcMYe4OB9Db+h
         QQER8OXKEvxxS5tVBjHomipg/VblBBvLszBEdH0pifItMHra0Ms9HuPf2h9MOJXyRVJM
         verUHUi7Yd7YU5VTc9LGEmfrU3L6qTK/m3Qp1tm9lYbA1S4N77zEUUMD43MCVQYRZ1dC
         UX6PhC+okR/2hoFoorF+VnOtBinI/3byniTpmCYkv4m9kvlWXfkPRsZsXn5f6YJ8Aeki
         c+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3xu1/speEFCXSiXRSbZnm/9GE/p4iKFv14b8BpRdtlY=;
        b=nqxEgtzkd+oCcuSWUfuzd3OAksJzNalPB8GPf3V8J9/fTWYkoqgX6gndlkyihG0O4y
         3VQHQB9YrnGnzoNbwpQPmmvogNB4jvCni7/tx4UUKE174nb1I7jX69jJCExL4RlQu9LN
         jrVlqZ33kwyU04oxGyARgho2iSW7EzZCrgdk39+71raiehu5yVmPuLcZn8TeX6wqxdqq
         v8BHV6DBxb0EEo+A5qwNKnWDMQbTH87GwfOEhpWFhAz9djNYZ1CrZkRfJSX73WJ1uLud
         0gW0pC9kZI+E6wW4pncD9xkZfJ13Am7O+x5847nRzydiuhmGmO1uT3ieZPRBJxlezGLk
         NqoQ==
X-Gm-Message-State: APjAAAVz9IihnVdUtIkPwCUx2e0HFVah02l1GOeslDAHQ87G3VlbFo1d
        DP6jmh1ZIM6gPEI7ag+yJxyHOw==
X-Google-Smtp-Source: APXvYqxP5oT32mxbY71s6qYMsp0B25ccv4pugYVqy4PVIrTAmwn9+OSbYCoGVNh8Z66E5fSZVMtm1g==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr1732603lji.71.1562324164453;
        Fri, 05 Jul 2019 03:56:04 -0700 (PDT)
Received: from centauri (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id h22sm1704161ljj.105.2019.07.05.03.56.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 03:56:03 -0700 (PDT)
Date:   Fri, 5 Jul 2019 12:56:01 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] dt-bindings: opp: Add qcom-opp bindings with
 properties needed for CPR
Message-ID: <20190705105601.GA22327@centauri>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-7-niklas.cassel@linaro.org>
 <20190409092352.joayvxyo77e6lehl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409092352.joayvxyo77e6lehl@vireshk-i7>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:53:52PM +0530, Viresh Kumar wrote:
> On 04-04-19, 07:09, Niklas Cassel wrote:
> > Add qcom-opp bindings with properties needed for Core Power Reduction (CPR).
> > 
> > CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and msm8996,
> > and was first introduced in msm8974.
> > 
> > Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  .../devicetree/bindings/opp/qcom-opp.txt      | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > new file mode 100644
> > index 000000000000..d24280467db7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > @@ -0,0 +1,24 @@
> > +Qualcomm OPP bindings to describe OPP nodes
> > +
> > +The bindings are based on top of the operating-points-v2 bindings
> > +described in Documentation/devicetree/bindings/opp/opp.txt
> > +Additional properties are described below.
> > +
> > +* OPP Table Node
> > +
> > +Required properties:
> > +- compatible: Allow OPPs to express their compatibility. It should be:
> > +  "operating-points-v2-qcom-level"
> > +
> > +* OPP Node
> > +
> > +Optional properties:
> > +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Even
> > +  though a power domain doesn't need a opp-hz, there can be devices in the
> > +  power domain that need to know the highest supported frequency for each
> > +  corner/level (e.g. CPR), in order to properly initialize the hardware.
> > +
> > +- qcom,opp-fuse-level: A positive value representing the fuse corner/level
> > +  associated with this OPP node. Sometimes several corners/levels shares
> > +  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> > +  min uV, and max uV.
> 
> I know we discussed this sometime back and so you implemented it this way.
> 
> Looking at the implementation of the CPR driver, I now wonder if that was a good
> choice. Technically a single domain can manage many devices, a big and a little
> CPU for example and then we will have different highest frequencies for both of
> them. How will we configure the CPR hardware in such a case ? Isn't the
> programming per-device ?

Hello Viresh,

I just posted this RFC as a real patch series:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=142447

Note that I disregarded your review comment above, because
this patch series only adds support for CPRv2, which is used
in e.g. msm8916 and qcs404.
There does not exist any QCOM SoC with CPRv2 for big little.

For big little, there is CPRv3, which is very different from CPRv2.
CPRv3 will require new and more complex DT bindings.

Right now we don't even have plans to upstream a driver for CPRv3.
Part of the reason is that CPR, for newer QCOM SoCs like sdm845,
is now performed automatically by the Operating State Manager (OSM),
for which we already have a kernel driver: drivers/cpufreq/qcom-cpufreq-hw.c


Kind regards,
Niklas
