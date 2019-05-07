Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E1CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F552054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fvP0O3tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfEGQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:56:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46480 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEGQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:56:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so14932687ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esZbZU1pgP8duus3WEzDEySF+/YyqE39bcTa0BgZfHg=;
        b=fvP0O3tZ7ZjnILeoVNXqpBW5oInlJpRKtMsHavAo8Xz6rGRg89S6GZWi4pGffqfCFg
         oatIXFLAoC9CKwk1ym8unSGXwAYeKchgsJsEKUm2XnsjPb9LqnjMjeafzahNU3X/YERf
         pCPdN8c31gCwwkI7LCI3zaZ1cxosDpm3CpW9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esZbZU1pgP8duus3WEzDEySF+/YyqE39bcTa0BgZfHg=;
        b=ZM49TvrxVp0fo7p1rpTGvIp49sWtbFGNgpCv45oMa4lukr75T7C8/aX0vtUfw3h8ak
         TQfXKKcVqiuGoAUAePP0KtUfjY74cekAbQ4lTSa7MKObUDgCVUDhQ5MztLACLlfmaN2F
         h0BNnRSf0HXhuZL5C8HUJMIvOF+PUa0S6YsC/Oxu066UGPISywvo55eQHM4xgaoaBJRx
         YhzkIS1JOcZVHxYHqOeiWJenjKtTZAUHaJqiYttVnphiA6pg+j9ZUI+gIIMwn3U9ZqPA
         PwbXFKXUVyOaVWJecgo5YpBxDmd9dyumGGeMC1PGMqzqx1QPTZXjkoM3SFlUkgH0w0ye
         g2wA==
X-Gm-Message-State: APjAAAWubI4B0fhyBhLomX+RMHZk06VnkHGwjP6h2IcDs4eqwNF3nbeD
        8JdaSRYOHf1PM4QP7xOKlMxDPGVRrKw=
X-Google-Smtp-Source: APXvYqyjTyZJ9aqAMxg5NK8qmc096hrVJYTZ0SiDoU4UhcV8+pO0itJeTJYFn2mbNW+2mq2jcrtSrA==
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr16326190lja.99.1557247694175;
        Tue, 07 May 2019 09:48:14 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j19sm3466097lfm.29.2019.05.07.09.48.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 09:48:12 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d8so12344223lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:48:12 -0700 (PDT)
X-Received: by 2002:ac2:54b7:: with SMTP id w23mr821657lfk.139.1557247692296;
 Tue, 07 May 2019 09:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org>
 <CA+ASDXOkHxYumCBv-T0gxTjdMVTu-c=33Lk-0TUgJ3WGUn2DVQ@mail.gmail.com> <CAD=FV=UKTDFwq3PSdpPmShRcOtZaH1mU=2H-ynoG4VooV=rKVQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UKTDFwq3PSdpPmShRcOtZaH1mU=2H-ynoG4VooV=rKVQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 7 May 2019 09:48:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMOmD+Wp5wfWU_1m+eEKhGTz62Ru1TJhH7Cea_CKa9PHw@mail.gmail.com>
Message-ID: <CA+ASDXMOmD+Wp5wfWU_1m+eEKhGTz62Ru1TJhH7Cea_CKa9PHw@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 9:25 AM Doug Anderson <dianders@chromium.org> wrote:
> On Mon, May 6, 2019 at 2:40 PM Brian Norris <briannorris@chromium.org> wrote:
> > The last part of the sentence technically isn't true -- the original
> > bindings (notably, with no DT maintainer Reviewed-by) didn't specify
> > where such a node should be found:
> >
> > 35da60941e44 pstore/ram: add Device Tree bindings
> >
> > so child-of-root used to be a valid location. But anyway, this code is
> > just part of a heuristic for "old DT" (where later bindings clarified
> > this), so it still seems valid.
>
> I agree that it was unclear in the past, but it is true that being
> under the root node is not according to the _current_ upstream
> bindings, right?  ;-)

Sure, I suppose. Although, given the general ABI policy around DT, it
seems to me that something that was "according to" an old binding
cannot really be made "no longer" according to the binding. It can be
discouraged, and removed from new DTs, but it doesn't really become
*wrong*.

But our DT was definitely *not* according to even the (un-reviewed)
merged binding. So I'm mostly mincing words here.

Brian
