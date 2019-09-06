Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E71C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F2120842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DbanTpsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405362AbfIFOND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:13:03 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:32825 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbfIFONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567779181; x=1599315181;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9G4bFzovgTxqFaJRsXnATnhBOQd8Ab1q5goy+J25MD4=;
  b=DbanTpsGOUyFO4z0/10UxdqdClAZA82Z+1MqkEFR/2gx68OBOHWsB2pJ
   acLtAtNjcrDuXcmQH4EkODnbSpzJRt2LBPwv8iOXEw04umyDDMMOX9U7E
   vJa1/5BpXcmoRCC1kbCBSHCHb+sf7ym0J6sTXBOjBsgAZgfUufdtqibJz
   0=;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="413941107"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Sep 2019 14:12:59 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id F40E0A2404;
        Fri,  6 Sep 2019 14:12:56 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 14:12:56 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.242) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 14:12:53 +0000
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To:     Peter Maydell <peter.maydell@linaro.org>
CC:     Christoffer Dall <christoffer.dall@arm.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
 <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org>
 <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
 <20190905092223.GC4320@e113682-lin.lund.arm.com>
 <4b6662bd-56e4-3c10-3b65-7c90828a22f9@kernel.org>
 <20190906080033.GF4320@e113682-lin.lund.arm.com>
 <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
 <20190906131252.GG4320@e113682-lin.lund.arm.com>
 <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
 <28c5c021-7cb0-616b-4215-dd75242c16e6@amazon.com>
 <CAFEAcA8HH-JeMLZ29h6GidDcLpb_oUHqoyEMJ0buo3hyTBj5jA@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <f5af43d5-d8f6-58f1-bd25-909e4e94ddb0@amazon.com>
Date:   Fri, 6 Sep 2019 16:12:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HH-JeMLZ29h6GidDcLpb_oUHqoyEMJ0buo3hyTBj5jA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.242]
X-ClientProxiedBy: EX13D18UWC003.ant.amazon.com (10.43.162.237) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAwNi4wOS4xOSAxNTo1MCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToKPiBPbiBGcmksIDYgU2Vw
IDIwMTkgYXQgMTQ6NDEsIEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+IHdyb3RlOgo+
PiBPbiAwNi4wOS4xOSAxNTozMSwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToKPj4+IChiKSB3ZSB0cnkg
dG8gcmV1c2UgdGhlIGNvZGUgd2UgYWxyZWFkeSBoYXZlIHRoYXQgZG9lcyBUQ0cgZXhjZXB0aW9u
Cj4+PiBpbmplY3Rpb24sIHdoaWNoIG1pZ2h0IG9yIG1pZ2h0IG5vdCBiZSBhIGRlc2lnbiBtaXN0
YWtlLCBhbmQKPj4KPj4gVGhhdCdzIHByb2JhYmx5IGEgZGVzaWduIG1pc3Rha2UsIGNvcnJlY3Qg
OikKPiAKPiBXZWxsLCBjb25jZXB0dWFsbHkgaXQncyBub3QgbmVjZXNzYXJpbHkgYSBiYWQgaWRl
YSwgYmVjYXVzZQo+IGluIGJvdGggY2FzZXMgd2hhdCB3ZSdyZSBkb2luZyBpcyAiY2hhbmdlIHRo
ZSBzeXN0ZW0gcmVnaXN0ZXIKPiBzdGF0ZSAoUEMsIEVTUl9FTDEsIEVMUl9FTDEgZXRjKSBzbyB0
aGF0IHRoZSBDUFUgbG9va3MgbGlrZQo+IGl0J3MganVzdCB0YWtlbiBhbiBleGNlcHRpb24iOyBi
dXQgc29tZSBvZiB3aGF0IHRoZQo+IFRDRyBjb2RlIG5lZWRzIHRvIGRvIGlzbid0IG5lY2Vzc2Fy
eSBmb3IgS1ZNIGFuZCBhbGwgb2YgaXQKPiB3YXMgbm90IHdyaXR0ZW4gd2l0aCB0aGUgaWRlYSBv
ZiBLVk0gaW4gbWluZCBhdCBhbGwuLi4KClllcywgYW5kIGl0IHByb2JhYmx5IG1ha2VzIHNlbnNl
IHRvIG1vZGVsIHRoZSBRRU1VIGludGVybmFsIEFQSSAKc2ltaWxhcmx5LCBzbyB0aGF0IGV4Y2Vw
dGlvbiBnZW5lcmF0aW5nIGNvZGUgZG9lcyBub3QgaGF2ZSB0byBkaXN0aW5ndWlzaC4KCkhvd2V2
ZXIsIGl0J3MgbXVjaCBlYXNpZXIgZm9yIEtWTSB0byBlbnN1cmUgZXhjZXB0aW9uIHByaW9yaXRp
emF0aW9uIGFzIAp3ZWxsIGFzIGludGVybmFsIHN0YXRlIHN5bmNocm9uaXphdGlvbi4gQ29uY2Vw
dHVhbGx5LCBhcyB5b3UndmUgc2VlbiwgaXQgCnJlYWxseSBkb2Vzbid0IG1ha2UgYSBsb3Qgb2Yg
c2Vuc2UgdG8gcHVsbCByZWdpc3RlciBzdGF0ZSBmcm9tIEtWTSwgCndpZ2dsZSBpdCBhbmQgdGhl
biBwdXNoIGl0IGRvd24gd2hlbiBLVk0gaGFzIGF3YXJlbmVzcyBvZiB0aGUgc2FtZSAKdHJhbnNm
b3JtYXRpb24gYW55d2F5LgoKU28gSSBndWVzcyB0aGUgcGF0aCBpcyBjbGVhcjogQ3JlYXRlIGEg
Z2VuZXJpYyBpbnRlcmZhY2UgZm9yIGV4Y2VwdGlvbiAKaW5qZWN0aW9uIGFuZCBhIHNlcGFyYXRl
IHBhdGNoIHNpbWlsYXIgdG8gd2hhdCBDaHJpc3RvZmZlciBhbHJlYWR5IApwb3N0ZWQgd2l0aCB0
aGUgbmV3IENBUCB0byByb3V0ZSBpbGxlZ2FsIE1NSU8gdHJhcHMgaW50byB1c2VyIHNwYWNlLgoK
Q29ubmVjdGluZyB0aGUgdHdvIGRvdHMgaW4gdXNlciBzcGFjZSByZWFsbHkgc2hvdWxkIGJlIHRy
aXZpYWwgdGhlbi4KCihmYW1vdXMgbGFzdCB3b3JkcykKCgpBbGV4CgoKCkFtYXpvbiBEZXZlbG9w
bWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNj
aGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKRWluZ2V0
cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNp
dHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

