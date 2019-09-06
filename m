Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BAAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC2320838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="E1edasld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405195AbfIFTAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:00:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44189 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfIFTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:00:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id p2so6056496edx.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrjX9gD4VIauKO9U5B9UI5Q0lIvPgAd5pEYZKOh182w=;
        b=E1edasldtuMUUwkDEeQ56lGV0qKHCc+ezSSI7PED72qKwm8givcI1UCheonDF+81rU
         DZOhA3PS5YT2Z+lRz68MmcNRorzwGoqu0KRyVhZh73RM5K5J8t3dDYLms/P0kTbvPtec
         7X0KIeg9UYHi7xjL3yLM/8gmOM3hLlwYmIHLEfMReHliOIdzcdvn9E3msksKAtQuGev3
         ToWGr15CVcoDF6P+lIE/dr4tO9E1aQqZPQUs26CFG4bEXIw89ZNUvP34ZpJRGdaObYaM
         GKhb6NJJySchkPl9O+1tmmIYBIgS1VoHFBQ5g7ReLTaEQvcU+kkN7J8ip6j/ozSYTNfg
         lfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrjX9gD4VIauKO9U5B9UI5Q0lIvPgAd5pEYZKOh182w=;
        b=pWfxe3i8GPHDjefz54at6EKGM7PeSQdf42KCgTjSR2nkxIck9w4/r/LrZmYbxnDVn6
         GahLZ9XX8vhiUkFOzAvD5PoArVVgqKPBEoMQ97JoD6WWFZZZNepBcQxB8CSX8qUsUrEx
         gKvrW0UE9OugiLyimb+9/hwkK5IIDNbPWRlIUV1eT94UbM+sthXbJipFvy7LAKWeprzv
         J6Vbj4Z+/4s3I2Ur6xlwpS1MSoTxQXn7YBR6T3GtHN4W7C8uA48Dqd2S/m7vQiH/gwOY
         0DlkzsA2s/neYC7Xg6o8kKUnRLDiS1Dq86DKHCcl/pMw8r+vnwS8XF2zWDNzoJpZHRLu
         EazQ==
X-Gm-Message-State: APjAAAWa35/0jxrBakYtg0+JvBZqw2ebjDo3sCJ/PdBookzjGnIDAn12
        Ssl/sC4gaGH9Zwe/BIB12tyRv+h2r6WH6ZwFrcrm7w==
X-Google-Smtp-Source: APXvYqySdTqXeFzwKDdERIUW6O7satVNK6R7jE0J4FvXnhmNRURLOur3h+Xuy9x0CmE+4eeQW35qwli0Re25EqwHAFE=
X-Received: by 2002:a17:906:bb0f:: with SMTP id jz15mr8571853ejb.264.1567796416697;
 Fri, 06 Sep 2019 12:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-10-pasha.tatashin@soleen.com> <2d9f7511-ce65-d5ca-653e-f4d43994a32d@arm.com>
In-Reply-To: <2d9f7511-ce65-d5ca-653e-f4d43994a32d@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 15:00:05 -0400
Message-ID: <CA+CK2bAkimTmsj-iGVq6AkMMNAb7+J5wm-Ra-qovS+3Ou5j33w@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] arm64, trans_pgd: add trans_pgd_create_empty
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:20 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > This functions returns a zeroed trans_pgd using the allocator that is
> > specified in the info argument.
> >
> > trans_pgds should be created by using this function.
>
> This function takes the allocator you give it, and calls it once.
>
> Given both users need one pgd, and have to provide the allocator, it seems strange that
> they aren't trusted to call it.
>
> I don't think this patch is necessary.
>
> Let the caller pass in the pgd_t to the helpers.

Ok.

Thank you,
Pasha
