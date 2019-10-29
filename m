Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4308CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfJ2KeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:34:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:9190 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfJ2KeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:34:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 03:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="198884160"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2019 03:33:59 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>, Peter Chen <peter.chen@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar\@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
In-Reply-To: <0c2c901c-a6f2-a81b-f5b1-e3f442d7c1ae@ti.com>
References: <20191023090232.27237-1-rogerq@ti.com> <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com> <20191025031343.GA13392@b29397-desktop> <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com> <20191029031223.GA26815@b29397-desktop> <0c2c901c-a6f2-a81b-f5b1-e3f442d7c1ae@ti.com>
Date:   Tue, 29 Oct 2019 12:33:56 +0200
Message-ID: <875zk7j0x7.fsf@gmail.com>
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

Roger Quadros <rogerq@ti.com> writes:

> On 29/10/2019 05:12, Peter Chen wrote:
>> On 19-10-25 12:59:17, Roger Quadros wrote:
>>> Peter,
>>>
>>> On 25/10/2019 06:13, Peter Chen wrote:
>>>> On 19-10-23 09:17:45, Pawel Laszczak wrote:
>>>>> Hi,
>>>>>
>>>>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
>>>>
>>>> Hi Roger & Pawel,
>>>>
>>>> Assume gadget function has already enabled, if you switch host mode
>>>> to device mode, with your changes, where the device mode will be enabl=
ed
>>>> again?
>>>
>>> When it switches from device mode to host the UDC is removed. When we s=
witch
>>> back from host to device mode the UDC is added, so,
>>>
>>> usb_add_gadget_udc_release()-> check_pending_gadget_drivers()->
>>> udc_bind_to_driver()->usb_udc_connect_control()->usb_gadget_connect()->
>>> gadget->ops->pullup()
>>=20
>> Thanks. I have another question how you decide when to store UDC name
>> to /sys/kernel/config/usb_gadget/g1/UDC? Do you have a user daemon progr=
am
>> to monitor VBUS or external connector? At host mode, the store operation
>> will fail due to there is NO UDC.
>>=20
>
> Yes, user space needs to monitor /sys/class/usb_role/6000000.usb-role-swi=
tch/role
>
> When it becomes "device" the UDC is available and it can prepare to confi=
gure
> the UDC.
>
> Could you please give your Ack for this patch if it is OK? Thanks.

this is already in its way to Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-linus&id=3Df3fb802efaef3662744a2215a51294d52a7cfc0e

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24FZQACgkQzL64meEa
mQb8GxAAkVg88x3zxLiaMlbDSwSkB6A3rUU+t+PeKfW2HC4iQGxWsl3UU34sr1uk
Lz/vit0HLb11mjHDt3J66hI7gxyqucMjsadiOy6e2H0dk3ehb2GKCEABPTho89l7
flKFU1cZWqYDUreoL0C7Y2OFMkCU8L9kGUwP6RLinEhleGytnRXxF0IVitWDJYda
qviXiOFLiAydkwriy1pVTU6gpdK4a8GDUfaoofsS792TD8jy/sOKnHEzLc918/f6
a82W+Htz9wWuUokddvmw5nlpIE6IVQVWU1RpPnn5d19ZhIORGMg2fq3VEeh7n3s3
C0np+xS5Re0UIbLoaXGgBjRCKdraCdaM92ODBx4e9HWpBuUwHPbFWY8aSLzerRSz
kG8CXyN5eWfucdcVCHq9XUuesZwwB0wc+b/I67ayI+rD3wqK9+RV5MGyjdvMwlyG
f/fZ41Y67JWqUzCAooYLTmdrxjSdSy/TQCbkiV8ghwGYUcUp6VPLxT3qABK+sX95
3IoSmnIa+oH9ykFTBNLt14v3dKNU/WKdFdSyp6YQKAvUVX7EVQoQFud7+/M4HZi2
3NlJpenqjvs68T4XmIeonF0/GxNCGFFdFH0DBrYTcWZ+2k2n/rbPNSDcBtpQ2/hF
ZnSDN1clFqtkAbz5q7JohSYc1ZTjLCTbDa0drHYW97Lh0ylZ5nM=
=je1a
-----END PGP SIGNATURE-----
--=-=-=--
