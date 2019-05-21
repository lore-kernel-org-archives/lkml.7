Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159CC208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfEUQYe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:24:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47260 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:24:33 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hT7Z0-0001Zw-Px
        for linux-kernel@vger.kernel.org; Tue, 21 May 2019 16:24:30 +0000
Received: by mail-pg1-f199.google.com with SMTP id 21so3346836pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f4cWlqI1jUt2yNrVL6MD7H0kVA2/rVI2x02kwXGnxEI=;
        b=mJ12bTDp+fmbdJ5h9LO6QXrXEMkCyO6K8Sqm1frEr6/Sq4NvOtnJX5R3fTu3ee0vX/
         b6xO+Ren+yFkQ1KAPH4+KkQVNaSVbOURkPskHKXjjyc4dw7bRFeLbVaQ3KgQcTRwO4Ru
         jolj2cWKIeItgwDXAd55Rn6x6lT2JkO6eNxlJY5HWYQ1kJl+Wqc5DuZdEIbolm/EFZDW
         1Y7O68bQPRugMlmRL8Prstp04Wsl8oOyCrkNN0z0W+bebpWnZEc3jdTALtRFkvuJWy9C
         5A+sUP3sGE+opaDm12yL6c1ngk9MUSfd3GTnRKheZmDsatdkxaEqaZaAvSfe80yB1J4g
         3U+Q==
X-Gm-Message-State: APjAAAUmugJJtwlntQxIZj/jyV0xSv5k7r2e+H1DHa+ksDUJLJaa0Xs2
        ku2O4zyEGIvG9UyVv1+6/nrLn8wgxONoCTXehK0/nO3HAbNrq8dbzmkIIUprlTzvQWPVQbzpiJi
        dPLspi+wmcvBP/A9whEW1d7ZwJ0s5naUEIrCRIvV6fw==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr88663378pfu.4.1558455869557;
        Tue, 21 May 2019 09:24:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0icQMTSNtq9BqYzHs17GjjnPoz2+R7usA4YqD3bB20+3eE7xxYWkuGE+Tly2KDyXI6Dt6Cg==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr88663344pfu.4.1558455869288;
        Tue, 21 May 2019 09:24:29 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id g83sm38252903pfb.158.2019.05.21.09.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:24:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJKctsp9=ZJuJB6YRtA+RHuv1NJ+9cWp9hub8oATh1MXCA@mail.gmail.com>
Date:   Wed, 22 May 2019 00:24:24 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Content-Transfer-Encoding: 8BIT
Message-Id: <1B225693-9307-46E2-B468-1529B1FF03CD@canonical.com>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
 <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
 <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
 <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
 <CAO-hwJKctsp9=ZJuJB6YRtA+RHuv1NJ+9cWp9hub8oATh1MXCA@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 21, 2019, at 9:58 PM, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Thu, May 9, 2019 at 9:30 PM Jiri Kosina <jikos@kernel.org> wrote:
>> 
>> On Fri, 26 Apr 2019, Kai-Heng Feng wrote:
>> 
>>>> Ronald (Cc-ed) raised quite a good point:
>>>> what's the benefit of removing the error message if this function (and
>>>> __extract) can only report an unsigned 32 bits value?
>>> 
>>> I didn’t spot this, sorry.
>>> 
>>>> 
>>>> My take is we should revert 94a9992f7dbdfb28976b upstream and think at
>>>> a better solution.
>>> 
>>> I think using a new fix to replace it will be a better approach, as it at
>>> least partially solves the issue.
>> 
>> Guys, did this fall in between cracks? Is anyone planning to send a fixup?
>> 
> 
> Kai-Heng, have you been able to work on that?

Sorry, I haven’t been able to work on this.

Please revert the commit and possibly use *_once() macro to reduce the noise.

Kai-Heng

> 
> Cheers,
> Benjamin

