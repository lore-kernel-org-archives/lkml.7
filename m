Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CABC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2921874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aW5e6lCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfH3DrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:47:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35421 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfH3DrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:47:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34so6234120qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZw4Pw9NdpmFzMDAaoh2/CiCenjoO+xtgLvv0Q7UjN8=;
        b=aW5e6lCRjh861Z3S8/UvOM5+PUm3WVunItFwmfs9SYpgePdO/KYGWZ47dixt5VhFtm
         1kVdZbqNsj1LEHwaDVzHzfaRc3rNQQYqf0VDRSvRQ56mf3q9Y0jPxip06pGzOmD9ck4h
         3FzkqA0wD0joegIt3qKZCHFmY1nxslDZTLAEMtu3F/YUHqbvsQT9uXjN21gHspy0TuJy
         t+v8Uze+SpDRHn7Uxbh/KiXgjaeror/fUuloirQGThZ1HmjswxCjct6Nd1gvLwYcIJ1H
         zeOasiMBhPrdvv35fHX8gvdYOXpMFQqRr63bFZ2fhLgwbsjRBZDJtwsuzf2KOXNA0vnE
         yoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZw4Pw9NdpmFzMDAaoh2/CiCenjoO+xtgLvv0Q7UjN8=;
        b=eccR1D+AkdXl1v5ThF7bp3RbcKP+TA86pc7w1E9Qi999x+WeIWCTOsBdBqQjBnqSlF
         rwl3eTklWcGUHCyqI0P1sOyOp7/CUpEWyG+inTCBu8v6wnCaz1NQQ7Nr1bUKYU7DEBAl
         q5p+ubCS0KlOYlqWFBFllGxMnNovbc3AhcIPLPa8gxCJwpceYVhsnOCpfxxOR5tvQrBS
         chj7WbpHyuttR1x8pnLgmjS7jubEB4lVDgwPkQXRMoWyaI/pi4nnypyDLk4cagsEsNr+
         yDmnGnx6pTn7BLMCfcKiYc4dGOLyUWXmEh5exVuVBQVNFqDBYYTLV00lwVNRMi27cLcN
         k/wQ==
X-Gm-Message-State: APjAAAXZuDMZvkfR8t9elgXkCBgm4mva2/Z03Wf1oFyJJRVWIA4E1wKu
        +siDFHeEY7y2vBf9OfTiG1pECslak++cry6c6bCCtQ==
X-Google-Smtp-Source: APXvYqxc02lc5CqJLnQbj16SE/wQ+yQVKYegZmYDf0KKwKgT/e/ILip5vbosJCfh9Aji6fhGDIDICLOVETBFTeiOx98=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr13618958qtc.110.1567136834352;
 Thu, 29 Aug 2019 20:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190829091232.15065-1-kai.heng.feng@canonical.com>
 <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de>
 <793CCD4F-35E0-46B9-B5D4-3D3233BA5D35@canonical.com> <alpine.DEB.2.21.1908292143300.1938@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908292225000.1938@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908292225000.1938@nanos.tec.linutronix.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 30 Aug 2019 11:47:02 +0800
Message-ID: <CAD8Lp46vG2TEAareYnLNLACkLOoNmsvUoFS64e+zgNfq0DH6EA@mail.gmail.com>
Subject: Re: [RFD] x86/tsc: Loosen the requirements for watchdog - (was
 x86/hpet: Disable HPET on Intel Coffe Lake)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, harry.pan@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, Pu Wen <puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Aug 30, 2019 at 5:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> So if we have to disable the HPET on Kaby Lake alltogether unless Intel
> comes up with the clever fix, i.e. poking at the right registers, then I
> think we should also lift the TSC watchdog restrictions on these machines
> if they are single socket, which they are as the affected CPUs so far are
> mobile and client types.
>
> Also given the fact that we get more and more 'reduced' hardware exposed
> via ACPI and we already dealt with quite some fallout with various related
> issues due to that, I fear we need to bite this bullet anyway anytime soon.

Thanks for the explanation here!

My experience in this area is basically limited to the clock-related
issues that I've sent your way recently, so I don't have deep wisdom
to draw upon, but what you wrote here makes sense to me.

If you can outline a testing procedure, we can test upcoming patches
on Coffee Lake and Kaby Lake consumer laptops.

Thanks,
Daniel
