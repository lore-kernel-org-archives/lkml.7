Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D82C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A91220644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="BXGlVD13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfGKP4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:56:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41853 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfGKP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:56:54 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so9427063ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fJtEaYpuW1JqorFnoIRC1eRM7QglomBLDPa42dGcdPQ=;
        b=BXGlVD134tv0UrHdeVauqmM9VF2iK9Q2rgU/9vwzW41UEFGvzyX6LjAO6XO+MI+YLy
         MBbLcEe4ElqZoxUKrmo5BVx3/1YnKiQyjTGP9WawjEWKqsVfua9QWs8Q6bFTV3G2vVZh
         m4LrRkrf3mmyk14neX9XpZGHJf5TO0ZtsECX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fJtEaYpuW1JqorFnoIRC1eRM7QglomBLDPa42dGcdPQ=;
        b=X0XBisABx9WUMzJDFtK0MQQW37l5/ninxaRyP8vwYnJ/7NTkwKjr0+71cRDxa+NbGS
         si/6M0hFSSvVeVjpGyl1g0owMFuZ+VZT7XVT6HnSAVVq6ljO8R112nPnFu4aPJLh4C3R
         TNYCjpbPgQfIrv9Z6ylDYVa7tn86JRwLqICdAdA0QVuBP/9uYtzPPgGRsziDNl+3woA1
         JFjbOZnTydjH4DyV7huOp5SPd/T2En06TnTbUsagxxXuDnTj4DQxwnx7V0+xMC7rs+zY
         gHbYRB8bMHNvg3hKo2LuicHatTxm56SxYJX67jJcRVyVyBKYJKoCgym6o9tJ5RsheGUw
         Jqqg==
X-Gm-Message-State: APjAAAX8d36BzNWchaBBlYXyEYV++ONsUSgeoiPaD2fSQARqfMGE7qlP
        Lf4ZOPEJNgizWOMs+yp9oRYXB44EG44=
X-Google-Smtp-Source: APXvYqwiAHd2KEejvraiMb5Q04ydtGX2I/yoJqHdxLfhsjHFt7eALr8s7wkHoddRpYZcnGQM8qmiQQ==
X-Received: by 2002:a5d:9ec4:: with SMTP id a4mr4930044ioe.125.1562860613315;
        Thu, 11 Jul 2019 08:56:53 -0700 (PDT)
Received: from [10.10.7.141] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id m20sm6302394ioh.4.2019.07.11.08.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 08:56:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] udf: support 2048-byte spacing of VRS descriptors
 on 4K media
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190711133852.16887-1-steve@digidescorp.com>
 <20190711133852.16887-2-steve@digidescorp.com>
 <20190711150436.GA2449@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <6abea3a8-53da-f7ed-33f5-a9ecfd386c56@digidescorp.com>
Date:   Thu, 11 Jul 2019 10:56:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711150436.GA2449@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/19 10:04 AM, Jan Kara wrote:
> Thanks for the patches! I've added them to my tree and somewhat simplified
> the logic since we don't really care about nsr 2 vs 3 or whether we
> actually saw BEA or not. Everything seems to work fine for me but I'd
> appreciate if you could doublecheck - the result is pushed out to
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
>
Tested-by: Steven J. Magnani <steve@digidescorp.com>

The rework is more permissive than what you had suggested initially
(conditioning acceptance of a noncompliant NSR on a preceding BEA).
I had also tried to code the original so that a malformed 2048-byte
interval VRS would not be accepted. But the simplifications do make
the code easier to follow...

Thanks,
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>


