Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CEFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF820C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GtsqRxeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405180AbfHIDjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:39:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36537 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405098AbfHIDjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:39:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so45135154pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65aYqAVIIYjhyCmnyqV/5PNvkM6BEAj6E5sBAAyQwCc=;
        b=GtsqRxeLoqj8K/ZiX15WNEvzIG7f3782O540QxuRkI9DX/f9lKPiHGZrCibf2mC43C
         L2c1x+ZZFrRF3TCiOzo6TYY0NVINPIv0vD0NqH2yN1WTjHQ3QCAifRuEi6yTTwMmjYK+
         gfVd9kz+jmv9glukworuJ+yoqetHZGWKiBvlSswDQIYycGH8fp8Ct3TzcLccWuuzQkjQ
         lv6CLMX/VIcgopNP1SK2XnAlqTU7d9I1Q1Ogy/DMqVNRQYJ6aptJZdXwDeAEISDQC9sE
         b6/N6G05TMvxVMTRzRmiWoVtnlikt6IM13dFz6WbuhRdrmCLB58kwoEORyaNQPD37+j/
         Dckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65aYqAVIIYjhyCmnyqV/5PNvkM6BEAj6E5sBAAyQwCc=;
        b=SzGjwQ/UuZA8Pyi6AruMhhR/6L+EEL+kli+U07GzGZIvqN4lzJXSiPIe/01G6f62c0
         0adKE+sZsyrYlW1mF3z0RmVl+PRoNG1OzNIvqQlaQObE2r8gWnpZSpfDD04rXs0z02Ni
         H0AJYROH13HtAL33FtGjuv9cplk2Xo0N9NQe7bW6wC9cGeUlfuIfJXjDaRScEwMFVhIt
         cU8h1atApRccA8ZetCuhqWu+esygdufO0ftK8+4/xMdpjJIPNlNbPitTMV+355ztaVLU
         Lt9oTR+xQzxGXejBgxVJrfa7SXu+aJVFC4MiLCrPiM91jlZGgu72sCrdeB1DHN1pqnA+
         0kUw==
X-Gm-Message-State: APjAAAVFQqNvfxs5VPpEoPzJuagVDmWlQ6tD9ZGKEf5jI7ImRyqVuh3A
        sO3lfqYTvhy8k53DL00VRipr8w==
X-Google-Smtp-Source: APXvYqyCoTbIY/SmEPfVHSkLa4H/SxltOTgybLImw8D4tHCW7Fmh/OfTA2wxCRvGAnZzMymDRXZjcg==
X-Received: by 2002:a63:481c:: with SMTP id v28mr15527467pga.50.1565321983685;
        Thu, 08 Aug 2019 20:39:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:3965:6e7a:8c2:c21b? ([2605:e000:100e:83a1:3965:6e7a:8c2:c21b])
        by smtp.gmail.com with ESMTPSA id j1sm129386216pgl.12.2019.08.08.20.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 20:39:42 -0700 (PDT)
Subject: Re: [PATCH v2] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
To:     Alessio Balsini <balsini@android.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dvander@gmail.com, elsk@google.com,
        gregkh@linuxfoundation.org, joelaf@google.com,
        kernel-team@android.com
References: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
 <20190807004828.28059-1-balsini@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4dc06fb1-df3c-5887-725a-0d20c3291528@kernel.dk>
Date:   Thu, 8 Aug 2019 20:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807004828.28059-1-balsini@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 5:48 PM, Alessio Balsini wrote:
> Enabling Direct I/O with loop devices helps reducing memory usage by
> avoiding double caching.  32 bit applications running on 64 bits systems
> are currently not able to request direct I/O because is missing from the
> lo_compat_ioctl.
> 
> This patch fixes the compatibility issue mentioned above by exporting
> LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
> The input argument for this ioctl is a single long converted to a 1-bit
> boolean, so compatibility is preserved.

Applied, thanks.

-- 
Jens Axboe

