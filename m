Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A55FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F187322DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="HcwA6HCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfIDLnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:43:12 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:46457 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfIDLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:43:11 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2019 07:43:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1567597390;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Py2ZD8CCSw/9B0rd6D03QDD9TGSgz5D84ZWXYCCdtq8=;
  b=HcwA6HCPbB/1iVnFtUqzUlucAdDgvgwiGR+nadl55l/HoVIqjfW/6cnK
   Kp0nLo0GFXKXOFbfv05Po6A8H3krhCeXWm6tJxltLUT6dI3R71j6NULIm
   NKYB3ygq9k9hEC3lFyWJkz48pEh+kO7AOHXKUtKyuy6FXCnYnaZnMijjG
   g=;
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
IronPort-SDR: 2PTu1kolVbKh7SpgBh5Drp1q5mHyou+YZiM+VEqUUyr78eZkRLs3AGIVi00rAA/BJKspJQfYBF
 3GaJIe+PrYIECgWU8inhCmA2FqHQuR6bT2blqwD12xI7+Ex/yHfCghPkbiJdJQeGlW+lAF3+Tf
 P+TXL70gVl1Pfc+zaH3Qsns+LKZK5zKh3s4xAKoEOPAbSRWWHjSUkkTHA5TdlBVQPu8S+0+5gz
 K/l+8Z/vM4LGBuHVLdB2pl6V9xUjd+9AlnGcbL5Ldl/wr520/JWn1LfIvVmKmsZHASjVFg7yDg
 Fjc=
X-SBRS: 2.7
X-MesageID: 5111376
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,465,1559534400"; 
   d="scan'208";a="5111376"
Subject: Re: [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Jan Beulich <jbeulich@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <52fe7f67-ffd0-2d22-90fb-f3462ea059cd@suse.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <d5dd94c2-070e-b3ff-57cf-92893b3cca7b@citrix.com>
Date:   Wed, 4 Sep 2019 12:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <52fe7f67-ffd0-2d22-90fb-f3462ea059cd@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 10:08, Jan Beulich wrote:
> On 04.09.2019 02:20, Igor Druzhinin wrote:
>> If MCFG area is not reserved in E820, Xen by default will defer its usage
>> until Dom0 registers it explicitly after ACPI parser recognizes it as
>> a reserved resource in DSDT. Having it reserved in E820 is not
>> mandatory according to "PCI Firmware Specification, rev 3.2" (par. 4.1.2)
>> and firmware is free to keep a hole E820 in that place. Xen doesn't know
>> what exactly is inside this hole since it lacks full ACPI view of the
>> platform therefore it's potentially harmful to access MCFG region
>> without additional checks as some machines are known to provide
>> inconsistent information on the size of the region.
> 
> Irrespective of this being a good change, I've had another thought
> while reading this paragraph, for a hypervisor side control: Linux
> has a "memopt=" command line option allowing fine grained control
> over the E820 map. We could have something similar to allow
> inserting an E820_RESERVED region into a hole (it would be the
> responsibility of the admin to guarantee no other conflicts, i.e.
> it should generally be used only if e.g. the MCFG is indeed known
> to live at the specified place, and being properly represented in
> the ACPI tables). Thoughts?

What other use cases can you think of in case we'd have this option?
From the top of my head, it might be providing a memmap for a second Xen
after doing kexec from Xen to Xen.

What benefits do you think it might have over just accepting a hole
using "mcfg=relaxed" option from admin perspective?

Igor
