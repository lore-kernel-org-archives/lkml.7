Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1017DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A262084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHwDUYqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfDAH3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:29:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46156 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbfDAH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:29:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so10469641wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gaqm0/7fomoSrPkoeDCPunTkVBxBVw4Yjb19GCrzBFU=;
        b=hHwDUYqtOcTmur6++aAkbaDa1GL+TUaLtFX7r3vQkahbGlUqVrzKtl/tFdUbNTOK21
         e8c9jn1kXiIGLOLTCr1E0E4o07McA+UFtzl0FmN6F7NyIykgTCHCbwbOq/J01agDY3n9
         ps4zXtU9jfstlAekJqBkMnP8GSrz9T/rCVqWjWes7hOZWOKuBpN6wyx6gqgQ9NtRCZDi
         TukHT2VdPU9YTYGRJhCgUV3FTFZQFbmFNFTueYoG6nnof2XTae5qce6KDO7VEj94YeRU
         K4+3ewUT3ZDAdcCnzRuwaqa1waXp2l3ZS7Yk9WzY5aaCboRYdVIgd/7q6uKJJxH/OXxM
         u5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gaqm0/7fomoSrPkoeDCPunTkVBxBVw4Yjb19GCrzBFU=;
        b=ITFkXqlkU/T0HrBkpag2XbXZTtbCF8rl6vrId4fDYPxu02PeuQSR1E1W+H07WuVJGA
         Y8soS78J9tug3nL4r7EIgmD3qrMbsAEvWrkpPS8M2GzbZKLOajp+vhLGE8hC3GQeaBs5
         H5Qf0vyabwZJGuJ2+SCQt/Ixg3QhNyxyxLxoOI0+RuS3lrn87RG6B6F9l1wFfD6IXtl2
         TbTm6O9qedoqQziVLWuPeTEDUS6MLSqm+YEFVmELVe8Zzfn+idp2XnjPvi6PhmuglOfn
         dZeS5sMSM1/Kpc7eP3gS29rwlhWlfkU+I2qYh7MkGUrKXVnU6NI9JFoR4HBkxL3rMY76
         eXSg==
X-Gm-Message-State: APjAAAWLW+3dl5W3bLpDrH6Cd3k9VbBwPSpcTIOsYUkg5xe8ZegM6/t6
        negi++J6doTNmZnvddfno9E4aw9BlpM=
X-Google-Smtp-Source: APXvYqwFsvT4STd/ANqfu3EnN+qqKBKN2f1OUO8b0AdCjJrzj7dNvAwd5/ee4C97gibr5t3M13Ngmg==
X-Received: by 2002:adf:c788:: with SMTP id l8mr30478343wrg.143.1554103758420;
        Mon, 01 Apr 2019 00:29:18 -0700 (PDT)
Received: from [192.168.0.101] ([88.147.53.253])
        by smtp.gmail.com with ESMTPSA id n189sm13990976wmb.28.2019.04.01.00.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:29:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
Date:   Mon, 1 Apr 2019 09:29:16 +0200
Cc:     Dmitrii Tcvetkov <demfloro@demfloro.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
 <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 29 mar 2019, alle ore 15:10, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 3/29/19 7:02 AM, Dmitrii Tcvetkov wrote:
>> Hi,
>>=20
>> I got kernel panic since v5.1-rc1 when working with files on block
>> device with BFQ scheduler assigned. I didn't find trivial way to
>> reproduce the panic but "git checkout origin/linux-5.0.y"
>> on linux-stable-rc[1] git repo on btrfs filesystem reproduces the
>> problem 100% of the time on my bare-metal machine and in a VM.
>>=20
>> Bisect led me to commit 9dee8b3b057e1 (block, bfq: fix queue removal
>> from weights tree). After reverting this commit on top of current
>> mainline master(9936328b41ce) I can't reproduce the problem.
>>=20
>> dmesg with the panic and bisect log attached.
>>=20
>> [1] =
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
>=20
> Paolo, can you please take a look at this?
>=20
>=20

Yep.

That you very much Dmitrii for also bisecting.  I feel like this
failure may be caused by the typo fixed by this patch:
https://patchwork.kernel.org/patch/10877113/

Could you please give this fix a try?

Thanks,
Paolo


> --=20
> Jens Axboe

