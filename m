Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03CB206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSYjeUJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfDEQYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:24:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41698 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:24:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so3544125pfd.8;
        Fri, 05 Apr 2019 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYxWlGoOF9nVIVtzmynZ/e/rze1trOYQ9O1cePxCsdk=;
        b=NSYjeUJ7+xqpjwA4ZlfEV4OWRsLdde8X8RJvGHOQMUzen8wE9kVcPO+vGNKRmcdtkI
         jrWkUpux3+1N6di1/wtopn17fhwlYCRJ2srr1vN2E/3nxftK70iyV7quP8EsNiolt8D9
         pBuBXuUCDZkYJ1x/EffzCO9g73UCTgQOCu7iJgZdeODETeDqJIiF9ySNjhR2ooPjFjqI
         DqVOSCqRzEVRf3nr6Wpe9hZf9rDui1l7QC4iFVLH/8EPMEG3B0Q6FTBa2vaj6kh1R8z/
         pOU6YF1cnYBNm+Yzn/S31cOIMLnii7Me5mu26/wTY3txHKfdhf35iODXQug4JyLR447/
         LTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYxWlGoOF9nVIVtzmynZ/e/rze1trOYQ9O1cePxCsdk=;
        b=qtmfWwhxGxc4jl6zrC3sy5wA7LGhYzFnUDHkTrE3XPS1fLj31FK97D3V9GHTSMPDcE
         Q0VnvUhL+/8tRVpVI5R+gxWg+J+oJ0yoTTfkefqc0wrLEQSOfG9Blyc2PkSwzEEcFKn8
         KrPA3gesvR5abXAMZUXUNH2uK5zMI3xsVroGVh9/6FUOqdxNJ13lYhjtfqF12CmgoybH
         KQ7UpqG/6eLGB10qr8TCgom34uVDm1P2UPpe/Sd2hf07Tf2Js8i/rut4XGWYjs+JWoMx
         y1x/cUTgIzWeCNLTpaN35QwNtlZGal7T0MJLlKxq9tnkKyX4EF6IFQhrNnsaP4JhFu5Q
         x+iw==
X-Gm-Message-State: APjAAAXzBM1Bq4q/SkOFVNVoRz+R9SqMn9X2vAx3nzeTu369/KE9FFd9
        maY+GZ67Jv127zmdjhcRAXcAXzQDRgpCvTzxo34=
X-Google-Smtp-Source: APXvYqwZEPJkmJK6fWs6hpef8WaBEfo3EQEQFrfDQ9ZuY8W1WTa0HZhvdMOoN368Mfj7jO9dO9WuR172AEfRPUdt5Mw=
X-Received: by 2002:a65:4302:: with SMTP id j2mr12361283pgq.291.1554481449867;
 Fri, 05 Apr 2019 09:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <1553632152-18888-1-git-send-email-linux@roeck-us.net>
 <4554bd3e-fabb-44aa-fc82-52ec9cbf9b2c@linux.intel.com> <CAHp75VfKYCnYdvpvkGgdjXJNRRKWOW-ps99ROWZZSH_NZAOMLg@mail.gmail.com>
 <0822b960-be6e-6fcd-fed5-1825d2818b80@linux.intel.com>
In-Reply-To: <0822b960-be6e-6fcd-fed5-1825d2818b80@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Apr 2019 19:23:57 +0300
Message-ID: <CAHp75VfvMU6iLmoV6wufPsBi7cC3nQgNjg-RxTkmkvq9RtfypQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Mark local function static
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 5:49 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> Sending again as i got delivery failure notification from the mailing
> list for some reason.

Mailing list doesn't accept HTML as was your previous message.

-- 
With Best Regards,
Andy Shevchenko
