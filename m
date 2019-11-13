Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969F1C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454D1222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KpdFd4ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKMD0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:26:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57891 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbfKMD0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:26:01 -0500
X-UUID: e23a333c27e24ed2819044bc012444cf-20191113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rDIAE49LJSoVbQpJ0kmEv+2G5B5G2a/scFj/B11Af9I=;
        b=KpdFd4lddrLeL7jARmsvUFFGiti8KhxBSFYDlmlt0tNxW5P4ELFzhsAQiHvfMd3DScmr2VHTpX7Z1694IFW7iw0P6wAEAXs7SN7u4sMxIpaiB/Sb57zBNGnt6msRwwT6J/wntWa/0RGnL6yQu2a5mh25RkuCDDOjaPPSDMdBsco=;
X-UUID: e23a333c27e24ed2819044bc012444cf-20191113
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 854095567; Wed, 13 Nov 2019 11:25:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Nov 2019 11:25:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Nov 2019 11:25:52 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <lvqiang.huang@unisoc.com>
CC:     <alix.wu@mediatek.com>, <allison@lohutok.net>,
        <eddy.lin@mediatek.com>, <enlai.chu@unisoc.com>,
        <gregkh@linuxfoundation.org>, <info@metux.net>,
        <kstewart@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <mark-pk.tsai@mediatek.com>, <matthias.bgg@gmail.com>,
        <mike-sl.lin@mediatek.com>, <phil.chang@mediatek.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] ARM: fix race in for_each_frame
Date:   Wed, 13 Nov 2019 11:25:54 +0800
Message-ID: <20191113032554.21034-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <64C83867-31FA-4243-A0EB-018AE9A83ACB@unisoc.com>
References: <64C83867-31FA-4243-A0EB-018AE9A83ACB@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-TM-SNTS-SMTP: 95B92524CD3366A2A5D654B2ED134B3B8F2C48BBE4E6AB8A5500FE4528A957B02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEZWFyIE1hcmssDQo+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIHJlcGx5LiANCj4gDQo+IEFzIHNh
aWQgaW4gbGFzdCByZXBseSwgc3ZfcGMgY2FuIGJlIGEgbW9kdWxlIHRleHQsIHRoZW4gbW9yZSBj
aGVjayBuZWVkZWQuDQoNCklmIHN2X3BjIGlzIGluIG1vZHVsZSB0ZXh0IGFyZWEsIGtlcm5lbF90
ZXh0X2FkZHJlc3MoKSByZXR1cm5zIHRydWUuDQoNCj4gDQo+IEFuZCBiZXNpZGUgY3Jhc2ggYXQg
MTAwMywgd2UgbWF5IGFsc28gZ2V0IGNyYXNoIGF0IDEwMDEsIHRoZSBmcmFtZSBpcyBpbnZhbGlk
LiAoVGhlIGxhc3Qgc3ZfcHYgaXMgdmFsaWQgYW5kIHN2X2ZyYW1lIGlzIGludmFsaWQpLCB0aGVu
IG1vcmUgY2hlY2sgbmVlZGVkLiANCg0KVGhlcmUncyBhIGJhc2ljIGNoZWNrIGZvciBzdl9mcCBh
dCB0aGUgZW5kIG9mIDEwMDQuDQpCdXQgSSdtIG5vdCBzdXJlIGlzIGl0IGVub3VnaCB0byBwcmV2
ZW50IHRoZSAxMDAxIGNyYXNoIHlvdSBtZW50aW9uZWQuDQpTaG91bGQgd2UgYWRkIGEgdmVyaWZ5
X3N0YWNrIGZvciBzdl9mcD8NCg0KPiANCj4gQW5kIHdlIG9mdGVuIHNob3dfZGF0YSBhcm91bmQg
dGhlIGdlbmVyYWwgcHJvcG9zYWwgcmVnaXN0ZXJzIHdoZW4ga2VybmVsIGNyYXNoLiBXaGVuIHRo
ZXkgY29udGFpbiBhbiBhZGRyZXNzIG1hcHBpbmcgZm9yIGEgaHcgcmVnaXN0ZXIgYnV0IGNhbsKS
dCBhY2Nlc3MgYmVjYXVzZSBjbG9jayBnYXRlZCwgaXQgd2lsbCBjcmFzaCBhZ2FpbiBiZWNhdXNl
IGRvX2JhZCgpIGlzIGludm9sdmVkLiAoY29udGludW91cyBjcmFzaCBpbiBhcm0gYW5kIGhhbmcg
YXQgZGllX2xvY2sgaW4gYXJtNjQpDQo+IA0KPiBTbywgd2h5IG5vdCBjaGVjayB0aGUgX19leF90
YWJsZSBpbiBkb19iYWQoKSA/DQo+IA0KDQpPbiBvdXIgYXJtIHBsYXRmb3JtLCBrZXJuZWwganVz
dCBkaWUgYmVjdWFzZSB0aGUgVW5oYW5kbGVkIGZhdWx0IGluIGZvcl9lYWNoX2ZyYW1lLg0KU28g
SSdkIHJhdGhlciB0byBmaXggaXQgYmVmb3JlIHRoZSBjb250aW51b3VzIGNyYXNoIGhhcHBlbi4N
Cg==

