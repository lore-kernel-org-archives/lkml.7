Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1DDC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C1920842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuRtfDui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKJSYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:24:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41252 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKJSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:24:33 -0500
Received: by mail-io1-f65.google.com with SMTP id r144so11859136iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGPvkCQhS8lOGjJsjyLIOzETx5n0C33gWGyQBfpGz08=;
        b=EuRtfDui/jVwc7I7G2EAEIoN7CusJdRjXcOpzduQ1FCCd/wL4Oymv8SmWjUDLcJiJH
         XJ1k46LoLnQS8qLJ0rKKwFj9tQF5XncAcJFYalytPsokgB73l61dymH9ObiimWRgRALx
         /e4oe4PRzYLuM+duiVlB4IHgKYpypi1byIzNTSoe4skgCzcTo6yrayCURZUjLdX3tBxX
         eF55HKBhql/aCdebLp8rEskuX2uAB0vnXgGfPDMiZdxza1FmkMQBkNEXzmV7IbWHsgIG
         v1lE4Kaic2fjve2LS9kPgI04vEbB0LzPw8cCD9E2aEtylU+L+pME+mHNcGDIPXoomHuC
         dtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGPvkCQhS8lOGjJsjyLIOzETx5n0C33gWGyQBfpGz08=;
        b=ccYp9UIsk7jZ3YYDFw5flnV8ZvMnxwbsR20XloI2mPTL1zpApD4GlRZkQIQD7yI3su
         Ztc/L4xBfuvzRlybKNFIHb075VjZcOPqSo0YlmGer5kFqtkSZPuPorhxfAq/CHwNStj5
         ER+M3ewVOhU1+SbBiEetaPifsLR2OoDhD5dkSy64BQoDrcgYrSOqvgLf8aXmQV5g9ac9
         N12S/Vkid33jthqTRgy+93JjxOSk2MqUVikj7CDxJ1DtIujiwkqbBDNjihQAvbYrhSeN
         dsRsETom/t8AgGnZPwFtAMw6vkRCGJyPnQVl813mjucZqf4Gvhq4mD12J7C42gtj4liH
         L0rQ==
X-Gm-Message-State: APjAAAXxsEzqBaObxlR2p4TC1FXQbaE16EYjH57Qm+qsP5relVTZeRZd
        kPXQYqWhHvBzTc7FtQ6TZehgY5lE91gaWQt+ViA=
X-Google-Smtp-Source: APXvYqyz5D2ExJqLF8IgqivapjYXzOhUz1k6GWk/e/rE20GM4qdFusyulwHj9R/uZPLrDWZ2NCC+37New78NJexUnkw=
X-Received: by 2002:a6b:3c04:: with SMTP id k4mr12754617iob.110.1573410271227;
 Sun, 10 Nov 2019 10:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
 <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com> <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
In-Reply-To: <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 10 Nov 2019 10:24:19 -0800
Message-ID: <CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     "Zeng, Jason" <jason.zeng@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 2:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > > > For VMM live update case, we should be able to detect and bypass
> > > > the shutdown that Deepa introduced here, so keep IOMMU still operating?
> > >
> > > Is that a 'yes' to Deepa's "if someone wants to make it conditional, we
> > > can do that" ?
> >
> > Yes, I think so. Thanks!
>
> Are these changes already part of the kernel like avoiding shutdown of
> the passthrough devices? device_shutdown() doesn't seem to be doing
> anything selectively as of now.

I've posted the v2 without the conditional for now:
https://lore.kernel.org/patchwork/patch/1151225/

As a side topic, I'm trying to support https://www.linuxboot.org/. I
have a couple of more such cleanups coming. The VMM live updates and
linuxboot seem to have contradicting requirements and they both use
kexec. So kexec_in_progress doesn't seem like a sufficient indicator
to distinguish between the two. Do you already have an idea on how to
distiguish between them? Does a separate sys_reboot() command
parameter sound ok? Or, we could use the flags in the sys_kexec_load()
depending on how the live update feature is implemented.

-Deepa
