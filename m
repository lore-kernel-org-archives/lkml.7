Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEEBFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A129721882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yiW23nuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKHQ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:27:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39618 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKHQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:27:51 -0500
Received: by mail-io1-f66.google.com with SMTP id k1so6995480ioj.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RiIe/nW+9AsCJyMreIOc9BvirXBLZtzkTWUj49kdOWI=;
        b=yiW23nuA8TdhuuIrPqsnDodwAfZlz7kLEuj1pDzBF778A3B5Pri8hlJ+VYcC16b6z7
         0hfXRCpRdcfNrWPLjHrAaxZ2qEDn8qMMaIvQ/5fOfR48fHI2qUnwlD0zX1ctDcmo30Kg
         bFz8oQrg3pL89wBAb0enYPVHRJ/klENw/8POBBLGoFPn2sv8ZPfTTlwg685l8ZGN2XLt
         WaHIJJmzPx/q5QKVcZSFYQd0fRgY03/ZuEZ6c+/Ev3Ks7ELhbvgbFeNrMjrlmBN7AEKu
         NIz3ipy6kdnoXPn3akIMnGDjNXhlht2ZIIEK7C34P/dKZafL+iwwLw5OaL0En/vaR7Xw
         xqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiIe/nW+9AsCJyMreIOc9BvirXBLZtzkTWUj49kdOWI=;
        b=r4zsri7gukyh3c/OVl1uVpW9HzPoBv8/lS5ZNnEfbVIF/EgguN0uuwRoHnkS48eW3N
         EwE5LdFmyLbVUqJwchd/xgYX+FEPpdEU/WFfNXEFvW2aLnvl/tJY4cE5eek/t1xfNmMG
         nxljHl4YJSoKlr4R9kgsfA/P7tTq8h8OZF6YkJMlQxskL1aW5e7PA/8hyYf6rjvxfyhf
         Ui1p9prNcLbjRTzDeABJLM4DyGR2nub5v6k4u2Hu1ngkhVkLenjGT4JQvXG8oCM95Qw3
         nWSXjIxSTHf25OKpBk83pPo5Vhh6q8IwDpnAi2fF3Ewx4XhFxUROQe6kZrMeGyj9bRLJ
         E3gA==
X-Gm-Message-State: APjAAAU2UqPSCLjgCwkMjAwsy7R3P3rwPD+IhGpGhU+fVDT62C38ooSP
        mfaGmdUSRdaIpYBZNf0y8q3Sow==
X-Google-Smtp-Source: APXvYqzFoIhq86iW74zmJxBejj+zma0nFYlI3I/P9W/xmwZlaX3LhI2wzB6oG6o03ZgY2UPVKy6hIw==
X-Received: by 2002:a02:9f12:: with SMTP id z18mr12194050jal.10.1573230468826;
        Fri, 08 Nov 2019 08:27:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm827186ila.41.2019.11.08.08.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 08:27:47 -0800 (PST)
Subject: Re: [PATCH] block: drbd: remove a stay unlock in
 __drbd_send_protocol()
To:     Bart Van Assche <bvanassche@acm.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@tron.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191107074847.GA11695@mwanda>
 <3a2d491f-3d24-3673-07f3-f601d5fafc97@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26822f67-1cd7-eeda-2caa-2bc7d420f173@kernel.dk>
Date:   Fri, 8 Nov 2019 09:27:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3a2d491f-3d24-3673-07f3-f601d5fafc97@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 9:26 AM, Bart Van Assche wrote:
> On 11/6/19 11:48 PM, Dan Carpenter wrote:
>> There are two callers of this function and they both unlock the mutex so
>> this ends up being a double unlock.
> 
> Is there a typo in the patch subject (stay -> stray)?

I fixed that up while applying, fwiw.

-- 
Jens Axboe

