Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A012C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00C5215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578077201;
	bh=1beLc+tasgALEwjdnRUcX/6fuY65B82WdwCOThKfaEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MrFviEWP5V/Jlbbf0LmZqMrAbcxhbq5l8QzIo4qK/26aResJXHhERXGxiQnRUh9pS
	 UQqI6fMsDjUjYGjYGRL03qoBy/s0U6sxvkhHf2Mu+cjw1sAiZVtZcRQFP12k9Ivd/g
	 yd1NmzlmVnYOg5hmOOWugx2vdpEzzJ20JrwYxM2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgACSqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:46:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33510 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:46:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so32468755lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09Fhb5KJtdVXpuTOxj9n6AxgCLlTa7iHkIeQIqz8ZXQ=;
        b=gQn987UynqGEaSDi7PzqcZnNE24GYhuSwEuB8jnz/K2ht/y/6Y4Eaq+5ZrqWLDJKFm
         DLfYiRceU9rAJ/iKZ+Kcq3FhJfAejLiEOsXP6+apzeqFfjISklQkC5r1Z/2//zpdza/L
         28M2GzAciQMj90SjWNUCeoNq+D6s1/JuCsIig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09Fhb5KJtdVXpuTOxj9n6AxgCLlTa7iHkIeQIqz8ZXQ=;
        b=Onz+snAgm+AD85QVDj0CY49TDTWBFJDFZYQx7gyEC7Ctmium8v6iNuJQLOIx/Q+g1f
         /zCH3PTfACrVOVppq/JFCSlPLais3G5YYhUjz3hGnqEH1ehdcElQEtc6LGEJ1UEm3dyK
         WIVxnYLAD5daixqeKmmKy12vA9eTZiStxq/BmeIziGHoPwCzEtJA5MWbfr+SLwHwtkMt
         jWLvQ5rYBDG6G7z0VKLMTBWBXeKgLvZuNtElFUwfmWadP8FW0FDU7PIlm5gUXX/eYeRa
         nxZUEOCazXwXI9W/6Vma5NlG1ZpMdgZltsHC5reGR93DIMpP3iKnQ+ywDD91dw1OWMww
         ZBVw==
X-Gm-Message-State: APjAAAWUQvobiT7Q4JfW60c4IcVNt43hTlaCqdepRtRCuCmfW0reuDAZ
        YaWfX/eM/4QgUoKButecqflkPkXkneM=
X-Google-Smtp-Source: APXvYqwPsDqjqcBq7EDlH9E2bkJAXX3oi/hbO3NQbfkRfeG5/D1zuM7RcSzg48kSLtO+vT0wjYNs+g==
X-Received: by 2002:ac2:59dc:: with SMTP id x28mr50810173lfn.38.1578077196745;
        Fri, 03 Jan 2020 10:46:36 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w16sm25540588lfc.1.2020.01.03.10.46.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 10:46:36 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id w1so22796260ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 10:46:35 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr53118229ljj.148.1578076856282;
 Fri, 03 Jan 2020 10:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20200102215829.911231638@linuxfoundation.org> <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <20200103154518.GB1064304@kroah.com> <CAK8P3a00SpVfSE5oL8_F_8jHdg_8A5fyEKH_DWNyPToxack=zA@mail.gmail.com>
 <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com> <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
In-Reply-To: <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jan 2020 10:40:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
Message-ID: <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/191] 5.4.8-stable review
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 9:59 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Before I started investigating, Jan Stancek found and fixed the issue.
>
> http://lkml.kernel.org/r/a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com

Applied upstream as commit 15f0ec941f4f ("mm/hugetlbfs: fix
for_each_hstate() loop in init_hugetlbfs_fs()").

I didn't add a cc: stable, because the original didn't have one, and
the "Fixes:" tag should make it happen.

               Linus
