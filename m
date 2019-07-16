Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC3C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7CA21848
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IjIS2Qfw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="IpKq61KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbfGPUkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:40:07 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:49604 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbfGPUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:40:07 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A3C21C2510;
        Tue, 16 Jul 2019 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563309606; bh=uJPRBJxggYs33I+/ZcgNHmE1IKEOjOEO4hSN1Tcc3u8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IjIS2QfwkNc2fdfVqGCLVxdi6SjqtdZFawliezM9PXkO8D2UJ2LnGpscxnJDTws7W
         sRAHXNnIL+bucoCv9trpQqk/E8WVr922vRCbYSPMSO+dJOeNe+EswTSzNwN4PzYAqw
         na8gvCf8Qvz3b8IhIv+tTBABRvcA10GPyx/6kM1Ck+PGL/n6pF7Jh9ckEsF/iMHEoJ
         h9Ou3tbo3/7qfJMAB9hVs8CfUxmc+DvAEV6wAEd5TR0k0aBmzIRNTZQ0SkcGQLbPH5
         paCE4m7zhTZFDkEtYwXGFafblbIGbRmjkL29FzkrbVgSevcUMF6bCcgxIz6ji/c32e
         YX4osmFh5ofOQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5ABC7A023B;
        Tue, 16 Jul 2019 20:40:03 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Jul 2019 13:39:46 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 16 Jul 2019 13:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm1hGCvTbdhXBCyKVDJwwIBmjctIgWlmjHXtIPZGXniJG0GJ3LD+guFyTXLLYVqHUJB7UV+KHfyfJo1d+AnqDEbqvKolQ8w7C754Baznu7Ayz/rz2NPlqhHvPjgkSz6xD45wYvE0W5SPLd8eqWHX3mTIP6lhIJFRrHifHjM3iJGAuFsqnR5a6OgryQhRwRP5adxoexHcZOFWFIdjvZLp7rQZC8T/3OGUiu25dLhkU1dT8OcI8ulfOobY7RmfHCosQMfzSBOPZiqeQuuRWkqkNul1Ie3UmWR8CThO7uVRGgQiVl8129TpDAE7kvPc4dwW+u7izUD0bTqNdG5ev+pC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJPRBJxggYs33I+/ZcgNHmE1IKEOjOEO4hSN1Tcc3u8=;
 b=nhTraMxgixS407YodU77VyW/af+whYPPH25WpDvucKUeaWUlE4HjZEIpnHxu0DLguWWuPxHpElkat7g3xPcXPL5pw5VkzE2f5uSe3fb/jepxiibg+23TmNvEDPd5/bREH8Xwsi8kTOBIC2GjwxOgFXbpU9ZoYhSoBMyWphF1gdOEoB0SpViGKsFSgcylWlS5ZTFzeydO5+8Rg3xi/rpz9o+GJURULaPYdOqYeAIS5+n+achdkumzkYvgRh16E9xs4cD9v+wxNN/O9/sBFcwQnv2RTCzq7DHUIWTXA4QJSGP/u/3AaljFpUjCFJ1u7kKYw2TP/6wK0CpJ+MFBZ7GjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJPRBJxggYs33I+/ZcgNHmE1IKEOjOEO4hSN1Tcc3u8=;
 b=IpKq61KZlXmw7sNfwPG3rfXs8XhKuPYyMp1++pE/+7i3V5h/XR/EO3vEcRdiyZzIdlJ065bX5Z7xU6eSEq3NDwDLvpC5Y9P4rWif4J8J32muYmO8rErYwBlLGo4wsaLgLm7f2+SN6tQWMIm1o0w+u8fdjP58lJDQfGXTY/euNiY=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0227.namprd12.prod.outlook.com (10.174.239.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 20:39:43 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c%11]) with mapi id 15.20.2073.012; Tue, 16 Jul
 2019 20:39:43 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: [GIT PULL] ARC updates for 5.3-rc1
Thread-Topic: [GIT PULL] ARC updates for 5.3-rc1
Thread-Index: AQHVPBRCHpBudYy3jUKEd/4lOklWzqbNtQaA
Date:   Tue, 16 Jul 2019 20:39:43 +0000
Message-ID: <c370f648-b9f6-a845-d3cd-170fc3ae8c2f@synopsys.com>
References: <99fc2ead-d7d8-1c54-b493-02e79e2fc24e@synopsys.com>
In-Reply-To: <99fc2ead-d7d8-1c54-b493-02e79e2fc24e@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-originating-ip: [198.182.56.5]
x-clientproxiedby: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To BN6PR1201MB0035.namprd12.prod.outlook.com (2603:10b6:405:4d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f68dc419-1807-47af-cc9b-08d70a2dbb4a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1201MB0227;
x-ms-traffictypediagnostic: BN6PR1201MB0227:
x-microsoft-antispam-prvs: <BN6PR1201MB02274557095A7E4B963E5380B6CE0@BN6PR1201MB0227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(6486002)(6436002)(7736002)(31696002)(229853002)(305945005)(3846002)(4326008)(65826007)(478600001)(6116002)(64756008)(25786009)(2906002)(76176011)(66946007)(6506007)(446003)(53936002)(6246003)(64126003)(65806001)(65956001)(81166006)(81156014)(8676002)(66066001)(8936002)(186003)(476003)(486006)(26005)(256004)(31686004)(102836004)(68736007)(4744005)(2616005)(66556008)(5660300002)(71200400001)(66476007)(6916009)(11346002)(52116002)(316002)(36756003)(14454004)(66446008)(58126008)(86362001)(54906003)(71190400001)(99286004)(386003)(53546011)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0227;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CX3p5MLgre0+Gv2IGZdTvvzIzHyy0sh/qSVHsuZa2knuT54iJIYuSXflzj1Zar+WXa948iyN9enhKQUsbNlf2jHgSjEkYkT14p4EB5lLeleMT5R4bXkUliVV8hvp21AjmxISAwOanwj08FfnVwcnIGXwNv8s9hUPM8a5/qgzicdufP7F6WZG/AVb5xVbOeq76AveZ9t1yBbSU0xTKZsJX/osaZJB83fp6fwnIo/Wg72ixTcodzx88Wcwk5Qna1lEkL8ILHdpSqPWT4C8Rzjpvxqm0ObudtxArnjxHVWECA9mbZh2t+FessCYIL9unAzAJDzSJ3K9JuCCsnIGeXI94cXcAktxrMtRXJ9IVouz2YQQIARzZvRtpESzRpiGdArR3+xcznDnSSQvf3RSjEWHYqC88UWFiNWxQw2gaKOOghM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <488DE52987D7694EA6B1E44D4ADDC859@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f68dc419-1807-47af-cc9b-08d70a2dbb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 20:39:43.0690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0227
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNi8xOSAxOjIyIFBNLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IEhpIExpbnVzLA0KPiAN
Cj4gQnVuY2ggb2YgY2hhbmdlcyBmb3IgQVJDLCBzb21lIGxvbmcgZHVlLCBmb3IgdGhlIG5ldyBy
ZWxlYXNlLiBQbGVhc2UgcHVsbC4NCj4gDQo+IFRoeCwNCj4gLVZpbmVldA0KDQpTb3JyeSBhbG1v
c3QgZm9yZ290LCB5b3Ugd291bGQgcnVuIGludG8gc29tZSBtZXJnZSBjb25mbGljdCBkdWUgdG8g
Y29sbGlzaW9ucw0KYmV0d2VlbiBkb19wYWdlX2ZhdWx0KCkgcmV3b3JrIGFuZCBmb3JjZV9zaWdf
ZmF1bHQoKSBhcmd1bWVudCBjaGFuZ2UsIGJ1dCBzaG91bGQNCmJlIGVhc3kgdG8gcmVzb2x2ZS4g
SSdsbCBnaXZlIGl0IGFsbCBhIHNwaW4gb25jZSB1IG1lcmdlIGl0Lg0KDQpUaHgsDQotVmluZWV0
DQo=
