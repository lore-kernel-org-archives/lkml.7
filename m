Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949BD20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS4JRKrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfCZHys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:54:48 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46972 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbfCZHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:54:47 -0400
Received: by mail-vk1-f195.google.com with SMTP id x2so2581018vkx.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoYeUnYwRmKzXxmqDFDatlEMJeBv6Nw3aI+53HUAAB8=;
        b=LS4JRKrjwCSucUdMH/O2h2OQe28ZRxpIKk2Npg6bGxmO5eP+5ev5r8ANnf3WRidOLW
         N2452iCUSu3iJs7mFu9qfj2yjX8jeMLK0oQS+LE5X4/MS89MatBU3Xt1JDSKead6Lair
         cUhpZK6kNM77/k1p2zHy6yjGsweAHNA5cDxr1sXbLDmD0EUsvB32vjxAVW9URevtUfCd
         tmi43gCtxufVifs3UR90m7b8E+TuZ+6Mdpe6lJ7SljQ2XqiQYB46LeicoxcM82fKilLj
         GCzisj8NxfT23GrE2FiXzOLzuOuFakb5KmlshTx0lb4THZznWBmCZPidAknvIux6csYg
         R9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoYeUnYwRmKzXxmqDFDatlEMJeBv6Nw3aI+53HUAAB8=;
        b=JAlIoGl6LTX42hYqee5Q2z4Pin1RTVVTFSH1e0I/RkfaDSOjid8rXpoffMTK5m09rt
         nol2sjG74aSZWhZ7phqdFzi4u0rXqC+cVIRZpMvy37JAQcDnuJhPavZtVlOX08tyXTMQ
         8KawHVd+dZ924tyG5yMnS7Z1xOu5ALUQNV8KfmJam2VS1ib8+kLu3JO1aZKR+f1fdCq0
         8ASpml7Oj0gwscHkAzGzGALQbLtMjifsHC4+zcQRVg2B4r1fFm3+Zj9sMCeDT1NqAF4e
         qoF7IveCIvXndtqeZRQwYncHlVP2XXJhY07xVU9Bw3gpbq7H6DqXPXY91MxF8DIExYQ1
         lTxg==
X-Gm-Message-State: APjAAAVhPxJo2UDxMT1P95yiM5c9XEqILmetX1rBnp1H+0V7XTo6oyBJ
        G2KJTsbtiGOJzXHBhcX1EzmcAxCMCgNIt/h8TYQ=
X-Google-Smtp-Source: APXvYqxSjh/gZT3PhHmrb0E6L10cQfxbplBWazo6DbjgwEzh6jTvyw80EydY+h9Eqmnb3fQwrskIBHxUd+WxjJwXMiQ=
X-Received: by 2002:a1f:9991:: with SMTP id b139mr13225741vke.73.1553586886523;
 Tue, 26 Mar 2019 00:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190321152816.GA1381@ogabbay-VM> <20190326075324.GA25748@kroah.com>
In-Reply-To: <20190326075324.GA25748@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 26 Mar 2019 09:54:20 +0200
Message-ID: <CAFCwf106g4jcjZkERQauAmKFpnTrOo37ufJ1treMA8LBmP+jhQ@mail.gmail.com>
Subject: Re: [git pull] habanalabs fixes for 5.1 rc2/3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 9:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 21, 2019 at 05:28:16PM +0200, Oded Gabbay wrote:
> > Hi Greg,
> >
> > A couple of important fixes for habanalabs driver:
> >
> > - Fix host crash upon resume after suspend
> > - Fix MMU related bugs which result in user's jobs getting stuck
> > - Fix race between user context cleanup and hard-reset which results in
> >   host crash
> > - Fix sparse warning
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> >
> >   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-03-21
> >
> > for you to fetch changes up to 2198b040b98cfbed62716692a34eb971e0383f93:
> >
> >   habanalabs: cast to expected type (2019-03-03 10:23:29 +0200)
> >
> > ----------------------------------------------------------------
>
> There is no text at all in your tag :(
>
> You need to put something there, like "here are the fixes that do..." or
> some sort of explaination for why this set of patches need to be pulled
> in.  That way it shows up in the merge commit properly.
>
> Can you fix this up and resend?
>
> thanks,
>
> greg k-h

Ok, didn't know that. I'll get to it right away.

Oded
