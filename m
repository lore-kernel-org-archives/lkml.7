Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52319C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204522082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GS21Jzjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfDCQog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:44:36 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:50886 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfDCQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:44:33 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9E8D424E13BD;
        Wed,  3 Apr 2019 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554309873; bh=o4JBa4XfHADSW2XV1UBcJpH0rGqp9fsnCl5YRIKQZjs=;
        h=From:To:CC:Subject:Date:References:From;
        b=GS21JzjgQdVC20SakmIc6FTS9LDB8UOqFvH11Rns2ZB2lDDcpIW0MyVkLkT8SY+8G
         LvZeJafo1eTI92WdN3mybm/Lk7D1y8rummAqIZDnZAwUbxhnGoQhJWGXQyXEslW1o4
         JbslkM+LdYJIHkISk5CfdyegV+yIsf6LqNtlwrrydc20EP/YmT38/day1fELukbcAt
         oGPxAb9o7ZZF7tX/ob6b5NuHrmG5YA04SkZ9pyKxLSenuQufgwL1cy/eM7FayeJThv
         coKODeN6sQav3s2SoEmk+TKnct3xbp2kdxmHQCVE/Rdj7DpLJRdiX2aUuLJSIdXM+U
         9cdA4APB678uA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 91191A0062;
        Wed,  3 Apr 2019 16:44:33 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 3 Apr 2019 09:44:33 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: [hsdk] Make it easier to add PAE40 region to DTB
Thread-Topic: [PATCH] ARC: [hsdk] Make it easier to add PAE40 region to DTB
Thread-Index: AQHU6YjWxx0Wxr9B3kK5/52+iXhnUg==
Date:   Wed, 3 Apr 2019 16:44:32 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146440077@US01WEMBX2.internal.synopsys.com>
References: <1554232683-8173-1-git-send-email-vgupta@synopsys.com>
 <1554309241.2797.20.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 9:34 AM, Eugeniy Paltsev wrote:=0A=
>> -		reg =3D <0x80000000 0x40000000>;  /* 1 GiB */=0A=
>> +		reg =3D <0x0 0x80000000 0x0 0x40000000>;  /* 1 GB lowmem */=0A=
>> +		/*     0x1 0x00000000 0x0 0x40000000>;     1 GB highmem */=0A=
> Could you please get rid of comment with reference for PAE40/HIGHMEM regi=
on in this patch?=0A=
> It gives wrong expectations that if we uncomment it and enable PAE40 in c=
onfig we'll get working system.=0A=
> But it isn't true - we also need to remap AXI apertures appropriately.=0A=
=0A=
Well I didn't have to do any remapping for successfully running a cross gli=
bc=0A=
testsuite over ssh.=0A=
This was v5.1-rc1 + HIGHMEM+ PAE + patch to disable ioc + this patch for DT=
 update.=0A=
=0A=
Perhaps the remapping is needed when you are remapping DDR to 0 (for HIGHME=
M + !PAE)=0A=
=0A=
> Otherwise kernel will crush somewhere. Moreover kernel will crush for dif=
ferent reasons in case of launch=0A=
> via U-boot and via MDB (because we remap AXI apertures in U-boot for inte=
rnal purposes).=0A=
=0A=
This was all via mdb !=0A=
=0A=
> If you really want to keep this - I can send you patch with AXI apertures=
 remapping we need to apply firstly.=0A=
=0A=
Well I can drop the last commented line but I don't want to do wholesale ch=
anges=0A=
to DT for enabling DT, so would liek to keep the rest of the patch anyways.=
=0A=
=0A=
But sure send over the AXI remapping stuff - is that described in hsdk spec=
s ?=0A=
=0A=
-Vineet=0A=
