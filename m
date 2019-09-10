Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF6C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A919A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TR8pm1x+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfIJJKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:10:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46731 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:10:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id i8so16285648edn.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iez8yZGFDi4oceFiuNT2xGD/UPWI8Mn1wAE4EZBiLGs=;
        b=TR8pm1x+5+93McH11wJzi98SRcpwX5O2y8OG42hvagT/7UHiVtW74HMGcwPXJf0w7w
         Cn/lBBy9lD0+a7/880e7d1bukGpYVoiffeuNMtO4uCUjgsaO1QDM5OXZ7vAjJXCmCZBf
         0C3LJWyRj++f193R8TKq7WnBTx9mP7PZ+ipVafA1tfCFnGBYz11HYgU5XTuffl9M0q77
         37d590kwYGCiNDXpAWRB06js2XfjxPKlJVcbyLIzRqjFCoI3DPkk3fEGVoCsNMEuxt+m
         vPhmqXKJXvkOAhLiQdPlCSlO3p1Z1SWiiL8Xcy+XjoSFfzFlXHja1JiLUV61MJ33GZkW
         hqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iez8yZGFDi4oceFiuNT2xGD/UPWI8Mn1wAE4EZBiLGs=;
        b=U0M1+V+gvF2r5UnPZnshM2r43HpMPHyrCmKeZXj8P7TEtVDgJR9aI47mKKWaQrg264
         H8I8nLFawDjOc7MRGcAElMgyM4uQBg/gnRp/hdHJJKP4MbglQydv/3gzCux7izMyeqUl
         XVheabE0B/S3UweilxuKLQbLup5XqJ/NjjR9sWR8fwfP5H0exKa0tcHJK9BScrJWXPve
         V5BoPvLDPPpa2RMIxVA6wfq8wBgLacecN9YHQ4TIPrInEY0sX7nt5QmH+O4e/5B1qJog
         XIAW57d2r+5ysAg/l4DnlYUGIEe+/pzRaPVZGEbFUxgSDFxp+kvWI4B98wlDXgcCLVC3
         1GqA==
X-Gm-Message-State: APjAAAV+hfYOVFo7TIeOu3gljHpddrt57z6f5g6OptR2JTII8AZ5rwlY
        ytwHZfAdFOSB40WZT5DDC4YcfPtdy4T1UHKXJsj39g==
X-Google-Smtp-Source: APXvYqw+MTXYLCZAfKQw+KljBbFHBLzEFXSK8JFfP6Xtr05eeItHAJhmdBtQMKUlIJDozLSmFBiEb9Xc0kOqfyUvFTE=
X-Received: by 2002:aa7:dd17:: with SMTP id i23mr28774906edv.124.1568106637988;
 Tue, 10 Sep 2019 02:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-5-pasha.tatashin@soleen.com> <e2ceb43a-d7bf-e0c6-c3ea-b83c95ba880d@suse.com>
In-Reply-To: <e2ceb43a-d7bf-e0c6-c3ea-b83c95ba880d@suse.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 10 Sep 2019 10:10:26 +0100
Message-ID: <CA+CK2bAsW0ExS2a2ZaGUmF2igKE7TM0qdCSYMaJn=0+pkM7ugQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/17] arm64: hibernate: use get_safe_page directly
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 09/09/2019 20:12, Pavel Tatashin wrote:
> > create_safe_exec_page() uses hibernate's allocator to create a set of page
> > table to map a single page that will contain the relocation code.
> >
> > Remove the allocator related arguments, and use get_safe_page directly, as
> > it is done in other local functions in this file to simplify function
> > prototype.
> >
> > Removing this function pointer makes it easier to refactor the code later.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
>

Thank you
