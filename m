Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE31218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fzSlmXFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfB1CvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:51:11 -0500
Received: from mail-eopbgr810104.outbound.protection.outlook.com ([40.107.81.104]:25042
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbfB1CvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNUcWAiT9G08etGnodPoMeGutDEDvniXTVuLUsbj9cQ=;
 b=fzSlmXFeKhfyZ8RUiA8p2Mxwqx39ntvC6n06S8r8BK+IkSc+R8YFebSjyK6lZckpf7a5k9v/rYd390uM0YXbStoQ1AxyJy3xjcFJJvHfGFQPJMwanV+xGI6eXjAcj+1ATqcEzflHu3qXgI+6J+1WFGVzdCckLs/Px9BxC3FZNFA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1565.namprd22.prod.outlook.com (10.172.63.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 02:51:08 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 02:51:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: fix memory setup for platforms with PHYS_OFFSET
 != 0
Thread-Topic: [PATCH v2] MIPS: fix memory setup for platforms with PHYS_OFFSET
 != 0
Thread-Index: AQHUzoDcCuh55Rc2gEaTvubzXZB12aX0g+WA
Date:   Thu, 28 Feb 2019 02:51:08 +0000
Message-ID: <MWHPR2201MB12779F5F70432A3234AF8EF4C1750@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190227094256.7658-1-tbogendoerfer@suse.de>
In-Reply-To: <20190227094256.7658-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 233c1be3-3f70-4267-b634-08d69d2796f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1565;
x-ms-traffictypediagnostic: MWHPR2201MB1565:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1565;23:2NydYnMdSvWcGts1IBo1kp9XKWBBBwci079B6?=
 =?iso-8859-1?Q?qT0ekhcYGG/Ye0L4ibRmfziOzYnhVH/ccVpQ7srFu133S+SFcP8zFuBzH/?=
 =?iso-8859-1?Q?SzsRtsLcj/WxEpX1vXg0idXYXNKbPe4by9oMiD2M88WdngxurQ02BiR7Nw?=
 =?iso-8859-1?Q?cZmDDAspEivUeDN/3BpC097rMOHK2tdS015zUFuuhhNNBBcmCCSSN0F5ku?=
 =?iso-8859-1?Q?TLSt2ulhSiwcv8k03JwOz33Js0NYF6Txd8SWDXyYI9M3Ner+D8EYD+PJ3l?=
 =?iso-8859-1?Q?9JrysPFPBkGcHXhFHe/YYmoKTw30ArYID9tjXWXl+lYdlXxsyyX8N9OrZN?=
 =?iso-8859-1?Q?iKtl53mlCQ1byd4IBm78aFXJOmnv5zS8PuPF5EbwwzwdiC5GcviTvLNhxa?=
 =?iso-8859-1?Q?MMUixO6U+sEwZ0DAmYHDiQRCrfdFL/H+gcLXfKyarBfxNXsmzpDWnQ3xyW?=
 =?iso-8859-1?Q?xDG/E3SZtYoZyFB20X8segorr5WGYXwbnXeCpuO52OOAM9l43WzIjm5+Na?=
 =?iso-8859-1?Q?3+6YBgAyMtvssXW/Y59VDE7bWX1Q8SP3enpSjNVWY1F99ObMFdNZ9l7Azz?=
 =?iso-8859-1?Q?PvE/E5XJJ4MdHX+c+PZypUulFfc6iYNbl4xmHLzLOK1MfMPWy23DT7566w?=
 =?iso-8859-1?Q?XNrKxRprvs20+O70gnPybOiyN8LUmY0lqVTqM3lYoXJrL1ATE/STs5lhvH?=
 =?iso-8859-1?Q?lv+iKEzPNXfjT3AbRamPY4Uwgpy6wsR2Mt+b3Awp3p+mU2hc+yUi+/UyUD?=
 =?iso-8859-1?Q?5tlOuIMOJ1nPeDQMlFJMvgPIm4QgEFuizXeymSbJ7lxLLhn5qNgW9fBiux?=
 =?iso-8859-1?Q?EjjLJ70c35JKass1XiMcnh7C7U4+i4uhv+Y/KJKoUpyjsL+Eu0EJlJep84?=
 =?iso-8859-1?Q?XyrL8Magy4GOy4Ha7rW+TwU0tmwBvR1VjWgVjVTSsMPmrDHjUYG2kfFM0q?=
 =?iso-8859-1?Q?gNvE131sfiKxbxKygQbwjOFEXNvA0TxIVawLDKGmbPynhzaXYlGbqxlEp8?=
 =?iso-8859-1?Q?i/lTAKEgSOwS/ufDUVgSGRTOZo7/9RpnEUU9h1SBIoCPsa6Ty2R3bB4PDf?=
 =?iso-8859-1?Q?mIBXubQ1XWZ09ppJ0N3OuFnklgEdw0UUM3y0svl0syk7xQEMrVX1LpHOaW?=
 =?iso-8859-1?Q?dr7y8MmhsDXhFH/k76U/ERLSSFeumToQdxalH02XUrUFdCkPOnd774nqCK?=
 =?iso-8859-1?Q?l3KST7FcxWPSufrC2Rb4K3h71p5V0qOLiEGh3s60QS5wN3fM/aM3t5AwRE?=
 =?iso-8859-1?Q?LLjHZ5ZtXbbXgY7UFW0GV9DkaL52yW7nTwd1aiVeZHQB61BRiJnYgCOZcG?=
 =?iso-8859-1?Q?v5zQMAZxt69T4vR5XLekr2MSefrRjKdoJ+86PcvRf1QBdLg=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1565BF4520633224A26F3B8CC1750@MWHPR2201MB1565.namprd22.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39840400004)(136003)(189003)(199004)(478600001)(8676002)(71190400001)(14454004)(6246003)(71200400001)(25786009)(53936002)(305945005)(11346002)(97736004)(7736002)(4326008)(66066001)(2906002)(106356001)(476003)(446003)(42882007)(6436002)(105586002)(229853002)(5660300002)(6916009)(52116002)(9686003)(44832011)(386003)(4744005)(99286004)(256004)(486006)(33656002)(8936002)(6506007)(7696005)(76176011)(81156014)(81166006)(68736007)(6116002)(74316002)(55016002)(3846002)(54906003)(186003)(316002)(102836004)(26005)(52536013);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1565;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CnLfYT+5J6rDBgGBPTVGcNlQz3U5LrCH8KSMbAdwDwyCZ0KxhG5i/JXLVEy7FrtoWb+Wxe4J7r3rkERqWJf1V50xCvdsuch2TXihsgF9KXPdJ1ueGHZUaFSgCkW37s7Tdr3bBGU3D5yq8K8uWgkMDyxxunmuL5BxOWGIgsfeh9QpIdsQaTdkzuEmWVWtLsmjZcsAdKR+pMlAd4ka1QTBkNU7UfDWUBXKjafeQnl2IFCaxcv3MBjI/rvyC50OfxpB32y1FUz6C37BDel3WVvfDEpiroLbM8Vl2kvi/qdJTlwHk/iPyJ6UezOcyu6OLirtMl3b2f5JpxhCZ9igCzPuSnEv0zHHSUrugjhR0++ZCe7NjCvDQM02QV5VQ28wZ2F5sRcqWDHQ4ABmqzJliYACFfwqDGYYSdhodkF+SIpY08w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233c1be3-3f70-4267-b634-08d69d2796f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 02:51:08.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> For platforms, which use a PHYS_OFFSET !=3D 0, symbol _end also
> contains that offset. So when calling memblock_reserve() for
> reserving kernel the size argument needs to be adjusted.
>=20
> Fixes: bcec54bf3118 ("mips: switch to NO_BOOTMEM")
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
