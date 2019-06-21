Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58609C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDDB2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCehu0cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFURMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:12:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56234 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFURMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:12:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so6982308wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxr2lSdUhJgiTc5D2qMkfm5yMBvV0zsum9CKhKZLKz4=;
        b=wCehu0cCKZdI0SqRemOcP+Jn913NqS5nSwotxkFEFo5+dPmAtz98iMU2wgRqCjFI/e
         mfJHcD6e3Xprhrb6TswjZuQ5BO33gux+9KU3rr2Lp4nxHKiQtODWN60aOqc8Bgj3TIh/
         tqfZHDPiQdwUZ7SkWBB+PP9i0DtUcFWK2kJF8kR7sqguXYAmNzuLpV/HoLY9VKKsxDs5
         0uNZj/It2Gjca0mOMdmL2lqX0vPV3cCPE9R0kOgEgVL6I4ZJclhj2GCJWjpvZUhK4U4a
         hOAIQflzgT+NnohAEOQQq4eM/KzhCa070OPFMc0pWwBhITwIWUxa01b+9KCgXcQGO2w4
         fNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxr2lSdUhJgiTc5D2qMkfm5yMBvV0zsum9CKhKZLKz4=;
        b=hzZKuJztR0I9T9GVSxInm7V8sq9jIVVD6G7VAf4mJVZdhDP2B6Yf9IJdN5ZBTqkUGy
         6YdOPyUjLCtg7AVMrFguSvUfP4bgLHSqdDb3jKTzETv69iKkGUY5vvE/JqXchQW8PtdA
         yy3gaJXIq8ozWPlfhwflWm7U+NASdG9br6wBWwNfYcBxGmbLeVwoo+QFOR6G2HN2TQtt
         hg7Wwjfbuni683Vq8kJwzJhCxFBTqvLAKQ3zMO1I31WIrBMzAH2WoTUIljE/L83m8dhJ
         kl3l0y+cARZArMIHfDxPm2lDl4Sj3BmVY+kdn1ZIKEtF5XRVGYT61O6kz0tNPDb+HQbj
         FB0w==
X-Gm-Message-State: APjAAAXZZpDmsWHw71EfuV4N+9nQzcB0433GRjFXCRuMz9lrSK/84xkl
        tnyaSKj1F7dhVoGT+4jG2Z0BmHtUCGXJxwjtwLJW
X-Google-Smtp-Source: APXvYqywL6fNwbUpFL//brGYmRCCnNuSg/TYeHcfUUEF0hSGIlVkbA14J2PQH52TmeF3M+qF5tLucTRd8fAuLAIi+2E=
X-Received: by 2002:a1c:9ecd:: with SMTP id h196mr5008540wme.98.1561137124525;
 Fri, 21 Jun 2019 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190621163921.26188-1-puranjay12@gmail.com>
In-Reply-To: <20190621163921.26188-1-puranjay12@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Jun 2019 12:11:52 -0500
Message-ID: <CAErSpo5TMPokae7BMY8ZcOXtW=GeGsWXX_bqS8SrZnh0pEQYxw@mail.gmail.com>
Subject: Re: [PATCH 0/3] net: ethernet: atheros: atlx: Use PCI generic
 definitions instead of private duplicates
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:39 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> This patch series removes the private duplicates of PCI definitions in
> favour of generic definitions defined in pci_regs.h.
>
> Puranjay Mohan (3):
>   net: ethernet: atheros: atlx: Rename local PCI defines to generic
>     names
>   net: ethernet: atheros: atlx: Include generic PCI definitions
>   net: ethernet: atheros: atlx: Remove unused and private PCI
>     definitions
>
>  drivers/net/ethernet/atheros/atlx/atl2.c | 5 +++--
>  drivers/net/ethernet/atheros/atlx/atl2.h | 2 --
>  drivers/net/ethernet/atheros/atlx/atlx.h | 1 -
>  3 files changed, 3 insertions(+), 5 deletions(-)

Let's slow this down a little bit; I'm afraid we're going to overwhelm folks.

Before posting more to LKML/netdev, how about we first complete a
sweep of all the drivers to see what we're getting into.  It could be
that this will end up being more churn than it's worth.  You could
send the result to linux-kernel-mentees, Shuah, me (but not LKML and
netdev), and then we can talk about whether it should be posted all at
once, as several series, etc.
