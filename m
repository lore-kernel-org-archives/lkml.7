Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4BC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CB921925
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfIQI3d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:29:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37177 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfIQI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:29:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-107-ZPVkqAGzNj-v0czpgaXBfw-1; Tue, 17 Sep 2019 09:29:29 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 17 Sep 2019 09:29:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 17 Sep 2019 09:29:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tony Luck' <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH 3/3] x86/split_lock: Align the x86_capability array to
 size of unsigned long
Thread-Topic: [PATCH 3/3] x86/split_lock: Align the x86_capability array to
 size of unsigned long
Thread-Index: AQHVbN+vZQX1JbkM+kyyTtwnTlEXh6cviXfw
Date:   Tue, 17 Sep 2019 08:29:28 +0000
Message-ID: <d75c94cf2ca345018ef60880ce6c4aeb@AcuMS.aculab.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <20190916223958.27048-1-tony.luck@intel.com>
 <20190916223958.27048-4-tony.luck@intel.com>
In-Reply-To: <20190916223958.27048-4-tony.luck@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ZPVkqAGzNj-v0czpgaXBfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck
> Sent: 16 September 2019 23:40
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> The x86_capability array in cpuinfo_x86 is defined as u32 and thus is
> naturally aligned to 4 bytes. But, set_bit() and clear_bit() require
> the array to be aligned to size of unsigned long (i.e. 8 bytes in
> 64-bit).
> 
> To fix the alignment issue, align the x86_capability array to size of
> unsigned long by using unnamed union and 'unsigned long array_align'
> to force the alignment.
> 
> Changing the x86_capability array's type to unsigned long may also fix
> the issue because the x86_capability array will be naturally aligned
> to size of unsigned long. But this needs additional code changes.
> So choose the simpler solution by setting the array's alignment to size
> of unsigned long.
> 
> Suggested-by: David Laight <David.Laight@aculab.com>

While this is probably the only play where this 'capabilities' array
has been detected as misaligned, ISTR there are several other places
where the identical array is defined and used.
These all need fixing as well.

	David

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/processor.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 6e0a3b43d027..c073534ca485 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -93,7 +93,15 @@ struct cpuinfo_x86 {
>  	__u32			extended_cpuid_level;
>  	/* Maximum supported CPUID level, -1=no CPUID: */
>  	int			cpuid_level;
> -	__u32			x86_capability[NCAPINTS + NBUGINTS];
> +	/*
> +	 * Align to size of unsigned long because the x86_capability array
> +	 * is passed to bitops which require the alignment. Use unnamed
> +	 * union to enforce the array is aligned to size of unsigned long.
> +	 */
> +	union {
> +		__u32		x86_capability[NCAPINTS + NBUGINTS];
> +		unsigned long	x86_capability_alignment;
> +	};
>  	char			x86_vendor_id[16];
>  	char			x86_model_id[64];
>  	/* in KB - valid for CPUS which support this call: */
> --
> 2.20.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

