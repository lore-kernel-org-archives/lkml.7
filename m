Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D76C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8507720645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IcIvG2zV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfC0RWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:22:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfC0RWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:22:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so3632045plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u0z/uiUA7cpRFpRLBb1uuNgQeFvoMDPLjRhLKGzcxak=;
        b=IcIvG2zVIQx27PcCq1h0HgkIusIy1Ky/Iisz6yp+vU6feXfjzLP5xDk3kiw0ec40tY
         CSXAaDfZUjCxItHMmrRrl5I4eYWxSuwH7jsRz6m/U6pGO4AvXw/CjAB8Pj2YCoUKFPxi
         AayE+lmBIrlg7yIrNwrk5afR7xIl3OjvmMolU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u0z/uiUA7cpRFpRLBb1uuNgQeFvoMDPLjRhLKGzcxak=;
        b=L2u7JXP0zQhIUsTMBWlJJUJvnvFRMliU7fYm8JUz0hRnp8nSdMhRuYuKAvFlUyZHyZ
         IM/ZMEr2tAZH5ViZYThXtjVL3/xC3d2dZWHLWaqUg2op7w2kO8fY9J2oY/abzqcanAte
         YmaEDLhp0RhpbjlGGrnADC9QTIaiEyozGVArffX7xi7PcaKQIwWkCCz7/KVDScaJem8b
         xtfpW2GgYeUzJ4ymXSP3vrqxNoHGft9DXMF5Pxl98Gkq6qlTrJd22PL+ZWDJs7+N1kK2
         xGBkDGnHwYlTFqGp3+NFYDljDN4/cjyIdh58rGRyach/E6D0HmEGOg3BnUW8iQrwUFuC
         ZmYQ==
X-Gm-Message-State: APjAAAXsqZQggSukIESywt0TGdu8Qt6CGTvYWeaoXA6r8yqkPZvr6d/m
        bo42MsjpaRVFqy1jeWbJPdoDvA==
X-Google-Smtp-Source: APXvYqxQFRuIvvWPTBAvxwG5ZvKO++4Z1pnQqNOH8BMAzC2+OPZCsA2B/1BIXlojg5H5BIDA9p1PHA==
X-Received: by 2002:a17:902:e3:: with SMTP id a90mr37096520pla.45.1553707331568;
        Wed, 27 Mar 2019 10:22:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v20sm13537173pfn.116.2019.03.27.10.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 10:22:10 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:22:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3998
Message-ID: <20190327172210.GD112750@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
 <20190312165928.GD200579@google.com>
 <88a923e02073461abb5f3a7674150615@codeaurora.org>
 <20190314185637.GB112750@google.com>
 <8432d8b9743e2b4b6a7195329c808af3@codeaurora.org>
 <20190326235458.GA112750@google.com>
 <6a57b6cfd92f982c5e00fc1db30e778e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a57b6cfd92f982c5e00fc1db30e778e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 03:53:58PM +0530, Harish Bandi wrote:
> Hi Matthias,
> 
> > > > > > You mentioned in an earlier version of the series that there are
> > > > > > multiple WCN3998 variants with different requirements for
> > > > > > voltage/current. This seems to suggests that multiple compatible
> > > > > > strings are needed to distinguish between them.
> > > > > >
> > > > > [Harish] -- for now we want to add WCN3998 support only, What i mean
> > > > > to say
> > > > > in my earlier
> > > > > explanation that. WCN3990 is base variant and on top of that we have
> > > > > variants like WCN3990,
> > > > > WCN3998 and WCN3998-0,WCN3998-1 like that..
> > > > > So I think wcn399x would make sense for this series.
> > > >
> > > > If the variants have relevant differences between them (like different
> > > > regulator requirements) I think you want unique names, rather than
> > > > 'wcn399x' (I was referring to comments/documentation with this
> > > > string).
> > > >
> > > > If there are variants wouldn't your first 'wcn3998' already be a
> > > > 'wcn3998-n'? If 'wcn3998' without suffix is used I think it needs to
> > > > be valid for all 'wcn3998-n' variants (it might be less
> > > > power-efficient though than using the variant specific compatible
> > > > string), otherwise things get confusing (a 'wcn3998-2' isn't a
> > > > 'wcn3998'?)
> > > >
> > > 
> > > 
> > >  [Harish] -- for now WCN3990 and WCN3998 only, also wcn3998-2 and
> > > wcn3998
> > > are same.
> > > So for now we are going to have only WCN3990 and WCN3998 for DT.
> > 
> > Since you brought up the different power requirements initially:
> > 
> > are your reasonably sure that future wcn3998-3, wcn3998-4, ... can
> > operate with the generic wcn3998 power settings?
> 
> [Harish] - yes with power settings of wcn3998, wcn3998-3 and wcn3998-4 ...
> also will work.

Thanks for the confirmation, in that case just using 'wcn3998' for now
sounds good to me.
