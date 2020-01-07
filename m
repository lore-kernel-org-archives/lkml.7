Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16578C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D763C2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QEBjFMFL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="ZWooqjMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgAGSaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:30:23 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36280 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbgAGSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:30:22 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 15E72C0530;
        Tue,  7 Jan 2020 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578421821; bh=EaCDkZSESud0qEJDsETyfvMbxrGc3XZFp790ZPpVlK4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QEBjFMFL0pwipO4D5CfGH8li2E8E52Czn+L5FgHZx/7tlJYiV/p21o5VZRiXusNwS
         6v1SxvPXPyOws/vTBauzMO0CFhj3dyscvDMGzKaMJc3coUGEpsl6wkl3yBlTN0a5R7
         +6JFLOBKLA21HH9e+XmR8A/S2b+gLfKHr5D2fbfXoCYo/YNL8/a43BuiQqdURDDAFK
         IRmJGZ9AMKFe7XWL/w56pdEr+1nEqq46QF60YImkwEEcgoxNZwYr98LAi/ZI0cailx
         ZAghCc5EwE6MIZ6MtJgkl/usTbiM/QFbEI/f8QhwxEvCf8FgTAQkJ/hbyEGQ7or/7Y
         X0ELg5muDUxKg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A42BBA0079;
        Tue,  7 Jan 2020 18:30:20 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 Jan 2020 10:30:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 7 Jan 2020 10:30:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEkSusa9Nr9dNefNMHi/j5vhu86IGYEBubsFD5ZDuIaYfUCPUvO0O2IzTWfMLSYlxCFBUPRAwapebPJchU5Ef0zKk4xReGLuexDatGOD9bxrKNcREHCowcoHnbG8l0A89eQvZrN32Syo37c9XxG+zjYtjMgqhxD0eAnC7qrKLpBkKJJ3WOG4Pd0+clEqfF/bb9vnbr+cYTBf2eTmH5hucAhKdOM56sAyk4JQ4+Hm1yjJsstaHke5Ws746mUQu1EJtmuAQgN4vqR7FAevP1YnLHlRmTtvsmTXe1s0KYW9XYkR12HCeMkm3dqWNeU8j5SqZ5tHcDYTXMrG/oY7CACQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaCDkZSESud0qEJDsETyfvMbxrGc3XZFp790ZPpVlK4=;
 b=PeTYZuRzZfq27pIxPqOYxbcQTxNO2oJeo93YPTIBBdM17TygYnsIFCzWZj2gZU1+KJ8xta0sI7qwO7A4pH9oF9k45VhxnoEe2ETDbBFqkI1OJVZDVbN4XI3ZH8siDVOp9QLStS3Aun7lbUqPTHFtmP8TwB0vwBAGZPw5v+aKBBnWKLtDXgLJPPtbwtuxGZ7S83aut5uHmPZ3oagGwkTOhZ5hFCARDt7pJRQVJH6bWWovx6SL/SrPxL6uZWWBzmqKqJ7uVNqBJXG0yxXqGIsi2AfjFObbrQLXEsVLa/QmoZzAb5GHJYrBq+5vijte6bD1Dk4jJZg4uSjBqTau+CUSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaCDkZSESud0qEJDsETyfvMbxrGc3XZFp790ZPpVlK4=;
 b=ZWooqjMjBdNl867vYyO+sZUjue/kBvdEmekdDgSbrW/wgRK8XrtxjGMBrO9b/jsWMA5c9R7MSh9KgkSYYwe/JXJM5p8kw05EsdArPHqDmBFrsdkQjZCwEZzfEWry7VwwreUJn3DI4DBPtIHop4c+RQNhDPt2iLcjW3bmXkzbOuA=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB2837.namprd12.prod.outlook.com (20.177.124.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 18:30:17 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.008; Tue, 7 Jan 2020
 18:30:17 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 5/5] ARC: allow userspace DSP applications to use AGU
 extensions
Thread-Topic: [PATCH 5/5] ARC: allow userspace DSP applications to use AGU
 extensions
Thread-Index: AQHVvOAPMhosDdGIBkSgrV+gH9oBDKffl0SA
Date:   Tue, 7 Jan 2020 18:30:17 +0000
Message-ID: <f19992fb-9226-f3db-fda7-2eed0ab75188@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-6-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20191227180347.3579-6-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 516fe661-92be-49dc-95c7-08d7939fa541
x-ms-traffictypediagnostic: BYAPR12MB2837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2837FB1EF254371317EADAEAB63F0@BYAPR12MB2837.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(366004)(346002)(189003)(199004)(4326008)(54906003)(110136005)(86362001)(31696002)(8676002)(2906002)(8936002)(4744005)(107886003)(6486002)(81156014)(81166006)(36756003)(6512007)(2616005)(316002)(31686004)(5660300002)(186003)(53546011)(6506007)(26005)(64756008)(66556008)(66476007)(66446008)(66946007)(478600001)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2837;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j1vplfpDQLMkbszbRDAHnZGgJir9zaYOayTt14edpQr4qht5ZhE1ZuuAB0XMWdr9/feLuZ+iMlucaptBJ7Pmrppflb+9rCmLkcUOmnosL9Nx9WjENBNwk29/dStLq/08vizYD6FRno+IbhePh8uFLiAoOwQeGv8goyNyW0MHysTxrNrn71V3QvtBfoT9f2fTfXTAflj9bBDglZxxIFn1Q4my6zHvysNNtTkxqat2IUQ/zcPnhObKGyzv4fI8ymAkSwIT06/BvbZc3XuvrGb8czaxVY15LqjIusCFSASjy7BOx3uN5bnw6lBgrbLoYqp7b/H/9wTB8D34lVc29lKROvX0M7gTkW+wY2ZAHKDfp+WMgJcom8p2OTiO2kCI+NLucERWmFhV+B8AIaYGOd74DRfcv8yCFC8IR5ptLjO3fHVG02AFZMN47+MbZ+XxmDg8
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCC052BC939F7B45A8A4456E2A180E68@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 516fe661-92be-49dc-95c7-08d7939fa541
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 18:30:17.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/v/2USdO6GWuG3+Bh7UwHNztMg4FF4gvsgE4huE5FgU0H7m46PsDVR0bziMffHbpqHFQ6YEncLSLm1v9rnMLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2837
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjcvMTkgMTA6MDMgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gVG8gYmUgYWJs
ZSB0byBydW4gRFNQLWVuYWJsZWQgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB3aXRoIEFHVQ0KPiAo
YWRkcmVzcyBnZW5lcmF0aW9uIHVuaXQpIGV4dGVuc2lvbnMgd2UgYWRkaXRpb25hbGx5IG5lZWQg
dG8NCj4gc2F2ZSBhbmQgcmVzdG9yZSBmb2xsb3dpbmcgcmVnaXN0ZXJzIGF0IGNvbnRleHQgc3dp
dGNoOg0KPiAgKiBBR1VfQVAqDQo+ICAqIEFHVV9PUyoNCj4gICogQUdVX01PRCoNCj4NCj4gU2ln
bmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29t
Pg0KDQpTaW1pbGFyIGNvbW1lbnRzIGFwcGx5IHRvIHRoaXMgYXMgNC81LiBMb29rcyBnb29kIG90
aGVyd2lzZSAhDQoNCi1WaW5lZXQNCg==
