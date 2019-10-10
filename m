Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0248C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E5D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MzCP3JEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfJJQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:38:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41462 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:38:21 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so15108892ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ph+cM1wqiv/orbsFFGXeEKlbXh51icoHvALffiLcYf0=;
        b=MzCP3JEh+/LlXlx0pBedozlo0FoZD5596/N3hdLGFXDY7yle3Gbnuy0SOR+2tzLqTW
         pJ7aFSAUD2tSeLCAS1SLIU1wJoZQJF33bVsjoTDQT19NMIzC/vf8WRVb7YA7dh79T3wO
         NU8cD67l6lYlGFfxwNY3bs1mg5iGsqMN1C34M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ph+cM1wqiv/orbsFFGXeEKlbXh51icoHvALffiLcYf0=;
        b=jKELnuxKbTM/aNGOWwtoH7AOD0YhbA78XyaNBJiueh7lhwbfk6+7jSVFJrsMa+ClNV
         YVTz4wISCCo/EOQZXhiGB/ZBsMUYOVUCIZMcT/TUN0l1M2lHcL3XySGpgbm34cFMOiOR
         vrxyTMh7CqdPcx74BkUbpoAiAxbUdfdaMTa0nc8ETo/0KgaWRMqq8ALCPitBFw+r+8Kv
         l/3XguC5tuKW3KNdyfh5huuiTD72cXqF+h644QXa9yAUfy22D7aWkPH2mS1kN+psaoH/
         k3mE9JxzpsrmHyZ24s74rP3h0ov8YlQVpkix8ZbMLRhJxfIGLLJjzsQxOMqnvi2s2jdz
         Notg==
X-Gm-Message-State: APjAAAX5QM1d2l5vvNyvvhjkJMMhD2RUh1v0QSudULddaIoGVR+66NGQ
        lk8BQP01g712mYSkSjv2OcxkIzMhhRM=
X-Google-Smtp-Source: APXvYqzmK8JBKD+E+Ty9wyra12u8uq2W95ROdDI6/mP5v6fLutcTsEz7kZ9TlfVS9GFdT00F3JARog==
X-Received: by 2002:a02:893:: with SMTP id 141mr11136425jac.36.1570725499971;
        Thu, 10 Oct 2019 09:38:19 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id a14sm3557914ioo.85.2019.10.10.09.38.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:38:19 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id b19so15191283iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:38:18 -0700 (PDT)
X-Received: by 2002:a02:90c7:: with SMTP id c7mr11362682jag.12.1570725498188;
 Thu, 10 Oct 2019 09:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
 <20191007135459.lj3qc2tqzcv3xcia@holly.lan> <CAD=FV=Vqj9JqGCQX_Foij8EkFtSy8r2wB3uoXNae6PECwNV+CQ@mail.gmail.com>
 <20191010150735.dhrj3pbjgmjrdpwr@holly.lan>
In-Reply-To: <20191010150735.dhrj3pbjgmjrdpwr@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Oct 2019 09:38:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuOVpvEB60-prMxuPyjcrJ-9O2hyaLKf86c-r9BVocdg@mail.gmail.com>
Message-ID: <CAD=FV=VuOVpvEB60-prMxuPyjcrJ-9O2hyaLKf86c-r9BVocdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't round up
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 10, 2019 at 8:07 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> > Reading through other control flows of the various backtrace commands,
> > it looks like it is intentional to leave the current task changed when
> > you explicitly do an action on that task (or a CPU).
> >
> > Actually, though, it wasn't clear to me that it ever made sense for
> > any of these commands to implicitly leave the current task changed.
> > If you agree, I can send a follow-up patch to change this behavior.
>
> Personally I don't like implicit changes of state but I might need a bit
> more thinking to agree (or disagree ;-) ).

I can post up a followup after this series lands and change it.  I
have a feeling nobody is relying on the old behavior and thus nobody
will notice but it would be nice to get this cleaner.

BTW: if you want me to spin to fix the commit message typo that Will
found or add his Ack to the series, let me know.  Otherwise I'll
assume that the typo can be fixed and Acks added when the patch is
applied.

-Doug
