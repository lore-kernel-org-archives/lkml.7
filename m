Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08798C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E4214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="FS7RLnzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKKQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:58:25 -0500
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:61760
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbfKKQ6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:58:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc6gbyyMYNqPyskjT2QCxTpP5SaSjjGTa6rQ8ZaNg9J/OItH4dZQyG2XmAyPROtmJqRXGm0M9F7av1yMrRIOk1/r35Jr+AybHmQX3VJn0Fbk6gvyDtBD8KZkdOu63f2QWy8hOIytCB9p/S9n9RVrcqBqOrustnVIqMY6VHs/BtIV96BzlDaSyryMbjBcxxhq/UfMRhDkB+4ijQ4xptTsAjpFxyRuo5JOctrUiCKEYDjDDQAs5t6ROcZDSvlNYUrOXc5O5aFcEUbIpmTsGHLdg7P5P+URuoGkgXgqSiVAaUTrKYo90KGHE/rWEUhozXcsZxGd5izfm95NQL8kLDiy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORnDWK740nzMfg0amdqfzXSv3w2ZXa+/T1RITE307e0=;
 b=c+PlAeJLLHev5aMKtMy7oekGW6jsVfJaAESE+fPt/Zw04OlXgmlK3+ebNcd9pnCFlwcJYv0Q2Cufh0bzS651yNICY54/Vy3qzO4CQXzR539WCvgyiA+k8wQkaN1+FZu1IM5Tp5S0HY32ln2lUDKwae7ZwSBdNK+kcWEOe3tb0TswJvVtm4TZD3JrfiO1da8VtpspMevOHhVsbW66CbVqGmDuYmdn6Yw+QX1jpvsSkF2KNoifAbuCyJIadLGzHwkYVeVqSgjE2RxIQOkmGGq+VhAqE69uBXPbt7/LQQiGQ/jFyQAhwBF6whrShVLbB2Z/3G7zt9zVV48otDA816eGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORnDWK740nzMfg0amdqfzXSv3w2ZXa+/T1RITE307e0=;
 b=FS7RLnzNeJzyKP8u5VDr/Dom7+JNbheIYW5bfy4Zj+9Obh4LRH/z4L+ztZ67Kr9JMD7YsS31Eg73RY7zetz69TC6uWqX52TpG+s3MiCcqxrJNhIzzA75w8q3w5pj68PTd5xnmp+r18lmDwvtWEKRXRc1oINVZN1diNRk7W9fGXg=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 16:58:20 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::90bc:abcd:689a:944]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::90bc:abcd:689a:944%7]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 16:58:20 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Jules Irenge <jbi.octave@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] staging: wfx: replace u32 by __le32
Thread-Topic: [PATCH v2 3/3] staging: wfx: replace u32 by __le32
Thread-Index: AQHVmJRSqL07aRTvF0afCHa79JWu9aeGMUUA
Date:   Mon, 11 Nov 2019 16:58:20 +0000
Message-ID: <3445403.d56fhTCmfW@pc-42>
References: <20191111133055.214410-1-jbi.octave@gmail.com>
 <20191111133055.214410-3-jbi.octave@gmail.com>
In-Reply-To: <20191111133055.214410-3-jbi.octave@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [88.191.86.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b88bc62-e073-4805-ef4a-08d766c85b1a
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-microsoft-antispam-prvs: <MN2PR11MB3712981B0C09148D98DC220593740@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(39850400004)(366004)(396003)(136003)(199004)(189003)(316002)(76116006)(66946007)(33716001)(66446008)(64756008)(91956017)(71190400001)(99286004)(478600001)(256004)(25786009)(71200400001)(229853002)(54906003)(6116002)(3846002)(2906002)(5660300002)(66556008)(76176011)(66476007)(14454004)(26005)(186003)(7736002)(102836004)(6506007)(6246003)(305945005)(66066001)(6436002)(4744005)(6512007)(9686003)(8676002)(8936002)(81166006)(81156014)(6486002)(6916009)(11346002)(86362001)(476003)(486006)(446003)(4326008)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLs2PLo2cE6couGefRTXJQcUqHH+LclQJu/CniXfKETJdQd7nhepzAx7i/pO94dkfVSY+liBL8pAa9QkLvcBUApM2LCNY5pRRpPNlv+8blQ2qCXYR+RLTYpwMmCfN1KJJer0sCEhJr5kQdIVlwx91CQn5vgS38cuQJbkwHTpf/oqSYE7X9LEk3b2BSR0UxRx602ss8fSM/CMDn6iOqm6vm9yMdswVNmNrn/0l1EmpYzif4OkvATVPz6XeBAxDFRBHk4KK4lBW1+MjZZ0oUQFPeJHywV2fhIGx9B89P7ZsI1GZ0dzHEI3+Pnl4AMoQwQe+RTDb95ujdlkaCvqzq68TYKn3ut9QhgqKFAPvP269STcB6UFMkDqE7Jj1N1iOa2AfpKEndgDI4UDSX96zeotATauFXoYC+XBNW0TLdmIISSXIVA8keIrmpy94qS9FQd2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C301CAF794125C40B7D66707E1FB2A3A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b88bc62-e073-4805-ef4a-08d766c85b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 16:58:20.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW7uya9ovTVHXA2EnSB4LGj3mmAZVmeqAd88g5FNC2nPPywL9P5Rl1iSoZb7t2EzzKgTg7YH3DeZGUVGS5oS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 November 2019 14:30:55 CET Jules Irenge wrote:
[...]
> -       u32   count_rts_failures;
> -       u32   count_ack_failures;
> -       u32   count_rx_multicast_frames;
> -       u32   count_rx_frames_success;
> -       u32   count_rx_cmacicv_errors;
> -       u32   count_rx_cmac_replays;
> -       u32   count_rx_mgmt_ccmp_replays;
[...]
> +       __le32   count_rts_failures;
> +       __le32   count_rx_multicast_frames;
> +       __le32   count_rx_cmacicv_errors;
> +       __le32   count_rx_cmac_replays;
> +       __le32   count_rx_mgmt_ccmp_replays;
> +       __le32   count_rx_beacon;
> +       __le32   count_miss_beacon;
> +       __le32   count_ack_failures;
> +       __le32   count_rx_frames_success;
>         u32   count_rx_bipmic_errors;
> -       u32   count_rx_beacon;
> -       u32   count_miss_beacon;

Hello Jules,

Your patch reorders members of the structure. It will break API with the=20
chip.

--=20
J=E9r=F4me Pouiller

