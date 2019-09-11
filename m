Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E74C49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 01:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3552171F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 01:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IBZYkiM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfIKBPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 21:15:17 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:6104 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfIKBPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 21:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1568164515;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5SOj58q8zjzP3gXE2tIU0/axznvGb5lEQXD3pecgzxI=;
  b=IBZYkiM10HYADSoY1FWVsLtXmgR9is4Rt7qH6EzHThUbFcgQbAusG35j
   ZSdgS2KPajGioJkoNricrjF4jcTCzwrYQHbzewknmScdaSA/T8DCy8MAq
   WPZ/3ASD1cOYZ727ZCu4vt/udz1N5sgoM7uo3u1o2F8BGYkrd2As5vADb
   c=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 2iROYvmhvGaU9c4Wz9o+O792gJVVNt9kTQX9GaFM5PYP9KqwZ0yXFbPSgp+lFWEuulyrKA/6RV
 367AAPVqmYtaEMObG59XNh0sl0C6TL1qz1K1zT7UcvtqrE1s9bCAssAZgnFvItFJ+U9u4A/60O
 L4cLmwt2zH2Jo3zbbVlaBsLKwj24x9yrylB7zk0oGxoItxFFS8Gf9PyySJfqQeLbJmR2Pb+W/S
 +zBRfGCHNjpOiHdBIsTvxj52wKxO92GWhrCRhxZ6NlpRJt5nPf3FEN+3OktJcmOxDJ/ZlytbuF
 xdY=
X-SBRS: 2.7
X-MesageID: 5647574
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,491,1559534400"; 
   d="scan'208";a="5647574"
Subject: Re: [Xen-devel] [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
 <e3114d56-51cd-b973-1ada-f6a60a7e99cc@citrix.com>
 <43b7da04-5c42-80d8-898b-470ee1c91ed2@oracle.com>
 <adefac87-c2b3-b67f-fb4d-d763ce920bef@citrix.com>
 <1695c88d-e5ad-1854-cdef-3cd95c812574@oracle.com>
 <4d3bf854-51de-99e4-9a40-a64c581bdd10@citrix.com>
 <bc3da154-d451-02cf-6154-5e0dc721a6e6@oracle.com>
 <c45b8786-5735-a95d-bc40-61372c326037@citrix.com>
 <43e492ff-f967-7218-65c4-d16581fabea3@oracle.com>
 <416ff4b7-3186-f61a-75fa-bcfc968f8117@citrix.com>
 <df64cd80-d92e-27ad-b1bc-e58184379e50@oracle.com>
 <d281baaf-a6d7-306e-63aa-b84552ac3ea5@citrix.com>
 <9ac1f34b-ea2a-3818-4cbd-a22a9a475dd4@oracle.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <74c9d2cc-a528-2cec-099e-0d803aeace6f@citrix.com>
Date:   Wed, 11 Sep 2019 02:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ac1f34b-ea2a-3818-4cbd-a22a9a475dd4@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2019 22:19, Boris Ostrovsky wrote:
> On 9/10/19 4:36 PM, Igor Druzhinin wrote:
>> On 10/09/2019 18:48, Boris Ostrovsky wrote:
>>> On 9/10/19 5:46 AM, Igor Druzhinin wrote:
>>>> On 10/09/2019 02:47, Boris Ostrovsky wrote:
>>>>> On 9/9/19 5:48 PM, Igor Druzhinin wrote:
>>>>>> On 09/09/2019 20:19, Boris Ostrovsky wrote:
>>>>>>
>>>>>>> The other question I have is why you think it's worth keeping
>>>>>>> xen_mcfg_late() as a late initcall. How could MCFG info be updated
>>>>>>> between acpi_init() and late_initcalls being run? I'd think it can only
>>>>>>> happen when a new device is hotplugged.
>>>>>>>
>>>>>> It was a precaution against setup_mcfg_map() calls that might add new
>>>>>> areas that are not in MCFG table but for some reason have _CBA method.
>>>>>> It's obviously a "firmware is broken" scenario so I don't have strong
>>>>>> feelings to keep it here. Will prefer to remove in v2 if you want.
>>>>> Isn't setup_mcfg_map() called before the first xen_add_device() which is where you are calling xen_mcfg_late()?
>>>>>
>>>> setup_mcfg_map() calls are done in order of root bus discovery which
>>>> happens *after* the previous root bus has been enumerated. So the order
>>>> is: call setup_mcfg_map() for root bus 0, find that
>>>> pci_mmcfg_late_init() has finished MCFG area registration, perform PCI
>>>> enumeration of bus 0, call xen_add_device() for every device there, call
>>>> setup_mcfg_map() for root bus X, etc.
>>> Ah, yes. Multiple busses.
>>>
>>> If that's the case then why don't we need to call xen_mcfg_late() for
>>> the first device on each bus?
>>>
>> Ideally, yes - we'd like to call it for every bus discovered. But boot
>> time buses are already in MCFG (otherwise system boot might not simply
>> work as Jan pointed out) so it's not strictly required. The only case is
>> a potential PCI bus hot-plug but I'm not sure it actually works in
>> practice and we certainly didn't support it before. It might be solved
>> theoretically by subscribing to acpi_bus_type that is available after
>> acpi_init().
> 
> OK. Then *I think* we can drop late_initcall() but I would really like
> to hear when others think.
> 

Another thing that I implied by "not supporting" but want to explicitly
call out is that currently Xen will refuse reserving any MCFG area
unless it actually existed in MCFG table at boot. I don't clearly
understand reasoning behind it but it might be worth relaxing at least
size matching restriction on Xen side now with this change.

Igor
