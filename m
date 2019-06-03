Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCBC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FFC2803C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F2OUPywV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFCJtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:49:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52190 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFCJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:49:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so10455264wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=j/q+dQU5QEVzcedEHboA/C4LUDOoFKTIbvHL7mdlN80=;
        b=F2OUPywVRqNGvuHhnmXmFNz96XnnIR9SzQdLvaoUpC+hJXZKKBDbW/4IgT5ZCgh9iD
         8Kl+SWzAIzwexVR+kmN4oCfCb/KJcyf8VTAud+xsybp1ryLa6dgLr30Lw06WPdmx2kRr
         KFFWcPsnoOeU7pdcETHQCqz8EHiWygmcNKnUH+o3T4cIJ2P+xpKxBsr4q3c3j4uJqRJ0
         hSsKiAMed2AD0BHIBtPz3mNeloQe4jQtaX1RQszRJmsDVs5s8cUYcRLw0TzvhKin5Nkf
         WXSvCPyXObf+fzjO7WYABkQS1r6hSmoJhKVHQbnyQUfZyLObBdtFhgkcICLSkqQ2WEKb
         ewzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j/q+dQU5QEVzcedEHboA/C4LUDOoFKTIbvHL7mdlN80=;
        b=UYfV/gUZH7PGNuCAbMyHZE4f7dA+x/9HD4vTaUhaHL5/uMysPYYkDJk97vZmF48KnF
         IWoV1PUlT0JvJJ6QPYlUtkExiAkiPtz2K+rsxi6Bc1CadDBAbtOZttl2y5dBR8yyhSCE
         /LZC8/5Ng7i1SKRc3P1Qz8Yyc3HJrW0FZxpcY0P4yW0Pv3OLeCfKtd3SkGCWGqI/DEGT
         4kdpS4NgCWSLAE2SpleLOr+xId3bb9GIkbmlnSd+Jm2AI0heYEiUEf5CWvGQZOaKZ1gS
         2WRA2Aa3iuIlzrjjxrCtffHeFmzedhJoIaCy6sqhixTeEGFMhAxmWnAHtW2aBlqkvHrx
         hiNQ==
X-Gm-Message-State: APjAAAU15MhbuRF0XPH8lgtZXtBBfjjQ/pMeTWH+82r2feBx9GGzAJFG
        J1giY3qaaMotR8H/mkyuabnRHA==
X-Google-Smtp-Source: APXvYqx0nlNUyxoYcjdSsxVjDlhe3OlFKryML03LIbZbVjhBYixeKXQz314bNZQI+jebMoxCyyoV0Q==
X-Received: by 2002:a1c:9906:: with SMTP id b6mr1655219wme.117.1559555391959;
        Mon, 03 Jun 2019 02:49:51 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y2sm25355651wra.58.2019.06.03.02.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 02:49:51 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: Testing the recent RISC-V DT patchsets
In-Reply-To: <BC002AAE-7EE6-404D-9204-D10263BEA5C9@sifive.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com> <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com> <86o93mpqbx.fsf@baylibre.com> <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de> <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com> <86woi94lvs.fsf@baylibre.com> <BC002AAE-7EE6-404D-9204-D10263BEA5C9@sifive.com>
Date:   Mon, 03 Jun 2019 11:49:46 +0200
Message-ID: <8636krhubp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 May 2019 at 12:25, Troy Benjegerdes <troy.benjegerdes@sifive.com>=
 wrote:

>> On May 29, 2019, at 5:04 AM, Loys Ollivier <lollivier@baylibre.com> wrot=
e:
>>=20
>> On Wed 29 May 2019 at 00:50, Atish Patra <atish.patra@wdc.com> wrote:
>>=20
>>> On 5/28/19 8:36 AM, Karsten Merker wrote:
>>>> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>>>>> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.com>=
 wrote:
>>>>>=20
>>>>>> An update for those testing RISC-V patches: here's a new branch of
>>>>>> riscv-pk/bbl that doesn't try to read or modify the DT data at all, =
which
>>>>>> should be useful until U-Boot settles down.
>>>> [...]
>>>>>> Here is an Linux kernel branch with updated DT data that can be boot=
ed
>>>>>> with the above bootloader:
>>>>>>=20
>>>>>>    https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1=
-experimental
>>>>>>=20
>>>>>> A sample boot log follows, using a 'defconfig' build from that branc=
h.
>>>>>=20
>>>>> Thanks Paul, I can confirm that it works.
>>>>>=20
>>>>> Something is still unclear to myself.
>>>>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>>>>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>>>>=20
>>>>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs on
>>>>> running /init.
>>>>>=20
>>>>> Would you have any pointer on what riscv-pk does that OpenSBI/U-boot =
doesn't ?
>>>>> Or maybe it is the other way around - OpenSBI/U-boot does something t=
hat
>>>>> extra that should not happen.
>>>>=20
>>>> Hello,
>>>>=20
>>>> I don't know which version of OpenSBI you are using, but there is
>>>> a problem with the combination of kernel 5.2-rc1 and OpenSBI
>>>> versions before commit
>>>>=20
>>>>   https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b5=
77d40c82649c
>>>>=20
>>>> that can result in a hang on executing init, so in case you
>>>> should be using an older OpenSBI build that might be the source
>>>> of the problem that you are experiencing.
>>>>=20
>>>> Regards,
>>>> Karsten
>>>>=20
>>>=20
>>> I verified the updated DT with upstream kernel for the boot flow OpenSB=
I=20
>>> + U-Boot + Linux or OpenSBI + Linux.
>>>=20
>>> OpenSBI should be compiled for sifive platform with following additiona=
l=20
>>> argument
>>>=20
>>> FW_PAYLOAD_FDT_PATH=3D<linux kernel=20
>>> source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
>>>=20
>>> FYI: It will only work when kernel is given a payload to U-Boot/OpenSBI=
=20
>>> directly.
>>>=20
>>=20
>> Hum, I am surprised by this statement.
>> I was able to verify the latest DT patch serie from Paul with:
>> OpenSBI + U-Boot + Linux & DT.
>>=20
>> Following the OpenSBI documentation [0] with U-Boot payload:
>> FW_PAYLOAD_PATH=3D<u-boot_build_dir>/u-boot.bin
>>=20
>> I get an U-Boot prompt and then I can just load the linux kernel and
>> device tree from the network.
>>=20
>> [0]: https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_f=
u540.md#building-sifive-fu540-platform
>>=20
>
> Could you confirm which git hash of U-boot you are building, and that the=
 .config matches
> the defconfig (or send me the .config you used)?

Sure,

OpenSBI: a6395acd6cb2c35871481d3e4f0beaf449f8c0fd
U-Boot: (origin/master) 344a0e4367d0820b8eb2ea4a90132433e038095f
Kernel: from Paul from this thread [1]

I use the sifive_fu540_defconfig of U-Boot with no additional changes.

[1] https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-exper=
imental

>
> I=E2=80=99d like to get everything that=E2=80=99s working integrated in o=
ne place into a freedom-u-sdk test branch.
>
>

Let me know the test branch when it's up :)

Loys

>>> Network booting is still not working as the clock driver probe doesn't
>>> happen because of the updated DT.
>>>=20
>>> --=20
>>> Regards,
>>> Atish
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
