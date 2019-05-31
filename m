Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DDC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3788026B0C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="j/GsBEIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEaOwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:52:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44065 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:52:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id g18so9406204otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dazNgH0WSo6RBdntgfM2itxBiI4ct6zLibwem/T/a7w=;
        b=j/GsBEIAjVbZy5Y3mimHxH4kZFIlLlKkT8Acinmv2sLTumtJSAz4+K45i94HMcU8B5
         5vuoBjVllo8eLWfIEEGmSHN3y18C2+WtOf2ld9xfh/eBfNzfI08ywejx6/WFhh2Qh1Js
         U/xC31+TIvuIg3zpSPwdusI6fAgBAbuf9ZVsZWxcMq9qesaxUCnyu+Jm/j/acoKaQrVk
         /xZ6KTMGmaqDluJACKDkBZki6qenzP6ucLDP6nqi5PMISHPe9me9sBfBu16SCQ9MmPmY
         x6x0pxCLwDJjV9HwPASaVKILGYScIoM8oWLKnlfoOZ9C4wOlTg6towcaz/+2kExeQ+Ur
         a5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dazNgH0WSo6RBdntgfM2itxBiI4ct6zLibwem/T/a7w=;
        b=b1iasGN7yernW9ghYXDO1824Bgge4/n3odSkamXb6n9wX9+RfFTbMGngIwHb3KrNEM
         /YTceIo5SNzy5f6/sn21X2tQ4FBFS+5Dt96AKLpoSwxBgYwnv87OiVE8ws2CDnXQb+Bl
         wi06Op+Wu9u5c5t9gzxIJcpjgRSp1KsyAszm1P+so6QYRIvu6f9hf8juPkF2TRFNmG1U
         BjiVCjJg1NLOaDKlgDfGzQNNMQUzn6U8jZUi69cfWFAZqArVpp6ArW1RUzRpyplS0Hso
         NZgGYOiCKeY/J9iV/bdfhSOsBb3nnU2C04QecdaeA5PCKK7e23wooMstnG1OJqmvTKRM
         ATmA==
X-Gm-Message-State: APjAAAWPgiTndFbjnEei2xI25xgIIve3PzdcPXOerdDk3jqlgDGE7LUW
        fpf+mUMBZCMdQQEkAKTKw6i0QBKU4ZR+l3y80RypDg==
X-Google-Smtp-Source: APXvYqz4eQwsdM8n+GXsG5v0XO/vAmXg8NEkFxvIGNZys/6jEKVlKq5wCfwFwo8AbFTYskZ23wp82lAK4anye2kHMfM=
X-Received: by 2002:a05:6830:1417:: with SMTP id v23mr1948581otp.71.1559314356156;
 Fri, 31 May 2019 07:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <4965161.Uu1Nigf0I0@kreacher>
In-Reply-To: <4965161.Uu1Nigf0I0@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 May 2019 07:52:24 -0700
Message-ID: <CAPcyv4ib1twvDBz6W=JU18JyvtYmyHeAU4iOruRGHf_cY+3Yvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-efi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 1:24 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, May 31, 2019 12:59:27 AM CEST Dan Williams wrote:
> > As a single source file object there is no need for the hmat enabling to
> > have its own directory.
>
> Well, I asked Keith to add that directory as the code in hmat.c is more related to mm than to
> the rest of the ACPI subsystem.

...but hmat/hmat.c does not say anything about mm?

> Is there any problem with retaining it?

It feels redundant for no benefit to type hmat/hmat.c. How about create:

    drivers/acpi/numa/ or drivers/acpi/mm/

...and move numa.c and hmat.c there if you want to separate mm
concerns from the rest of drivers/acpi/?
