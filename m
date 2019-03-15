Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA38218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCOUSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:18:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42647 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCOUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:18:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id u7so11527558qtg.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvBgwuvfiw7f7IIXtiNVuKC/kKvxABII8ZzOIVdVU8o=;
        b=W51BEEMU/K9qjUzcAGyeSaOMSRP9fnkveppSYPOC5AAOSUVK1b+2uDYQM5OFUgAYSW
         la+8+ONT9AQ+zmBmcuMYGiGbKIR2Sc/qUZiXGtwMsf2VO1ORAtBeQMZZPC0GnBx86wUx
         YlYZKLRewsrFoSYUwjkq68gFndHqEnsD9eD3EI5XFbZdJQLX8e2uMDC898XxB8nrHUCD
         1xzb72IzktbO1jFgsmk9qw1f70pfPWh4qLOXBQlCa2Qzw9SITT80hjllFgMNcDfpn5o1
         1eZSIhnPKDN1TPKG7ISW50poY2rwxhCqJ6N/DXSz1imooW9LeFLm+FP8Mbo46RfNozdX
         J07A==
X-Gm-Message-State: APjAAAXJm7jXbXlL1kOluE8005JDseIlqObCHuMp0OGQmlLzRGpzMB36
        En9SyI7f0rYhfbG6sKpwvQu5Bw==
X-Google-Smtp-Source: APXvYqyCqzO5VVvcV9+GALOkK3jFbTqTAeSf/M4iceiIFAT0M7ZQbbAFjQqS546NX2TL9r6fmwKnTg==
X-Received: by 2002:ac8:2269:: with SMTP id p38mr4371965qtp.340.1552681116137;
        Fri, 15 Mar 2019 13:18:36 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::362? ([2601:602:9800:dae6::362])
        by smtp.gmail.com with ESMTPSA id n1sm1969832qkd.28.2019.03.15.13.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:18:35 -0700 (PDT)
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
Date:   Fri, 15 Mar 2019 13:18:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551819273-640-2-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 12:54 PM, John Stultz wrote:
> +DMA-BUF HEAPS FRAMEWORK
> +M:	Laura Abbott<labbott@redhat.com>
> +R:	Liam Mark<lmark@codeaurora.org>
> +R:	Brian Starkey<Brian.Starkey@arm.com>
> +R:	"Andrew F. Davis"<afd@ti.com>
> +R:	John Stultz<john.stultz@linaro.org>
> +S:	Maintained
> +L:	linux-media@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +L:	linaro-mm-sig@lists.linaro.org  (moderated for non-subscribers)
> +F:	include/uapi/linux/dma-heap.h
> +F:	include/linux/dma-heap.h
> +F:	drivers/dma-buf/dma-heap.c
> +F:	drivers/dma-buf/heaps/*
> +T:	git git://anongit.freedesktop.org/drm/drm-misc

So I talked about this with Sumit privately but I think
it might make sense to have me step down as maintainer when
this goes out of staging. I mostly worked on Ion at my
previous position and anything I do now is mostly a side
project. I still want to see it succeed which is why I
took on the maintainer role but I don't want to become blocking
for people who have a stronger vision about where this needs
to go (see also, I'm not working with this on a daily basis).

If you just want someone to help review or take patches
to be pulled, I'm happy to do so but I'd hate to become
the bottleneck on getting things done for people who
are attempting to do real work.

Thanks,
Laura
