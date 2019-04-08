Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776A12148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEfy4aEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfDHTeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:34:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37862 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDHTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:34:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so7873306pgc.4;
        Mon, 08 Apr 2019 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6l7wTzWQN9GvZ7EyQjK6wXZcZeUcC8uhQgz6Bw25NY=;
        b=mEfy4aEiMVKfZx2ynfFfc0x+vK66RFf0udP49NPJWCdYHY1HgrTXH2PmDTNt/bpxz9
         ZAoCifw0kH74KKfUKaHSF7k1hH6okHgx3959FqEnL8Ey82D+3y7n/7fnQ8nvBjrVu88p
         /4OB60PBm7sIrGIMpmlFTS3pF4IixrHP753qmd0DKbFw3k4UNZEn2QcXsGWVchkrhUNW
         BztX4gsvKo6ZxMyIMO5PuZWdqzZPuPtwhTFfOVpti3QZAEN3pAFskDl7Io0II5wtnRz7
         KZRwPPEX8O3IFE4VRPgY/sRM9+3N4I65GQFAU/UImp4N/dgdGtGTXaEi0b/ieWsln3aX
         FcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6l7wTzWQN9GvZ7EyQjK6wXZcZeUcC8uhQgz6Bw25NY=;
        b=Ds4hOmgtPnejDVFl39eFrVCzdTSNITNTlxy9JD9nuECNRUZNPV2d44DuEPrRWwEVja
         8QfiMSZlVYJon4PYGtEBSD7tVsMEh4tQduZ7A0dnGi/yTFH04p4ggBHl2VZB/mdOYAU0
         x9wsAz7EuRZxcE/pvNJyYUwYC5a2fft2A9Ard40ihIW1mIYeSpbQA+rym/vwqKl5NtrE
         EMURMZx3Vsgbi8TWq6VwEEdkF2wwlZTng6uK8wWQHlUdR5PHQ5S7B9Umk72O39IwryEy
         sdDpidc9bQJLFUoZGirlZ8NpBOh5+/CV98tLBQiPHRKAipAYQZrNp2eLWjc0lOmKFZiK
         mRMg==
X-Gm-Message-State: APjAAAVv/Z/TwF5IPPujfcMuXGjlDXCAjZwqV/pv3NNryI2HTAh8TwqP
        0F1QMdm4KR/mXR9CBs9HXURQ6+BjZmKZ4Se44v8=
X-Google-Smtp-Source: APXvYqz3tcGPBiyT8e/ULtoHlH0jXmeElSaATOFoVc3Ssf0X+Ol0i3xlwU1hegbWJsoA0p/GZU2xfwhXcdbVVg6QwZg=
X-Received: by 2002:a62:6587:: with SMTP id z129mr32060389pfb.88.1554752046652;
 Mon, 08 Apr 2019 12:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-2-rajatja@google.com> <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
 <CACK8Z6FGFiS_jN_5ctWmjKbrcUyjGkV0MsVs7_2TsaS7UAoydA@mail.gmail.com>
 <CAHp75Ve9zq2MWbiHhNV6RSV8xgmWQdqaMi=UdE7RFiZ9QgmH5Q@mail.gmail.com> <CACK8Z6Fb603NV-CreX6mxgj=JF0VmfP0kORHZg5T8L5vOeTsQA@mail.gmail.com>
In-Reply-To: <CACK8Z6Fb603NV-CreX6mxgj=JF0VmfP0kORHZg5T8L5vOeTsQA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 22:33:54 +0300
Message-ID: <CAHp75VcU9VvV3M5jVxE6ezii7d4JtFXPG7D-0zRF_amW+bEGdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Wysocki <Wysocki@google.com>,
        Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 9:58 PM Rajat Jain <rajatja@google.com> wrote:
> On Mon, Apr 8, 2019 at 11:41 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Apr 8, 2019 at 9:36 PM Rajat Jain <rajatja@google.com> wrote:

> > Instead of adding module parameter and doing these prints, perhaps
> > introduce another debugfs node.
>
> Uh, I actually did wanted to print them at the resume time in kernel
> logs, because I think this is something kernel developers would be
> responsible for debugging and thus would be great to have this
> included within the kernel logs. User space tools may differ on
> different distros and may or may not be looking for S0ix failures, and
> particularly may not dump this new debugfs attribute.
>
> The other thing is that seemingly this could also help in situations
> where debugfs is not configured?

The keywords above "developers", "debugging",  so, the concept of this
driver is almost all about debugging, debugfs is not for users or esp.
user space tools.
So, I don't see any issue here with creating another node and use it
for *debugging* whenever it's needed.

-- 
With Best Regards,
Andy Shevchenko
