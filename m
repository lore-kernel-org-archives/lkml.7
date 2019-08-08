Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A8C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C413C2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VF3jDH9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbfHHJKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:10:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40879 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:10:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so94085193wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WnFIjQXgXX4HpQXzl5d7aVjF1IceK98bHXgNRMC9R2E=;
        b=VF3jDH9x6fKheMED4hVWQ8723aTsAzeXO4+U76l9DaXiSjQ7ti9kzSceMqkQ6CVLZq
         wmlcYHvIYOwNRWmR2Fh9CVcoh5ZS0YdBt6zvw1zf07TYBL0PCP3vNE5Fa5hJ0Qgjt+88
         URAnwPx5TCorNNqTejslQXJFIv8GHkaZUkhs20ThbkeX3pyH+7mi+/fBZv3aVQiKWcUP
         MSLWVUqy7A3ENmkDGZxM08VEWHvIbLVjQMv1s+7m6vLJdpaYHX5hZ+16YbSMo93ykdpD
         dWlAIHem4V3yAPe8RrrP71YKaUUHqfIOyOEqRqaa6iWWF8hs6SfywBTNu7QvNGxp1/xf
         z3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WnFIjQXgXX4HpQXzl5d7aVjF1IceK98bHXgNRMC9R2E=;
        b=g9Nsk3t2mr/+QIjc/WDMrLqvaYfhg5wXIMyNpd8fw8t4ycXO7VtML5iVZdFPG9ncBL
         RSpLimHUcUnjYikEwV6JtjX3ZR2sVEGYL1pdrJh9R7kBin4ThtbxG94dGRsqH6JXPqZI
         8rTB694QiQImHIYXYBFRHUTC3zHjEXcLYzagMlm4BI6JJB3VCzSwTI5kb+gnp3Fx5JvD
         tT2Dhrl7+01hdStDXh3Zxa2+H7pv6nDLs2TynNBse8JNy5Lr9X7x+7updhEAqz2BOAS2
         TrH1lA9DqEli5nn9M8IAkAyGdJ7Y3coZsRkjxWp45+pJAg8sPSTgqV2DeqQjG//sQaLa
         7PAg==
X-Gm-Message-State: APjAAAV6DWS450rpxo0l6xay++pHwyJODoOxqE417P1HAbhT/XFV7/nD
        qRvBeoGdk7X+jMSxouT7kCZidw==
X-Google-Smtp-Source: APXvYqw1FHVUwPlw6iYZqQAZJ93EKvuYj5LGADMHUw4SVlFTgX4blYNt06zxPwkO71y36ndHrmUsMw==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr16182614wrq.29.1565255450068;
        Thu, 08 Aug 2019 02:10:50 -0700 (PDT)
Received: from [192.168.0.100] (84-33-64-52.dyn.eolo.it. [84.33.64.52])
        by smtp.gmail.com with ESMTPSA id n9sm143533129wrp.54.2019.08.08.02.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 02:10:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6cfd07de-f5a8-78ea-405a-0243061cb620@eikelenboom.it>
Date:   Thu, 8 Aug 2019 11:10:48 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A27F793-838B-4329-8C26-8768ED9BBD8A@linaro.org>
References: <6cfd07de-f5a8-78ea-405a-0243061cb620@eikelenboom.it>
To:     Sander Eikelenboom <linux@eikelenboom.it>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 8 ago 2019, alle ore 11:05, Sander Eikelenboom =
<linux@eikelenboom.it> ha scritto:
>=20
> L.S.,
>=20
> While testing a linux 5.3-rc3 kernel on my Xen server I come across =
the splat below when trying to shutdown all the VM's.
> This is after the server has ran for a few days without any problem. =
It seems to happen consistently.
>=20
> It seems it's in the same area as =
dbc3117d4ca9e17819ac73501e914b8422686750, but already rc3 incorporates =
that patch.
>=20
> Any ideas ?
>=20

Could you try these fixes I proposed yesterday:
https://lkml.org/lkml/2019/8/7/536
or, on patchwork:
https://patchwork.kernel.org/patch/11082247/
https://patchwork.kernel.org/patch/11082249/

I posted a further fix too, which should be unrelated. But, just in =
case:
https://lkml.org/lkml/2019/8/7/715
or, on patchwork:
https://patchwork.kernel.org/patch/11082521/

Crossing my fingers (and think you for reporting this),
Paolo

> --
> Sander
>=20
>=20
> [80915.716048] BUG: unable to handle page fault for address: =
0000100000000008
> [80915.724188] #PF: supervisor write access in kernel mode
> [80915.733182] #PF: error_code(0x0002) - not-present page
> [80915.741455] PGD 0 P4D 0=20
> [80915.750538] Oops: 0002 [#1] SMP NOPTI
> [80915.758425] CPU: 4 PID: 11407 Comm: 17.hda-2 Tainted: G        W    =
     5.3.0-rc3-20190807-doflr+ #1
> [80915.766137] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , =
BIOS V1.8B1 09/13/2010
> [80915.773737] RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
> [80915.781294] Code: 00 00 00 00 00 00 48 0f ba b0 20 01 00 00 0c 48 =
8b 88 f0 01 00 00 48 85 c9 74 29 48 8b b0 e8 01 00 00 48 89 31 48 85 f6 =
74 04 <48> 89 4e 08 48 c7 80 e8 01 00 00 00 00 00 00 48 c7 80 f0 01 00 =
00
> [80915.796792] RSP: e02b:ffffc9000473be28 EFLAGS: 00010006
> [80915.804419] RAX: ffff888070393200 RBX: ffff888076c4a800 RCX: =
ffff888076c4a9f8
> [80915.810254] device vif17.0 left promiscuous mode
> [80915.811906] RDX: 0000100000000000 RSI: 0000100000000000 RDI: =
0000000000000000
> [80915.811908] RBP: ffff888077efc398 R08: 0000000000000004 R09: =
ffffffff81106800
> [80915.811909] R10: ffff88807804ca40 R11: ffffc9000473be31 R12: =
ffff888005256bf0
> [80915.811909] R13: 0000000000000000 R14: ffff888005256800 R15: =
ffffffff82a6a3c0
> [80915.811919] FS:  00007f1c30a8dbc0(0000) GS:ffff88807d500000(0000) =
knlGS:0000000000000000
> [80915.819456] xen_bridge: port 18(vif17.0) entered disabled state
> [80915.826569] CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [80915.826571] CR2: 0000100000000008 CR3: 000000005d9d0000 CR4: =
0000000000000660
> [80915.826575] Call Trace:
> [80915.826592]  bfq_exit_icq+0xe/0x20
> [80915.826595]  put_io_context_active+0x52/0x80
> [80915.826599]  do_exit+0x774/0xac0
> [80915.906037]  ? xen_blkif_be_int+0x30/0x30
> [80915.913311]  kthread+0xda/0x130
> [80915.920398]  ? kthread_park+0x80/0x80
> [80915.927524]  ret_from_fork+0x22/0x40
> [80915.934512] Modules linked in:
> [80915.941412] CR2: 0000100000000008
> [80915.948221] ---[ end trace 61315493e0f8ef40 ]---
> [80915.954984] RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
> [80915.961850] Code: 00 00 00 00 00 00 48 0f ba b0 20 01 00 00 0c 48 =
8b 88 f0 01 00 00 48 85 c9 74 29 48 8b b0 e8 01 00 00 48 89 31 48 85 f6 =
74 04 <48> 89 4e 08 48 c7 80 e8 01 00 00 00 00 00 00 48 c7 80 f0 01 00 =
00
> [80915.976124] RSP: e02b:ffffc9000473be28 EFLAGS: 00010006
> [80915.983205] RAX: ffff888070393200 RBX: ffff888076c4a800 RCX: =
ffff888076c4a9f8
> [80915.990321] RDX: 0000100000000000 RSI: 0000100000000000 RDI: =
0000000000000000
> [80915.997319] RBP: ffff888077efc398 R08: 0000000000000004 R09: =
ffffffff81106800
> [80916.004427] R10: ffff88807804ca40 R11: ffffc9000473be31 R12: =
ffff888005256bf0
> [80916.011525] R13: 0000000000000000 R14: ffff888005256800 R15: =
ffffffff82a6a3c0
> [80916.018679] FS:  00007f1c30a8dbc0(0000) GS:ffff88807d500000(0000) =
knlGS:0000000000000000
> [80916.025897] CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [80916.033116] CR2: 0000100000000008 CR3: 000000005d9d0000 CR4: =
0000000000000660
> [80916.040348] Fixing recursive fault but reboot is needed!

