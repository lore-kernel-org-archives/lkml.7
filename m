Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F26C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A612087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="RnCL2vpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEPGn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:43:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35758 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEPGn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:43:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id c17so1725522lfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 23:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imhQI7GDUD7lkEFWiWq9LCRO6updyJwsynuuz3zk8A4=;
        b=RnCL2vpDFDeF9T0vaCvryQmcHOeIkW1g0H3ycEvTcZURbuYVHU9LVNDgGKKOijBD72
         3hjDY9Cpc/NcNt/YYH4o/yQz4Af1uRd8twYJcBwL8jeEX72E3XJptEL6FTWjunv4HL2c
         AkMWRwAEGTzzI4KfS1xpKUd/QpjWVkJ7Llypd9kaogq+U9h1kdrKnSEieckPnRykBhZz
         FOZW4AxbtEkRzKTZ6x5buBwLor9nfdrplF2GzlIHiykGeYVSTnPF55VL3Xt7lEn03n00
         iO2TzN3jmFggpaYJpnLy1X9d3FquG/tUaEc/7JfEBeMalSq31cHaQn1UBjXwU0hUgMhK
         kDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imhQI7GDUD7lkEFWiWq9LCRO6updyJwsynuuz3zk8A4=;
        b=f0FpDo4nLsm2QUfEt5y8BdjDRIv38ZkzskAO2xiWT/d1dVUytrSArINOWj+V1VH6dP
         GfRuHwlPFWJDUganrIVH/7tzyIzpUmqTdEiMBs5X1qW/XX9ItmJ22qLC1fohRcuWyyEC
         hubnd17BBmF5ow0iBsctZWYuzc8796ycWHOq3xSk+qYR/umviFU9LySEBF1vyexFk9xf
         pxhR2ZyfaLb3lzCkWFHN5PT8w9XByRiRAn+kIsP6E1h16LyjpWYE78Ox/lUr0E0zK7Zi
         C5frEjUNb8vF+saoQSdz92brQlsUq0KY0gic1Uf5l4iuJGhgjJxMe/ybp1Piyf0CXVml
         Mjgg==
X-Gm-Message-State: APjAAAUjUjNFi26oKcXdgY5CudmW8KOAh3W/F+UbMjN75mxfggG9QCvv
        x6HIzgXuOr6gNQawqLjoiQFdSlTckrE=
X-Google-Smtp-Source: APXvYqxZtW6IDc+EPw0F+TXziG3dbjLWv6UKEKzEnJ2Zzlp3bursU9lKtoJDm9LGprugMwVQq68SJQ==
X-Received: by 2002:ac2:51d1:: with SMTP id u17mr22525545lfm.151.1557989037799;
        Wed, 15 May 2019 23:43:57 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x184sm905564lfa.27.2019.05.15.23.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 23:43:56 -0700 (PDT)
Date:   Wed, 15 May 2019 23:24:40 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL] fixes to soc/fsl drivers for v5.1
Message-ID: <20190516062440.x23dgkuikrbfcnqa@localhost>
References: <20190501203748.5393-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501203748.5393-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 03:37:48PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please help to merge the following fix for soc/fsl drivers.
> 
> Thanks,
> Leo
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.1
> 
> for you to fetch changes up to 5674a92ca4b7e5a6a19231edd10298d30324cd27:
> 
>   soc/fsl/qe: Fix an error code in qe_pin_request() (2019-04-02 18:02:48 -0500)
> 
> ----------------------------------------------------------------
> NXP/FSL soc driver fixes for v5.1
> 
> QE drivers
> - Fix an error path in qe_pin_request()

Merged into arm/late. Thanks!


-Olof
