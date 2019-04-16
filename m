Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0598FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECC720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfDPLfP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:35:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbfDPLfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:35:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3164C5D8D5BD007EC094;
        Tue, 16 Apr 2019 19:35:10 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 19:35:06 +0800
Date:   Tue, 16 Apr 2019 12:34:53 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH] iio: accell: mma8452: free iio trigger
 pointer when cleanup
Message-ID: <20190416123453.00003e9d@huawei.com>
In-Reply-To: <DB3PR0402MB3916880099E1A5956B10BB74F5240@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554364635-19653-1-git-send-email-Anson.Huang@nxp.com>
        <20190407113939.0717a6c9@archlinux>
        <DB3PR0402MB39162CD8C7BF1431C16B378FF52C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
        <20190414150805.43420097@archlinux>
        <DB3PR0402MB3916880099E1A5956B10BB74F5240@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 05:28:12 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> Hi, Jonathan
> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > 
> > On Mon, 8 Apr 2019 02:07:24 +0000
> > Anson Huang <anson.huang@nxp.com> wrote:
> >   
> > > Hi, Jonathan
> > >
> > > Best Regards!
> > > Anson Huang
> > >  
> > > > -----Original Message-----
> > > > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > > > Sent: 2019年4月7日 18:40
> > > > To: Anson Huang <anson.huang@nxp.com>
> > > > Cc: knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net;  
> > Leonard  
> > > > Crestez <leonard.crestez@nxp.com>; gustavo@embeddedor.com;
> > > > martink@posteo.de; rtresidd@electromag.com.au;
> > > > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: [EXT] Re: [PATCH] iio: accell: mma8452: free iio trigger
> > > > pointer when cleanup
> > > >
> > > > WARNING: This email was created outside of NXP. DO NOT CLICK links
> > > > or attachments unless you recognize the sender and know the content is  
> > safe.  
> > > >
> > > >
> > > >
> > > > On Thu, 4 Apr 2019 08:02:05 +0000
> > > > Anson Huang <anson.huang@nxp.com> wrote:
> > > >  
> > > > > When mma8452 is built as module, once it is insmod and rmmod,
> > > > > below kernel dump will show out, the root cause is module being
> > > > > put twice if iio trigger pointer is NOT NULL, this patch frees iio
> > > > > trigger pointer after iio trigger is unregistered to avoid below
> > > > > kernel
> > > > > dump:
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 3 PID: 270 at kernel/module.c:1145  
> > > > module_put+0xd0/0x188  
> > > > > Modules linked in: mma8452(-)
> > > > > CPU: 3 PID: 270 Comm: rmmod Not tainted
> > > > > 5.1.0-rc3-next-20190403-00022-g5ede0c9-dirty #1596 Hardware name:
> > > > > Freescale i.MX6 Quad/DualLite (Device Tree) [<c011272c>]
> > > > > (unwind_backtrace) from [<c010d094>] (show_stack+0x10/0x14)
> > > > > [<c010d094>] (show_stack) from [<c0bdc160>]
> > > > > (dump_stack+0xd8/0x10c) [<c0bdc160>] (dump_stack) from
> > > > > [<c01275d8>] (__warn+0xf8/0x124) [<c01275d8>] (__warn) from
> > > > > [<c0127714>]  
> > > > (warn_slowpath_null+0x3c/0x48)  
> > > > > [<c0127714>] (warn_slowpath_null) from [<c01ca4d0>]
> > > > > (module_put+0xd0/0x188) [<c01ca4d0>] (module_put) from
> > > > > [<c08a5bb4>]
> > > > > (iio_device_unregister_trigger_consumer+0x18/0x24)
> > > > > [<c08a5bb4>] (iio_device_unregister_trigger_consumer) from
> > > > > [<c08a0ab4>] (iio_dev_release+0x20/0) [<c08a0ab4>]
> > > > > (iio_dev_release) from [<c065c0e8>] (device_release+0x24/0x8c)
> > > > > [<c065c0e8>]
> > > > > (device_release) from [<c0be1810>] (kobject_put+0x74/0xd4)
> > > > > [<c0be1810>] (kobject_put) from [<c0664dc0>]
> > > > > (release_nodes+0x16c/0x1f0) [<c0664dc0>] (release_nodes) from
> > > > > [<c0661b80>] (device_release_driver_internal+0xec/0x1a0)
> > > > > [<c0661b80>] (device_release_driver_internal) from [<c0661c90>]
> > > > > (driver_detach+0x44/0x80) [<c0661c90>] (driver_detach) from
> > > > > [<c066096c>] (bus_remove_driver+0x4c/0xa0) [<c066096c>]
> > > > > (bus_remove_driver) from [<c01cc1a4>]
> > > > > (sys_delete_module+0x130/0x1dc) [<c01cc1a4>] (sys_delete_module)
> > > > > from [<c0101000>]  
> > > > (ret_fast_syscall+0x0/0x28) Exception stack(0xe8d87fa8 to
> > > > 0xe8d87ff0)  
> > > > > 7fa0:                   0001ffc0 38616d6d be87bbf0 00000880 00000000  
> > be87be98  
> > > > > 7fc0: 0001ffc0 38616d6d 00323534 00000081 000a9744 be87bf81
> > > > > 000a9790
> > > > > 00000000
> > > > > 7fe0: be87bbe8 be87bbd8 0001fe18 b6e381a0 irq event stamp: 4017
> > > > > hardirqs last  enabled at (4035): [<c0188a0c>]
> > > > > console_unlock+0x400/0x630 hardirqs last disabled at (4052):
> > > > > [<c018868c>] console_unlock+0x80/0x630 softirqs last  enabled at
> > > > > (4050): [<c0102698>] __do_softirq+0x458/0x554 softirqs last
> > > > > disabled at (4069): [<c012ed6c>] irq_exit+0x130/0x180 ---[ end
> > > > > trace
> > > > > a7ba8f1823b1e073 ]---
> > > > >
> > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>  
> > > > Good fine, but the fix is not in the best place.  The key thing is
> > > > that any assignment inside a driver to iio_dev->trig should be done
> > > > with iio_trigger_get.
> > > >
> > > > indio_dev->trig = iio_trigger_get(trig).  The intent is to avoid
> > > > this exact double free, but also handle it correctly if we are using devm_  
> > for all the handling.  
> > > >
> > > > I just did a grep and there are quite a few drivers not doing this
> > > > though so it's one we should be more careful about.
> > > >
> > > > Hmm. Anyone fancy doing an audit of existing drivers and checking
> > > > which ones have this problem?  Some seem to do exactly what you have
> > > > here, but that isn't a the best pattern to encourage.
> > > >
> > > > For this one would you mind trying with the iio_trigger_get approach
> > > > and if I'm not missing something, send a v2 fixing it that way?  
> > >
> > > With below patch to use iio_trigger_get, looks like
> > > try_release_module_ref() will return 1 and cause try_stop_module()
> > > return fail and we will see " rmmod: can't unload 'mma8452': Resource
> > > temporarily unavailable ",
> > >
> > > As the module ref count check is before
> > > iio_device_unregister_trigger_consumer() is called which will do  
> > iio_trigger_put(), so looks like there is still something wrong with the module
> > ref count?
> > Hmm. Drivers that grab their own triggers are a bit of a pain.  We need the
> > infrastructure to try to prevent trigger drivers going away, but it can cause
> > self references.
> > 
> > For this particular driver the validation is only that the trigger is not used with
> > a different device.  You can use a different trigger with this device I believe?
> > 
> > As such, we shouldn't really be setting this default at all.  However, removing
> > it now will break userspace that is assuming the default trigger is set.
> > (setting a trigger should always be a userspace decision, rather than hard
> > coded  unless there is a clear one to one mapping - mind you we have this
> > same problem  if we have a fixed trigger, though in that case we have
> > trig_readonly set  so we can know it's happening and there is an easy fix).
> > 
> > The right option, I think, is to remove the trigger manually before removing
> > the driver.  This is admittedly a bit ugly.
> > 
> > echo '' > /sys/bus/iio/devices/iio:\devicesX/current_trigger.
> > 
> > rmmod mma8452
> > 
> > Can you confirm if that works as expected?  
> 
> After removing the current_trigger, below Oops will occur when remove the mma8452 module. Any other idea?
Yes, the driver should not be using the value of indio_dev->trig in remove.  

Given it is not preventing unassocation of the trigger (which is correct) it needs
to maintain an alternative way of accessing the trigger for remove purposes.
I would suggest a pointer to a
struct iio_trigger in struct mma8452_data.

I clearly missed this in review. Definitely worth checking to see if other drivers
are doing this wrong.

Anyone want to take a look?  If not I'll get to it but might be a few weeks.

Jonathan

> 
> i.mx8mm-evk# cat /sys/bus/iio/devices/iio\:device2/trigger/current_trigger
> mma8451-dev2
> i.mx8mm-evk# echo  > /sys/bus/iio/devices/iio\:device2/trigger/current_trigger
> i.mx8mm-evk# cat /sys/bus/iio/devices/iio\:device2/trigger/current_trigger
> i.mx8mm-evk#
> i.mx8mm-evk#
> i.mx8mm-evk#
> i.mx8mm-evk#
> i.mx8mm-evk# rmmod mma8452
> [   93.004967] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> [   93.011696] Modules linked in: mma8452
> [   93.015460] CPU: 1 PID: 272 Comm: rmmod Not tainted 5.1.0-rc4-next-20190415-00009-gef9b7e5-dirty #1756
> [   93.024771] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   93.031316] PC is at sys_delete_module+0x1c0/0x1dc
> [   93.036112] LR is at 0x32
> [   93.038739] pc : [<c01cc3d8>]    lr : [<00000032>]    psr: a0070013
> [   93.045012] sp : e8b23f58  ip : bf0041d3  fp : 00000000
> [   93.050242] r10: 00000081  r9 : e8b22000  r8 : c01011c4
> [   93.055472] r7 : 00000081  r6 : be85cbf0  r5 : c1908908  r4 : bf0041c0
> [   93.062004] r3 : bf0043fc  r2 : 00000000  r1 : ffffffff  r0 : 00000000
> [   93.068538] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   93.075677] Control: 10c5387d  Table: 3875004a  DAC: 00000051
> [   93.081429] Process rmmod (pid: 272, stack limit = 0x(ptrval))
> [   93.087267] Stack: (0xe8b23f58 to 0xe8b24000)
> [   93.091630] 3f40:                                                       38616d6d 00323534
> [   93.099816] 3f60: 00000001 c190eb04 00000017 b6ea74e0 e8b23fb0 10c5387d 000a9758 00000002
> [   93.108001] 3f80: be85c72c c011799c 00000001 c0101068 00cd0c80 38f6dac7 0001ffc0 38616d6d
> [   93.116186] 3fa0: 00323534 c0101000 0001ffc0 38616d6d be85cbf0 00000880 00000000 be85ce98
> [   93.124370] 3fc0: 0001ffc0 38616d6d 00323534 00000081 000a9744 be85cf81 000a9790 00000000
> [   93.132555] 3fe0: be85cbe8 be85cbd8 0001fe18 b6e551a0 60070010 be85cbf0 00000000 00000000
> [   93.140746] [<c01cc3d8>] (sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> [   93.149014] Exception stack(0xe8b23fa8 to 0xe8b23ff0)
> [   93.154073] 3fa0:                   0001ffc0 38616d6d be85cbf0 00000880 00000000 be85ce98
> [   93.162258] 3fc0: 0001ffc0 38616d6d 00323534 00000081 000a9744 be85cf81 000a9790 00000000
> [   93.170440] 3fe0: be85cbe8 be85cbd8 0001fe18 b6e551a0
> [   93.175501] Code: 0affffd6 ee072fba e3e0400a eaffffb2 (e7f001f2)
> [   93.181604] ---[ end trace d1b72b60c2108067 ]---
> Segmentation fault
> 
> Anson.
> 
> > 
> > Thanks,
> > 
> > Jonathan  
> > >
> > > +++ b/drivers/iio/accel/mma8452.c
> > > @@ -1468,17 +1468,15 @@ static int mma8452_trigger_setup(struct  
> > iio_dev *indio_dev)  
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       indio_dev->trig = trig;
> > > +       indio_dev->trig = iio_trigger_get(trig);
> > >
> > > Thanks,
> > > Anson.
> > >  
> > > >
> > > > Thanks
> > > >
> > > > Jonathan
> > > >
> > > >  
> > > > > ---
> > > > >  drivers/iio/accel/mma8452.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/iio/accel/mma8452.c
> > > > > b/drivers/iio/accel/mma8452.c index 3027811..6b18177 100644
> > > > > --- a/drivers/iio/accel/mma8452.c
> > > > > +++ b/drivers/iio/accel/mma8452.c
> > > > > @@ -1475,8 +1475,10 @@ static int mma8452_trigger_setup(struct
> > > > > iio_dev
> > > > > *indio_dev)
> > > > >
> > > > >  static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)  {
> > > > > -     if (indio_dev->trig)
> > > > > +     if (indio_dev->trig) {
> > > > >               iio_trigger_unregister(indio_dev->trig);
> > > > > +             indio_dev->trig = NULL;
> > > > > +     }
> > > > >  }
> > > > >
> > > > >  static int mma8452_reset(struct i2c_client *client)  
> > >  
> 


