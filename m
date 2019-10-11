Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20750C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BFD2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="GVa5+K0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfJKJAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:00:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32915 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfJKJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:00:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so6495435lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D5J4x6iVABhyT7MQ535l1DTGxw0inOgPAWVql4OaM3E=;
        b=GVa5+K0sA3bT0teEuW8q6lBeCPvC/40O+4wY6c68FbMZ+KXqDbDDktIBeN+MBHZl2n
         iQ2m9GnynAMroFRCCyGrM6OSITGyeEOmhKXIAj9oVcwbq4c31d0RQ2x5Mcv+VnOAW87p
         fRcgD9E5A0Wz/TtGb1c5+1VYwrJEdc1trrhZ7/TOHkttJD6Id9n8G0yXSuIVeqWa/mDO
         TJGLfem2Ft1XoHqjIpY2SVWVFCz7sravp3VkL/oT5KLmf37DL7Fti8eqAC3507+C6Til
         qeLoCJ4FSx5t2mOzru0EFZlur2UdQBepGMVJp2dzcVhjOBFxdOxQ80bfbw8o/JXdnLrm
         F5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5J4x6iVABhyT7MQ535l1DTGxw0inOgPAWVql4OaM3E=;
        b=AntWK1CynhmYYTyW1f5S8R5hP5MsetjXAL5cJtLlUpko1+sAhkUg+Egzo5ZU4riCmr
         pXHp9B1fCaeFL8bGCm1uznQjW5pPhtFKu8KeJ3TSEumJmv+F/qFQarmIWJotTRES6HAk
         HTMczKraymcmeCU8P702CWEDG+L6GvBeu7fU76gZ6i9GSAso8mCoqlsvBm3N1VrLUPsq
         m8gDCWs4qEJXl/D1M5a8KKaEqPDc+ROC07SdM4KbwB4vESVRfclWgd+vX2OFlE4qlel1
         nstYer+f0SXLhZ9F9mF+jM04C+zY8RYPA8SazV90QrllON6YUxeQECclI7tmCy94466R
         qXtA==
X-Gm-Message-State: APjAAAVOaP1WFtedLveQ4tql8Q4T6/dWf2o4iaKSuyldUPeUW+5j8tmY
        p1zR19SeJQ1ur5a3sWmrJEBRCg8REypAFg==
X-Google-Smtp-Source: APXvYqwQtqvuB1NOLWSlqNK6UF4AaRNCs+oaXZCrTHa1FIXAYVyqdbzs7ivri4cr5rF8kRboVQEyHg==
X-Received: by 2002:ac2:5610:: with SMTP id v16mr8173294lfd.93.1570784445097;
        Fri, 11 Oct 2019 02:00:45 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:86c:2e5e:9033:59d0:e194:cd55? ([2a00:1fa0:86c:2e5e:9033:59d0:e194:cd55])
        by smtp.gmail.com with ESMTPSA id g27sm1806349lja.33.2019.10.11.02.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 02:00:44 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Remove Simon as Renesas SoC Co-Maintainer
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191010123046.15291-1-geert+renesas@glider.be>
 <20191011073515.2933918c@canb.auug.org.au>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <fc7ec17b-c61b-842e-13d9-1e154ce2a654@cogentembedded.com>
Date:   Fri, 11 Oct 2019 12:00:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011073515.2933918c@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.10.2019 23:35, Stephen Rothwell wrote:

>> At the end of the v5.3 upstream kernel development cycle, Simon stepped
>> down from his role as Renesas SoC maintainer.
>>
>> Remove his maintainership, git repository, and branch from the
>> MAINTAINERS file, and add an entry to the CREDITS file to honor his
>> work.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> So, I will remove Simon's Renesas tree from linux-next and rename the
> renesas-geert tree to be renesas, OK?

    I thought Geert's new repo is called renesas-devel?

MBR, Sergei
