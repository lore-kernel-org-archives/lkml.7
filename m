Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA33C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F562070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pEGWv8XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2JlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:41:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2JlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:41:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so1249993wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=f4sEI9yG6GpMwqHITTXcIshL6zD0jAjZRybb4dnfs7U=;
        b=pEGWv8XIyBlPvoBMuLhmJCRnsakkEZvpMkDr63LRYi25eLXJnV1RzXsBbMgi3iZIYj
         ExH1tQ4KjTdkrims0DrRkrkNoZnhI+CBoSPEf6r/PhVTlaOqT+0kuIuFdy9JnCnHm/C2
         fuRwh2MJDJMKDmybw+7wm4OwR3GmgqPrIrk5QfkQGOCK03VtX3rgtaM/fD9XMqa+8M+C
         iFyBrpOj0AZlxJrHjoQF4OUIAI0I0W9c2moVukJcm61YqREWq9PaXv/t00+2GioyiBmO
         LLNVM3R0n4kBjL23YyCePBMkCjXy24zxsZZZFkuPd3eMPl9rPVUw5izRkehAk0TDfoPY
         k07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f4sEI9yG6GpMwqHITTXcIshL6zD0jAjZRybb4dnfs7U=;
        b=qHYPO+BKG17xIVfhRH6pEYlX9snuNlOVLNj3Q7RPmB8rUp363nmzxGbnUsSHtFlxRU
         aMstn19pyYDO2k9Y77Aznv2XB965e/5SgUgzcYOFh9rXT0oV9mKxX+4kI3bgck67m1Lk
         XLX2+Ktv/l2aRCNecUN7WLoirMlWZq6KVfSMOEWGRnuXgQoKxPz44mVIj6RRQwFElvM1
         1dvBVyE6Bhi7XHQDDnEIwIZAAZIRaeluHlUDHPYi3J9DnzJQlYkM+TCnMrsHc+BSUWUk
         HYxZ6RREKsfgDF5cNAUVZZ3hm9KN1BXpXOmPF8VoD8IiPbBOtlXnoE/1hRhKSxlM/T+6
         cX8A==
X-Gm-Message-State: APjAAAWalvw1MpWRz7vLw0Rb+ur6e7yMbT56MjlwLq3G7j9qoyV2Vii2
        et9YQDTseulBPVtHTCJNTYJoIQ==
X-Google-Smtp-Source: APXvYqybPz/dJgD/pPZK0boCv7Be6LJq3uXqA8v5HAX5Laduz+DAmgPPLkF2uW55sxcJpAGjkvuELQ==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr73549530wrj.182.1559122877662;
        Wed, 29 May 2019 02:41:17 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f20sm4727482wmh.22.2019.05.29.02.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:41:17 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Karsten Merker <merker@debian.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Testing the recent RISC-V DT patchsets
In-Reply-To: <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com> <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com> <86o93mpqbx.fsf@baylibre.com> <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
Date:   Wed, 29 May 2019 11:41:11 +0200
Message-ID: <86zhn54myw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 May 2019 at 17:35, Karsten Merker <merker@debian.org> wrote:

> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.com> wr=
ote:
>>=20
>> > An update for those testing RISC-V patches: here's a new branch of=20
>> > riscv-pk/bbl that doesn't try to read or modify the DT data at all, wh=
ich=20
>> > should be useful until U-Boot settles down.
> [...]
>> > Here is an Linux kernel branch with updated DT data that can be booted=
=20
>> > with the above bootloader:
>> >
>> >    https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-e=
xperimental
>> >
>> > A sample boot log follows, using a 'defconfig' build from that branch.=
=20=20
>>=20
>> Thanks Paul, I can confirm that it works.
>>=20
>> Something is still unclear to myself.
>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>=20
>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs on
>> running /init.
>>=20
>> Would you have any pointer on what riscv-pk does that OpenSBI/U-boot doe=
sn't ?
>> Or maybe it is the other way around - OpenSBI/U-boot does something that
>> extra that should not happen.
>
> Hello,
>
> I don't know which version of OpenSBI you are using, but there is
> a problem with the combination of kernel 5.2-rc1 and OpenSBI
> versions before commit
>
>   https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d=
40c82649c
>
> that can result in a hang on executing init, so in case you
> should be using an older OpenSBI build that might be the source
> of the problem that you are experiencing.
>

Hello Karsten,
That was it ! This fixes the issue I had on init execution.
Good catch, thanks a lot for the help !

Regards,
Loys


> Regards,
> Karsten
> --=20
> Ich widerspreche hiermit ausdr=C3=BCcklich der Nutzung sowie der
> Weitergabe meiner personenbezogenen Daten f=C3=BCr Zwecke der Werbung
> sowie der Markt- oder Meinungsforschung.

