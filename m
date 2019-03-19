Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF838C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF52085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bu0f2xgG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U3T4G/4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCSX5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:57:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59745 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553039795; x=1584575795;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=t/HTHPvkjJ1accV8t6iMADgZGwTgz6CH005jmTXlcQ8=;
  b=bu0f2xgG2i0+aCSJw3p09DSztHqdPCnQPJpo90+8UGRg2dN2ebQaTB6H
   Yn8H/exfyBuFBJ4ZQD79Cs3RDvhC2EKL41tjspnTXtfHnRDGpMG0cifAm
   j0g23Kbfh1fQwWoPShKb8Q3qlfmus5FJj+/QYTU/1AX60NXwJB79GuDMp
   s1k4XmVkSskgZKr5aulvF+kMhJZvI9EEjC1/K8JqaEHNNw7eMoDwqsRmy
   ABF2zLgUsWKbQ2pkeYuOlqNLAee/brBS/oIBmLPe8Q+ZfJTKgbDPIcBkZ
   GCv8FIlnt5v9vhlnFYVyRzLUCEhpkammpXOXrjHEgumYqNkXj4Kf25zHX
   w==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="105528985"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 07:56:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTBjFExEcFw3x6yRH1zxBbh36Xf3VUlYXe4tJ658uto=;
 b=U3T4G/4kKo2pFaWJ8LRg41MIuaywxBzNDEDjh0wnoh/f+T39atmatFq1kDyp6emOcta6C5A3/q2OIoG0pCkIi/ae4qeb7PJcZt0eappD0JHBvYE3o2llz8xMuv/Mo29zKCmv26nEOrqA1S+8Sm2jdnUKaCSc5Qju2to+Kya/lME=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4294.namprd04.prod.outlook.com (20.176.251.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 23:56:32 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 23:56:32 +0000
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
Date:   Tue, 19 Mar 2019 23:56:32 +0000
Message-ID: <BYAPR04MB5816217E1BD06F0EB68E15A7E7400@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190319222028.4293-1-atish.patra@wdc.com>
 <20190319222028.4293-4-atish.patra@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbf02de8-2a08-430b-1298-08d6acc68349
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4294;
x-ms-traffictypediagnostic: BYAPR04MB4294:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4294AF403E3048DFA69ED966E7400@BYAPR04MB4294.namprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(6116002)(97736004)(74316002)(7736002)(305945005)(105586002)(2906002)(106356001)(99286004)(110136005)(86362001)(8676002)(54906003)(186003)(68736007)(7696005)(3846002)(2501003)(26005)(76176011)(52536014)(53546011)(102836004)(6506007)(14454004)(81156014)(81166006)(478600001)(316002)(66066001)(229853002)(72206003)(9686003)(53936002)(8936002)(486006)(71190400001)(71200400001)(33656002)(6436002)(55016002)(256004)(5660300002)(4326008)(25786009)(14444005)(446003)(6246003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4294;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5/x+dTKIXlW26M5t18ppBPL6SM4+F6SvINA+ETv9aZz5O+bzLwJc4iw3tOiT/JiUT/Okuez63EaUjCPVs3cS23Q6xXwqDAV0rqWkNRleosu8IaUfWdJTBhppx6+KtsJ3Fp3feJbjC16zW+FWr9hXC2QPyuut501Lv6r++251xBpmXP1JSeiGN1q9D9myO+GmRLLqUXq1dwanaN5W3rNrt0BQ7SY1hQMtl4sRuxzeFb6LcMeUEe0iR1gIS4+8+4NoTlTWhQIPaUpAg+t/qubWj+RztTtfuXO7P9tYOcvHwAB6XscR5GsL2dl6tUPRmreMZZ9ELSJ0N3WlFyGtAFPrtGlQ3Uscj7JEBAesGtNS4GZK9e7QARyB3aRhi/1K+bEHRXYcuYw/VCD1hQxYWTfEJZ/EDHK1+rbj3HvCciu/eYA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf02de8-2a08-430b-1298-08d6acc68349
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 23:56:32.4289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/20 7:20, Atish Patra wrote:=0A=
> If nr_cpus command line option is set, maximum possible cpu should be=0A=
> set to that value.=0A=
> =0A=
> Signed-off-by: Atish Patra <atish.patra@wdc.com>=0A=
> ---=0A=
>  arch/riscv/kernel/smpboot.c | 10 +++++++++-=0A=
>  1 file changed, 9 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c=0A=
> index 609475c5..a8fe590c 100644=0A=
> --- a/arch/riscv/kernel/smpboot.c=0A=
> +++ b/arch/riscv/kernel/smpboot.c=0A=
> @@ -86,11 +86,19 @@ void __init setup_smp(void)=0A=
>  		}=0A=
>  =0A=
>  		cpuid_to_hartid_map(cpuid) =3D hart;=0A=
> -		set_cpu_possible(cpuid, true);=0A=
=0A=
This looks weird: the code being changed does not match what patch 3/4 did.=
=0A=
=0A=
>  		cpuid++;=0A=
>  	}=0A=
>  =0A=
>  	BUG_ON(!found_boot_cpu);=0A=
> +=0A=
> +	if (cpuid > nr_cpu_ids)=0A=
> +		pr_warn("Total number of cpus [%d] are greater than configured via nr_=
cpus [%d]\n",=0A=
=0A=
"The total number of cpus [%d] is greater than nr_cpus option value [%d]\n"=
=0A=
=0A=
> +			cpuid, nr_cpu_ids);=0A=
> +=0A=
> +	for (cpuid =3D 1; cpuid < nr_cpu_ids; cpuid++) {=0A=
> +		if (cpuid_to_hartid_map(cpuid) !=3D INVALID_HARTID)=0A=
> +			set_cpu_possible(cpuid, true);=0A=
> +	}=0A=
>  }=0A=
>  =0A=
>  int __cpu_up(unsigned int cpu, struct task_struct *tidle)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
