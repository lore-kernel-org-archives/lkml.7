Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE21C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978B02184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFw4U+Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbfHHKVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:21:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50369 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbfHHKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:21:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so1856233wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8P5zAdPVdet8v3GL+58Hj4zkwcQ24EYEc31mCmld6FY=;
        b=KFw4U+LeLdgmnrFZilfwVAUipWXgc6H45sWEnDwEOK54RWFibqaoTq/pT402WZFnXs
         UjrkQWbc4Wyl1ybyPd7laSwqcnYEt7QMp39jo4T8DHvuEdzQlqL74iAbj41Ok102PXFT
         GOT+46NwX7/S/HZz3F+BepRQmIc3+E6AtQrV1hlbeyvF/VHV5mB4qZFbLR7HVQ8cTsI1
         AUXdNP/n+FeIyg3Vg2bdWFrVc9D+nGh0m1Sk0wNjhxjYWSfACOGn7SalFJ+PItMsAAZD
         /Qs05aETppCaLA19kKzTDf1UQ/Sq4+8Wqax/4Avm2wdA3ZOLxZc3+6tO9qtEpA5453dR
         ZKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8P5zAdPVdet8v3GL+58Hj4zkwcQ24EYEc31mCmld6FY=;
        b=MtdXqL/j2O7aYxJUV07sarO3IX7uXRwAqtBQCsbHn0kNBl6RQHVfKpybXM9BzKWzAy
         h2aOSQ5YwzWn1gcfaoGlHrHSejIHqfu2Pk+kju6pxZtjkdz1CEhDbFDpwqEWf4C3yPLp
         UnS7nRuPqM6AkD6Y7FbkP6Giz4SBeuU1AZ2QpTib6V14mncwXrwd0rhTPdPIUwQmXyBU
         0EcvyYO1wTc5mYOxGy3FGkTIQ9f6wGdH1PsNWvkxlQSt4A3DPsOW9Jlv6BQkXZwMJoxo
         tlcb1qK/Vxg4j5rQJq/4hy4NW0G70lJsUDowDdR3Me4oD6HVZWmV4hB7T8yei8bdTEgw
         oqNg==
X-Gm-Message-State: APjAAAUsQqCOIVBS5CxZ+okjrvsATcsKTZxcp7Dqe/UlAUfhynICMVWh
        qP7USwmV/Ld3GKLmMnq7XMKx2vRg/kM=
X-Google-Smtp-Source: APXvYqxw9Na6k6tojYSLlGArMgea9ErvhZA6zdJR2qzJzvOXreMHWL0u97wQktTSj7aTimMpmHjA9g==
X-Received: by 2002:a7b:c632:: with SMTP id p18mr3640845wmk.114.1565259708956;
        Thu, 08 Aug 2019 03:21:48 -0700 (PDT)
Received: from [192.168.0.100] (84-33-64-52.dyn.eolo.it. [84.33.64.52])
        by smtp.gmail.com with ESMTPSA id 5sm1645644wmg.42.2019.08.08.03.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 03:21:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1d2e8bf8-902e-3e3c-ce0f-78efedf82209@eikelenboom.it>
Date:   Thu, 8 Aug 2019 12:21:47 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E34CECED-072D-449D-91F1-2ECF8DF53612@linaro.org>
References: <6cfd07de-f5a8-78ea-405a-0243061cb620@eikelenboom.it>
 <6A27F793-838B-4329-8C26-8768ED9BBD8A@linaro.org>
 <1d2e8bf8-902e-3e3c-ce0f-78efedf82209@eikelenboom.it>
To:     Sander Eikelenboom <linux@eikelenboom.it>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 8 ago 2019, alle ore 12:21, Sander Eikelenboom =
<linux@eikelenboom.it> ha scritto:
>=20
> On 08/08/2019 11:10, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 8 ago 2019, alle ore 11:05, Sander Eikelenboom =
<linux@eikelenboom.it> ha scritto:
>>>=20
>>> L.S.,
>>>=20
>>> While testing a linux 5.3-rc3 kernel on my Xen server I come across =
the splat below when trying to shutdown all the VM's.
>>> This is after the server has ran for a few days without any problem. =
It seems to happen consistently.
>>>=20
>>> It seems it's in the same area as =
dbc3117d4ca9e17819ac73501e914b8422686750, but already rc3 incorporates =
that patch.
>>>=20
>>> Any ideas ?
>>>=20
>>=20
>> Could you try these fixes I proposed yesterday:
>> https://lkml.org/lkml/2019/8/7/536
>> or, on patchwork:
>> https://patchwork.kernel.org/patch/11082247/
>> https://patchwork.kernel.org/patch/11082249/
>=20
> Hi Paolo,
>=20
> These two above seem to fix the issue !
> So thanks for the swift reply (and the patchwork links for easy
> downloading the patches).
>=20
> I will test the third unrelated patch as well, but if you don't hear
> back , it's all good.
>=20

Great! Thank you for offering to test also the other patch. Tested-by =
are welcome too :)

Thanks,
Paolo

> Thanks again !
>=20
> --
> Sander
>=20
>> I posted a further fix too, which should be unrelated. But, just in =
case:
>> https://lkml.org/lkml/2019/8/7/715
>> or, on patchwork:
>> https://patchwork.kernel.org/patch/11082521/
>>=20
>> Crossing my fingers (and think you for reporting this),
>> Paolo
>>=20
>>> --
>>> Sander
>>>=20
>>>=20
>>> [80915.716048] BUG: unable to handle page fault for address: =
0000100000000008
>>> [80915.724188] #PF: supervisor write access in kernel mode
>>> [80915.733182] #PF: error_code(0x0002) - not-present page
>>> [80915.741455] PGD 0 P4D 0=20
>>> [80915.750538] Oops: 0002 [#1] SMP NOPTI
>>> [80915.758425] CPU: 4 PID: 11407 Comm: 17.hda-2 Tainted: G        W  =
       5.3.0-rc3-20190807-doflr+ #1
>>> [80915.766137] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , =
BIOS V1.8B1 09/13/2010
>>> [80915.773737] RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
>>> [80915.781294] Code: 00 00 00 00 00 00 48 0f ba b0 20 01 00 00 0c 48 =
8b 88 f0 01 00 00 48 85 c9 74 29 48 8b b0 e8 01 00 00 48 89 31 48 85 f6 =
74 04 <48> 89 4e 08 48 c7 80 e8 01 00 00 00 00 00 00 48 c7 80 f0 01 00 =
00
>>> [80915.796792] RSP: e02b:ffffc9000473be28 EFLAGS: 00010006
>>> [80915.804419] RAX: ffff888070393200 RBX: ffff888076c4a800 RCX: =
ffff888076c4a9f8
>>> [80915.810254] device vif17.0 left promiscuous mode
>>> [80915.811906] RDX: 0000100000000000 RSI: 0000100000000000 RDI: =
0000000000000000
>>> [80915.811908] RBP: ffff888077efc398 R08: 0000000000000004 R09: =
ffffffff81106800
>>> [80915.811909] R10: ffff88807804ca40 R11: ffffc9000473be31 R12: =
ffff888005256bf0
>>> [80915.811909] R13: 0000000000000000 R14: ffff888005256800 R15: =
ffffffff82a6a3c0
>>> [80915.811919] FS:  00007f1c30a8dbc0(0000) GS:ffff88807d500000(0000) =
knlGS:0000000000000000
>>> [80915.819456] xen_bridge: port 18(vif17.0) entered disabled state
>>> [80915.826569] CS:  10000e030 DS: 0000 ES: 0000 CR0: =
0000000080050033
>>> [80915.826571] CR2: 0000100000000008 CR3: 000000005d9d0000 CR4: =
0000000000000660
>>> [80915.826575] Call Trace:
>>> [80915.826592]  bfq_exit_icq+0xe/0x20
>>> [80915.826595]  put_io_context_active+0x52/0x80
>>> [80915.826599]  do_exit+0x774/0xac0
>>> [80915.906037]  ? xen_blkif_be_int+0x30/0x30
>>> [80915.913311]  kthread+0xda/0x130
>>> [80915.920398]  ? kthread_park+0x80/0x80
>>> [80915.927524]  ret_from_fork+0x22/0x40
>>> [80915.934512] Modules linked in:
>>> [80915.941412] CR2: 0000100000000008
>>> [80915.948221] ---[ end trace 61315493e0f8ef40 ]---
>>> [80915.954984] RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
>>> [80915.961850] Code: 00 00 00 00 00 00 48 0f ba b0 20 01 00 00 0c 48 =
8b 88 f0 01 00 00 48 85 c9 74 29 48 8b b0 e8 01 00 00 48 89 31 48 85 f6 =
74 04 <48> 89 4e 08 48 c7 80 e8 01 00 00 00 00 00 00 48 c7 80 f0 01 00 =
00
>>> [80915.976124] RSP: e02b:ffffc9000473be28 EFLAGS: 00010006
>>> [80915.983205] RAX: ffff888070393200 RBX: ffff888076c4a800 RCX: =
ffff888076c4a9f8
>>> [80915.990321] RDX: 0000100000000000 RSI: 0000100000000000 RDI: =
0000000000000000
>>> [80915.997319] RBP: ffff888077efc398 R08: 0000000000000004 R09: =
ffffffff81106800
>>> [80916.004427] R10: ffff88807804ca40 R11: ffffc9000473be31 R12: =
ffff888005256bf0
>>> [80916.011525] R13: 0000000000000000 R14: ffff888005256800 R15: =
ffffffff82a6a3c0
>>> [80916.018679] FS:  00007f1c30a8dbc0(0000) GS:ffff88807d500000(0000) =
knlGS:0000000000000000
>>> [80916.025897] CS:  10000e030 DS: 0000 ES: 0000 CR0: =
0000000080050033
>>> [80916.033116] CR2: 0000100000000008 CR3: 000000005d9d0000 CR4: =
0000000000000660
>>> [80916.040348] Fixing recursive fault but reboot is needed!

