Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9BBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751C21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfe5Qu6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438221AbfJYI6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:58:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55158 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfJYI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:58:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id g7so1191217wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfc4XdDPDgITfXuGMDkydNahYHOMhJfV27d5eLCxPe4=;
        b=Kfe5Qu6VnEOWhAwoTxpz013V7Jndiwq8G1LSlscS4O48yVzRNX/enux6Ir24edhXr1
         PjBmyY6G+AGdb8lvJ7CCDVVrnftJERZL/yyU5tCWRUW+jhEItlx2MP37hpA3Ro2HuZio
         JTdvXDNY9sIBcxgB1wJRAzpjNdvBeEqwnRWJBDHgSPqFQjn43SiP/RM7/yYh+Rb0ADnC
         hgYPx3wtNM67T+hutiYrh8YHkbzXOxqkM3fKsrB8AWCjK11MS0qhAJfzvuUwy+RfiYdL
         vJJAz6s0gVinLyAGzLpJT2x52QfgdC091VFoC8roDdtcY4wJsFJb4/8QZhZBEhWpEc2c
         kWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfc4XdDPDgITfXuGMDkydNahYHOMhJfV27d5eLCxPe4=;
        b=S6qzzTwMJRLVsQALtGQEHq8C82iV/7JqvU6cdKOGPnqdX1Rhqqhb2+rpfm9Y34lOpz
         QWMkIc6ChJUPG5d933Ad0tZ19h8v8byIeOluYAHtxpPObR1s3kX8GJSIWLg8n+HcVdmb
         nddYRhLcw8blIkgQl1cq066oAoDUX7KzyeWzg6ZozgS6UKHYCz7ax2LT3GafzMI5Y3kQ
         Cesl8fD0/eQ69ClZ1/lp0MROsJReA3kc3dkDeQ0+/No7c2rKRjY5/qjxO9thtorsdVKW
         n4PiKGcLSDQxaZqA1VRTBlrSebp7TVvbie3oJ2lIQoy/kjF1DvYQXUDwOCcDpgR8dPjS
         qRhQ==
X-Gm-Message-State: APjAAAWuNcT6U5IOn9/0OAq7eHNSRKCsaL+m1bdUM4EW9mHXsqxwMM4Q
        uYIK11JnzO5Z8Z4d5ZS9dRUt4FIgAwYumGsUQiM=
X-Google-Smtp-Source: APXvYqw7oRV1JZS4pFNl8UgUqttJB5ChiBnHX9kI6iRC5EGVmpUb+c0nv/nEYSYmc8auJbZtPr3PlNk3/ddpwgpnztI=
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr2292177wmf.37.1571993896359;
 Fri, 25 Oct 2019 01:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com> <20191025080129.GE32742@smile.fi.intel.com>
In-Reply-To: <20191025080129.GE32742@smile.fi.intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 10:58:05 +0200
Message-ID: <CAHtQpK7e-W9cGyCan=yxM7sSN=L_SKaFy8DSNE4vQGrc_pFdQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove regulator
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:01 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> > Add regulator driver for Intel Cherry Trail Whiskey Cove PMIC, which
> > supplies various voltage rails.
> >
> > This initial version supports only vsdio, which is required to source
> > vqmmc for sd card interface.
>
> This patch has some style issues. I will wait for Adrian and Hans to comment on
> the approach as a whole and then we will see how to improve the rest.

Agreed, styling issues are coming from definition of CHT_WC_REGULATOR
elements in regulators_info array, and they are mainly related to 80
characters per line. I decided to leave it like this since it is more
readable. But if the 80 characters rule is to be enforced here - I can
go with something like this for every element:
CHT_WC_REGULATOR(V3P3A,    3000, 3350, 0x00, 0x07,\
                                     50, 0x01, 0x01, 0x0, true,  NULL),

Let's wait for other people's comments here and I can then come up
with v2 of this patch.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

--
Regards,
Andrey.
