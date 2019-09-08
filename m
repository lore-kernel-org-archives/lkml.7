Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DC1C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EEB20854
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NyzBvW7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfIHVLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 17:11:43 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:19249 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfIHVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 17:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1567977101;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=I6JRjNC6jGloUsMWw5bRRxRNOT8ykZ15S5WsOIB4YKE=;
  b=NyzBvW7x//QsR8/LmdrbeW9g4BvkTrbnu8NaFZuXV4kmrnm0FcJt6xf5
   cKpB4sPiQ1TAs+eYiQPv3V7jzPhV4hmIfGJ3vx+n5jatIMYsIOKj0vnwD
   sntSV6A/o6WZ/17TxIgo2Z9vfWW1WuCotGjncAsugnUz2AC8xP5pOpp0/
   w=;
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
IronPort-SDR: QBSdi5HD2a9n4ngJuFf05ktyxatNog/I/LGJqyVA8tONNkpDxNeLmZlzpeB3eU+/ImS1IYCTAP
 F9WYilOHcrPTrb7yhDKN0+HX0nFZUCVjkhyjbxFX2T3VXvrKCquXYzjGlkHn+7c+JSlkUoQ2m+
 8KUoab9XGaRvNf2pONgtnzIZvVfQM3O5GPJf59RowzScX75gAXtkEeTZDCcRyOsIDr0Y6e0y+R
 2Xme73dmt1PhOuNPqeuaFxsGOmfita0GF/7Bsr3fk+90zqKEKpkmitkeyMbW92KZiZh0EvI3mi
 p0c=
X-SBRS: 2.7
X-MesageID: 5523475
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,481,1559534400"; 
   d="scan'208";a="5523475"
Subject: Re: [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
 <e3114d56-51cd-b973-1ada-f6a60a7e99cc@citrix.com>
 <43b7da04-5c42-80d8-898b-470ee1c91ed2@oracle.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <adefac87-c2b3-b67f-fb4d-d763ce920bef@citrix.com>
Date:   Sun, 8 Sep 2019 22:11:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43b7da04-5c42-80d8-898b-470ee1c91ed2@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2019 19:28, Boris Ostrovsky wrote:
> On 9/6/19 7:00 PM, Igor Druzhinin wrote:
>>
>> On 06/09/2019 23:30, Boris Ostrovsky wrote:
>>>
>>> Where is MCFG parsed? pci_arch_init()?
>>>> It happens twice:
>> 1) first time early one in pci_arch_init() that is arch_initcall - that
>> time pci_mmcfg_list will be freed immediately there because MCFG area is
>> not reserved in E820;
>> 2) second time late one in acpi_init() which is subsystem_initcall right
>> before where PCI enumeration starts - this time ACPI tables will be
>> checked for a reserved resource and pci_mmcfg_list will be finally
>> populated.
>>
>> The problem is that on a system that doesn't have MCFG area reserved in
>> E820 pci_mmcfg_list is empty before acpi_init() and our PCI hooks are
>> called in the same place. So MCFG is still not in use by Xen at this
>> point since we haven't reached our xen_mcfg_late().
> 
> 
> Would it be possible for us to parse MCFG ourselves in pci_xen_init()? I
> realize that we'd be doing this twice (or maybe even three times since
> apparently both pci_arch_init()  and acpi_ini() do it).
> 

I don't thine it makes sense:
a) it needs to be done after ACPI is initialized since we need to parse
it to figure out the exact reserved region - that's why it's currently
done in acpi_init() (see commit message for the reasons why)
b) given (a) we cannot do it ourselves before acpi_init and after is too
late as we're already past ACPI PCI enumeration
c) we'd have to do it in the same place I call xen_mcfg_late() and it'd
be code duplication of what's already done by the existing code.

Igor
