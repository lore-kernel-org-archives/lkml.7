Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2273C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4365219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Wk9GLsDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfGVVMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:12:34 -0400
Received: from mail-eopbgr730047.outbound.protection.outlook.com ([40.107.73.47]:8034
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbfGVVMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAJmQ15ZpsOIUdXbX2AIESFPiG5tsyIyNJfqTrOZ2i4VIXPUi9LZcvdZJ77SZOtLGG5V/6l7YlfRXORE3yMNAl/yNGyVetAoK+hVcmdBoqdi6m7zZKMhaD311gmV0Wa1hXqkQAGQYU4XAQwHqq3zUSobgnKah9gObdfmCpurY+6C8hRj2nMpWL09l+6uMxoWZxvxYeWqxDAx/4P3RrQxKrk4pJQMUrclV17gR9IUTqppI7HXkp2ccE85HBBzeH8OyjaG7xcLsDISG6AxLADUMLrENqwp7qqRxK1kiqAdfafC9WdB/lm7JqXL2SO24ZXnHMDI7SGNe/nNCUrltGqk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amayE6LGTa+gvjqgNjJzE+hQ4Jai9dVrcoNZUzr2+ME=;
 b=NHtr/ypzGCEseWaFZqWpbbj2+cqKKLh659o+JizlvX331uvnPOI2auJvgHRsG1p7zDhreKxuJzIKl8zVrtgbjlz6P9bYV7Gs2tEcrOzJzr11oJ8QKD+Nx73r/b81mwGbXqYgFhTCIRisbIDVKGX191eh7srypBlA+os9/QaQO1M4SJe1yrlCS22k6eejvE7asEyrbOU1RwHu399ZeA7mAIpxhFWZmHQ6li31aphIkB71OPJFaiZDEFaivKOr98UP+1+wJmHB36VhcBkQFUvHMDEUvYAE3lrofdoyUMT7evzQwq53UouLTxIs8PpPx0lsbYvpQVqwzIs/ME3B0Eg6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amayE6LGTa+gvjqgNjJzE+hQ4Jai9dVrcoNZUzr2+ME=;
 b=Wk9GLsDgOvhjeFxGUtuNZkcPPAtV70quRRWjxE7+G5cLx+7T+iHcmazPH8DxCzp0IeglM+4ZtZu2JlB59KSPMoRsQq67ewDeApHMmwctQgRKr360VjADzjWlRt3Y0Nm1/KFuyGSjQUVdiuUx0lXwJFyyDmxN+AfzA8i+lcVOWe4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4744.namprd05.prod.outlook.com (52.135.233.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.8; Mon, 22 Jul 2019 21:12:30 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 21:12:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC 3/7] x86/percpu: Use C for percpu accesses when possible
Thread-Topic: [RFC 3/7] x86/percpu: Use C for percpu accesses when possible
Thread-Index: AQHVPc3X8iG4Nn7Ym0aTUC7TEdfgCabXIyGAgAAFmYA=
Date:   Mon, 22 Jul 2019 21:12:30 +0000
Message-ID: <ADDC5AFB-2E49-467C-937A-0171CEECBC42@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
 <20190718174110.4635-4-namit@vmware.com>
 <20190722205227.GK6698@worktop.programming.kicks-ass.net>
In-Reply-To: <20190722205227.GK6698@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71feacdb-5bc9-4b80-b54c-08d70ee94e86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4744;
x-ms-traffictypediagnostic: BYAPR05MB4744:
x-microsoft-antispam-prvs: <BYAPR05MB4744F7B154DE40168BA4574BD0C40@BYAPR05MB4744.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(6506007)(53546011)(478600001)(229853002)(68736007)(25786009)(102836004)(2906002)(53936002)(476003)(6486002)(6916009)(2616005)(446003)(186003)(486006)(33656002)(6512007)(6436002)(11346002)(81156014)(26005)(4744005)(14454004)(316002)(81166006)(8676002)(305945005)(54906003)(66476007)(66556008)(64756008)(256004)(76116006)(66446008)(66946007)(6116002)(7736002)(36756003)(3846002)(71190400001)(71200400001)(6246003)(66066001)(99286004)(8936002)(86362001)(76176011)(4326008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4744;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fw6N2FWGHlcprOhFYCvwP9CWChd1NXycEfniTPrdcwulZ2CHYDduVjXO5Ka8yHMwtGMNyioMKDwhJQoMBIH5wM7ijESj8E+oTXVtYwletSOToFOOPKPgv2Bg5ctDOJwa4c9A1n1noFTNWIoRZ1WzeThVD7W+WchkBL0MA2toSObS8+b7iZJhMBjeq37snKDgiRQzsaXdZaQf/5qC2PLiWvSSyopvQW4H8BcyrgPEU2SQAhUXrTk+4L1pfNxk8pGXR6UqCvbJcKHZHkzxgJNMcK1G7204v9l8nEHEgscMglopuWXcV311AR7HLi3PJYYVPbg1bo0t6TgT/kJTzQB5WXbXesUl6eJOapXq+yvyghv9ipj/5syUE7vfNbTHkJHRMhwmjATrRoDPmHEkhXFGBhM/+65syJQqxlQWbaTSpJY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BBE50E53B42424CB010DC637EA00CBF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71feacdb-5bc9-4b80-b54c-08d70ee94e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 21:12:30.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 22, 2019, at 1:52 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Jul 18, 2019 at 10:41:06AM -0700, Nadav Amit wrote:
>=20
>> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preem=
pt.h
>> index 99a7fa9ab0a3..60f97b288004 100644
>> --- a/arch/x86/include/asm/preempt.h
>> +++ b/arch/x86/include/asm/preempt.h
>> @@ -91,7 +91,8 @@ static __always_inline void __preempt_count_sub(int va=
l)
>>  */
>> static __always_inline bool __preempt_count_dec_and_test(void)
>> {
>> -	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var])=
);
>> +	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
>> +			       __percpu_arg([var]));
>> }
>=20
> Should this be in the previous patch?

Yes, it should.=
