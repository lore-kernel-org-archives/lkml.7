Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B09C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFDE207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKZJxq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:53:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:24428 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbfKZJxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:53:46 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-214-4-9H7vGLMDuAXhSNvLlglQ-1; Tue, 26 Nov 2019 09:53:39 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 26 Nov 2019 09:53:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 26 Nov 2019 09:53:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Fenghua Yu' <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v2 2/4] xen-pcifront: Align address of flags to size of
 unsigned long
Thread-Topic: [PATCH v2 2/4] xen-pcifront: Align address of flags to size of
 unsigned long
Thread-Index: AQHVo8bqrfjaxnvKokKft9QerImLSKedNnnQ
Date:   Tue, 26 Nov 2019 09:53:38 +0000
Message-ID: <10982a76b2b9431f90d4d8c41c8ad48f@AcuMS.aculab.com>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
 <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4-9H7vGLMDuAXhSNvLlglQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: 25 November 2019 19:43
> The address of "flags" is passed to atomic bitops which require the
> address is aligned to size of unsigned long.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  include/xen/interface/io/pciif.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/xen/interface/io/pciif.h b/include/xen/interface/io/pciif.h
> index d9922ae36eb5..639d5fb484a3 100644
> --- a/include/xen/interface/io/pciif.h
> +++ b/include/xen/interface/io/pciif.h
> @@ -103,8 +103,11 @@ struct xen_pcie_aer_op {
>  	uint32_t devfn;
>  };
>  struct xen_pci_sharedinfo {
> -	/* flags - XEN_PCIF_* */
> -	uint32_t flags;
> +	/* flags - XEN_PCIF_*. Force alignment for atomic bit operations. */
> +	union {
> +		uint32_t	flags;
> +		unsigned long	flags_alignment;
> +	};

This is papering over the cracks.....
Changing flags to be 'unsigned long' and removing the casts is correct.
Either that or change to code to use simple assignments on the single 'flags' variable
instead of the relatively expensive function calls that are designed for large arrays
of bits.

	David.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

