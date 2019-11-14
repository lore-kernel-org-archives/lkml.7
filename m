Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C09EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356AD2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al5B8Qg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfKNIl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:41:26 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44339 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfKNIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:41:25 -0500
Received: by mail-pg1-f180.google.com with SMTP id f19so3275302pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3gNp5AR/thc+L1y5xJjdkSqmT/cSSY4HgpMILU6J9U=;
        b=Al5B8Qg4R5gQsFCbxN/pHpsDKNFwZ10mLNdMavt/+yuE6k0ExngJOThOUHL7n6lZg3
         ZU7+n8seQ2AL/lbEsseWajReb5h1yF8FFr6MifBW95o8tPh93CMmlVXU2Zcleqg3QY9D
         Gklu287gnR/i0bFVsTyJNtHLVFFYLvHs1b9XmbGFfg/jEXTiZaqWSC25RaUsre6Xrl7u
         yxMtX6Raud8jJmD4QoPc790p8cmGaYc5U/tkbVMCEERLAPJ/XhbqjAqKdeym23Pbq0gc
         IW/vFZjZKnEIOXDGUOI5NA6ePn5kvRDj+ZpVXQnaZng8q4nvVhLBgmmjv3FoM62lD+Uz
         UYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3gNp5AR/thc+L1y5xJjdkSqmT/cSSY4HgpMILU6J9U=;
        b=fFa2dTJs/2Ngl7tmvcgBKOzEem0cjNH4IaLYKYrwx5VSQaySIEq6ytBZ8O7E389U4i
         Zd9hGTuWMv0Agg+TMaVn1t1Pnm2hklc9WFO0zRRy2xdXYEBTNXo9urEzHPA32roYUHvd
         qmg6fY37EaMWmqRG79RkEvMd5bvHRbaDIPXhBUFn8FwUzSq15Hy8uJZDKHfsBOxzZPlr
         YXJ14k2is7hba7uyKFG6QwcdEZiG7Sqi8XUtggH7oGH06YS+KV01Gc9AS8Yk5GsLd2Of
         EX4b1FKdCewowSiW5xNU5jhWOpSBsVWO+mM2Pm8zM1PcPamDbQgDNJKmsJQcks+eYIVC
         YdGg==
X-Gm-Message-State: APjAAAUYu9yCX0uLfdCZ4q+VVvIOcWwhoCK/n9mQzp+m4qg/uYITil3V
        GkmISpNOYG2BlzT0KNNdv+B45w==
X-Google-Smtp-Source: APXvYqyh0xLsR6j8VPQoMgv8oLAbGBK9NPzoD9pymbIVMrICUXmU2iKFKWK+gAshxQ1D8ygYH5BUtw==
X-Received: by 2002:a63:64c3:: with SMTP id y186mr8636135pgb.409.1573720884695;
        Thu, 14 Nov 2019 00:41:24 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id j20sm5132254pff.182.2019.11.14.00.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 00:41:24 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:11:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191114084122.35myncenejt54hht@vireshk-i7>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
 <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
 <20191110101647.GA1441986@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110101647.GA1441986@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-19, 11:16, Greg Kroah-Hartman wrote:
> On Sat, Nov 09, 2019 at 12:27:29PM -0800, Bjorn Andersson wrote:
> > As your question shows, everyone gets this wrong and the build breaks
> > all the time (it's not "depends on framework", it's "depends on
> > framework || framework=n" - and everyone you'll talk to will be
> > puzzled as to why this is).
> 
> Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
> express that type of dependancy.

Maybe we can use

depends on framework != m

-- 
viresh
