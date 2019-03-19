Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887682085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xh0WSDZD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xsx/gLg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfCSX6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:58:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40802 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSX6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553039896; x=1584575896;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1xbRE7RXwMsrL7OpNmu/OPP0tnPKkuIPjpcNe7WNrO0=;
  b=Xh0WSDZDZaulJt8qz93M1Xr09DhPvS1WTPYWSb7x8I9YVAAshyaZptaL
   4oECuZhDMogRnZbTXrw07taKuOAhpEzW56w8j4M1Cz1VGbg3KC1LOSLWs
   HsgHTMlN26H0pZ+w5StVnBCrrcvAwvH2FADloLyONq15DkWlelfuUNNaF
   GXCaqmjfRIKFjXv3Zubw4kFqJOSiYdF/dWDElGRAxgk9rZt662y8uRLFq
   WoJ0LPPvDzYD4w53dOmGXmrI9L/szNoM7kxwRqkCUvBtaIN8A5AusujW7
   yqe5fK1h1/+hneEA32WYbMzk0Pbcf8IhnyRxbt157ujwu69aAwFjO6YCq
   A==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="108837836"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 07:58:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5Xzhrhd1L7g3aeBeMLj4COBGerd5O8zk0xX1wijCuE=;
 b=Xsx/gLg+D9f4DOsY8ehwGdyq5fJwIgyzXE8YjzTc/72UmLafDheoMXECj0GMWSu6Az1NXCjguVkd3065B+fZ0CM7I7LFLC07lN42v8QFqAXhIH4w2HSdnUUhNHAmS/P0o258GAs5Vhp2e0mdhjEzORS2GiT7ohIQcNRK3oGt13M=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5766.namprd04.prod.outlook.com (20.179.58.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 23:58:10 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 23:58:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [v1 PATCH 4/4] RISC-V: Support nr_cpus command line option.
Thread-Topic: [v1 PATCH 4/4] RISC-V: Support nr_cpus command line option.
Thread-Index: AQHU3qIAiA88vIkHh0W9ePhVGAezdw==
Date:   Tue, 19 Mar 2019 23:58:10 +0000
Message-ID: <BYAPR04MB58168FE99AA058FB79A0650EE7400@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190319222028.4293-1-atish.patra@wdc.com>
 <20190319222028.4293-4-atish.patra@wdc.com>
 <BYAPR04MB5816217E1BD06F0EB68E15A7E7400@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97cf0687-572f-4135-6b12-08d6acc6bd82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5766;
x-ms-traffictypediagnostic: BYAPR04MB5766:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5766CF42416FCE41B1E5DBF4E7400@BYAPR04MB5766.namprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(14444005)(71190400001)(52536014)(54906003)(8936002)(71200400001)(256004)(229853002)(9686003)(76176011)(55016002)(186003)(53936002)(68736007)(6246003)(7696005)(446003)(110136005)(99286004)(66066001)(93156006)(316002)(486006)(476003)(81156014)(86362001)(8676002)(305945005)(2906002)(7736002)(3846002)(25786009)(33656002)(81166006)(97736004)(4326008)(72206003)(2501003)(102836004)(53546011)(74316002)(26005)(6506007)(105586002)(5660300002)(6116002)(106356001)(6436002)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5766;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BdGKXHqCcPenwDvuMU1hZ6YshlKtzImK19iz3zMOVFuvjbCAoHLZyzmNlO1dDPlZst8AbtIhjC2feQlv6ybzgoDPNdCZDsF6Ny7tPCnEta1FXvEARj5dX6vH30qIPdIDm5VNLBYL4ykki516WlCNd8QS2u/ZOCONt63LxoCjvIbn/vq7ncetoTvCX25h+t8I69iK60IxjtjoG/IVr487lIVotpGkijRFau4FO1D3oPMZz26ACqKnertgEZbibtgm9kO7amr/D79D9rdbF5/0kU+5rmbilVohCHzVJLvMaDq9e0jFq4nok1LX1sAS+2cC+S6hcNFsQWoM9Pn2urP45e6vgqJkOvBMJndACXWR/Kry4Mevlv56MSqqnTzG8UiTQXUh+XIV/qcySjV6K0xE0QvPzF5k5Y3gSLDQv79RQ5g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf0687-572f-4135-6b12-08d6acc6bd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 23:58:10.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/20 8:56, Damien Le Moal wrote:=0A=
> On 2019/03/20 7:20, Atish Patra wrote:=0A=
>> If nr_cpus command line option is set, maximum possible cpu should be=0A=
>> set to that value.=0A=
>>=0A=
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>=0A=
>> ---=0A=
>>  arch/riscv/kernel/smpboot.c | 10 +++++++++-=0A=
>>  1 file changed, 9 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c=
=0A=
>> index 609475c5..a8fe590c 100644=0A=
>> --- a/arch/riscv/kernel/smpboot.c=0A=
>> +++ b/arch/riscv/kernel/smpboot.c=0A=
>> @@ -86,11 +86,19 @@ void __init setup_smp(void)=0A=
>>  		}=0A=
>>  =0A=
>>  		cpuid_to_hartid_map(cpuid) =3D hart;=0A=
>> -		set_cpu_possible(cpuid, true);=0A=
> =0A=
> This looks weird: the code being changed does not match what patch 3/4 di=
d.=0A=
=0A=
Arg... Ignore this one. My bad. Morning here, I need more coffee :)=0A=
=0A=
> =0A=
>>  		cpuid++;=0A=
>>  	}=0A=
>>  =0A=
>>  	BUG_ON(!found_boot_cpu);=0A=
>> +=0A=
>> +	if (cpuid > nr_cpu_ids)=0A=
>> +		pr_warn("Total number of cpus [%d] are greater than configured via nr=
_cpus [%d]\n",=0A=
> =0A=
> "The total number of cpus [%d] is greater than nr_cpus option value [%d]\=
n"=0A=
> =0A=
>> +			cpuid, nr_cpu_ids);=0A=
>> +=0A=
>> +	for (cpuid =3D 1; cpuid < nr_cpu_ids; cpuid++) {=0A=
>> +		if (cpuid_to_hartid_map(cpuid) !=3D INVALID_HARTID)=0A=
>> +			set_cpu_possible(cpuid, true);=0A=
>> +	}=0A=
>>  }=0A=
>>  =0A=
>>  int __cpu_up(unsigned int cpu, struct task_struct *tidle)=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
