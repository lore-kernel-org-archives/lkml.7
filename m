Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C5C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814EB21D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gaNzLAbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfKHINh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:13:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62012 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726072AbfKHINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:13:37 -0500
X-UUID: 167b119e3f294fcbaa365433fb373abf-20191108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xBlkyXC6QXDUVtiAo1Ep4CtUp9rzUNb55vuuwtwgRxQ=;
        b=gaNzLAbHUbPc8cHrLJOCkW0kG80ufIGtRF9iUaqDaRtsVQh8ow/lZUTpXlzHkhwouwrhoa21FFfCtS57v/v6pwjhTJvW4jAuON/iUmw/aSuFcmWC7kIVENw0Wf65Tk2ZBpSHD7KJxJVMtyTRWB33G0p+Oa/7YKSqEFo251Z65m0=;
X-UUID: 167b119e3f294fcbaa365433fb373abf-20191108
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-mc.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 72878197; Fri, 08 Nov 2019 16:13:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 8 Nov 2019 16:13:26 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 8 Nov 2019 16:13:26 +0800
Message-ID: <1573200809.10348.9.camel@mtksdccf07>
Subject: Re: [PATCH net] net: ethernet: mediatek: rework GDM setup flow
From:   mtk15127 <Mark-MC.Lee@mediatek.com>
To:     David Miller <davem@davemloft.net>
CC:     <sean.wang@mediatek.com>, <john@phrozen.org>,
        <matthias.bgg@gmail.com>, <andrew@lunn.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <opensource@vdorst.com>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jakub.kicinski@netronome.com>,
        <Mark-MC.Lee@mediatek.com>
Date:   Fri, 8 Nov 2019 16:13:29 +0800
In-Reply-To: <20191107.154922.1123372183066604716.davem@davemloft.net>
References: <20191107105135.1403-1-Mark-MC.Lee@mediatek.com>
         <20191107.154922.1123372183066604716.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDE1OjQ5IC0wODAwLCBEYXZpZCBNaWxsZXIgd3JvdGU6DQo+
IEZyb206IE1hcmtMZWUgPE1hcmstTUMuTGVlQG1lZGlhdGVrLmNvbT4NCj4gRGF0ZTogVGh1LCA3
IE5vdiAyMDE5IDE4OjUxOjM1ICswODAwDQo+IA0KPiA+ICsJZm9yIChpID0gMDsgaSA8IDI7IGkr
Kykgew0KPiANCj4gVGhpcyBpcyBhIHJlZ3Jlc3Npb24sIGJlY2F1c2UgaW4gdGhlIGV4aXN0aW5n
IGNvZGUuLi4NCj4gDQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgTVRLX01BQ19DT1VOVDsgaSsrKSB7
DQo+IA0KPiB0aGUgcHJvcGVyIG1hY3JvIGlzIHVzZWQgaW5zdGVhZCBvZiBhIG1hZ2ljIGNvbnN0
YW50Lg0KIFllcywgeW91IGFyZSByaWdodCwgSSBtYWtlIGEgbWlzdGFrZSBoZXJlLCB3aWxsIGNv
cnJlY3QgaXQgaW4gdGhlIG5leHQNCnBhdGNoDQo+IA0KPiBZb3UncmUgZG9pbmcgc28gbWFueSB0
aGluZ3MgaW4gb25lIGNoYW5nZSwgaXQncyBoYXJkIHRvIHJldmlldw0KPiBhbmQgYXVkaXQuDQo+
IA0KPiBJZiB5b3UncmUgZ29pbmcgdG8gY29uc29saWRhdGUgY29kZSwgZG8gdGhhdCBvbmx5IGlu
IG9uZSBjaGFuZ2UuDQo+IA0KPiBUaGVuIG1ha2Ugb3RoZXIgZnVuY3Rpb25hbCBjaGFuZ2VzIHN1
Y2ggYXMgcHV0dGluZyB0aGUgY2hpcCBpbnRvDQo+IEdETUFfRFJPUF9BTEwgbW9kZSBkdXJpbmcg
dGhlIHN0b3Agb3BlcmF0aW9uIGV0Yy4NClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLCBJIHdp
bGwgc2VwYXJhdGUgdGhlc2UgY2hhbmdlcyBpbnRvDQphIHBhdGNoIHNlcmllcyB0byBtYWtlIGV2
ZXJ5IGNoYW5nZSB0byBiZSBtb3JlIGNsZWFyIGZvciBpdHMgDQpwdXJwb3NlLg0KDQoNCg==

