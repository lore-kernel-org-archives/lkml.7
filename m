Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D20C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A172070E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjufNMLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKOAXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:23:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41327 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:23:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so7073243oif.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 16:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsrGyoqQOYTH2PPKiYL70RKRI4in0yNtJQIpGh3K26A=;
        b=GjufNMLb+2YWJLijLeqWGOvXAVzz4XsHL1I40V3nObyb3FekAhPvoAXapmoM3+HXQl
         4lXuWj5kAUZ8DShtZYDijjP4NLhLGvDJ4jZFRJmu+Lg5XQCKQj1vhFU5DfAoKfnVAxxP
         mkT/Lo7o3ATgV4w+prTyisBFmjzSxW1Z6Gnx47cfQqYV9BZdEIWIYZsD6Q0b8YBQsUe4
         a9j8xUqQXkmBtiLEwHAKNuPsGCarYjqGuqxsN3zKm2uuv9/2p/MK0I1+wKKGz0Hc/vPJ
         Swi3A+ww7I1gjZiAi87V35E+2V8ah7vDTvMDRrBc70t63sUFVwVUfl+KUh5nVHImZ/ww
         nvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsrGyoqQOYTH2PPKiYL70RKRI4in0yNtJQIpGh3K26A=;
        b=Aywpvd6PtojBnGBbZObK+UlLTXhGrxPIrlsB/vxGpHjhCvWG5R6WR+XUiVTYDFET0D
         Lk0E3YN3OZs0nTL45T8PfoAz7L+P5U3nimbAQHlSLt7ndVwyzbTg+IgPfuZzlxW7p4P/
         LCaC/SSKA7sIxUwkF9aoQ7yCfraS0sAHbdYcOZRfi7UwZKP9nrTG1UcHSoPk7haijAi6
         j+bI/8FWJ/Q67Hy96FTymWxWtUWQ4hCqD2WTFnlITUZmcP/z30mt+dQINqGjNAPSZM8V
         0eA5dR/uEhn5z34q58HjKekkjigQvgyNKSzcnS3QZ6kUtPsm7Ts1r4CgtoH2MvL0WeZp
         pijQ==
X-Gm-Message-State: APjAAAVpBpZGZ7Nthag/oeiIARYqXf5QwxWbP2ne+abOan5UOKNO86zM
        mr3NNQ21//KCcaBY/E1fPj8zDiKCwNkElSLLKd8AEg==
X-Google-Smtp-Source: APXvYqxfcWlpb80bfV9/wf4du5Ri0OHkQNIq7dTOGMorsiq+ISYV3iyGYJ5gy6j6vXuX0krZDW5k5bg9mqAlmEdJMVY=
X-Received: by 2002:aca:c3cf:: with SMTP id t198mr5965693oif.10.1573777393028;
 Thu, 14 Nov 2019 16:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com> <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com> <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
 <f2236442-111d-cd84-fc47-0737df71cf3a@redhat.com> <CALAqxLWHbhst5KXAGCswKVp7ztzFHxdb6nskfze+Jk+xWo2Ssw@mail.gmail.com>
 <7877d69b-b17c-d4a4-9806-3dca98fc9e26@redhat.com> <CALAqxLWE-8YkYmrKoP6-+2xherwsGZ8-CeUyOFe9YPQj6EuSpg@mail.gmail.com>
 <7ea7824f-abc2-4cf6-720a-3668b6286781@redhat.com> <CALAqxLVrEYT5RbL_R0tx_3jHzt7ZuWHDPuEwt1r2iXgPwR+Czw@mail.gmail.com>
 <f5c9f5a3-97b8-389b-47ee-cfa5ddb9afa7@redhat.com> <CALAqxLW5vYpGY1yLTvRefiX6anOGsPWW_Dc1Rj8kdf9+BDm0kw@mail.gmail.com>
 <5965292c-4837-5f3b-816e-287174c909ff@redhat.com> <CALAqxLXhmS2CsPRgjOdZHhzegc_z9pOse4C6oPH44ny9JJcf+A@mail.gmail.com>
 <2d98ea33-e128-6b38-8c16-c6339cb27fd1@redhat.com>
In-Reply-To: <2d98ea33-e128-6b38-8c16-c6339cb27fd1@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 14 Nov 2019 16:23:02 -0800
Message-ID: <CALAqxLXGFBcfdpzt+xznH1jqPfnL2KXG5eeCwz114ohgriT6tQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:11 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 22-10-2019 07:58, John Stultz wrote:
> > I'm fine to
> > continue digging and working on this approach, but I also don't want
> > to have to pollute the core code too much for this oddball hardware
> > (esp since doing the vbus control in the role-switch intermediary does
> > work ok - or at least better then this approach so far).
>
> Given the special nature of the hardware I'm fine with the OTG intermediary
> approach here. IMHO it is fine to just stick with that and to not spend
> too much time on this.

Ok.  That was what I was leaning towards as well.
Thanks again for all the review and feedback here! I really appreciate it!
-john
