Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17B9206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cbpQbDHR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="D+U11gff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbgAITB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:01:59 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:50314 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729054AbgAITB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:01:58 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 676CCC00BD;
        Thu,  9 Jan 2020 19:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578596517; bh=6rX1QNqgN7AIyl1Um8POPl1F749eAXZl193MTnB6RFA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cbpQbDHR+jdJg68PJXy3QsLkYdX+wb8rjzoKRWcdyxpE3LE/Kusjir9FCgG787A6b
         oJq7rlD0EahdppJ37wkxKpStKgbFgX1ntdxIiwNwkoXbIBod23eXrKKZDyoo54s3vi
         UN8EwfVUg+aGDkq5D7Ti5GMDsaLA9hFDMqySMrdPBIGpCAs7YTLBX2jQeJIOzP4G3B
         tlR7JLLe03vohZSNvYjTbMiR7k6Y3tzatRJSAxz/n56qLfTFtJetZI8S44YZm8YQZd
         l5CUb3kugw3nXgUEknnqF/TSgqGtXjrw8jjnH6QEq7mYGyJjKAuvIybxVYg5JhweFg
         ceZFrwyJxOCcw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id CA3E4A0067;
        Thu,  9 Jan 2020 19:01:56 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Jan 2020 11:01:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Jan 2020 11:01:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3oldwCDtTTVhI/zRqKDZb754YVWmWZhR4GAO1hZOdNO4NvDAUoas5Bv66Z2sDi562mNrCadPsv+t8CdyGYUQsteq3q//1lw1eL/E9c1OSc2z/kpHkHgnPIpzG+16oG0Z6IuozRU8z550eLPLZ3idm/02O4Q6liSs/W0LqLvPLO99R0fXg2OOpzr89QlJw534eBcOBjy5OpJVqRYl1wE3mEIidX+nnf6dXAuuEO60Q3XJ4+w+K33kL8uWQRChnL5h8KZBcppcs8xWzu+9UN0Mdn9glAx8I3YOiaI6sAVtce3vKmcWGvaCgZC/4OVydpaPXw1pYZxtr35aTOFJHmjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h78LBTdhwF6Kx+B/2HSfM0atsLKkT730Nn+BguLQMgY=;
 b=kbGIzsdxM2xaGbeCoDfFPbYPARRDl8FrMElSaZVfenHjHlEExXoiP7F/ojLh4d7H02Rhe+lT448+2VEeRrPZ0LC+MvS8gvSOCacnw2O59KStTnW/6PN8w0AlZZ0zzuRIKW0+g72yKwm4al9okp5MQSeJJJ+dqf77YLbg9aaJVnxCu4RcnPrdhsleDJkoeWF2hpcYdLYfKc6q2Gfs3gOHS6xyu6jP2Hqi2npsgH3Hu+ClNBBo3Xfu+q2Ll7zyFGm04pGf/qZVtcHkd7vqY3tJ5TQCuwZegdbf0fg7ly0GUhyxeZcgfDdfvMcQd4NFP8OI/8RA0RQN775ujmM2p7i4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h78LBTdhwF6Kx+B/2HSfM0atsLKkT730Nn+BguLQMgY=;
 b=D+U11gff8XXpU/ZD/lmUhFRjeWCUQmHjeEXt7VgcMX0PHEgcxT71l66Kg4mInzUcNBkaiToMmzyryi1czHQLcGqNIR4iMaq4hoxC3RGzzfX3UsRu0zEGHWQ9jWu5Bf3MT64jek1W1tfFRxAdbxklrIHsrZkoY897276RO9Fvv5E=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (52.135.53.73) by
 BY5PR12MB4308.namprd12.prod.outlook.com (52.135.54.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 19:01:46 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::21e8:207a:f5a0:e090]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::21e8:207a:f5a0:e090%4]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 19:01:46 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 4/5] ARC: add support for DSP-enabled userspace
 applications
Thread-Topic: [PATCH 4/5] ARC: add support for DSP-enabled userspace
 applications
Thread-Index: AQHVvOALEgJG1jhHKUKrXAMj7igcXqfflg6AgAMuUuk=
Date:   Thu, 9 Jan 2020 19:01:46 +0000
Message-ID: <BY5PR12MB403419E2722BE80E329D3409DE390@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-5-Eugeniy.Paltsev@synopsys.com>,<a3890ccb-e948-6ad6-c2ea-5b77b9d3a289@synopsys.com>
In-Reply-To: <a3890ccb-e948-6ad6-c2ea-5b77b9d3a289@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d49ddd5-c26d-4957-4334-08d795365fa5
x-ms-traffictypediagnostic: BY5PR12MB4308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB43081D31E752B00F64B839BCDE390@BY5PR12MB4308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(91956017)(81156014)(81166006)(2906002)(478600001)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(33656002)(76116006)(86362001)(8936002)(7696005)(186003)(71200400001)(4326008)(6862004)(52536014)(5660300002)(6506007)(26005)(316002)(55016002)(6636002)(54906003)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB4308;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UHUn0szkWPWILP3AvYf7cTkSnzBjzteT9UaLCeJIP+DQ6kOdzRqWTmRH7RWLDGMh82fHtnw2/R3KZaLWWhFfLHYfkCjjeEDoT0cFmazMnKidKBkrlcBQXlQ2J1imkhTTLobTIdwyfHejSUoIjDpB8Nt77wKOq1/IlocbJkCfFjoeCWQNvPw5M9b6Y4DXy0T9sJNX95qjtxh9NVREEBSQEpZKnru2uOnyGC/2qvY1g39bKgjcJd1qkowQuQTpO3+Q5PMgTUUz+WplJwpFFR26cRB2Ug9oYkPZJvE32MVPpSwrVuSSxj1ixE0Xr7Q1i6PHlcgaBgyami6liwEiS9xYZtqP72GLQWni6yHMU9kH2UJWSXqbgahGj0fdZ7yzy3u1VMMFq/olj1wVjRkx8IHoe4WvIjIus84LEiNPP6h+iWbOkAuH98Z+smxGjy/3tyFt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49ddd5-c26d-4957-4334-08d795365fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 19:01:46.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uK9jkxH9C+MhoxRlU+TRJqFwTN32wnPinLNem5+c1gu4Wx/vQ65wkpHcHxXMPJuhisMXlhRq+XoOTnh0mGQvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,=0A=
=0A=
>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>On 12/27/19 10:03 AM, Eugeniy Paltsev wrote:=0A=
>> To be able to run DSP-enabled userspace applications we need to=0A=
>> save and restore following DSP-related registers:=0A=
>> At IRQ/exception entry/exit:=0A=
>>  * ACC0_GLO, ACC0_GHI, DSP_CTRL=0A=
>>  * ACC0_LO, ACC0_HI (we already save them as r58, r59 pair)=0A=
>> At context switch:=0A=
>>  * DSP_BFLY0, DSP_FFT_CTRL=0A=
[snip]=0A=
>> +=0A=
>> +#ifndef __ASSEMBLY__=0A=
>> +=0A=
>> +/* some defines to simplify config sanitize in kernel/setup.c */=0A=
>> +#if defined(CONFIG_ARC_DSP_KERNEL)    || \=0A=
>> +    defined(CONFIG_ARC_DSP_USERSPACE)=0A=
>> +#define ARC_DSP_HANDLED                      1=0A=
>> +#else=0A=
>> +#define ARC_DSP_HANDLED                      0=0A=
>> +#endif=0A=
>=0A=
>This is a really bad idea - u r introducing explicit include dependencies =
which=0A=
>can change even outside of arch changes !=0A=
>We've dealt with enough of these problems with current.h, so best to avoid=
, even=0A=
>if there is some code clutter.=0A=
=0A=
Hmm, would it be OK if I add this option as a private kconfig option?=0A=
I.E (for ARC_DSP_HANDLED):=0A=
=0A=
---------------->8----------------------=0A=
config ARC_DSP_HANDLED=0A=
	def_bool n=0A=
=0A=
choice=0A=
	prompt "DSP support"=0A=
	default ARC_DSP_NONE=0A=
	help=0A=
	  Depending on the configuration, CPU can contain DSP registers=0A=
	  (ACC0_GLO, ACC0_GHI, DSP_BFLY0, DSP_CTRL, DSP_FFT_CTRL).=0A=
	  Bellow is options describing how to handle these registers in=0A=
	  interrupt entry / exit and in context switch.=0A=
=0A=
config ARC_DSP_NONE=0A=
	bool "No DSP extension presence in HW"=0A=
	help=0A=
	  No DSP extension presence in HW=0A=
=0A=
config ARC_DSP_KERNEL=0A=
	bool "DSP extension in HW, no support for userspace"=0A=
	select ARC_HAS_ACCL_REGS=0A=
	select ARC_DSP_HANDLED=0A=
	help=0A=
	  DSP extension presence in HW, no support for DSP-enabled userspace=0A=
	  applications. We don't save / restore DSP registers and only do=0A=
	  some minimal preparations so userspace won't be able to break kernel=0A=
=0A=
config ARC_DSP_USERSPACE=0A=
	bool "Support DSP for userspace apps"=0A=
	select ARC_HAS_ACCL_REGS=0A=
	select ARC_DSP_HANDLED=0A=
	help=0A=
	  DSP extension presence in HW, support save / restore DSP registers to=0A=
	  run DSP-enabled userspace applications=0A=
endchoice=0A=
---------------->8----------------------=0A=
=0A=
---=0A=
 Eugeniy Paltsev=
