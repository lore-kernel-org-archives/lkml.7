Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD92C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB1820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YJgos/DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCDIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:55:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35374 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:55:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id m73so2928562lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0RPRlgul4650j7zSsp/LsMWPDxwWTFUY5UFHVP6tQY=;
        b=YJgos/DL91fncA+6jfgbPz3CI+jCIE/8jYMQg8+A0lmYjWd8T1rG3lX7d9NWO+D+MO
         nUse/Gt9widLAN0rxl9LuzGlhd6qjE4csSrq7nOqzh9H5YgVvFU7rh8aMzIrfSkTKmL+
         G2HB3+6G/LwWoKfKrLKNE3aunbwymJbOriydGKVAXtOGhBPz2TVFezeRgcH1hmVt0lKx
         qb0cvkV2mzreK6jmMwDfUnHOHvvGDWh248t/wDvV05UMSEeoJr4iqQ1ysfme8ov8e5Cz
         raPcCxbIO5vtpmxmcDBQGj9v9Vn/Xx54QK1EyX92/2BSMrkeqyTnjGo5UMWaO2rtB3vC
         wrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0RPRlgul4650j7zSsp/LsMWPDxwWTFUY5UFHVP6tQY=;
        b=H4rS2mKOHTkB3UZ4ED1PjyAjBHj+SpO+4aF+gFS+Q0JZ8SBdKY2ZLYyEnlvH9UIeNK
         Tama/tAaAnAsAYZLgZ1vucf3PP1Bhc5DKayDWFCxCb/yo5WNERQdl58lIK6mcORBR3ex
         tyKkL4gArng+l1MGjf2djaxTbVW73Jy27LuFudNCVVMSVmxtT4OmHwcAhE/GBYQK2m3r
         f22fa/Q8FLxzxs2lBFyxtyqGkg+po002BngpvwfbUTW5kp0DZLkuPmnZ0Uuo/cBT5qy3
         lBAD+z0kB0YbvAiaFtSFiB4ZAuH7nb4EQC0RKbajx5e6sFJjCs0rvFutNWkeOvhe+Kd6
         uNWg==
X-Gm-Message-State: APjAAAW2OAG+oSzXsIjyswLpzZ18TrPIt1YAkrZ6D2R9TbdZf7u19ovG
        G6jjr/M9gzvbnY4rIUu5X66cwvL9MDw=
X-Google-Smtp-Source: APXvYqw2V4J3EH/f7Bn5+SGgU+uoyfq7QRDm1i3Avh+Gzk0HZ47wEXU7y0lhgCR4EnXcVsKstLY6cA==
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr598833lfa.64.1551689742884;
        Mon, 04 Mar 2019 00:55:42 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.72])
        by smtp.gmail.com with ESMTPSA id q6sm1393877lfh.52.2019.03.04.00.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:55:42 -0800 (PST)
Subject: Re: [PATCH] net: xfrm: Add '_rcu' tag for rcu protected pointer in
 netns_xfrm
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>, davem@davemloft.net,
        steffen.klassert@secunet.com, fw@strlen.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551678403-23132-1-git-send-email-suyj.fnst@cn.fujitsu.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b9f2ccd4-96cb-941f-29d2-3274fc37c11e@cogentembedded.com>
Date:   Mon, 4 Mar 2019 11:55:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551678403-23132-1-git-send-email-suyj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04.03.2019 8:46, Su Yanjun wrote:

> For rcu protected pointers, we'd bettter add '__rcu' for them.

    2 t's were enough. :-)

> No functional change.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
[...]

MBR, Sergei
