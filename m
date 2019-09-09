Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE41C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD2E2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cMqn+GpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406098AbfIIVsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 17:48:45 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:14036 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfIIVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 17:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1568065722;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MtqZUegknBgsc7V9oe2SWxhatbu90YiITWhF1QMXFXQ=;
  b=cMqn+GpWr60vFpVz/DCuvwfIEiIEW8zHtmhL9shdy0Bmj4aFD0antSjt
   hMUxv+YnsNQ5PACOzfmcIaKD8LRyfZ/BVC6tgzAjERZf+mBVK7/Yq1eMa
   El7Av6SZqeZlOuSias03vLqwzmpS/jXUucqmw/eRzDeclahLiF+ynj+54
   I=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: hCi2gIgXCpOpzBw/5gQOHY8H5elKkQJt9aNlcE1NFqFo0yPRohSWIGMRxTs0CjTDo5YTJqiyFG
 fcBPotXRNk1rKG19cBsTmSUHUnMEDEHqgidlwyLuWBEDhq+OuqSeMlWtSehk032wQBIRjYTrip
 W5DSJDoTmhfi9f2U8/FI2WEzbl7yZ79GCST1SOY8/Ztw0KGg1q0VymaIA2tfcHShwTogFgolRP
 A6jg/uiT+vgu/xatzJ0Otyf8gvOgW7LMhSPpf46TGpWPsYTY7xHBqVZ1SbI++I9bx2WJucfliJ
 MBo=
X-SBRS: 2.7
X-MesageID: 5348248
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,487,1559534400"; 
   d="scan'208";a="5348248"
Subject: Re: [PATCH] xen/pci: try to reserve MCFG areas earlier
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
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <c45b8786-5735-a95d-bc40-61372c326037@citrix.com>
Date:   Mon, 9 Sep 2019 22:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bc3da154-d451-02cf-6154-5e0dc721a6e6@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2019 20:19, Boris Ostrovsky wrote:
> On 9/8/19 7:37 PM, Igor Druzhinin wrote:
>> On 09/09/2019 00:30, Boris Ostrovsky wrote:
>>> On 9/8/19 5:11 PM, Igor Druzhinin wrote:
>>>> On 08/09/2019 19:28, Boris Ostrovsky wrote:
>>>>> On 9/6/19 7:00 PM, Igor Druzhinin wrote:
>>>>>> On 06/09/2019 23:30, Boris Ostrovsky wrote:
>>>>>>> Where is MCFG parsed? pci_arch_init()?
>>>>>>>> It happens twice:
>>>>>> 1) first time early one in pci_arch_init() that is arch_initcall - that
>>>>>> time pci_mmcfg_list will be freed immediately there because MCFG area is
>>>>>> not reserved in E820;
>>>>>> 2) second time late one in acpi_init() which is subsystem_initcall right
>>>>>> before where PCI enumeration starts - this time ACPI tables will be
>>>>>> checked for a reserved resource and pci_mmcfg_list will be finally
>>>>>> populated.
>>>>>>
>>>>>> The problem is that on a system that doesn't have MCFG area reserved in
>>>>>> E820 pci_mmcfg_list is empty before acpi_init() and our PCI hooks are
>>>>>> called in the same place. So MCFG is still not in use by Xen at this
>>>>>> point since we haven't reached our xen_mcfg_late().
>>>>> Would it be possible for us to parse MCFG ourselves in pci_xen_init()? I
>>>>> realize that we'd be doing this twice (or maybe even three times since
>>>>> apparently both pci_arch_init()  and acpi_ini() do it).
>>>>>
>>>> I don't thine it makes sense:
>>>> a) it needs to be done after ACPI is initialized since we need to parse
>>>> it to figure out the exact reserved region - that's why it's currently
>>>> done in acpi_init() (see commit message for the reasons why)
>>> Hmm... We should be able to parse ACPI tables by the time
>>> pci_arch_init() is called. In fact, if you look at
>>> pci_mmcfg_early_init() you will see that it does just that.
>>>
>> The point is not to parse MCFG after acpi_init but to parse DSDT for
>> reserved resource which could be done only after ACPI initialization.
> 
> OK, I think I understand now what you are trying to do --- you are
> essentially trying to account for the range inserted by
> setup_mcfg_map(), right?
> 

Actually, pci_mmcfg_late_init() that's called out of acpi_init() -
that's where MCFG areas are properly sized. setup_mcfg_map() is mostly
for bus hotplug where MCFG area is discovered by evaluating _CBA method;
for cold-plugged buses it just confirms that MCFG area is already
registered because it is mandated for them to be in MCFG table at boot time.

> The other question I have is why you think it's worth keeping
> xen_mcfg_late() as a late initcall. How could MCFG info be updated
> between acpi_init() and late_initcalls being run? I'd think it can only
> happen when a new device is hotplugged.
> 

It was a precaution against setup_mcfg_map() calls that might add new
areas that are not in MCFG table but for some reason have _CBA method.
It's obviously a "firmware is broken" scenario so I don't have strong
feelings to keep it here. Will prefer to remove in v2 if you want.

Igor
