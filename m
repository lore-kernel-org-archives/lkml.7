Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB6CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9FD2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552434056;
	bh=dDatgJnqxZjEx3ZvIZHYFXTAqw4K4WWgaS8xhNNdXT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yxsNu5BMa2dOVj/keghvcruQcsbB7JKME/07kACN3WILyZKlTbmOFoKOA1e2rlO3d
	 9+TLXiFLYE6Q6c0sWojFNDJnGGm1XKrF5ixG6xcyJOsCIGwKwLwXAfijeKLfI/KGfK
	 wNBdIbW15E4m+BdJ1gd/edw0i2uxpFxp6oYkwDK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfCLXky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:40:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44030 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfCLXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:40:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id z20so3862416ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsKe3e/rRCB2ilvS5ByoqjhLaNrBbXFuuZeU6FgWeaw=;
        b=DjU2Rz9c9ubVU3V1ayfdP/hErH6gw2To1kUnCQUGS4VJZWaNbwt205P09+S3qjzN2k
         WenjmgdKgP73MPbkLgL/pUz9ztGUC024sXplE7oUmC82HDSbK1astxS3sCqGiNVRbDQ+
         CRCqNWNr3Ht8xKXv5477pKlAnRk+7LEII/MUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsKe3e/rRCB2ilvS5ByoqjhLaNrBbXFuuZeU6FgWeaw=;
        b=MtWJkl2PmUVEB8vmmsWJAxiL/6DRjQYUERHwU8qiKn1yqjOPcMbVmL6GaI3J+Bud38
         UaOe+XKj/Fq82uhzv5cxVLKeFqc/h3WQ1d+fEV9t1/yqdgLfRYCdwJnzZwtiW7iSHJuS
         VchVlDb8ndbhLJ4fNLCTCvyKp6MzpreeHZVb1QVlEdQgAdpA2lEUNenQMq+/oeVghXD/
         OSPwpoVSiYzPttWHMXZdZbicBLEvUTdh6cmeTxaVNKehx2v23WpbceX3oqhBptdFT7bu
         xdt2Lm3j4s1reA0NSa/+1sgGKYN3b7xYdmcbAQdHJ+qgDNxfcA2Z4yE6bXPuIYO2BMVr
         gkqg==
X-Gm-Message-State: APjAAAXxguCRN5Cp3lpaAefNjdP1WSYxEwk0j4oKiziC9FqKJP0BPbLd
        Xa/ycGtf7V2pF3AQuiu87NizFuclve0=
X-Google-Smtp-Source: APXvYqxIme6lND1dpOtCclhxKcxOMuSiQ1GN3Pn/a/bX0byxUfLSwKTSBIqr+GiGRVDH+YwHNvyQmQ==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr19115764ljc.188.1552434050715;
        Tue, 12 Mar 2019 16:40:50 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j16sm1986340lfh.81.2019.03.12.16.40.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 16:40:49 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h6so84435lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:40:49 -0700 (PDT)
X-Received: by 2002:a19:700e:: with SMTP id h14mr21654369lfc.67.1552434049202;
 Tue, 12 Mar 2019 16:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <6283638.XALati16HY@blindfold> <CAHk-=wixZBzR5nbPZ3Y1=VahyVDsqVZhRfRhewJybx2-yA_FEQ@mail.gmail.com>
In-Reply-To: <CAHk-=wixZBzR5nbPZ3Y1=VahyVDsqVZhRfRhewJybx2-yA_FEQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Mar 2019 16:40:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiR64B3MY852L64auE8ZGBhfFoTNXG=F=h5TVEM5gxRtg@mail.gmail.com>
Message-ID: <CAHk-=wiR64B3MY852L64auE8ZGBhfFoTNXG=F=h5TVEM5gxRtg@mail.gmail.com>
Subject: Re: [GIT PULL] UBI/UBIFS updates for 5.1-rc1
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 12, 2019 at 8:13 AM Richard Weinberger <richard@nod.at> wrote:
> >
> >   git://git.infradead.org/linux-ubifs.git tags/upstream-5.1-rc1
>
> Pulling this thing is taking forever for me. I can _ping_ the site,
> but the "git pull" has been hanging for a while.

Ok, after leaving it for an hour and a half I just gave up. It's not worth it.

Put your repos on some other host, and re-send the pull requests,

                   Linus
