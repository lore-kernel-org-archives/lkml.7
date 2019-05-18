Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB078C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 04:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C83E204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 04:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UErM4dK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfEREQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 00:16:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33176 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfEREQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 00:16:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so4642076pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IHN+2zb98EUzBrL1AKIr2dSLN5sypIhYJWUd5zaRtbE=;
        b=UErM4dK6pGkYInu7hET63Mf+T3s3qXd1V5TgiYj7o6Nr0zVC60FJirJ/mVOjZeoSru
         8YDIMgiEK2loOXuOhUCtYPGCWaVmuDj3JtNEbo8EV8XwxYfV+V352ZHB8qjN+/4gTOWe
         PNeNxol7huPsh2gO4ZbOT44o9qE+s5trLRobmwAZZ/mXsPZvwRd362+VPcqpwoN6zJFh
         /hHGRs0iL3nCw6+pT4n7qLrUfOubQXJQVbok8ci0O7DjQ9tJFMuWxInF+GjfkiiWF31l
         KVGgHk8yVt2iwWkNYke7zEQDzlGkYqpriePKSZOOoUzZFPPM70d0tUtkORlCZJxvdtek
         QhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IHN+2zb98EUzBrL1AKIr2dSLN5sypIhYJWUd5zaRtbE=;
        b=DzSk9/UWBNtH4fZm7s2sfxe6UzLHXakGf1jT/QUjDQ77Cq+G4U2PYPjVU3uKsGU0+3
         iJXQNGrjYi1aQU9z06xTpuRzSQ5wD2g26MPNCdgM8h+z5Ds6lfoTXlq926250AKVtuaq
         +ZyDfKl5CbZagfkvBm4GG7YY0pykG3WnEqNkhVS/omaBrQJAhOxl7IrjGklCNkhCRfFZ
         6Ifo2ITYf4BXVZZWy3PwKlyAYvKF9VMFZHqvzAcmY7ffjcW4031xAlSKjox3cFvOgbj8
         qq03GPCQQmiQnXpdgS7vVO33qiMx1mCKaz4+rh9aHB2MLi8bPXFCOLzfLdOufTJXShzm
         DqtA==
X-Gm-Message-State: APjAAAW/6yt45ElBcuan35uHpWO5DwGW9TazeQfOAlMd+jDnusLyLA/6
        1izdR1Xyq8WYnN9Km2FLHzt+XA==
X-Google-Smtp-Source: APXvYqw0+uz2DLSFXWLN/soxGTf2r7GpZS8rqe9CpsogxdXqQEMdHbEPUDMvULtXrtXl71MIswmu5w==
X-Received: by 2002:a65:51cb:: with SMTP id i11mr58187479pgq.390.1558152969501;
        Fri, 17 May 2019 21:16:09 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id c15sm12574491pfi.172.2019.05.17.21.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 21:16:07 -0700 (PDT)
Subject: Re: [PATCH] block: bio: use struct_size() in kmalloc()
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xiaolinkui <xiaolinkui@kylinos.cn>
References: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
 <e46a73e2-b04d-371b-f199-e789dbdbd9fc@kernel.dk>
 <d83390a9-33be-3d76-3e23-b97f0a05b72f@kernel.dk>
 <SN6PR04MB45270B6B0A4EDE903568A29E86040@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4d33107-75d5-fa18-536e-6d21c96e4972@kernel.dk>
Date:   Fri, 17 May 2019 22:16:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB45270B6B0A4EDE903568A29E86040@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 6:43 PM, Chaitanya Kulkarni wrote:
> - linux-block@vger.kernel.org <linux-block@vger.kernel.org> to reduce
> the noise.
> 
> I apologies Jens, I didn't apply and tested these patches before
> submitting the review and assumed that patches are compiled and
> tested, I'll do so for each patch before submitting the review.

Just to be clear, I'm not placing any blame on you. It's easy to miss
that kind of thing in a review. The onus is on the submitter to ensure
that anything he/she sends in has been both compile and runtime tested.

> Xiaolinkui,
> 
> Please send compiled and tested patch only on the latest kernel on the
> appropriate subsystem, otherwise mark the patch appropriately
> [RFC/Compile only] so reviewer would know without such a tag
> it is easy to assume that patch is compiled and tested.
> 
> You have also sent out the couple of more patches with this fix.
> 
> If they are not compiled and tested with right kernel branch for each
> subsystem, please update the appropriate mail thread either to ignore those
> patches (if they have compilation problem on appropriate branch) or mark
> them compile test only (this needs to be avoided for these patches), in
> either
> case please send updated patches for this fix if needed.

This is solid advice. Sending out untested patches without EXPLICITLY
saying so is reckless and irresponsible, and causes harm to your
reputation as well. Trust is an important part of being successful in an
open source project.

-- 
Jens Axboe

