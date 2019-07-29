Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BA7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BBC2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hYU/+XcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfG2LwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:52:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53985 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfG2LwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:52:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190729115220euoutp02ab853a4d2bcedea55e755ba07a4bf7c7~13ox05m2R1852918529euoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 11:52:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190729115220euoutp02ab853a4d2bcedea55e755ba07a4bf7c7~13ox05m2R1852918529euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564401140;
        bh=gp3W8C8kFm2/cZPC6dvOVHLsDheOwe7O7ni8wdNNKh8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hYU/+XcSESJ3ny8NRgh38MlEw27iqI8itUskxkeUHb1GISBjglwPCDEFI3+W6LLyj
         tQh1phrgQxaDOwljaukbmo4bgVIA0CkfW/oOSmAEHu/ZwTdunbBHr9SWg5uBtWBtxs
         F2slwaQT8JYjmHTTqvw4xig1rJSSngli0T++k+FA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190729115219eucas1p202d0b90eb0a461d27e89caa7b1723730~13oxLu8mQ0970109701eucas1p2m;
        Mon, 29 Jul 2019 11:52:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.84.04298.3FDDE3D5; Mon, 29
        Jul 2019 12:52:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190729115218eucas1p26d902f7fe92ed478c8674c4e661e4ba7~13owERqTd1766217662eucas1p2l;
        Mon, 29 Jul 2019 11:52:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190729115218eusmtrp2f36a65dec3323f5f949a27954114a539~13ov2PK9D3066930669eusmtrp2B;
        Mon, 29 Jul 2019 11:52:18 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-bb-5d3eddf3e682
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.EE.04146.2FDDE3D5; Mon, 29
        Jul 2019 12:52:18 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190729115217eusmtip17c879854ef64b77b38d271dcad87fd19~13overT571225412254eusmtip1g;
        Mon, 29 Jul 2019 11:52:17 +0000 (GMT)
Subject: Re: [PATCH v3] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Staudt <max@enpas.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3fb686e0-1f60-b7c3-5b88-83f63e56a563@samsung.com>
Date:   Mon, 29 Jul 2019 13:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUGsfzQg8xy2OqWfuo09MxwZ5OJz=t5CARJp+A1ZVtqaA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7qf79rFGjTfk7RYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFsUl01Kak5mWWqRvl0CV8bF7QfYCpYoVay+voa5gfG7VBcjJ4eEgInEgd+d
        rF2MXBxCAisYJWbtvMYO4XxhlNj68RmU85lRYsqiw4xwLdvmMEIkljNKtO9/wQLhvGWU2PNg
        DitIlbBAoET7teXMILaIgKfErzXL2ECKmAXamCQO3t3ODpJgE7CSmNi+Cmwsr4CdxMTtc8Bs
        FgFVib8XL4A1iwpESNw/toEVokZQ4uTMJywgNifQgomnj4DZzALiEreezGeCsOUltr+dwwyy
        TELgELtE55njQMs4gBwXiZZbXhAvCEu8Or6FHcKWkfi/E6QXpH4do8TfjhdQzdsZJZZP/scG
        UWUtcfj4RVaQQcwCmhLrd+lDhB0llu5fxgIxn0/ixltBiBv4JCZtm84MEeaV6GgTgqhWk9iw
        bAMbzNqunSuZJzAqzULy2Swk38xC8s0shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn
        525iBKal0/+Of9rB+PVS0iFGAQ5GJR5eh5u2sUKsiWXFlbmHGCU4mJVEeLcoWccK8aYkVlal
        FuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYBST1Th2RTXw42uWua/5
        VugcSVpdVrZQKUYhMqg9I/nwjV/TtxmoN0QcWPs+z/eB9zrlHWddZl+ebT1fsSKnifvxpbiZ
        xf4m7ueDOgyrd7CbiQrxftliU7zZ/bvwdvEW/1kHz0su3eUtISP1+gJT24mAbxcFPgkslJt2
        79kBbrbss+92fPh50kaJpTgj0VCLuag4EQD/h26URwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7qf7trFGrw9zG+x+m4/m8WzW3uZ
        LGa/V7Y4tuMRk8XlXXPYLHa/v89o8bDpA5PF3Nbp7A4cHoe/bmbz2DnrLrvH5bOlHocOdzB6
        HDx3jtHj8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYyL2w+wFSxRqlh9fQ1zA+N3qS5GTg4JAROJA9vmMHYxcnEICSxllNg6Yz9TFyMH
        UEJG4vj6MogaYYk/17rYIGpeM0q82rWRBSQhLBAo0X5tOTOILSLgKfFrzTKwImaBDiaJyV+X
        s0J0HGeSuL9vJlgVm4CVxMT2VYwgNq+AncTE7XPAbBYBVYm/Fy+A1YgKREiceb+CBaJGUOLk
        zCdgNifQtomnj4DZzALqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsC
        RpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgXG47djPzTsYL20MPsQowMGoxMPrcNM2Vog1
        say4MvcQowQHs5II7xYl61gh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgemiLySeENTQ3ML
        S0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYymz97mnMvb4WG99O2RSw/4fJ7L
        iLc7bWqqrODf8PrViRBtj8gd6xRmyPffK495rv/76+1JPAKdKyr5n3f5RnS4+/ybW8z34ZHz
        Ec3IO53KJ9Zdvfx4QnrO9U/yx8MyYg/5fNLc3vb61YdH6m1pqhk7l6pbnnE0kZybzyAny/Nt
        fuzEvb+nPw5WYinOSDTUYi4qTgQA6ZsMCNkCAAA=
X-CMS-MailID: 20190729115218eucas1p26d902f7fe92ed478c8674c4e661e4ba7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190729113035epcas2p213400dfb13ca10b4f24cedf856cf2187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190729113035epcas2p213400dfb13ca10b4f24cedf856cf2187
References: <20190725180825.31508-1-max@enpas.org>
        <CAMuHMdURm-9nazOBTL8uRH8WMt7gi=QUYy0qr9kaxzczCr+ujg@mail.gmail.com>
        <9cde6e79-52da-e0c0-f452-6afc2e5fa5ee@enpas.org>
        <CGME20190729113035epcas2p213400dfb13ca10b4f24cedf856cf2187@epcas2p2.samsung.com>
        <CAMuHMdUGsfzQg8xy2OqWfuo09MxwZ5OJz=t5CARJp+A1ZVtqaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 7/29/19 1:30 PM, Geert Uytterhoeven wrote:
> Hi Max,
> 
> On Mon, Jul 29, 2019 at 1:10 PM Max Staudt <max@enpas.org> wrote:
>> On 07/29/2019 11:05 AM, Geert Uytterhoeven wrote:
>>>> --- a/drivers/ata/pata_buddha.c
>>>> +++ b/drivers/ata/pata_buddha.c
>>>
>>>> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
>>>> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
>>>> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
>>>> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
>>>
>>> drivers/net/ethernet/8390/zorro8390.c also matches against
>>> ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, while only
>>> a single zorro_driver can bind to it.  Hence you can no longer use both
>>> IDE and Ethernet on X-Surf :-(
>>> Before, this worked, as the IDE driver just walked the list of devices.
>>
>> Okay, now this gets dirty.
>>
>> The reason why I've submitted this patch is to allow pata_buddha to be built into the kernel at all. Without this patch, its initcall would be called before the Zorro structures are initialised, hence not finding any boards.
> 
> IC. I wasn't aware of the new pata_buddha.c driver not working at all
> when builtin.

Isn't the same true also for old buddha.c driver?
(please see below)

>> That means that not only would the previous driver only make sense as a module that is manually ensured to be loaded after Zorro has started, but the X-Surf IDE support was a really ugly hack to begin with.
> 
> Right. Please note that most drivers for Zorro boards predate the device
> driver framework, and thus all started life using zorro_find_device().
> But this did have the advantage of supporting multi-function cards
> out-of-the-box.
> Later, several drivers were converted to the new driver framework.
> but not all of them, due to multi-function cards.
> 
>>> I think the proper solution is to create MFD devices for Zorro boards
>>> with multiple functions, and bind against the individual MFD cells.
>>> That would also get rid of the nr_ports loop in the IDE driver, as each
>>> instance would have its own cell.
>>>
>>> I played with this a long time ago, but never finished it.
>>> It worked fine for my Ariadne Ethernet card.
>>> Last state at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd
>>>
>>> Oh, seems I wrote up most of this before in
>>> https://lore.kernel.org/lkml/CAMuHMdVe1KgQWYZ_BfBkSo3zr0c+TenLMEw3T=BLEQNoZ6ex7A@mail.gmail.com/
>>
>> This looks great!
>>
>> Unfortunately, I don't have any MFD hardware other than a single
>> Buddha to test this with. I especially don't have an X-Surf, hence no
>> good way of testing this other than the two IDE channels on my Buddha.
>> WinUAE doesn't seem to emulate the IDE controller either.
>>
>> What shall I do? Maybe as a stop-gap measure, we could hard-code a
>> module_init() again, just for X-Surf? It's been good enough until a
>> few weeks ago, so what could go wrong ;)
> 
> In the short run: keep on using drivers/ide/buddha.c?

IDE subsystem is initialized even before libata so I cannot see how
this would help?

drivers/Makefile:
...
obj-$(CONFIG_IDE)               += ide/
obj-y                           += scsi/
obj-y                           += nvme/
obj-$(CONFIG_ATA)               += ata/
...
obj-$(CONFIG_ZORRO)             += zorro/
...

What am I missing?

> Your single Buddha should be sufficient to convert pata_buddha.c from
> a plain Zorro driver to an MFD cell driver, and test it.
> I expect the buddha-mfd.c MFD driver from my zorro-mfd branch to
> work as-is, or with very minor changes.
> 
> However, to keep X-Surf working, this needs to be synchronized with
> a Zorro MFD conversion of the zorro8390 driver, too.
> 
>> On another note: Maybe your MFD idea could be used to expose the
>> clockports on the Buddhas as well? That wouldn't solve the issue of
>> clockport *expansions* being fundamentally non-enumerable, but maybe
>> you can think of a reasonable way to attach a driver?
> 
> Yes, the clockport could be added as an extra MFD cell.  Later, drivers can
> be written to bind against the clockport cell.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
