Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD0B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bNu4Ji+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCNJ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:58:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37342 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:57:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id a17so4235556ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NuSK0qOPLXxH7vhF0A67emmli0VyceoxlDDTT3FCfac=;
        b=bNu4Ji+16FXSqNVd2X6tyw2n1bEq8Gi+CACP2GwVjOxPUcgsgl0SO7r1Mxln0OMDFr
         N62zKvkajrRJOdMXvvhAH4UrZGcGMcp2D1tHW6nEQBFdUIEHmHyJNLb8147ItktBzcgd
         XMOrFXwfwd5lU37g+woqdhOekkVmeSWVeLs/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuSK0qOPLXxH7vhF0A67emmli0VyceoxlDDTT3FCfac=;
        b=YCkz592/j3On2mnTCmFKEkzbh1I7/2hr8lwZPOMIZgfULBE/n02d3/MOOqaHTxi/4Q
         nb8f9RcKZmhoJ8eivOhHQn5XZ2RrdMvFWh/KDeGEOxZlFyicbIwF82nSUKaUgjLqXH9e
         5Yy4fBMvkUr7Xe7MsbymjkmT3oXQcG670uLM8NqyfQeJpAD4+4PQ3aiBZMginxcsa5pH
         6+K+CpwsjN71kUSkR7gFQeMv6yxfa8BQn0Kjk1b/2m5U8bcLOiQbrHjXAo3kuXuIIOVw
         n2bBh5ML9tvzF1q8f/KKtJd27LHby5s+T8dW7ubpGEJHE2zx12vod1v7ri+562q1KJjc
         pCig==
X-Gm-Message-State: APjAAAXoKVyBHcZquLc78Yp9s8cbbexa+M4To8CXrx3phS9fB5Xz8YON
        hpLCxAK/F5iRu/MsCmnwEoSm9w==
X-Google-Smtp-Source: APXvYqzfoDW4YIqGAQydrHS7IYHc5KVDEF4P14BiLGFI1yhUqrDjB0Hun2D+aAODl1CcBD3292ux6A==
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr14743771ljg.153.1552557477304;
        Thu, 14 Mar 2019 02:57:57 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q2sm1302809ljb.86.2019.03.14.02.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 02:57:56 -0700 (PDT)
Subject: Re: [PATCH 2/4] leds: netdev trigger: factor out middle part of
 device_name_store
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-3-linux@rasmusvillemoes.dk>
 <20190314093111.7ivkdg7ozk4vylio@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c6eb8d99-67ff-defd-31fc-fa55deb16b5b@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 10:57:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314093111.7ivkdg7ozk4vylio@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 10.31, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 13, 2019 at 09:26:13PM +0100, Rasmus Villemoes wrote:
>> +static void set_device(struct led_netdev_data *trigger_data,
>> +		       const char *buf, size_t size)
> 
> "set_device" is a very generic name. Can you please prefix it with
> "ledtrig_netdev_"?

Sure. Will do next round.


