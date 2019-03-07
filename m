Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7073C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F1F2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCGQ7y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:59:54 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34412 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfCGQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:59:53 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-162-fxZsAPfkMhuUi9vIaV79pg-1; Thu, 07 Mar 2019 16:59:50 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 7 Mar 2019 17:00:35 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 Mar 2019 17:00:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiaxun Yang' <jiaxun.yang@flygoat.com>,
        "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>
CC:     "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
Thread-Topic: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
Thread-Index: AQHU1L0maNvBcxqlI0i0JUFS+mPQBaYAY76w
Date:   Thu, 7 Mar 2019 17:00:35 +0000
Message-ID: <4801d0ea91ac46888b11d924b9508d1e@AcuMS.aculab.com>
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: fxZsAPfkMhuUi9vIaV79pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang
> Sent: 07 March 2019 08:08
...
> +static int __init have_bt_fwbug(void)
> +{
> +	/* Some AMD based ThinkPads have a firmware bug that calling
> +	 * "GBDC" will cause bluetooth on Intel wireless cards blocked
> +	 */
> +	if (dmi_check_system(bt_fwbug_list)) {
> +		if (pci_get_device(PCI_VENDOR_ID_INTEL, 0x24F3, NULL) || \

WTF if that \ ??

> +		    pci_get_device(PCI_VENDOR_ID_INTEL, 0x24FD, NULL) || \
> +		    pci_get_device(PCI_VENDOR_ID_INTEL, 0x2526, NULL))
> +			return 1;
> +		else
> +			return 0;
> +	} else {
> +			return 0;
> +	}
> +}

You don't need 'else' after a 'return'.
I'd also put the return nearer the test.

While the above could be written:
	return dmi_check_system(bt_fwbug_list) &&
		(pci_get_device(PCI_VENDOR_ID_INTEL, 0x24F3, NULL) ||
		pci_get_device(PCI_VENDOR_ID_INTEL, 0x24FD, NULL) ||
		pci_get_device(PCI_VENDOR_ID_INTEL, 0x2526, NULL));

I think I'd write:
	if (!dmi_check_system(bt_fwbug_list))
		return 0;
	return pci_get_device(PCI_VENDOR_ID_INTEL, 0x24F3, NULL) ||
		pci_get_device(PCI_VENDOR_ID_INTEL, 0x24FD, NULL) ||
		pci_get_device(PCI_VENDOR_ID_INTEL, 0x2526, NULL);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

