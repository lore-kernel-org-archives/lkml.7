Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B17C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96B220665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ir8Q9jan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfFMUfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:35:30 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:43178 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbfFMUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:35:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBDA3C0246;
        Thu, 13 Jun 2019 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560458129; bh=jsFFEjF512FgPkQJhTvFb8dpbi1Ey52PpS6d7gE4Aco=;
        h=From:To:CC:Subject:Date:References:From;
        b=ir8Q9janMXIgtC9SfzadlISDHA94Fi/CXa+S18i715MLQHkwBniZeu3uvI5wxPB8z
         /o3kwlft4zeXL4Q3Ao8rg4Y4egEKwxfN9swYmfLrp4o2yMISaY8y8DnNsytPsRoWWE
         YsRNzzKb4wDe8r++BABw1zn6Jgi4215xb+xLqfJnjONZqearmPJUXB1DpqrvoTYgVx
         D+13znxZv7T2YK3a3+ath/Zq6BFA5pkg0Rjas2SiFAPkcw5vlMRBZjSME2vUrbm5Xx
         srt8oK/uAeztcWFol+hJ6w3sJIHn6lTbQwRPqjMmp7f6reHOmNLF4A9D2w6z643VCq
         Lbomlh3pnO+mQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2AC58A0105;
        Thu, 13 Jun 2019 20:35:26 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu, 13
 Jun 2019 13:35:26 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Cupertino.Miranda@synopsys.com" <Cupertino.Miranda@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "Claudiu.Zissulescu@synopsys.com" <Claudiu.Zissulescu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARC Assembler: bundle_align_mode directive support
Thread-Topic: ARC Assembler: bundle_align_mode directive support
Thread-Index: AQHVHicA2N+x/AVgjkyWYOIr/ofXig==
Date:   Thu, 13 Jun 2019 20:35:26 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2526536@us01wembx1.internal.synopsys.com>
References: <3962a9ad199cea45b1cfadb80be551aab83b7028.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2525686@us01wembx1.internal.synopsys.com>
 <d79085cbc6126c2a4fad173934e1e9b29523abba.camel@synopsys.com>
 <02fcd330-8b3c-a3cb-0aa9-e91bca6b6d0f@synopsys.com>
 <8a027c250d7bd14ff107c169351af6a04a6d8334.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 11:14 AM, Eugeniy Paltsev wrote:=0A=
> BTW:=0A=
> there is discussion in Linux ML about implementation of static calls.=0A=
> The idea is to patch immediate operand in jump instruction instead of usi=
ng function pointers to optimize hot code.=0A=
> @vineet I bet you'll like this :)=0A=
>=0A=
> Current v3 patch revision is for x86 only and it's not applied yet. Howev=
er I expect (based on comments to last patches)=0A=
> it'll be applied after several respins. =0A=
=0A=
Indeed when researching on jump labels I saw that and indeed like that appr=
oach a lot.=0A=
=0A=
=0A=
> It would be nice to implement it for ARC too.=0A=
=0A=
Absolutely.=0A=
=0A=
> And x86 static calls implementation uses '.bundle_align_mode' directive t=
oo.=0A=
=0A=
Ok then we have a case for pushing for this feature in tools !=0A=
