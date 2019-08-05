Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C89C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F160F206C1
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfHEM6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:58:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35199 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:58:41 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hucZS-00075M-7e
        for linux-kernel@vger.kernel.org; Mon, 05 Aug 2019 12:58:38 +0000
Received: by mail-pl1-f197.google.com with SMTP id n1so46153918plk.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kLQHkY6IzjLJ/SxKbqZprYGcodxnQqbLc6H8ulCgR/0=;
        b=Tt+SaEkZv7qhLp3lrY5fd4OmQtH4Roq04c5Fc3NJwOmjdZpVj9YDtwi7pl73MwAbSg
         h9TmNlSaubJu44IQxb1uc46j4yfG316byaJ1plM4eshs6FzEp5bzudJDBimiXlLc+yyN
         XVkpthObowPyQbmA7EUJEnEotDy/3YBWAT/NXORHUxvbgJmyDxJH8iwtSeXk6LLHwaga
         cHfCm9PZ9WLzE+ZRexo6ZnAQXziRZBaSDdbg8wYQW0096M0PBujHJGzzCRZMEYC07uWo
         cc0iKcXGi4EE2uOLVtU98VbfHU2H+nItgK3gQ6RcwiyxN8WFAEM/GKPLZOTKnkUzQ/rh
         eGJg==
X-Gm-Message-State: APjAAAUxsXtoCTFf2reGMwbQDN/RM1QXK/4sDFU3trvVF13CXqnO3xnu
        lGs71idKdu6lGWfA8SjhwZrs0kv7NUxjzqoxmUkiCDU+GLPUa9Nxcv/3Oan/rCvl555gE/D/QWY
        7bAvLqVo7JoYzKp56sHug0o6Kw9X1a6+RhfMH5flb7Q==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr17818352pju.124.1565009916984;
        Mon, 05 Aug 2019 05:58:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6wB7RQJuS893yP0lCto2JC6p6RMOWq5tsJVXCzjroOijdAwdM4YtEXc5wZU7Uw3eYJjb+Ow==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr17818334pju.124.1565009916772;
        Mon, 05 Aug 2019 05:58:36 -0700 (PDT)
Received: from 2001-b011-380f-37d3-1da7-2297-19d9-489e.dynamic-ip6.hinet.net (2001-b011-380f-37d3-1da7-2297-19d9-489e.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:1da7:2297:19d9:489e])
        by smtp.gmail.com with ESMTPSA id x24sm81693897pgl.84.2019.08.05.05.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:58:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <46147522-7BC2-4C30-B3E5-6568E9642982@canonical.com>
Date:   Mon, 5 Aug 2019 20:58:33 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <27A5C1CC-E0A4-4CAF-B81E-90EE76C8A887@canonical.com>
References: <Pine.LNX.4.44L0.1906061013490.1641-100000@iolanthe.rowland.org>
 <46147522-7BC2-4C30-B3E5-6568E9642982@canonical.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

at 17:22, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> at 22:17, Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> I agree with Kai-Heng, this seems like a fairly light-weight solution
>> to a reasonable problem.
>
> Thanks for your review.
>
>> As to the issue of how much it will slow down system shutdowns, I have
>> no idea.  Probably not very much, unless somebody has an unusually
>> large number of USB devices plugged in, but only testing can give a
>> real answer.
>
> In addition to that, only USB2 devices that enable LPM will slow down  
> shutdown process.
> Right now only internally connected USB2 devices enable LPM, so the  
> numbers are even lower.
>
>> I suppose we could add an HCD flag for host controllers which require
>> this workaround.  Either way, it's probably not a very big deal.
>
> IMO this is not necessary. Only xHCI that reports hw_lpm_support will be  
> affected. At least for PC, this only became true after Whiskey Lake.
>
> Kai-Heng
>
>> Alan Stern

This patch is included in Ubuntu’s kernel for a while now, and there’s no  
regression report so far.
Please consider merge this patch.

Kai-Heng
