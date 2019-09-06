Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D57207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ABcmNdnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392707AbfIFXC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:02:26 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:52996 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392182AbfIFXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1567810944;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dpPsk8LE83368fkJgEcOsXssOy2FoPlssTTZn0BFLZY=;
  b=ABcmNdnfZj5F3awRBT4ElXugV/R4FAhj9Y5NMbAwDP8QFMcbfVT8QoCG
   5ii7BByOHE/QFBuEuws6g2tn8JWy/0BQxxmf509uDENhhpwty7vWqv3DP
   Yc0s5yanL0PP9qGomas689QvLoi3HyvmKBV34Xu83D+zzQVMDPJgnhzL4
   w=;
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
IronPort-SDR: T/9zojaCofQTVlg9JytA1HFg6m2EOIp6isp71QNFOWodT3M/pxCZDFS6Tp7lRml6yh9gRo2kio
 k4m0NoQDKq4gwgl/vh+1lZsUVEdxbh0ykvTE3sxXrqKw8IeRa4vj4u+eAuPXXOqnOd03HFyjme
 oMU975HElEZIHLolgJex75ZNWkzp3vEu7c6F6MWHfuf8EvN3yzZL2fw+bqaBQuuOUXRimGOswx
 omBipzSNypUdsO2QvhRuh8Ky9w7+glJ3gnAXM8VxjTLQ0iyvFQraFIUR4PtigIttZLRI4ee31Q
 6qM=
X-SBRS: 2.7
X-MesageID: 5266131
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,474,1559534400"; 
   d="scan'208";a="5266131"
Subject: Re: [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <e3114d56-51cd-b973-1ada-f6a60a7e99cc@citrix.com>
Date:   Sat, 7 Sep 2019 00:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2019 23:30, Boris Ostrovsky wrote:
> On 9/3/19 8:20 PM, Igor Druzhinin wrote:
>> If MCFG area is not reserved in E820, Xen by default will defer its usage
>> until Dom0 registers it explicitly after ACPI parser recognizes it as
>> a reserved resource in DSDT. Having it reserved in E820 is not
>> mandatory according to "PCI Firmware Specification, rev 3.2" (par. 4.1.2)
>> and firmware is free to keep a hole E820 in that place. Xen doesn't know
>> what exactly is inside this hole since it lacks full ACPI view of the
>> platform therefore it's potentially harmful to access MCFG region
>> without additional checks as some machines are known to provide
>> inconsistent information on the size of the region.
>>
>> Now xen_mcfg_late() runs after acpi_init() which is too late as some basic
>> PCI enumeration starts exactly there. Trying to register a device prior
>> to MCFG reservation causes multiple problems with PCIe extended
>> capability initializations in Xen (e.g. SR-IOV VF BAR sizing). There are
>> no convenient hooks for us to subscribe to so try to register MCFG
>> areas earlier upon the first invocation of xen_add_device(). 
> 
> 
> Where is MCFG parsed? pci_arch_init()?

It happens twice:
1) first time early one in pci_arch_init() that is arch_initcall - that
time pci_mmcfg_list will be freed immediately there because MCFG area is
not reserved in E820;
2) second time late one in acpi_init() which is subsystem_initcall right
before where PCI enumeration starts - this time ACPI tables will be
checked for a reserved resource and pci_mmcfg_list will be finally
populated.

The problem is that on a system that doesn't have MCFG area reserved in
E820 pci_mmcfg_list is empty before acpi_init() and our PCI hooks are
called in the same place. So MCFG is still not in use by Xen at this
point since we haven't reached our xen_mcfg_late().

Igor


