Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1580C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFD421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JbEcn6F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfDXWGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:06:24 -0400
Received: from mail-eopbgr710130.outbound.protection.outlook.com ([40.107.71.130]:41236
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730041AbfDXWGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSEel34HTGSrQMQzINhnq0xfVEfHgKgyLAuJHFTlQdo=;
 b=JbEcn6F8T/b/p+aPeEsmOtnZpNe45/ZlEkc5GerSWDVjkFn8OEJCyXax79gYgiKy7gRz/9EyYRD/iB+1lBstX1+YIFGWkWQwvX02C94g8duAkfioI2MS4Yt8j6w9vq8/BLyPJ3P3dDlkZig3rwSMi/LkNjPodc7syiidPQL3WTw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1326.namprd22.prod.outlook.com (10.174.162.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 22:06:19 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:06:19 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Shuah Khan <shuah@kernel.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
Thread-Topic: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
Thread-Index: AQHU+rH+AJnCxtNxUESFNInzrhwEUaZL3nOA
Date:   Wed, 24 Apr 2019 22:06:18 +0000
Message-ID: <20190424220609.4kryfcgsv46iu3ds@pburton-laptop>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
 <20190424152502.14246-11-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190424152502.14246-11-mathieu.desnoyers@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd137777-6ee9-4ffb-5c03-08d6c90113de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1326;
x-ms-traffictypediagnostic: MWHPR2201MB1326:
x-microsoft-antispam-prvs: <MWHPR2201MB132655BA2D8188D74EF1CB47C13C0@MWHPR2201MB1326.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(346002)(396003)(39850400004)(136003)(189003)(199004)(305945005)(446003)(7736002)(11346002)(476003)(44832011)(97736004)(76176011)(42882007)(486006)(186003)(26005)(66066001)(386003)(6506007)(102836004)(58126008)(316002)(68736007)(33716001)(99286004)(52116002)(54906003)(7416002)(6916009)(8936002)(8676002)(4326008)(81166006)(1076003)(229853002)(71190400001)(71200400001)(6116002)(3846002)(2906002)(256004)(81156014)(14454004)(73956011)(25786009)(478600001)(66556008)(6512007)(66476007)(9686003)(64756008)(66446008)(53936002)(66946007)(6246003)(6486002)(5660300002)(6436002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1326;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X6H0NwzwLJTqqxS4s257OLIEYvEp3/YUY3HXyTYBtzJh4HTvUVrQjwEs4haPtiEczy2h46drSPES2VlULbdPCjIB2i48RvzjpEw+ssUGZNvUCo6mwhDB4vbACwhwamDtF2gRzlgfphAZkUKKdaQnY0OhxjVDM2O7nsaG5VKV4XQge4oKMfPmxn/ImHM/VKkfzDXxalOlKol7h6d9Fisl8dt7cfMFrXMKWihvjvye5nYlYMbeoevQ9Qw8stUxTIXFRfm1tj8puJgjU6hSNy/PbCGbxNjh8/7egGRDoosiUq8Ub9T3SsbQGFGmqch019KbZ+LFHDYVjLptlsOg0y6wof3GgZKOpkH4Iuel9whuT8lROhhjuXOEHEqZzrbXeyBWMyrw39RjtAIVF6Rq7vnF4TNQOCmGujBIQifzT0ZjtcM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0349F935DC2E5A4DA6D239763892D2AE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd137777-6ee9-4ffb-5c03-08d6c90113de
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:06:18.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Apr 24, 2019 at 11:25:02AM -0400, Mathieu Desnoyers wrote:
> diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/sel=
ftests/rseq/rseq-mips.h
> index fe3eabcdcbe5..eb53a6adfbbb 100644
> --- a/tools/testing/selftests/rseq/rseq-mips.h
> +++ b/tools/testing/selftests/rseq/rseq-mips.h
> @@ -7,7 +7,11 @@
>   * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@effici=
os.com>
>   */
> =20
> -#define RSEQ_SIG	0x53053053
> +/*
> + * RSEQ_SIG uses the break instruction. The instruction pattern is
> + *	0350000d        break    0x350
> + */
> +#define RSEQ_SIG	0x0350000d

My apologies for taking a while to get back to you on the various ISAs &
endian issues here, but I think we'll want this to be something like:

#if defined(__nanomips__)
# ifdef __MIPSEL__
#  define RSEQ_SIG	0x03500010
# else
#  define RSEQ_SIG	0x00100350
# endif
#elif defined(__mips_micromips)
# ifdef __MIPSEL__
#  define RSEQ_SIG	0xd4070000
# else
#  define RSEQ_SIG	0x0000d407
# endif
#else
# define RSEQ_SIG	0x0350000d
#endif

For plain old MIPS the .word directive will be fine endian-wise, but for
microMIPS & nanoMIPS we need to take into account that the instruction
stream is encoded as 16b halfwords & swap those accordingly for little
endian.

Thanks,
    Paul
