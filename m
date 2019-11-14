Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED16720715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qThZbChf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:24:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40750 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:24:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so4138400otq.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w40CyROdbhEGnEjb3+LNbwGjl3SSGgfFFSofpoToFUM=;
        b=qThZbChfueqA8geQJQth/pYRoMkko/v7LaMttggXVh7wli9Jgu1V3g20kXHf7L3WMv
         vdeeXw2VydDZT8RP1jpmK64FIL7vaNa8WcK73iw7lEPAxso7uESESmpFeV/YkjQnOzBj
         OOf/V0IFlK8J5Ojdq7nTGqvK0xRasy/q0V0AHygtWOMNznPKWZJhgMcTkc0fGlJwOf/o
         a9kj22A9LKYX8Do1Qsq/XHb7ZGcug3BshBHSJE6VUZuV1mHI04n01l/2OSgrY98mWBTx
         2Owupv297hP+48bMtPRUmh4Vc+1+UW6KUu7DcRydeT86q+RWTX5r2J6LfI1ffVCljB7E
         2zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w40CyROdbhEGnEjb3+LNbwGjl3SSGgfFFSofpoToFUM=;
        b=nll4PIRlIzlgbk7m4P63LvhJ0qumYSsDjnfMo6npRl/vr/GFSOBVgbPqaPcAPUnADT
         1khawJxa3G8K5zo7yjeI+sXxKQrYQ6gJeFSG/DzaBebWibCzRI0m9DwgofBfuleRvuH3
         yqfmIclGJsUpvyJNYjKlwRZLTU/8PwUBOsxlJHVWzwo2E5LrbXRa9fFny9sF1Kf4mkQ9
         lG7V4N1YPFcMy8erkbt8YkHNGg+7S70x/gPg7Jllv74cu1I1rvVuM02yvjskUkr2sh7P
         eEJl1ILsFqHnPy9M3XJ9uXyNtqXlSVlRVR7GPQE0rHZ2RKDVPPK5jsSFN7YEseRHc/Et
         aHhg==
X-Gm-Message-State: APjAAAXi1k9fvQnaA82Oi2cTzVL/me0LDbnl40gZM6SKvIUvXGP4Ck8z
        BbCUjlE3SVAIfbeLBSvl+a+W8h5ImHDKLMx4zWXo+g==
X-Google-Smtp-Source: APXvYqx4/q1HK8mVj3VNaG/0yZ1QJLN3UhO09pQOutLvCOpK7tuoXAJisdjP3+p6T+X61OaNRPwCMAKUT1MLwkDZTsQ=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr6685154otl.195.1573719857367;
 Thu, 14 Nov 2019 00:24:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf@epcas5p3.samsung.com>
 <20190724014222.110767-1-saravanak@google.com> <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
In-Reply-To: <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Nov 2019 00:23:41 -0800
Message-ID: <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:48 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Saravana,
>
> Any other progress of this series?

Hi Chanwoo,

Thanks for checking. I haven't abandoned this patch series. This patch
series depends on "lazy linking" of required-opps to avoid a cyclic
dependency between devfreq and OPP table population. But Viresh wasn't
happy with my implementation of the lazy liking for reasonable
reasons.

I had a chat with Viresh during one of the several conferences that I
met him at. To fix the lazy linking in the way he wanted it meant we
had to fix other issues in the OPP framework that arise when OPP
tables are shared in DT but not in memory. So he was kind enough to
sign up to add lazy linking support to OPPs so that I won't have to do
it. So, I'm waiting on that. So once that's added, I should be able to
drop a few patches in this series, do some minor updates and then this
will be good to go.

Thanks,
Saravana
