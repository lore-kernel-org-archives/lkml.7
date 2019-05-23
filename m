Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DCE2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F5HMpVG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfEWNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:43:13 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43303 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:43:13 -0400
Received: by mail-ua1-f68.google.com with SMTP id u4so2173030uau.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDtnRElNuUyMt12FB8Rk0MvDHzUU1QwxTxxj3HBh2vw=;
        b=F5HMpVG3EWCJPzMlJKs927sGGct8xw/xB0Y89Vgc09MmTe9qCI0EWFwkd3F7L+ZqFU
         kWHqmexwtAqAJgSeoLTmFnZylC+rm5Br2x4lzGtcs02ZZCavNG2Gf5f+gE/JWhQ/Ivs/
         8x2rRNG3Gb6qPEUUT/ibkLnE5XHfMOxE1oKgDBsbVXYeq/geXD2fm0t7ZMlNcI6Ag/XQ
         tbJ0nagR/yajVw57nuQCPVX18YlRvtDzNv8eAC23gjHJgwzVXV5xko9O2KehbFq5yR5X
         JXt7dQUscteyeiumbcstLMRjk9pfvtsuAbcAyqhHrkbkUqxZO4aGLoi3vYUAgFsAwP9e
         VWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDtnRElNuUyMt12FB8Rk0MvDHzUU1QwxTxxj3HBh2vw=;
        b=IK90TvaGgGozeV433ZekRf1/yXX8NJjNfk2TNjrC5UzH5LcHAjtZPWWhoApmI8QS0R
         mdchY8WRnX4lP5ziw5lI04/zQmB9gv9/CZ760L4yEmLCk4ccjTF+Sps7xDugEeePJ3xF
         CppYzwrwDNFtUXbtXpDDkqe6DiH7AmVOG6NdHiEOuHDTFfeEeAHQxuN4BstHoyEDg4Gx
         zpGWBePGf56WfqHCKJBYia0nJCX50+vdR4SqH8nU4DWivAGnCzVuKvG8ju7fPqZdgyzA
         lCZ5b3jT5Po2hSI4eww7ijjvNWmUtwsHQwufYBACfsLovBM38U9Twzdjj75mEmoYK6Pf
         qs+A==
X-Gm-Message-State: APjAAAXQXC90wnVZouQ58QzFXMxGk9wPSaTEYTseIlyUcHY1LKrJs6zf
        Fr/DDq0RxBaJjWs7S1BfewTJxq2160HW+lgbioPnBw==
X-Google-Smtp-Source: APXvYqwGxws4eO22FIKVa1UIaqOVwcqNo2ovHYADpIBiJJe9TRlN+UMwHQoxWg/gax3t035v1obA5yqmm0zqE+T3KI8=
X-Received: by 2002:a9f:366b:: with SMTP id s40mr22365743uad.121.1558618992582;
 Thu, 23 May 2019 06:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <1558515574-11155-1-git-send-email-sagar.kadam@sifive.com>
 <1558515574-11155-4-git-send-email-sagar.kadam@sifive.com>
 <20190522194529.GJ7281@lunn.ch> <CAARK3HmMVibudG2CFLBoMSAqnraXyirTL6CXYo1T_XJEuGJy7Q@mail.gmail.com>
 <20190523123435.GA15531@lunn.ch>
In-Reply-To: <20190523123435.GA15531@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Thu, 23 May 2019 19:13:01 +0530
Message-ID: <CAARK3H=BPT3aGUGiQvov5aqFRNVTSeyqJ-bNGw6uEoU7c8iiJg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,


On Thu, May 23, 2019 at 6:04 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Thank you Andrew for reviewing the patch set.
> > Can you please let me know weather you or Peter will be pick up the patch
> > for v5.3 or they  should go in via some other tree?
>
> Hi Sagar
>
> Wolfram Sang should pick the patchset up.
>

Ok, Great. Do we need to write to him about this patchset?

>         Andrew

Regards,
Sagar Kadam
