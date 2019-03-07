Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41AD20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZNq8TlmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCGKW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:22:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44193 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:22:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so12945318edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K7EajfG83OwVfh7KJ8UAnI3kO4lUa5c37gHIuXg4eMA=;
        b=ZNq8TlmRf6DH05VtqeSQxyfZUf8gIPU2frD2FPaSNsjBmRMrB497/Hi3H0NvMg/GUJ
         Nhf5mSKk98fOaUNNwoujivylG1NuOncX9PZXRlc9GuViIOafpWxD/ygMBUN7HBE8ZWTf
         QcqLVV+mPPmcZTTKVYfMrTO2sWK2It5ucHe0TA7qUxbLPVUriO1o94s/gf4g3472Um54
         WHItoMRewRQAndpkV6vam5GD3yA4mG8mShpwM7LHS+KcJV5Nn9CJA/sZBof5RNUcsSZC
         lkAoDhBZVn/L7uPnTskFYonUr5prW86cKRN+LYmEeXrQyXcPu3eo5rq+pxcIYy7eQRk3
         eQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K7EajfG83OwVfh7KJ8UAnI3kO4lUa5c37gHIuXg4eMA=;
        b=MrE++hiYiGbLGeRO9KW05ydRmGe/aPsKibkSKwd+Lb3YTJJCti8PVJNfCg6Om1B85Z
         9tr0z3oxFc9OsTxZG5+jNUJlMjeZwqNBE0Fesd+6Jm/01m8hyAoUDOvjGzRwz2Hs7np/
         TYbGdBN5gr2xWeWnJGJXlo56ND/iCYaXkMT0AD9ffh3/eGcJRljjPYBSm1LVWyobTeV9
         XYVnXXtqecF0THeKRxkyuvL2xRjOJq0gUsJrRWfQYFJszbpS2zwQHv6gr+DSfkCIvCdG
         yYj+WaRMHrU11zVap9OlluIeLxJUP8k90hVaFrhwRDcvfjenK1ZgJvjuufMaG3/4QE3v
         W2Bw==
X-Gm-Message-State: APjAAAUruzb5pHLHyo+V5wuhyQPkMyzzrdjQR3sCUCQkGljhYqwJEn0t
        OiWJg+7Y90RPs5MK1rdw5G498xbovms=
X-Google-Smtp-Source: APXvYqzOo7LHunZLjGU+S1PQ1Jyk0toq0moOQkXX/h3T7ulWRuYe+iibNMDV+xkrtX5IiYW3pGIB4Q==
X-Received: by 2002:a50:d2d7:: with SMTP id q23mr27956118edg.120.1551954146276;
        Thu, 07 Mar 2019 02:22:26 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g5sm806096ejj.42.2019.03.07.02.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:22:25 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
Date:   Thu, 7 Mar 2019 10:21:23 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 7 Mar 2019, at 06:31, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/7/19 2:08 AM, James Sewart wrote:
>>>>>> -	/*
>>>>>> -	 * For each rmrr
>>>>>> -	 *   for each dev attached to rmrr
>>>>>> -	 *   do
>>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>>> -	 *     allocate free domain
>>>>>> -	 *     allocate page table entries for rmrr
>>>>>> -	 *     if context not allocated for bus
>>>>>> -	 *           allocate and init context
>>>>>> -	 *           set present in root table for this bus
>>>>>> -	 *     init context with domain, translation etc
>>>>>> -	 *    endfor
>>>>>> -	 * endfor
>>>>>> -	 */
>>>>>> -	pr_info("Setting RMRR:\n");
>>>>>> -	for_each_rmrr_units(rmrr) {
>>>>>> -		/* some BIOS lists non-exist devices in DMAR =
table. */
>>>>>> -		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
>>>>>> -					  i, dev) {
>>>>>> -			ret =3D iommu_prepare_rmrr_dev(rmrr, =
dev);
>>>>>> -			if (ret)
>>>>>> -				pr_err("Mapping reserved region =
failed\n");
>>>>>> -		}
>>>>>> -	}
>>>>>> -
>>>>>> -	iommu_prepare_isa();
>>>>> Why do you want to remove this segment of code?
>>>> This will only work if the lazy allocation of domains exists, these
>>>> mappings will disappear once a default domain is attached to a =
device and
>>>> then remade by iommu_group_create_direct_mappings. This code is =
redundant
>>>> and removing it allows us to remove all the lazy allocation logic.
>>> No exactly.
>>>=20
>>> We need to setup the rmrr mapping before enabling dma remapping,
>>> otherwise, there will be a window after dma remapping enabling and
>>> rmrr getting mapped, during which people might see dma faults.
>> Do you think this patch instead should be a refactoring to simplify =
this initial domain setup before the default domain takes over? It seems =
like duplicated effort to have both lazy allocated domains and =
externally managed domains. We could allocate a domain here for any =
devices with RMRR and call get_resv_regions to avoid duplicating RMRR =
loop.
>=20
> Agree. We should replace the lazy allocated domains with default =
domain
> in a clean way. Actually, your patches look great to me. But I do =
think
> we need further cleanups. The rmrr code is one example, and the =
identity
> domain (si_domain) is another.
>=20
> Do you mind if I work on top of your patches for further cleanups and
> sign off a v2 together with you?

Sure, sounds good. I=E2=80=99ll fixup patch 3 and have a go at =
integrating=20
iommu_prepare_isa into get_resv_regions. This should make the initial=20
domain logic here quite concise.

>=20
> Best regards,
> Lu Baolu

Cheers,
James.=
