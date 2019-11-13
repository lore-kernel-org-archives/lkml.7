Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A83C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C901E222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HBILv9he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKMDjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:39:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35055 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbfKMDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:39:32 -0500
X-UUID: b676502951aa4aa3bc418226a313c88d-20191113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=l+3HLJlr9FU1jj0l+q4WqZWs0HC9AL455Rau+3GvDuw=;
        b=HBILv9heeeUS1LBs8Dcev111DYoy0ti8qll/+M5WgD9H6M+JuxwlbRJjLJ2PWLoTvz79SeEWoAW5e7SP+BedGj+nqADpQ7WNvddgmHCkypXnAzwe3gTUtiqQwvspclspVxRQ24Qo9mf9dRCIJw0Bz1Jlo7zPHD/y9tFQ7mkmIK0=;
X-UUID: b676502951aa4aa3bc418226a313c88d-20191113
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 611289577; Wed, 13 Nov 2019 11:39:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Nov 2019 11:39:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Nov 2019 11:39:23 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Evan Green <evgreen@chromium.org>, Joerg Roedel <jroedel@suse.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v1] memory: mtk-smi: Add bandwidth initial setting for MT6779
Date:   Wed, 13 Nov 2019 11:39:20 +0800
Message-ID: <1573616362-2557-1-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGVzY3JpcHRpb24gYW5kIGJhbmR3aWR0aCBpbml0aWFsIGdvbGRlbiBz
ZXR0aW5nIGZvciBNVDY3NzkgU01JLg0KVGhlIHNldHRpbmcgbWFrZSBiZXR0ZXIgcGVyZm9ybWFu
Y2Ugb2YgbWVtb3J5IGNvbnRyb2wgZm9yIG11bHRpbWVkaWEgbW9kdWxlcy4NCg0KDQpNaW5nLUZh
biBDaGVuICgyKToNCiAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBBZGQgYmluZGluZyBmb3IgTVQ2
Nzc5IFNNSQ0KICBtZW1vcnk6IG10ay1zbWk6IEFkZCBiYW5kd2lkdGggaW5pdGlhbCBnb2xkZW4g
c2V0dGluZyBmb3IgTVQ2Nzc5DQoNCiAuLi4vbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNt
aS1jb21tb24udHh0ICAgICB8ICAgIDMgKy0NCiAuLi4vbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlh
dGVrLHNtaS1sYXJiLnR4dCAgICAgICB8ICAgIDMgKy0NCiBkcml2ZXJzL21lbW9yeS9tdGstc21p
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNDEgKysrKysrKysrKysrKysrKysrKy0N
CiAzIGZpbGVzIGNoYW5nZWQsIDE0MyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K

