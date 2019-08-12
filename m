Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81774C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578F6208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHLJpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:45:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:34875 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfHLJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:45:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 02:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="asc'?scan'208";a="375884173"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 02:45:34 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
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
In-Reply-To: <BYAPR07MB4709C07ED94C952886858F14DDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <877e8tm25r.fsf@linux.intel.com> <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com> <8736idnu0q.fsf@gmail.com> <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com> <87k1bjvtvi.fsf@gmail.com> <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com> <87imr2u77c.fsf@gmail.com> <BYAPR07MB4709C07ED94C952886858F14DDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 12 Aug 2019 12:45:30 +0300
Message-ID: <87d0hau37p.fsf@gmail.com>
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
>>>>>>Quick question, then: these ISTS registers, are they masked interrupt
>>>>>>status or raw interrupt status?
>>>>>
>>>>> Yes it's masked, but after masking them the new interrupts will not b=
e reported
>>>>> In ISTS registers. Form this reason I can mask only reported interrup=
t.
>>>>
>>>>and what happens when you unmask the registers? Do they get reported?
>>>
>>> No they are not reported in case of USB_ISTS register.
>>> They should be reported in case EP_ISTS, but I need to test it.
>>
>>okay, please _do_ test and verify the behavior. The description above
>>sounds really surprising to me. Does it really mean that if you mask all
>>USB_ISTS and then disconnect the cable while interrupt is masked, you
>>won't know cable was disconnected?
>
> Yes, exactly.=20
>
> Initially I've tested it and it's work correct.=20
> I can even simply write 0 to EP_IEN in hard irq and ~0 in thread handler.=
=20
> It's simplest and sufficient way.=20=20

okay. Just to be sure I understand correctly. If you mask USB_IEN, then
we would miss a cable disconnect event. Right?

>>>>>>>>> +		struct cdns3_aligned_buf *buf, *tmp;
>>>>>>>>> +
>>>>>>>>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
>>>>>>>>> +					 list) {
>>>>>>>>> +			if (!buf->in_use) {
>>>>>>>>> +				list_del(&buf->list);
>>>>>>>>> +
>>>>>>>>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>>>>>>
>>>>>>>>creates the possibility of a race condition
>>>>>>> Why? In this place the buf can't be used.
>>>>>>
>>>>>>but you're reenabling interrupts, right?
>>>>>
>>>>> Yes, driver frees not used buffers here.
>>>>> I think that it's the safest place for this purpose.
>>>>
>>>>I guess you missed the point a little. Since you reenable interrupts
>>>>just to free the buffer, you end up creating the possibility for a race
>>>>condition. Specially since you don't mask all interrupt events. The
>>>>moment you reenable interrupts, one of your not-unmasked interrupt
>>>>sources could trigger, then top-half gets scheduled which tries to wake
>>>>up the IRQ thread again and things go boom.
>>>
>>> Ok, I think I understand.  So I have 3 options:
>>> 1. Mask the USB_IEN and EP_IEN interrupts, but then I can lost some USB=
_ISTS
>>> events. It's dangerous options.
>>
>>sure sounds dangerous, but also sounds quite "peculiar" :-)
>>
>>> 2. Remove implementation of handling unaligned buffers and assume that
>>>     upper layer will worry about this. What with vendor specific driver=
s that
>>>     can be used by companies and not upstreamed  ?
>>>     It could be good to have such safety mechanism even if it is not cu=
rrently used.
>>
>>dunno. It may become dead code that's NEVER used :-)
>>
>>> 3. Delegate this part of code for instance to separate thread that will=
 be called
>>>    In free time.
>>
>>Yet another thread? Can't you just run this right before giving back the
>>USB request? So, don't do it from IRQ handler, but from giveback path?
>
> Do you mean in:
> 	if (request->complete) {
> 		spin_unlock(&priv_dev->lock);
> 		if (priv_dev->run_garbage_collector) {
> 			....
> 		}
> 		usb_gadget_giveback_request(&priv_ep->endpoint,
> 					    request);
> 		spin_lock(&priv_dev->lock);
> 	}
> ??

right, you can do it right before giving back the request. Or right
after.

> I ask because this is finally also called from IRQ handler:
>
> cdns3_device_thread_irq_handler
>     -> cdns3_check_ep_interrupt_proceed
>         -> cdns3_transfer_completed
>             -> cdns3_gadget_giveback
>                 -> usb_gadget_giveback_request

Did you notice that it doesn't reenable interrupts, though?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1RNTsACgkQzL64meEa
mQbzRg/+MLEj71b8djBbt+Uz57Ql2QhV8yYkwbxEZVfM1lmQO25GkANNKdDJxUWX
3Xnlh+xsTNuEqzYtjQ+65SWjtWI3diK4WZL/5aATZi7/sDZK97nTSOINNJiHkOWR
8nxps4bOeGXhSzB9c6V04nXR7HkGoZZExPImyb7crJWP3vhLpulSvSobgv0iDkEN
0St25AbVuPeFL27ZJ9/ZWiv6A1t5jNZ1LifLskPMklWo6RD7QaumIMyBJzP1sDFu
w9kd+scAAuXk4grmpZijRXk2chI+1a892z7MqTqIvQV69fJfXz34U7KLiVR3jpoK
o10rSGhGUzlT33ljm2wp8tOGD+lSQLO9ukIqnlmWxC7ogRpK+wKQneV4yov+lUoG
6EfJ0Bw/0w5HOyn3GLSTVQrZsOi3ikrua3B0jEJkMrCFRQddAR3YhCEmR40mFvMh
zRYR73/m51o8AoLCcJOCI2dohKict/IR3pCBggUYr+kP+/V86Fm7vBnNvRnjjid0
1DjttwA33SGioYVFs1pndHjv38CeMBfsYGuO233z+lXN1TlELaNv6WdmVqq4lZik
6/YTM3UUQDq/stl+MeMfLwhSQdEdphK5zL54zucBlbsWW/YIFprfvoNb7CX+yNvB
I4rW3mEfl1Ov3jCCmQd35px8QHQWtsfwozaAKNa6qBSivBzV+HE=
=CUWd
-----END PGP SIGNATURE-----
--=-=-=--
