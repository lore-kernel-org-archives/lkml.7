Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF49DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722D621721
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLD2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:28:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40462 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfDLD2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:28:38 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <vicamo.yang@canonical.com>)
        id 1hEmrg-0008Kq-Q8
        for linux-kernel@vger.kernel.org; Fri, 12 Apr 2019 03:28:33 +0000
Received: by mail-pg1-f197.google.com with SMTP id h14so5671713pgn.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 20:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=SR+bNYaNKkdfDP4lLFvM3wbEo7dY3tFO+CGM2u3fEDI=;
        b=DKbdsHrflWpEUBBZRBLTZ2bSaXqSlrKIvbO4C1B7K1aNBTQ9SZXRlGECBbKS3N+g/H
         JJGdP5X/PRwrvDBEhO987VU4q1sFvOkmOg8s/mkwYcuvD2H4oerSRJdKgJXYCHWWSO2l
         ibQXgxLeMvvK1pMvmQd1FNGxEY71bZ1i+7gAh5gKdpHeJ0Tq4xga1Gwaspp9CGG+02u4
         xrqEur57EIq5+fJdNeWLMeTMQNC0oHT19EHhN9RBEPkUwphmGrGaf21ITT5azvwB8eKR
         2rylTkevZxonX5ZeGnk+TNCxl88wOpysrCMAdbm0uMsv36Q3ObEDwZCb8cif9umU/WOh
         U4Eg==
X-Gm-Message-State: APjAAAX8jVbIn2Dmg2Bk4Qod+P393VuIHqMl6WNNqu/eK2pRoDia0Vpt
        NgzccNaU5JRQszIrFaaKy3UG8AKx8ZcF4/YoD1+16nrhPFdx8+euwpyxX5yiaRRL6rHksAK2+HS
        BeK5wLqj1kQ0TSzgtUAb0E6I1M16vJ9w8IJya8KNpbQ==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr53787975plb.115.1555039711316;
        Thu, 11 Apr 2019 20:28:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4cZfvR5OxfKhQHrBCHxTnYMQFvCKmm/wED73NCloeZboKoeTwHSoj+VH3GCDgp1ZkD/Wzdg==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr53787958plb.115.1555039711159;
        Thu, 11 Apr 2019 20:28:31 -0700 (PDT)
Received: from Vicamos-MacBook-Pro-3.local (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id k65sm87070121pfb.68.2019.04.11.20.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 20:28:29 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        You-Sheng Yang <vicamo@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chuanhua Lei <chuanhua.lei@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20190408104012.26791-1-vicamo@gmail.com>
 <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vicamo.yang@canonical.com; keydata=
 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
Subject: Re: [PATCH] x86/tsc: mark tsc reliable on CoffeeLake
Message-ID: <bc576802-9029-3e52-f831-ba955b222898@canonical.com>
Date:   Fri, 12 Apr 2019 11:28:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7cjH1XwkFoEg8xS0EzQzTRR9Yga9UkzU4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7cjH1XwkFoEg8xS0EzQzTRR9Yga9UkzU4
Content-Type: multipart/mixed; boundary="dSuZ5aXFliqye4GciFuQdyADaU5yJPNCA";
 protected-headers="v1"
From: You-Sheng Yang <vicamo.yang@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>, You-Sheng Yang <vicamo@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Dou Liyang <douly.fnst@cn.fujitsu.com>, Daniel Vacek <neelx@redhat.com>,
 Mike Travis <mike.travis@hpe.com>, Xiaoming Gao
 <gxm.linux.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Chuanhua Lei <chuanhua.lei@linux.intel.com>, Juergen Gross
 <jgross@suse.com>, linux-kernel@vger.kernel.org
Message-ID: <bc576802-9029-3e52-f831-ba955b222898@canonical.com>
Subject: Re: [PATCH] x86/tsc: mark tsc reliable on CoffeeLake
References: <20190408104012.26791-1-vicamo@gmail.com>
 <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>

--dSuZ5aXFliqye4GciFuQdyADaU5yJPNCA
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 2019/4/8 8:03 PM, Thomas Gleixner wrote:
> On Mon, 8 Apr 2019, You-Sheng Yang wrote:
>> +	/*
>> +	 * On Intel CoffeeLake, tsc may be marked unstable unexpectedly afte=
r
>> +	 * entering PC10.
>> +	 */
>> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
>> +	    (boot_cpu_data.x86_model =3D=3D INTEL_FAM6_KABYLAKE_MOBILE ||
>> +	     boot_cpu_data.x86_model =3D=3D INTEL_FAM6_KABYLAKE_DESKTOP) &&
>> +	    boot_cpu_data.x86_stepping >=3D 0x0a)
>> +		tsc_clocksource_reliable =3D 1;
>=20
> No. We are not starting that family/model/stepping game especially not
> with random stepping cutoffs which are pulled out of thin air.  That's
> going to spiral out of control sooner than later.

What about we simply disable clocksource watchdog if this is an
invariant TSC?

> There must be a better way to do that. Rafael?
>=20
> Thanks,
>=20
> 	tglx

You-Sheng Yang


--dSuZ5aXFliqye4GciFuQdyADaU5yJPNCA--

--7cjH1XwkFoEg8xS0EzQzTRR9Yga9UkzU4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEVhtdp+wXuXuqVL95S6BJ+2O0nE8FAlywBcwACgkQS6BJ+2O0
nE/6zgf8Dd92N1us8jeYdl6awWD8ODDX386Xx1gGztZqHIPjbhio6w91iSFuFmbh
B5tnM6MkotrLIBNMFnVosZOE2cUyIcPOPJRCobuarpPQtT+rjSoI50BqphvlI3lv
+a75fXw7+Gq25GEnS2m6lQdgreUq6Z4QG6Pr6VwZ1+6EclYMl+8q5uNOdPlxKSjz
eEKn/NzFfCFMyBmij9DMHQFDNQosZnAtz9KN+ArViuk7PHUl5svs53o/YR+hL9OX
iu8E3ZdUzPApusBBrZvHMlNRqXU91pNGM95Mc3lq0tMIrs4HySVCtJjp2J5hFr+f
TLBuQ1Y0sllFj6hqxpQ+AbOdt5odcQ==
=qsz4
-----END PGP SIGNATURE-----

--7cjH1XwkFoEg8xS0EzQzTRR9Yga9UkzU4--
