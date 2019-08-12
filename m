Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACDBC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581D220842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfHLKep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:34:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:28382 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbfHLKeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:34:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 03:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="asc'?scan'208";a="170000591"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2019 03:34:39 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede\@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus\@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB470931F8C699784CC88E21CBDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <877e8tm25r.fsf@linux.intel.com> <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com> <8736idnu0q.fsf@gmail.com> <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com> <87k1bjvtvi.fsf@gmail.com> <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com> <87imr2u77c.fsf@gmail.com> <BYAPR07MB4709C07ED94C952886858F14DDD30@BYAPR07MB4709.namprd07.prod.outlook.com> <87d0hau37p.fsf@gmail.com> <BYAPR07MB470931F8C699784CC88E21CBDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 12 Aug 2019 13:34:35 +0300
Message-ID: <877e7iu0xw.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>>>Yet another thread? Can't you just run this right before giving back the
>>>>USB request? So, don't do it from IRQ handler, but from giveback path?
>>>
>>> Do you mean in:
>>> 	if (request->complete) {
>>> 		spin_unlock(&priv_dev->lock);
>>> 		if (priv_dev->run_garbage_collector) {
>>> 			....
>>> 		}
>>> 		usb_gadget_giveback_request(&priv_ep->endpoint,
>>> 					    request);
>>> 		spin_lock(&priv_dev->lock);
>>> 	}
>>> ??
>>
>>right, you can do it right before giving back the request. Or right
>>after.
>>
>>> I ask because this is finally also called from IRQ handler:
>>>
>>> cdns3_device_thread_irq_handler
>>>     -> cdns3_check_ep_interrupt_proceed
>>>         -> cdns3_transfer_completed
>>>             -> cdns3_gadget_giveback
>>>                 -> usb_gadget_giveback_request
>>
>>Did you notice that it doesn't reenable interrupts, though?
>
> I noticed that there is a lack of reenabling interrupts :)
>
> The problem is that If I have disabled interrupt the kernel complains
> for using dma_free_coherent function in such place.=20
>
> Here you have a fragment of complaints:=20
> [ 7420.502863] WARNING: CPU: 0 PID: 10260 at kernel/dma/mapping.c:281 dma=
_free_attrs+0xa0/0xd0
> [ 7420.502866] Modules linked in: usb_f_mass_storage cdns3(OE) cdns3_pci_=
wrap(OE) libcomposite
> 		...
> [ 7420.502965]  cdns3_gadget_giveback+0x159/0x2a0 [cdns3]
> [ 7420.502975]  cdns3_transfer_completed+0xc5/0x3c0 [cdns3]
> [ 7420.502986]  cdns3_device_thread_irq_handler+0x1b1/0xab0 [cdns3]
> [ 7420.502991]  ? __schedule+0x333/0x7e0
> [ 7420.503001]  irq_thread_fn+0x26/0x60
> [ 7420.503006]  ? irq_thread+0xa8/0x1b0
> [ 7420.503011]  irq_thread+0x10e/0x1b0
> [ 7420.503015]  ? irq_forced_thread_fn+0x80/0x80
> [ 7420.503021]  ? wake_threads_waitq+0x30/0x30
> [ 7420.503029]  kthread+0x12c/0x150
> [ 7420.503034]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 7420.503038]  ? kthread_park+0x90/0x90
> [ 7420.503045]  ret_from_fork+0x3a/0x50
> [ 7420.503061] irq event stamp: 2962
> [ 7420.503065] hardirqs last  enabled at (2961): [<ffffffffb252672c>] _ra=
w_spin_unlock_irq+0x2c/0x40
> [ 7420.503070] hardirqs last disabled at (2962): [<ffffffffb25268f5>] _ra=
w_spin_lock_irqsave+0x25/0x60
> [ 7420.503074] softirqs last  enabled at (2918): [<ffffffffb2800340>] __d=
o_softirq+0x340/0x451
> [ 7420.503079] softirqs last disabled at (2657): [<ffffffffb1aa02b6>] irq=
_exit+0xc6/0xd0
> [ 7420.503082] ---[ end trace d02652af11011c3b ]---
>
> Maybe it's a bug in implementation of this function.  I allocate memory w=
ith flag GFP_ATOMIC with=20
> disabled interrupt, but I can't free such memory.=20

I don't understand the intricacies of the coherent API to judge if it's
a bug in the API itself. In any case, here's where the splat comes from:

void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
		dma_addr_t dma_handle, unsigned long attrs)
{
	const struct dma_map_ops *ops =3D get_dma_ops(dev);

	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
		return;
	/*
	 * On non-coherent platforms which implement DMA-coherent buffers via
	 * non-cacheable remaps, ops->free() may call vunmap(). Thus getting
	 * this far in IRQ context is a) at risk of a BUG_ON() or trying to
	 * sleep on some machines, and b) an indication that the driver is
	 * probably misusing the coherent API anyway.
	 */
	WARN_ON(irqs_disabled());

	if (!cpu_addr)
		return;

	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
	if (dma_is_direct(ops))
		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
	else if (ops->free)
		ops->free(dev, size, cpu_addr, dma_handle, attrs);
}
EXPORT_SYMBOL(dma_free_attrs);

maybe you're gonna have to fire up a workqueue to free this memory for
you :-(

Unless someone else has better ideas. Alan, Greg, any ideas?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1RQLsACgkQzL64meEa
mQaIQRAA0TD8TKQptnOmAGv1zIYC6xgBgnsm0x2vGb6xL4PRP2OCZ5rtKxQ68m4V
yp7zk5HSsVupbVXXvnlrwW1kkYSeSGy6Eu4R13SndS1AzDhoT4GXVQp4p4lnC/qP
C7tHOOEFBAcN6/R5xmdfztd7OnNzvLVSyHQDjPTV/ZrhO5WA/7PiISDbrIJwko63
ew2eR97yc6ieP0AntOPEePHqp07h2PkOSDBECZd3k4HqI2HhZI/yRK2x02dzYLTd
UeKfQePHjlfyhoptUrsumaombaIvOi4OzaW+e/XXitZAzcQhlbjiKtBy8HzSiF0U
4Y1ElXeeP1HqQBmWvOetFSgKLNjR5TAlRrWOp/x6XS8IUM/jyJHKIYqMWShjGbPZ
/V2JvOhJH8z7/Gnldx47LC4qyHQaNFhtZ8DTvGTLyYiC4aJp1geNvOsn7h4hmUNp
Un5t5ytPUuNrWITTN4V6w1S8eQem1GN947GTJmWDICYrlKWuBwAIfM7GrVgV0omp
4YGouah8LD8o+h2IVHqAlRui/uNQMxk0h+MHHkxo8JbrFJfOdR2JBKUT36Npv4ut
3KaCHAVG/LHY5+2LbqlbLZiH9gUjntSs0efbDDePT4OudMFqz3HX95MHAcNq1JgP
s4NR1rdSKILE+EYOk9XT6ch5jNKqq9ylfwCuRhJtIShcyBGEHF0=
=xDrg
-----END PGP SIGNATURE-----
--=-=-=--
