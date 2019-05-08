Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B2920989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoIdT6ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEHIko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:40:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38564 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEHIkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:40:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so9744636pgl.5;
        Wed, 08 May 2019 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rX6ucNl5H/QLYT5MirDdIdADtlybrhpXP2ffdTKqLlA=;
        b=HoIdT6evN4j/sBXYzP0MOsSz0/32FftHywFEyONPKeqbcOqjCzyxnfQDAjCXTFSS6G
         ao6dBjp/AXmt2K54mASLesuSjTbnztNkHfeC5CMGR3YI27PUU43V5TzjqqzCUYGt/4oJ
         orrTcPd7cqMiJtB54BkbMbjOB4sm+UccQ3wAupd8MKq4wdHl0vla2WD0U7xo7wG5LkPg
         JvR9UM/TfYorWS78Wlyk4c8CEEsOU+Y4BznxJVHuJV+K1xG1L8JmaFQpJPWduKlkBa/i
         IN78iCIfeHAglip8C8RmgCyzxN7Tp8y2TDqWjLZ0cfXHeh4j6qRHIfZEPSrlZgyLcHvB
         zaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX6ucNl5H/QLYT5MirDdIdADtlybrhpXP2ffdTKqLlA=;
        b=tEkPKQ/ulZ6t4CFWc2BocTCVbmMkoWkTtn38rixSBuWETjrm2F9XSMdPfsxGS0tvhR
         2Uyuh1f60RDv3/0GqaMFhAlob50/GgiHSXVz+I3qmrXxxfz2uEwD5Tux4l4bYvZ1UtRj
         buGd7UJabh7CIHoWfmJ3hQ67QRq9VsROGkJbbGxbM8rcVCSBLRBrFdbQ5dPRcHsTF1fc
         ZFEiIBgISiS2g82O8GsyyE17a4LFKCqi2JyUoqg7jNe5fwnNAx2KQ2swmOlL3jJ4TJ3n
         AoZqWXtvL71YAH7K8/SjUCC2oCPNKeGfKyPqAhdaWzp22xWGkmYpsvI3kvZ8f8r5ZX+Z
         ve0g==
X-Gm-Message-State: APjAAAVaLEaCLBxidJxllU/zOFh/nltEgtF7iUG1vnGBvo4kQ551iiu8
        ZDqNNA29YjkAkeTIObXmbNR0W+EkAgXJuxiQ2yo=
X-Google-Smtp-Source: APXvYqxu74Z3Cfg0rOWll+OMmbusjO4FWCxvJ5UFfTJOChpSYAnZiFfg8XZ2TfgwcAVbw+q2PoUwXqLbN0N4Sdc5lPM=
X-Received: by 2002:a63:dd58:: with SMTP id g24mr45029848pgj.161.1557304842196;
 Wed, 08 May 2019 01:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190508082319.GA8817@hjy-HP-Notebook>
In-Reply-To: <20190508082319.GA8817@hjy-HP-Notebook>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 11:40:30 +0300
Message-ID: <CAHp75VeZgWxEvrVGajiosPCZNMwobYV9OjC4sVyW_pajK5B3Zw@mail.gmail.com>
Subject: Re: [PATCH] fix double fetch in wmi_ioctl.
To:     JingYi Hou <houjingyi647@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 11:23 AM JingYi Hou <houjingyi647@gmail.com> wrote:
> There is a double fetch problem in function wmi_ioctl.
> After second fetch overwrite the length to avoid this.
> buf->length is not used now,but it may in the future.
> It is good to get it fixed up.

So, there is no issue right now.
Patch is not needed then.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
