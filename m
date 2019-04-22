Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF962075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRdwyv9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfDVWy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:54:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35729 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfDVWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:54:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so11664424ljc.2;
        Mon, 22 Apr 2019 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sa0sj+SqbFLJtcUjJxzjircvPJEjja3JARBb+oDNqk=;
        b=hRdwyv9ShjSgXPEHxrqgTqja6A1jzA1rp1bEo3ThA1XX9sMqtLxisbz7jYlNhPRZES
         Mr+6NGzI+FMVT6Sgnnsk8qDT28YyrCJiGfD7I7SH6BV+IywpybbkIDNezHEyUpKvRq7U
         6V30Y/p+LchB6363JW9s/W53wo/+s09CMTjqwH2vyS5bCqK0MzML6fTZl42IAfvlxLTy
         7AKUtkXJgd0SO8zLcl4Oq1rvCf4nrMj4J9aJdatgptPzKxvkIaVEcs/3vJTqwvZUftT4
         mEBaW//uAwdkzBcc+J+ALHNTIY6MWUDutMR6Xv7Wz6BrThYJXoHGOtlGprH037VM7uZb
         Rulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sa0sj+SqbFLJtcUjJxzjircvPJEjja3JARBb+oDNqk=;
        b=aPWDPKGZHP93HLeu9pGzMf9g6OZAMPxaXn9+4iQ3O5tJjVH1RYLpdzgDf3/TYUQAbI
         CxnH2CPBy/BfOzZyA68LbGTGUWiCpraUZCUJ8vNJlNwUkmADE8iYiQUunjmgFwfH8mee
         bC05dBIEZvTb7PNnHs5yZceBwXX91BJjWiGtiv/52oQMzYUlBUSru+18TelJG5IM3xWW
         qY/QeXKUSO6J1JWK7cLOONgkdsVdSX3iHaQW4CE56a/pdo0JevXGB3HxdQNfEV2cafKC
         Fuffqi51VgHBfeCOLyWs0EZZj4wSLAHH9oN+ONvnTXCJuPcHDaPdbPogRrRyolawR1nL
         6I4Q==
X-Gm-Message-State: APjAAAVvPvM0M0B4/W1iL0GW3wm4gTFsG2WArOpL4I0se+3Fu97cWCGA
        YzXJFnqZ3pCLLI1B5KQgFvAXm2lBEzZAyqthaTg=
X-Google-Smtp-Source: APXvYqxcnF3NJSoc8ffirhMgxRZdzv5KB0PbpJvHgMZKWkodtfdoDu7rxGFUaneSgQkmhoG3fDg4PR/hfnk7e+GnOcE=
X-Received: by 2002:a2e:9812:: with SMTP id a18mr7731554ljj.146.1555973666070;
 Mon, 22 Apr 2019 15:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190423084501.15824b18@canb.auug.org.au>
In-Reply-To: <20190423084501.15824b18@canb.auug.org.au>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 22 Apr 2019 19:54:22 -0300
Message-ID: <CAOMZO5B4MA8kjxk+nYdwMhBHM4OKPFe0RsQyHibNkcewkdjOpw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 7:45 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> arch/arm/boot/dts/imx7d-zii-rpu2.dts:46.12-50.4: Warning (io_channels_property): /iio-hwmon: Missing property '#io-channel-cells' in node /soc/aips-bus@30400000/adc@30610000 or bad phandle (referred from io-channels[0])
>
> Caused by commit
>
>   69ab5392f517 ("ARM: dts: Add support for ZII i.MX7 RPU2 board")

Andrey has submitted a fix for this issue:
https://lkml.org/lkml/2019/4/14/168
