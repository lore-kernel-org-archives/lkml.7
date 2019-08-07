Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB7A218FE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbfHGLlK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:41:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:33004 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbfHGLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:41:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-105-UxpvcEd0PjOivqu6C53zeA-1; Wed, 07 Aug 2019 12:41:07 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 7 Aug 2019 12:41:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 7 Aug 2019 12:41:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'john.hubbard@gmail.com'" <john.hubbard@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: RE: [PATCH v2] x86/boot: save fields explicitly, zero out everything
 else
Thread-Topic: [PATCH v2] x86/boot: save fields explicitly, zero out everything
 else
Thread-Index: AQHVR2NW7IoEB4DZD0igIVYuZS+m96bvl74Q
Date:   Wed, 7 Aug 2019 11:41:06 +0000
Message-ID: <531b38aaa15e4de79a5e27fd37c04351@AcuMS.aculab.com>
References: <20190731054627.5627-1-jhubbard@nvidia.com>
 <20190731054627.5627-2-jhubbard@nvidia.com>
In-Reply-To: <20190731054627.5627-2-jhubbard@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UxpvcEd0PjOivqu6C53zeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: john.hubbard@gmail.com
> Sent: 31 July 2019 06:46
> 
> Recent gcc compilers (gcc 9.1) generate warnings about an
> out of bounds memset, if you trying memset across several fields
> of a struct. This generated a couple of warnings on x86_64 builds.
> 
> Fix this by explicitly saving the fields in struct boot_params
> that are intended to be preserved, and zeroing all the rest.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  arch/x86/include/asm/bootparam_utils.h | 62 +++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> index 101eb944f13c..514aee24b8de 100644
> --- a/arch/x86/include/asm/bootparam_utils.h
> +++ b/arch/x86/include/asm/bootparam_utils.h
> @@ -18,6 +18,20 @@
>   * Note: efi_info is commonly left uninitialized, but that field has a
>   * private magic, so it is better to leave it unchanged.
>   */
> +
> +#define sizeof_mbr(type, member) ({ sizeof(((type *)0)->member); })
> +
> +#define BOOT_PARAM_PRESERVE(struct_member)				\
> +	{								\
> +		.start = offsetof(struct boot_params, struct_member),	\
> +		.len   = sizeof_mbr(struct boot_params, struct_member),	\
> +	}
> +
> +struct boot_params_to_save {
> +	unsigned int start;
> +	unsigned int len;
> +};
> +
>  static void sanitize_boot_params(struct boot_params *boot_params)
>  {
>  	/*
> @@ -35,21 +49,39 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>  	 * problems again.
>  	 */
>  	if (boot_params->sentinel) {
> -		/* fields in boot_params are left uninitialized, clear them */
> -		boot_params->acpi_rsdp_addr = 0;
> -		memset(&boot_params->ext_ramdisk_image, 0,
> -		       (char *)&boot_params->efi_info -
> -			(char *)&boot_params->ext_ramdisk_image);
> -		memset(&boot_params->kbd_status, 0,
> -		       (char *)&boot_params->hdr -
> -		       (char *)&boot_params->kbd_status);
> -		memset(&boot_params->_pad7[0], 0,
> -		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
> -			(char *)&boot_params->_pad7[0]);
> -		memset(&boot_params->_pad8[0], 0,
> -		       (char *)&boot_params->eddbuf[0] -
> -			(char *)&boot_params->_pad8[0]);
> -		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
...

How about replacing the above first using:
#define zero_struct_fields(ptr, from, to) memset(&ptr->from, 0, (char *)&ptr->to - (char *)&ptr->from)
	zero_struct_fields(boot_params, ext_ramdisk_image, efi_info);
	...
Which is absolutely identical to the original code.

The replacing the define with:
	#define so(s, m) offsetof(typeof(*s), m)
	#define zero_struct_fields(ptr, from, to) memset((char *)ptr + so(ptr, from), 0, so(ptr, to) - so(ptr, from))
which gcc probably doesn't complain about, but should generate identical code again.
There might be an existing define for so().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

