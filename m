Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ED3C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB11218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTeYKlvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfJJQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:51:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJJQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:51:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so8749497wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7bu/p1V/jPBVukNh0HzQltOIjl5iBAhuyWFtm99yZ2M=;
        b=PTeYKlvjW/Mo8h5FYVG1JpGMdBacSGeS1LH4pBUSwmp5OwJXPe6UwEDxq1ax1LPek8
         9pjVrtmUrmuz1OpOOP4TR7Kb9Qssjw6lwq8y5GorqmLXqAKH4Y2qVaIY2mfTL31YiGn7
         DczwZWj0zyKBsnc/vLKGCSC6UVeXsNO03NDfzW+MlKnpuq3x9PgEsP6+P9NtikqhObqd
         vTH/0umRJUAKt5yh5JsXN8LLFXeOb1xo0Xvf+mxkBuPnddm74mc21EyStWmLcLpFIE7b
         rsE2UJd30z31HZuNXKM6TFecvUF3zkYiNv8XdHwELQRw+flhyLeOI8diV462eevYPqvI
         Vyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7bu/p1V/jPBVukNh0HzQltOIjl5iBAhuyWFtm99yZ2M=;
        b=O+ucFIdUbxVox+jTUD9UCTBAs0G6a8IkQSGX3MH7HiHVt3JOgEvvFvFUwSWr/TGVy6
         05NxWHRMkaV5ODC5Mkqbq+pO93M2XBotyo3V1jXbwqAm423DuQRHzwtjYYN1nI4U15Uo
         M6j2VAh6AK+UmqvTfGsiP0Eax75mcByV+K6SFRjkCuxe9b9kQhaQWa51XSwJXEho/b+Q
         ARADCNrsdKTan51sjzrotpiYApGBTkwKm2N9kHXxCX4DfetlAVc0oJIKuEc8u21pgAf3
         HHrq29VniN0HWoaYUwue8anT6owNwbL+sKhSzPV6c08tOpfBsqYuz0YyYxDNSJkk7Vxb
         FVqg==
X-Gm-Message-State: APjAAAVG8rbJq3IUsPCaCNIWOCNcaepcykjFZiSKQlVbv5CvZq9J4rhT
        IpfEKD2oDAGJqQEuWXxdy2XWtA==
X-Google-Smtp-Source: APXvYqx+JMkN3tC8wFFueYa7ICq4JDkKxjd8DhWTdlw1o8w+B0UKdW2izWlRVtwxrOVVrS4Puqf1tA==
X-Received: by 2002:a05:6000:44:: with SMTP id k4mr9905117wrx.121.1570726290338;
        Thu, 10 Oct 2019 09:51:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a10sm6846042wrm.52.2019.10.10.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:51:29 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:51:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] kdb: Fixes for btc
Message-ID: <20191010165127.sms6kanpkivda5rp@holly.lan>
References: <20190925200220.157670-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925200220.157670-1-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 01:02:16PM -0700, Douglas Anderson wrote:
> 
> This series has a few kdb fixes for back tracing on CPUs.  The
> previous version[1] had only one patch, but while making v3 I found a
> few cleanups that made sense to break into other pieces.
> 
> As with all things kdb / kgdb, this patch set tries to inch us towards
> a better state of the world but doesn't attempt to solve all known
> problems.
> 
> Please enjoy.
 
Applied.

Note: Given this series alters a very long standing behaviour I've queued
      it for v5.5 rather than add it to a fixes branch. It should land
      in linux-next shortly.


Daniel.
