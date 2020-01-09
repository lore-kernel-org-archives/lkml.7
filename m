Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13561C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA91F2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgAIJX7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:23:59 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:42173 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729269AbgAIJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:23:59 -0500
Received: from [46.226.52.196] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id B5/46-19908-A21F61E5; Thu, 09 Jan 2020 09:23:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsVyU+ECq67WR7E
  4gw9reC0u75rD5sDo8XmTXABjFGtmXlJ+RQJrxv6OiIJd8hU/j6xnbWA8KNXFyMUhJLCXUeLy
  0WXMEM4ZRokpXzYydTFycrAJaEnM2DqVEcQWEdCQeHn0FgtIEbNAJ6PE7dcHgBIcHMICXhLbn
  itB1HhL7L03lwXCdpP4ffQz2BwWARWJZ0cmgMV5BXQlrs98zQix7BijxK4Pq1hB5nAKGEpM2A
  K2i1FAVuLRyl/sIDazgLjErSfzweZICAhILNlznhnCFpV4+fgfK4RtILF16T4WCFtR4vXPaWC
  nSQhYS9x4wA8xxkDi/bn5zBC2tsSyha+ZIc4RlDg58wnLBEaxWUi2zULSMgtJyywkLQsYWVYx
  WiQVZaZnlOQmZuboGhoY6BoaGukaWpoDsZleYpVukl5qqW55anGJrqFeYnmxXnFlbnJOil5ea
  skmRmCMpRQcPbKD8d3Xt3qHGCU5mJREeY+/FosT4kvKT6nMSCzOiC8qzUktPsQow8GhJMH75z
  1QTrAoNT21Ii0zBxjvMGkJDh4lEd7jIGne4oLE3OLMdIjUKUZjjgkv5y5i5nj3c/EiZiGWvPy
  8VClxXsMPQKUCIKUZpXlwg2Bp6BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5hkIU8mXkl
  cPteAZ3CBHTKnTuiIKeUJCKkpBqYAp/k/ebTWp7/QIQz1NdgS4N1c8jq5GzDhZ8/HSqas+CRn
  +3EBVvuZ7E9/Hu31jdn8/uPXQ87jj6aLVrAEhzBfOP+BefrR+/ciTRc3fCsRrKDdXJ0trKTz5
  +3W/ifZtm9YpPub2rKtdIvurG+/PGBN6d3JpZtvqrof/LhB+tVM0x/t7/fGLK2VCP0oJ5Udt2
  L3BMpnJFe/dv6HQrfr/w/S/7L7sOliY5fo3hfFYlvjORPnRK2Y/fyN86793y+fvTN8W1TBKWt
  HjT7fmaddn3Gzen5qTesy14+vCI64cm+Nyu2HBC9O9n/R2xfyuaf60vF09adYHkpPfFQRIWEz
  b+9Sx5I5j6xCTuuZHhz+vaY65eUWIozEg21mIuKEwGSxhtGvgMAAA==
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-22.tower-284.messagelabs.com!1578561833!2127243!2
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23015 invoked from network); 9 Jan 2020 09:23:54 -0000
Received: from unknown (HELO exukdagfar01.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-22.tower-284.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 9 Jan 2020 09:23:54 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Jan 2020 09:23:53 +0000
Received: from exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5]) by
 exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5%14]) with mapi id
 15.00.1497.000; Thu, 9 Jan 2020 09:23:53 +0000
From:   "Kim, David" <david.kim@ncipher.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: Re: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Thread-Topic: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Thread-Index: AQHVt0zVoKuntuLcG0+uDmw07DztyKfDitUAgBt0RECAAAvvgIADIt3B
Date:   Thu, 9 Jan 2020 09:23:52 +0000
Message-ID: <1578561832423.48959@ncipher.com>
References: <20191220154738.31448-1-david.kim@ncipher.com>
 <20191220213036.GA27120@kroah.com>
 <46e2f36d770c462db487d0e918ad2b0b@exukdagfar01.INTERNAL.ROOT.TES>,<20200107092827.GB1021817@kroah.com>
In-Reply-To: <20200107092827.GB1021817@kroah.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.23.142.31]
x-exclaimer-md-config: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > A cryptographic accelerator uses key material which is stored on, and managed
> > by, the host machine. Hardware security modules, such as nCipher’s Solo
> > products, retain key material (i.e. secrets) within the secure boundary of the
> > device, and implement various forms of access control to restrict use of that
> > key material.
> > 
> > nCipher's product range started, in the early 1990s, as cryptographic
> > accelerators.  The series of hardware security modules served by this driver
> > still does do cryptography but their main function is the generation, management
> > and use of keys within a secure boundary.
> > 
> > The driver doesn't do any cryptography. It provides the link between the
> > userspace software and the HSM's firmware. Cryptography is done within the HSM's
> > secure boundary.
> 
> So this should tie into the correct crypto/key apis that the kernel has
> and not create a brand new user/kernel api, right?
> 
> Please work with the crypto kernel developers to get this right, I can't
> take this until they agree that this code and api is correct.


Although it is technically possible for us to use the linux crypto APIs, that
doesn't fit in with how our hardware is meant to be used. Please see the
explanation below from Ian, one of our architects. If you feel that our driver
should instead be targeted to drivers/crypto, I can resubmit our patch to the
crypto list and we'll discuss with the crypto maintainers.

Thanks,
Dave

Ian's reply:

The Linux Kernel Crypto API
(https://www.kernel.org/doc/html/latest/crypto/intro.html) allows callers to
apply cryptographic transformations to input data. There is a socket-based
interface (https://www.kernel.org/doc/html/latest/crypto/userspace-if.html )
which makes these available to user-space. The documentation also mentions the
libkcapi library (http://www.chronox.de/libkcapi.html) which is a C wrapper
round the socket interface.

The basic mode of operation for all of these is: (a) create a transformation
object (or handle), (b) call a “set key” function to supply key data, (c) call
an encrypt or decrypt function to apply the transformation.

This interface is appropriate when the caller has the key data itself available.
In the user-space case, key data is supplied via the ALG_SET_KEY option passed
to setsockopt(). For the in-kernel interface, this is via various setkey()
function pointers in structures defined in include/linux/crypto.h.

The nCipher Solo device is a “Hardware Security Module”, the purpose of which is
to protect key data in various ways; its functionality goes beyond simply
providing implementations of cryptographic algorithms. In other words, the user
of an HSM doesn’t generally possess the key data itself, but requests access to
it via the HSM interface. Key data itself remains within the (physical and
logical) “security boundary” of the HSM, and access to it is subject to various
checks and policies. For instance, a smartcard which allows a digital signature
to be made when the user has correctly entered a PIN is acting as a simple
hardware security module.

Our customers use Solo HSMs where they have a need (often legally mandated) to
keep key data protected by a separate subsystem. Many require compliance with
the FIPS 140 standard
(https://csrc.nist.gov/publications/detail/fips/140/2/final) or the eIDAS
regulations (https://ec.europa.eu/futurium/en/eidas-observatory). So, while it
would be possible to implement a “set key” function to deliver key material to
the HSM in order to perform an operation, this would not meet the protection
requirements of these standards, and would be of no use to customers.
