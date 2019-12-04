Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B01C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E22073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="OYmGaBOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfLDTup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:50:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:50:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so603569wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4td+J/y8zL+0kbu/mhl0o3220/b/42t+qrkDa4+tfk=;
        b=OYmGaBOx0ht+4SVFQ8LShoz8qHD00vVsn9YoIESp213aFXGm3e4D9RewEL4BslOr2F
         h3yuRIZp7zblcpOsSfEMh1mlizj0lDpv7HuSC02848MWR4DMOcxC7wMy4amITCpB9NfG
         fGl1Kv3xlDMpTfBlwN9nuSZnBObMPbxfadAjbKRb9gVUAImnxShb6LQvE0ipnwt8qCO3
         ZaMj5YSrN270/2qLQLNUbCVQwFELkxg3RqFqGrzBiUEPgqLRP15yixWkAjm3N6FFb2zs
         wdDeFVQvk9J1BvCObwBBdQ+0JoTShRSkfroLKxwXGpjGVcAn2vXPzERPI6ydfmz4/GBF
         hWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4td+J/y8zL+0kbu/mhl0o3220/b/42t+qrkDa4+tfk=;
        b=Nh4lzl1lNHoH+ln5p0HOR2D37XK1M4LKujTN1kNi7F7uXCvGPrj+9eivxkIZs30DYK
         9wI5/9eXBkLRObQrQ5swsG1kvKQco3ysqKCAfStpoh2uPY7OjfXyyOjnksulQ/kOwdB/
         Z/6UKrSf7ZBwCYoa0vueKXiIribb/L1uuA511Gg6qZ4tbuGpF7/smtb3MdEB10NrcFni
         t0+K+JlGQBgxFuabeOYueal965obxrFf4UDnIn32hzGWAYf65knpmEHbkPlQZfWRHi9o
         nbrPst9JIH9ao1o17VeMRaB92Gay2UdfN8Mj5QGIBIanjyNR4et3cQZtjMFDj5YeZrOM
         IUIA==
X-Gm-Message-State: APjAAAWvDViLRmSDOKE6LdnnIeb1N4iBQDwG/H78pTLDbuYeaDLplEh4
        U4S9pTQ8M8/JV6ZBOxYPgpsYw4xWO37ix+eBtDcrEg==
X-Google-Smtp-Source: APXvYqyfhH1mfipFn2hXP6Wg78v6VpoqDikrwF6VjZX8J/+QWbJZxgRYeoR7HdjjJHf5hWk9qYLs4gNjoa/mpfyXGfg=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr5792679wro.195.1575489043186;
 Wed, 04 Dec 2019 11:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com> <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
In-Reply-To: <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 4 Dec 2019 11:50:31 -0800
Message-ID: <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 11:41 AM Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 7:30 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> > Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
> > is busmastering on when the kernel is loaded?
>
> It's only relevant where firmware configures the IOMMU but then
> removes that configuration before handing control to the OS. I'm not
> aware of that happening anywhere other than EFI.

Wouldn't it also be applicable in the much simpler case where the
firmware hands over control with no IOMMU configured but also with the
busmastering bit cleared.  Does firmware do this?  Does the kernel
currently configure the iOMMU before enabling busmastering?

--Andy
