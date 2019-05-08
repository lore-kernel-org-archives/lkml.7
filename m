Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352CCC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04772204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ0Sl/1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfEHImV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:42:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45863 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEHImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:42:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so9730631pgi.12;
        Wed, 08 May 2019 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRQ5RNNGW8Mx//5L1gh6ddvvzKGMuy8npBda/7vOraw=;
        b=dZ0Sl/1e46iI77qiFe4IK7c+yvMbUHLTAQ+0DPsWD3WD/+E/peoNRNT5DPB+RYVGhJ
         oA4sjxQLxrGA3Ka4SG3S8ssxXJP1nGZ3LOn+Qagt3aMrnjCPxgFjImKT96FDbRQBR76e
         WWUb2ZlrOYB1jXLuDdWskmUwxc/MK5Hd5E2pnbIpqCyUqEFR9ZTz9pGGPe/6Vyhi8va9
         JXDF+7rtuQzqi76+SxoujHC5KgCCaA/jk/3xRJ+ex9eZwG4IN4HU1Qf33YXlFKXt0PvF
         Yxmqu2rqueO2Xc4i77EoULoFrtzZDOi363MCsF/+3UYMKBHZiiRFX2G0A6ioAHT1fxfo
         qFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRQ5RNNGW8Mx//5L1gh6ddvvzKGMuy8npBda/7vOraw=;
        b=ZMt6AwHRcyUptH9uuxZy6F94mzUZynlg2DKeUpbl5gCalaPOnmMlrDgjE9rJ233BG4
         D9FLd3GiXgUkZXYQtg5E5cDgFW+/Ma+ncRh5cvYYeLWjbGH7/FaF6LpiE0svWDZ0c071
         yUiMOqwif8KdjlIda7UFRXkeuyuWuepAuIEzEkXBGY+8zTcT9MaeeD2eptbCGXO3SN4x
         nwL7oqKL1UZRmdHH5OJiVIwCTnXFyQJeCoXtSUrO+y0DwZh4t3RiEh43mTjSflSH/fti
         zfL/RTbCJZCL/wg6F7FegAWdsO83R22buFGmvr+vEkVaaD66nvY4i6VeRVxp3B06uxGk
         o9Tg==
X-Gm-Message-State: APjAAAW8C+QE9RiA4rvMQldiP2pyCW24lsS7CFXLW/DQNuE312Otj8HR
        A3YA3gCn8gQoY/RTpx72dJ/SetIG2pTu+f7aY1s=
X-Google-Smtp-Source: APXvYqy2nIPIHZlYOlLqYgJAaSO4cmDpBhuQySZvIpT/pt6tP++9AZNkiv2qigARYGPfav2e0Rk6zC7YChZK2xp53P4=
X-Received: by 2002:a62:30c2:: with SMTP id w185mr47431034pfw.175.1557304940122;
 Wed, 08 May 2019 01:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190429150135.15070-1-hdegoede@redhat.com> <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
 <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com> <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com>
 <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com> <155726027056.14659.1724431433952718602@swboyd.mtv.corp.google.com>
 <10c8864c-6ee7-4dfd-6274-b1996e767653@redhat.com>
In-Reply-To: <10c8864c-6ee7-4dfd-6274-b1996e767653@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 11:42:09 +0300
Message-ID: <CAHp75VdnxRQi3X6J9hLGUjGsOYTkjoPN5MakJc=mUSumoC+wag@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 10:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 07-05-19 22:17, Stephen Boyd wrote:
> > Quoting Hans de Goede (2019-05-06 08:05:42)

> > I guess this is urgent?
>
> Somewhat, getting this into e.g. rc2 would be fine too, waiting till 5.3
> would be bad.

So, I can do it as a fixes for rc2, just ping me after merge window.

-- 
With Best Regards,
Andy Shevchenko
