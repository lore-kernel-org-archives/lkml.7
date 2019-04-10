Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736D217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfDJMyw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:54:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20196 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732195AbfDJMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:54:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-A2oPZ-l9M2SWGjvacewE_g-1; Wed, 10 Apr 2019 13:54:44 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 10 Apr 2019 13:55:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 10 Apr 2019 13:55:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paolo Bonzini' <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: optimize check for valid PAT value
Thread-Topic: [PATCH] KVM: x86: optimize check for valid PAT value
Thread-Index: AQHU74O4C+qyka3PCE+FdT/UfNmwwaY1VKDw
Date:   Wed, 10 Apr 2019 12:55:53 +0000
Message-ID: <c2aaa028ef564c6d8bd50dbd86489115@AcuMS.aculab.com>
References: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: A2oPZ-l9M2SWGjvacewE_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini
> Sent: 10 April 2019 10:55
> 
> This check will soon be done on every nested vmentry and vmexit,
> "parallelize" it using bitwise operations.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
...
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 28406aa1136d..7bc7ac9d2a44 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -347,4 +347,12 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
>  	__this_cpu_write(current_vcpu, NULL);
>  }
> 
> +static inline bool kvm_pat_valid(u64 data)
> +{
> +	if (data & 0xF8F8F8F8F8F8F8F8)
> +		return false;
> +	/* 0, 1, 4, 5, 6, 7 are valid values.  */
> +	return (data | ((data & 0x0202020202020202) << 1)) == data;
> +}
> +

How about:
	/*
	 * Each byte must be 0, 1, 4, 5, 6 or 7.
	 * Convert 001x to 011x then 100x so 2 and 3 fail the test.
	 */
	data |= (data ^ 0x0404040404040404ULL)) + 0x0202020202020202ULL;
	if (data & 0xF8F8F8F8F8F8F8F8ULL)
		return false;

   David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

