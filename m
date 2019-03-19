Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D77AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE4E20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="yU4ztIrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCSDPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:15:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35790 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCSDPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:15:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so2172798pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/g5shMExclC44bZgU+m0b5jjVwdDBAIFLmLk4oMubY=;
        b=yU4ztIrn0lEmaGjeISXIczB0Cf++niCPbf4ErCUQz65oU4oDnEscCMlQd3EEJvGEIC
         OTGXSwvFUl+iqkgfJGUdFMlkhtnBJ6PboTl+8nQfAXX6/3HJMhTrqghJzPUfRaIbtmHI
         FP2w5r1PtJ/xlphp4mokg+tgROFnwamNlnUtNSN/ZWP3ylQXMutdTbGP1e+Hcdg5+/eE
         qUgh4qsSlV8bOhiVYgqTp0soYcNXM2N0x4ViARk+qiygm5s/6CwqQlkm94NO3z6QCq7x
         LYlLJ0sSTzM1dLEMExhMirJBWoFXF625JcTyKPImGSOBirN29t6SkOgHfN1RBdmYAqU2
         uiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/g5shMExclC44bZgU+m0b5jjVwdDBAIFLmLk4oMubY=;
        b=k6GjEJLQEiuIEDPUvd5UOypmpa15hpe36SuEvEXpXdjEtVMyhJVMjAS1+C+/JnO5UM
         S2Si0ED0P97O0PchKhW/WumBGHgcGrsIPADwsqn71UxJ5bxKBn/bPQaL8S2AqOcW9XvY
         c7xY6dzL2Mm2fyq2GvAMFJK2PbA7+BN5+gAj6YS7gLDQAG5TuaLTgiyHvpdCoYjPWg5u
         bun7PPvd/W2j3c9NIYpCmkkAfVYj2igDn0ud0dpV3P5GCvgZK5BsG4OiZlxGXlEPAMbc
         ojgE49m2sbbqxFUnOP9narBVfazYWwcEELzWcojmg0gXKBpjTldqwHiTh4AEIsxuVXjx
         Absg==
X-Gm-Message-State: APjAAAWraBMr0EJ4dG/Qk98b55knIfjK4bezLYsceujiTgW1QwfSQVYj
        WVy1jh9KN4Cw+3Y+EqQzwGoPRg==
X-Google-Smtp-Source: APXvYqy9YrKsrBfNsETLGOiVWf7HssI2Y/q34jMa/TjN82uaRWuxpMdV3GVxRV+BXn9gytUPL/5ENA==
X-Received: by 2002:a17:902:bccb:: with SMTP id o11mr5929901pls.23.1552965350433;
        Mon, 18 Mar 2019 20:15:50 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id v9sm19105491pfg.130.2019.03.18.20.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 20:15:50 -0700 (PDT)
Date:   Mon, 18 Mar 2019 20:15:46 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>,
        <f.fainelli@gmail.com>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190318201546.7675e5ec@shemminger-XPS-13-9360>
In-Reply-To: <cfc4b528-8bda-6823-cdf8-f4d12eb95c85@huawei.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
        <20190318085724.1e0c017b@shemminger-XPS-13-9360>
        <cfc4b528-8bda-6823-cdf8-f4d12eb95c85@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 11:03:54 +0800
"wanghai (M)" <wanghai26@huawei.com> wrote:

> =E5=9C=A8 2019/3/18 23:57, Stephen Hemminger =E5=86=99=E9=81=93:
> > On Tue, 19 Mar 2019 01:06:57 -0400
> > Wang Hai <wanghai26@huawei.com> wrote:
> > =20
> >> When registering struct net_device, it will call
> >> 	register_netdevice ->
> >> 		netdev_register_kobject ->
> >> 			device_add(dev)
> >> 			register_queue_kobjects(ndev)
> >>
> >> If device_add(dev) or register_queue_kobjects(ndev) fails.
> >> Register_netdevice() will return error, causing netdev_freemem(ndev)
> >> to be called to free net_device, however (&ndev->dev)->kobj.name will
> >> not be freed, resulting in a memory leak.
> >>
> >> syzkaller report this:
> >> BUG: memory leak
> >> unreferenced object 0xffff8881f4fad168 (size 8):
> >> comm "syz-executor.0", pid 3575, jiffies 4294778002 (age 20.134s)
> >> hex dump (first 8 bytes):
> >>    77 70 61 6e 30 00 ff ff                          wpan0...
> >> backtrace:
> >>    [<000000006d2d91d7>] kstrdup_const+0x3d/0x50 mm/util.c:73
> >>    [<00000000ba9ff953>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
> >>    [<000000005555ec09>] kobject_set_name_vargs+0x55/0x130 lib/kobject.=
c:281
> >>    [<0000000098d28ec3>] dev_set_name+0xbb/0xf0 drivers/base/core.c:1915
> >>    [<00000000b7553017>] netdev_register_kobject+0xc0/0x410 net/core/ne=
t-sysfs.c:1727
> >>    [<00000000c826a797>] register_netdevice+0xa51/0xeb0 net/core/dev.c:=
8711
> >>    [<00000000857bfcfd>] cfg802154_update_iface_num.isra.2+0x13/0x90 [i=
eee802154]
> >>    [<000000003126e453>] ieee802154_llsec_fill_key_id+0x1d5/0x570 [ieee=
802154]
> >>    [<00000000e4b3df51>] 0xffffffffc1500e0e
> >>    [<00000000b4319776>] platform_drv_probe+0xc6/0x180 drivers/base/pla=
tform.c:614
> >>    [<0000000037669347>] really_probe+0x491/0x7c0 drivers/base/dd.c:509
> >>    [<000000008fed8862>] driver_probe_device+0xdc/0x240 drivers/base/dd=
.c:671
> >>    [<00000000baf52041>] device_driver_attach+0xf2/0x130 drivers/base/d=
d.c:945
> >>    [<00000000c7cc8dec>] __driver_attach+0x10e/0x210 drivers/base/dd.c:=
1022
> >>    [<0000000057a757c2>] bus_for_each_dev+0x154/0x1e0 drivers/base/bus.=
c:304
> >>    [<000000005f5ae04b>] bus_add_driver+0x427/0x5e0 drivers/base/bus.c:=
645
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Fixes: 1d24eb4815d1 ("xps: Transmit Packet Steering")
> >> Signed-off-by: Wang Hai <wanghai26@huawei.com>
> >> ---
> >>   net/core/net-sysfs.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> >> index 4ff661f..f0e53dc 100644
> >> --- a/net/core/net-sysfs.c
> >> +++ b/net/core/net-sysfs.c
> >> @@ -1745,17 +1745,22 @@ int netdev_register_kobject(struct net_device =
*ndev)
> >>  =20
> >>   	error =3D device_add(dev);
> >>   	if (error)
> >> -		return error;
> >> +		goto device_add_error;
> >>  =20
> >>   	error =3D register_queue_kobjects(ndev);
> >> -	if (error) {
> >> -		device_del(dev);
> >> -		return error;
> >> -	}
> >> +	if (error)
> >> +		goto register_error;
> >>  =20
> >>   	pm_runtime_set_memalloc_noio(dev, true);
> >>  =20
> >> +out:
> >>   	return error;
> >> +
> >> +register_error:
> >> +	device_del(dev);
> >> +device_add_error:
> >> +	kfree_const(dev->kobj.name); =20
> > This looks a bug in device_add() not here.
> > In general, it is better for an api to clean up after itself.
> > Since dev->kobj.name is created in device_add and normally freed
> > in device_del; why is device_add leaving it behind?\ =20
>=20
> When registering struct net_device, it will call
> register_netdevice ->
>  =C2=A0=C2=A0=C2=A0 netdev_register_kobject ->
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_set_name(dev, "%s", ndev->name)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 device_add(dev)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 register_queue_kobjects(ndev)
>=20
> The dev->kobj.name that causes the memory leak is created in=20
> dev_set_name(dev, "%s", ndev-> name) in the function=20
> netdev_register_kobject(), not in device_add(dev). If device_add(dev) or=
=20
> register_queue_kobjects(ndev) fails, it should release dev-> kobj.name=20
> in netdev_register_kobject()

Good catch, dev_set_name is using asprintf to allocate new memory
for the name. The problem with your patch is that device_del()
already cleans up the device (including name). The device object
should really not be touched after device_del.

Where is the name freed in the normal case?

