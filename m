Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7DC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD372133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ih6cRijz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfHPVCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:02:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32919 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:02:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id q10so2252825oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pzf5ttKVjeyOHGj3IBlJBDsgNbGhDBmBkaYw60KhRKk=;
        b=Ih6cRijzi1WXJSNLOQ5fjrTQfNVdHvPC1zCClUbe4A4GZ+SH2HV5VUDYPxH71hNvAO
         K+zxhM53FgnfZQsPHkv/hVom1N5R9l9Uznj9QLmSdX+oorsI1L/7GwAeixUslqiFcIoK
         sJsBKcxtUggJLyu6CAueRaFQfnw9OH7uYOm4p7932gibeD+HjohvFy7ChhjOTxz4YO46
         IRGGKBFDE5FDfVaehQSFxh5L5NdYA5ht6gn83yeVqIbO3hTMpFm/59QHkNxGZnu3Qmmi
         I4drtOLT3KLfoKwnbIevMG0m926zemLHgV1/posP1CqiaCxqPJQdQifeZFe3Fje4RoZm
         786w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pzf5ttKVjeyOHGj3IBlJBDsgNbGhDBmBkaYw60KhRKk=;
        b=LL1HMAYlNUyJf75GwSyj1u3lUTcxc8vS1Q+wjmCF5fIZqaQWbpFZVJDBLCYiPwd5+R
         eY0tUpJLYrVmAiPf4QXhDur8PN3eLLSS6kd0q8H73NdXFcsVoneJOJt5Grcr8GDpB7pR
         DmEvgBhU0qgHp5t+0xm9ZIo5yM1OEYy4LkHWGgEZfWCwy1NEzZJmRpn8tsMK/cBt30rs
         8ew/MOBZ+dFR+yhMOx6+2qfzBBS2bXEdqGh+82x1LzsFdI0rRhMk56fONjDpiXz9tAov
         wcJm65IiVf2rEvE45urWhWbj33Mw7YAJWIggghVyuMJg4v8F5+t8nsRc5/NEALKQBLR4
         C4Lw==
X-Gm-Message-State: APjAAAWyyk0U8Q8DsE57iHxFMZ+2Vnwt9IUCyjL1AL88zhfeymZZPeFp
        tjBU8CYPIYLh9qcpGaS+6y+36b9Lat9REC55W8tbcg==
X-Google-Smtp-Source: APXvYqytMWXAd1gIG3+fmsLmzgobobDXChkzQo57KKls/WBzWZd7ckKQzPYvdyHBOfrSC/IuJzJ5dxaS27c/FqT46qA=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr5715248oif.70.1565989351296;
 Fri, 16 Aug 2019 14:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156583202386.2815870.16611751329252858110.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49zhk8bzuh.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49zhk8bzuh.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Aug 2019 14:02:19 -0700
Message-ID: <CAPcyv4iPBO9atdr_LdHNt=tCgjh-j_HyKXaCdUkWxb_J7OCcxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs
 security operations
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 1:49 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The blanket blocking of all security operations while the DIMM is in
> > active use in a region is too restrictive. The only security operations
> > that need to be aware of the ->busy state are those that mutate the
> > state of data, i.e. erase and overwrite.
> >
> > Refactor the ->busy checks to be applied at the entry common entry point
> > in __security_store() rather than each of the helper routines.
>
> I'm not sure this buys you much.  Did you test this on actual hardware
> to make sure your assumptions are correct?  I guess the worst case is we
> get an "invalid security state" error back from the firmware....
>
> Still, what's the motivation for this?

The motivation was when I went to test setting the frozen state and
found that it complained about the DIMM being active. There's nothing
wrong with freezing security while the DIMM is mapped. ...but then I
somehow managed to write this generalized commit message that left out
the explicit failure I was worried about. Yes, moved too fast, but the
motivation is "allow freeze while active" and centralize the ->busy
check so it's just one function to review that common constraint.
