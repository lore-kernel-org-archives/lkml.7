Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D5120820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YOa1vj/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfIVGzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 02:55:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:63907 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfIVGzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 02:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569135352; x=1600671352;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gWgdLrARls0GrnyzF+OrQtm8H+2wz1GFIztrAN9r0t0=;
  b=YOa1vj/dmMitq29uqqFrdO/BUbVwqk5ugtNDaYbb1c17kRsGHP8+Jn82
   26usevx4I7B6isNeQ9UvB/PTWC2gHgXNZp7qd7AHlfG3VJ/Z5xAaHgZGV
   n7Gnu5d9heRNHszrhtKuh2LQh1Gv+C2STBSP7dI5bsPfZDIUFVgYlg8gT
   s=;
X-IronPort-AV: E=Sophos;i="5.64,535,1559520000"; 
   d="scan'208";a="416736677"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Sep 2019 06:55:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 68832A22E2;
        Sun, 22 Sep 2019 06:55:49 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Sep 2019 06:55:48 +0000
Received: from [10.125.238.52] (10.43.161.176) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 22 Sep
 2019 06:55:42 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [UNVERIFIED SENDER] Re: [PATCH v2 2/3]
 soc: amazon: al-pos: Introduce Amazon's Annapurna Labs POS driver
To:     James Morse <james.morse@arm.com>
CC:     Marc Zyngier <maz@kernel.org>, <robh+dt@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <mchehab+samsung@kernel.org>, <shawn.lin@rock-chips.com>,
        <gregkh@linuxfoundation.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-3-git-send-email-talel@amazon.com>
 <86d0g6syva.wl-maz@kernel.org>
 <3205f7ae-5568-c064-23ac-ea726246173b@amazon.com>
 <865zlxsxtd.wl-maz@kernel.org>
 <36f19b3f-46d3-f6d0-3681-71e3a9bb52ce@amazon.com>
 <93e5ac72-13e1-4672-16f0-62ee6b8a8390@arm.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <dde86fec-ca92-a2a9-2d63-42c33c8594b0@amazon.com>
Date:   Sun, 22 Sep 2019 09:55:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <93e5ac72-13e1-4672-16f0-62ee6b8a8390@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D17UWC001.ant.amazon.com (10.43.162.188) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/2019 5:42 PM, James Morse wrote:
> Hi guys,
>
> On 12/09/2019 10:19, Shenhar, Talel wrote:
>> On 9/12/2019 11:50 AM, Marc Zyngier wrote:
>>> On Thu, 12 Sep 2019 07:50:03 +0100,
>>> "Shenhar, Talel" <talel@amazon.com> wrote:
>>>> On 9/11/2019 5:15 PM, Marc Zyngier wrote:
>>>>> On Tue, 10 Sep 2019 20:05:09 +0100,
>>>>> Talel Shenhar <talel@amazon.com> wrote:
>>>>>
>> James, will love your input from EDAC point of view, does it make sense to plug
>> un-correctable only event to EDAC?
> I think this device is an example of something like a "Fabric switch units" in
> Documentation/driver-api/edac.rst. It makes sense that it should be described as a
> 'device' to edac. You can then use the existing user-space tools to control/report/monitor
> the values.

Thank you James,

Will port this logic to be edac device.

>
>
> Thanks,
>
> James
