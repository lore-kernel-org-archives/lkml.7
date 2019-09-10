Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2335C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08412067B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IbiowjFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405732AbfIJKJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:09:08 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:1324 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388625AbfIJKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1568110147;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pBz+UuMi9t93ue09GBBv3yYtxQyJZrHCSoPQj54RG68=;
  b=IbiowjFdvCrTET/hnp4FUOF9fNzxF/u3FKqSu4XIMxpyRD4G2agsTYEb
   XpJlVuPYMkIzi0+ApdTYpRMClcIGueSpFVbj/lDbKOrIhINakPr/IXJwK
   ivznr0ChUo0x3kOCbb9RtPVoOF8uFAmhQHqa/T5IZPYbKo+MXVuoZ5uEY
   A=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: TBU9T7jchkQ1P6Nrhbf6mhdO6bD+/m42BsdXyRYJtPpVp/Rs3BiRhYYuEDtYOV+OYR0sXCTfV3
 i9xCXGd7TleNz75eYywzvFE9JqvxK+Avt2qtc2hWfvBvzVOcVwbohM15EKXFGzitdShIprtrJK
 tmAk/VYBahVFLE1fRtlTuyEo0c8uMtiDP/nqz4L1UD6xaERdMa1SfhX2dc8mk6jEeeANJTDgrj
 6DA51xzX8DCoggt7+BSzLGh8d/VkQVUuu8T50AI0xpZ8LYO2EMD6Fm25u46HxewvhDOFFtfsXi
 Bck=
X-SBRS: 2.7
X-MesageID: 5361133
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,489,1559534400"; 
   d="scan'208";a="5361133"
Subject: Re: [Xen-devel] [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <linux-kernel@vger.kernel.org>
CC:     <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>
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
 <64d52960-28d5-fb23-8892-35c9d4ed9d90@suse.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <8fa50f93-bc83-3474-8bca-3437f3b47a6e@citrix.com>
Date:   Tue, 10 Sep 2019 11:08:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64d52960-28d5-fb23-8892-35c9d4ed9d90@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2019 10:55, Jan Beulich wrote:
> On 10.09.2019 11:46, Igor Druzhinin wrote:
>> On 10/09/2019 02:47, Boris Ostrovsky wrote:
>>> On 9/9/19 5:48 PM, Igor Druzhinin wrote:
>>>> Actually, pci_mmcfg_late_init() that's called out of acpi_init() -
>>>> that's where MCFG areas are properly sized. 
>>>
>>> pci_mmcfg_late_init() reads the (static) MCFG, which doesn't need DSDT parsing, does it? setup_mcfg_map() OTOH does need it as it uses data from _CBA (or is it _CRS?), and I think that's why we can't parse MCFG prior to acpi_init(). So what I said above indeed won't work.
>>>
>>
>> No, it uses is_acpi_reserved() (it's called indirectly so might be well
>> hidden) to parse DSDT to find a reserved resource in it and size MCFG
>> area accordingly. setup_mcfg_map() is called for every root bus
>> discovered and indeed tries to evaluate _CBA but at this point
>> pci_mmcfg_late_init() has already finished MCFG registration for every
>> cold-plugged bus (which information is described in MCFG table) so those
>> calls are dummy.
> 
> I don't think they're strictly dummy. Even for boot time available devices
> iirc there's no strict requirement for there to be respective data in MCFG.
> Such a requirement exists only for devices which are actually needed to
> start the OS (disk or network, perhaps video or alike), or maybe even just
> its loader.
> 

This was my interpretation of 4.1.3 of "PCI Frimware specification":
"Memory mapped configuration base addresses for non-hot pluggable host
bridges must be described using MCFG table." Although, I admit that
"non-hot pluggable" might mean available at boot as well.

Igor
