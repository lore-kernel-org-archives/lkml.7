Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BDBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCC82147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyLIflsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDDDO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:14:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36275 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:14:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so485370pgc.3;
        Wed, 03 Apr 2019 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TQ40qmDazPJecSGF8d1lVR7pVACTEC++D5hm/cHmS0=;
        b=SyLIflscTDUxNnVZoEyWuD7RhWKez6brnvftDRcsHVFsaXWyKepW38EXB4JqKI/uop
         yghJtcMZ+su+IEz9FLOVJ5tYxDWgVsMLFppHZ1uSnV9aC9I2m5iICLd0s8K8lJ6qNG+h
         CVDzffzErSvoA/y7tjphQtiikeNfXRQ4zU5oaj2Kha9TumQ0ZxM6OIk28WQTTh6dIVou
         z/FsA4KC7POcCqb9zxAHb4iKoZgbzgFpF1uOwmWeNe1iZqmoSLZ7yQQjnZ+0hz6YwJs/
         1YStbtpHfERx3MzZMyDpJms35VX6qLE16cVdhKBYcXfjkOCbBGMrbJrXbyx0zpF/scqW
         kJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TQ40qmDazPJecSGF8d1lVR7pVACTEC++D5hm/cHmS0=;
        b=UB6PxNwdyCF20LHVUVphajOGmHqYiS6I9u2IcNpBMsaTc3heAgPXboBO0nYEexW4fr
         Nst4/3qydGmSCirhJdircax/pz6nL7rZy/P91hQlF/aO14WKlNzxdaZrXAjIZ8+mv1W6
         wzQv5GtQYylZk5jVW4LeBNXaQFhMo21sMlFMLDZMkY7kkW/273TgXg1zEDI03lzDuzQT
         pMbVVwbLONtamW7GSakgxMACm+eZyIY4L/p//yvHm+Z6Lxb5fGKU6OoH9AeMTa+F9xne
         QNcV/HzE/8kVmODdaXYHuBrUVXXOtzdB9pzhsV+laoQh3rXBmWtSl2z+sBxL4JBNG9Sz
         +bTQ==
X-Gm-Message-State: APjAAAXGtD0kbYazKIYPElywmwNpEfuCBY1qhDMubbOl4A88ubtibx72
        npB0HXG9C3hXQsaEvujWSxs=
X-Google-Smtp-Source: APXvYqz9CcjRFhkOKUrZaHilUMRABwGeQXyCG7lKc3fBtEf0n2EPVNmDxI6JxCzNmZcvZfS/Rg51cA==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr3337473pgc.78.1554347698138;
        Wed, 03 Apr 2019 20:14:58 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id f14sm21974316pfn.3.2019.04.03.20.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 20:14:57 -0700 (PDT)
Date:   Wed, 3 Apr 2019 20:14:55 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Siddaraju D H <siddarajudh@gmail.com>
Cc:     john.stultz@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp/ptp_clock.c: Correct input parameter range check
Message-ID: <20190404031455.cn4cc5wxbn6izvwe@localhost>
References: <20190404000958.15236-1-siddarajudh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404000958.15236-1-siddarajudh@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 05:39:58AM +0530, Siddaraju D H wrote:
> From: Siddaraju DH <siddarajudh@gmail.com>
> 
> The ealier implementaion used to return EINVAL for -ve adjustments
> in the range -1ns to -999999999ns as these -ve numbers will fail the
> unsigned comaparison against NSEC_PER_SEC. Since the tv_sec field
> will be ZERO in this range, the user will not be able to specify
> the signedness of adjustment through the tv_sec field.

NAK, the tv_sec field can be set to -1.  See the example, below.

Thanks,
Richard

void clockadj_step(clockid_t clkid, int64_t step)
{
	struct timex tx;
	int sign = 1;
	if (step < 0) {
		sign = -1;
		step *= -1;
	}
	memset(&tx, 0, sizeof(tx));
	tx.modes = ADJ_SETOFFSET | ADJ_NANO;
	tx.time.tv_sec  = sign * (step / NS_PER_SEC);
	tx.time.tv_usec = sign * (step % NS_PER_SEC);
	/*
	 * The value of a timeval is the sum of its fields, but the
	 * field tv_usec must always be non-negative.
	 */
	if (tx.time.tv_usec < 0) {
		tx.time.tv_sec  -= 1;
		tx.time.tv_usec += 1000000000;
	}
	if (clock_adjtime(clkid, &tx) < 0)
		pr_err("failed to step clock: %m");
}


