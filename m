Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6102C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5CB20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5JWF3tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407733AbfJQELs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:11:48 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36577 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407691AbfJQELr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 00:11:47 -0400
Received: by mail-il1-f196.google.com with SMTP id z2so694304ilb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGz8qdq3Dw0gukgZrVxUVyXcJ/Gcz/OyEL/XFXnvkAM=;
        b=n5JWF3tD5Zg82bv6F8WCxSx1usc2qiyNCST0oWBdk5ZCXPwJe1l9NiLuV8BZsTP9Dt
         vko5Ctem7pHxv5Xy40Tq8+MVub/ziVVcY6A4zCTyE2Vs9TsVvdxvmRsizv3q8zxa7wiT
         HVpKaMEu/ZsfFkT1JMtp6PGVYh2dKLDuirimI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGz8qdq3Dw0gukgZrVxUVyXcJ/Gcz/OyEL/XFXnvkAM=;
        b=c8y65fMfLiVB85LRSCLBvLJNzIfr11dSpMSKmkAqB/mLM7ZVBG7zdSMslMzE0p3gsq
         uuyMbUjTpRBBnzvKr4+xekh8HwVDmYeZiAWR1706PxTD9l4Jqaudeuq+0Q8Z3DX/P1f3
         xuPy1SgTojw5zYDGHgLMbWIppzbYBqZdJuNUcuL0VucRObEzeLzgQNfQASAIcyjNqWEh
         2IkctgyejRPhPky0WPG0qaIJtF70hA63U39pZ2MeaKiZ4jysyUUbnUWV7D/N7HhjfEn8
         czM4cDZGKQr1VC4VxppRUjDrCUpFSAYJQsrKj9vz4dt5CpbxG2vNbLEJCi+B7pw+Dww6
         TiUg==
X-Gm-Message-State: APjAAAUj0BCAgPWxRIvy3qdcRwpo46BLDGhaifIIWxMMXjOg0aoAND2+
        +h4x+pl6xJVZqJFSzdsyuJVilLvCTJw=
X-Google-Smtp-Source: APXvYqwQK5v9SSrsCjbivEWwUVH3XlVmbkoDwj1JvbJ8akkHxTNC0kczxEHB3rKX3huAC7TxZ6O0NA==
X-Received: by 2002:a92:d392:: with SMTP id o18mr1504745ilo.256.1571285505441;
        Wed, 16 Oct 2019 21:11:45 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id z20sm339233iof.38.2019.10.16.21.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 21:11:45 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id z10so672123ilo.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:11:44 -0700 (PDT)
X-Received: by 2002:a92:d652:: with SMTP id x18mr1434259ilp.58.1571285504656;
 Wed, 16 Oct 2019 21:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191014154626.351-1-daniel.thompson@linaro.org> <20191014154626.351-5-daniel.thompson@linaro.org>
In-Reply-To: <20191014154626.351-5-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Oct 2019 21:11:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFMnNdPd_LHYMzRauH=82ZwuwB+QUizLsHT+o4X5q3yA@mail.gmail.com>
Message-ID: <CAD=FV=XFMnNdPd_LHYMzRauH=82ZwuwB+QUizLsHT+o4X5q3yA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] kdb: Improve handling of characters from different
 input sources
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 14, 2019 at 8:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently if an escape timer is interrupted by a character from a
> different input source then the new character is discarded and the
> function returns '\e' (which will be discarded by the level above).
> It is hard to see why this would ever be the desired behaviour.
> Fix this to return the new character rather than the '\e'.
>
> This is a bigger refactor than might be expected because the new
> character needs to go through escape sequence detection.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
