Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AA2207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 20:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjKrdXSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfKJUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 15:37:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44402 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKJUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 15:37:02 -0500
Received: by mail-il1-f194.google.com with SMTP id i6so10109337ilr.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYkUdq1QNwEYjmWnKj0EdSuQZBm50tV0WRMLPz5fi40=;
        b=YjKrdXSAahH1StV8EmSM0xqq4aLCOmXxLU+j1f4BFwlEJmyrOlP8RZba67nit3HqzZ
         DM0QOGvUfkHeJ0i1omMyHJ0v9iSEfXl49WzFAq70cWB6KBQF91bZV/aZ7PJDYo5vvjsl
         m8lqsOILU324B9CX+YylLNIqu+CqkNaL2lm4GmxdverQZZagLlK5LldN8LpbxzuwoOjk
         0pPRitP0e2w3MEHCNpLzlYHyIV2jUULL7hRCoXLd6klTDgrgpxBHNxWt5VAJP6m0vOGn
         wVQVH7CDt3gNJvsHaLfqExGe/GjEMeQLmbEy16STAvESl8tCI9lljvE6NN8rMSnHRdeL
         S2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYkUdq1QNwEYjmWnKj0EdSuQZBm50tV0WRMLPz5fi40=;
        b=Oyp+9pP/HYHYb1Ej7yJsdAlO6NfontvzCr0PKey2SOssQvqiBEHY02mhFwAxk4SJMN
         +sCOVbPmeWyC8zYu74WLzz1dXznq402tGekqwUKyIh7SOphjeVV3N/7XUKBOPf7KNrWt
         6Ys/D5B63JkaloGoSaXWbvjt1wN/t3oouIzpnb2obLRJvwY+Cte9QCowgblh9WB+p8cY
         xaBhq9ed66BQyJy6gelTy5uPq0e0rYA9Zll4JjB2qgz4jf0wFWZ7nwUW8S3iMDHZQFxH
         OA3wzgqg3fcNdDWJrhAaWJY/vjmi6gONO/awm8crYuCmwwZ+NEnSKELzH8pjZjwaDhC4
         dG1w==
X-Gm-Message-State: APjAAAUwkDG9ROOGZ7Ya+X2ObzM04lUpR65rhor0d/3Ck9g/v7oal1mI
        zY7p0Kuiw3K8JpxvXKTl2bQYpmrAhreDqOqupKs=
X-Google-Smtp-Source: APXvYqxONBNYETcCcUx22bjTXa1sKNF4MrVTIE2FFq9+pLOdkaD4ocrmdqnJ9MtBZc99i0YC9k5Ha4jPIpBl2Wj89B0=
X-Received: by 2002:a92:d7c2:: with SMTP id g2mr17371311ilq.81.1573418221372;
 Sun, 10 Nov 2019 12:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
 <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
 <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com> <CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
In-Reply-To: <CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 10 Nov 2019 12:36:49 -0800
Message-ID: <CABeXuvrYzLoc7YGtmXDJqEovwyERbndN4cC6UaYAw5+qABRr8A@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     "Zeng, Jason" <jason.zeng@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, rminnich@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 10:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Fri, Nov 8, 2019 at 2:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > > > For VMM live update case, we should be able to detect and bypass
> > > > > the shutdown that Deepa introduced here, so keep IOMMU still operating?
> > > >
> > > > Is that a 'yes' to Deepa's "if someone wants to make it conditional, we
> > > > can do that" ?
> > >
> > > Yes, I think so. Thanks!
> >
> > Are these changes already part of the kernel like avoiding shutdown of
> > the passthrough devices? device_shutdown() doesn't seem to be doing
> > anything selectively as of now.
>
> I've posted the v2 without the conditional for now:
> https://lore.kernel.org/patchwork/patch/1151225/
>
> As a side topic, I'm trying to support https://www.linuxboot.org/. I
> have a couple of more such cleanups coming. The VMM live updates and
> linuxboot seem to have contradicting requirements and they both use
> kexec. So kexec_in_progress doesn't seem like a sufficient indicator
> to distinguish between the two. Do you already have an idea on how to
> distiguish between them? Does a separate sys_reboot() command
> parameter sound ok? Or, we could use the flags in the sys_kexec_load()
> depending on how the live update feature is implemented.

Also, the AMD driver disables iommu at shutdown already. So the live
update feature is already broken on AMD.

-Deepa
