Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCAA214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573581275;
	bh=Ua9UrxbuWpTREDVckC9mOPVVtqvHEOjNV1brqlRg7JY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qux4OAlm+n44Rggc83fGfh+QvWgN0PRlNcIuU4pzSf/KdtkVpAgfR7Rj7P4n4DYLB
	 D7E5mKYBgBjj8HWuqtn+1qJc1bmrbO9hTVwEMbA+wm/uFe4T65MgqWi11iJqR278wv
	 jv3xNW6zyETvwpvCQWzD/wrW1ZXARmWI2sScX8PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKLRyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:54:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45913 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfKLRy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:54:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so18829044ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9/3cBw+s1St4spxQYIlofga3jANKje6wVfYU7Z8I14=;
        b=XArryZV/v4RmtTO4Uz8dg1dXkxZB1fxbh+wisjfXATawAXtZq8WaEDH0Xo5G0TfMHC
         GpvFN/7I4mKoAqw8+MhDIyW+CxF8fSw7n3q6QTJsVFKwHaHAuMEbhXUmfpTnaN/xr2Pe
         /LxmamUpQTbHpSF6mu+lfYlInTwgYktnh3+xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9/3cBw+s1St4spxQYIlofga3jANKje6wVfYU7Z8I14=;
        b=dcCRMG1vlPYWj+Q3pTqmOvKYs6bNjDLeZFA7bjPjyDUtGEoExeVYidp3GHQvWe2LOr
         r3Sk7W6pJiA2nVQI/kHeI1ccuUTCaY2MFm/a+kDUhuLcZfgVsh161HZvHa6lCDpgtOjU
         0aA7UP08sWC8WGhB2wqTpDTDrTPqeju8POW0Z9+SWsLafmj78aycDYnW/ziewdDnAyP4
         /MaIcYPGCTXZfN+p74ZRxHBj0b0oyMypEjP9zej5O1cVFO5gSBOl324skM2wKioFazDw
         M8uqmTTPf/Jg7WfAzpcX55hV0uAUPxj41GXXuPYEXPOv03rDxf135euHWQx5K6M6Jc4E
         /ukw==
X-Gm-Message-State: APjAAAVDKllQfPJIVhOJD3UstmcDXXKngYBZIpM3al1d5Xdm+O+BkHu9
        7RpkB8Yz0C1k6qvQI+jR28KQQSrJvX8=
X-Google-Smtp-Source: APXvYqzUoLxQFA3wxhiNP53eFHPr8ZCTmOxCW3OpG+slBi26EQXS0UrgMzEkZO9ME9QwaUON6XFOkw==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr21464831ljn.88.1573581265274;
        Tue, 12 Nov 2019 09:54:25 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id d24sm3781723ljg.73.2019.11.12.09.54.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:54:24 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n21so18828901ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:54:24 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr21291645ljp.133.1573581263488;
 Tue, 12 Nov 2019 09:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20191112130244.16630-1-vincent.whitchurch@axis.com> <20191112160855.GA22025@arrakis.emea.arm.com>
In-Reply-To: <20191112160855.GA22025@arrakis.emea.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 09:54:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=LHkmw9SS066X_00TszjWzj-5t4F3ODua8W_tagVb=w@mail.gmail.com>
Message-ID: <CAHk-=wi=LHkmw9SS066X_00TszjWzj-5t4F3ODua8W_tagVb=w@mail.gmail.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read hazard
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> While you can add some barrier here, there may be other cases where this
> can go wrong.

Yeah, that patch isn't going to be accepted. We don't add random arch
workarounds to core header files like that - particularly when it's
not at all clear that there aren't hundreds of other cases where that
cpu errata can trigger..

                Linus
