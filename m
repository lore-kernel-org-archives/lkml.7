Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2FA2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dFDRItX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbfCRJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:35:46 -0400
Received: from mail-bgr052101134031.outbound.protection.outlook.com ([52.101.134.31]:15634
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387490AbfCRJfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7JegbPDtXmGDRw2qOuyJkN2vfbEbt1M1vX6CO2F1Cs=;
 b=dFDRItX1Ts2aQ0y8DCF18mZMpfbbstiLKBh5Vu/VHGwEWt192ifHNMrLNyeiPKBL2KA55z7udQisqwpjKMR/WA8zXKatXPWYwK0kLCLeNlw8YMpc2een0iupdJxQ317LyqXDdlQz5Uz2u0TeHETMV7a8Tr3vYGvhXnB5x4iM1OY=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.9.147) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 09:35:27 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::6d4d:8478:83bd:c020]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::6d4d:8478:83bd:c020%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:35:27 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kvm/hyper-v: avoid spurious pending stimer on vCPU
 init
Thread-Topic: [PATCH] x86/kvm/hyper-v: avoid spurious pending stimer on vCPU
 init
Thread-Index: AQHU2cAg1Ir75Ld2kEirRD2GDjkNfaYRKFGA
Date:   Mon, 18 Mar 2019 09:35:27 +0000
Message-ID: <20190318093523.GA11912@rkaganb.sw.ru>
References: <20190313171342.12814-1-vkuznets@redhat.com>
In-Reply-To: <20190313171342.12814-1-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.3 (2019-02-01)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,_kvm@vger.kernel.org,=09Paolo_Bonzini_<?=
 =?iso-8859-2?Q?pbonzini@redhat.com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09linux-kernel@vger.kernel.org?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:7:16::28) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:a6::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcd0b9b6-102a-4f4a-07d3-08d6ab850d99
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB5099;
x-ms-traffictypediagnostic: DB8PR08MB5099:|DB8PR08MB5099:
x-microsoft-antispam-prvs: <DB8PR08MB509956B99FB5E0711A3E3EE6C9470@DB8PR08MB5099.eurprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39840400004)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(81166006)(97736004)(81156014)(71200400001)(71190400001)(86362001)(6916009)(486006)(25786009)(36756003)(26005)(8676002)(14444005)(256004)(68736007)(478600001)(14454004)(446003)(8936002)(1076003)(2906002)(6116002)(3846002)(5660300002)(4326008)(11346002)(52116002)(102836004)(9686003)(229853002)(476003)(316002)(386003)(33656002)(6506007)(6436002)(6512007)(7736002)(305945005)(186003)(106356001)(66066001)(6486002)(99286004)(58126008)(54906003)(6246003)(76176011)(105586002)(53936002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB5099;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Z2rOPYUsSz+p311IoivP7WIHu4GQXLeZNONX5NvohzsT3OFacHkGA5PrZc5oqnBCvS9J7R3/FrK5ngvUEPRYuhBGn2nOgSCfaKRdzVmfA3BLWbgWmH7ZeMdjLS1r5lZE5I9EKlQbeNEjQCfuvMeNYt7e/Ot+Vr75HfJJQmU+Ss1S0ExcD/h2ZRp1VVgL1OMw9bW2wvygXnKjaOpO8yJgAmuEWmLLaT5jzmafGZe1la/1DB5pXekggmazSZ04ciXjlPMKnQBEq37DlPEfdQ9aZs0kHSUehkgNml4V/3d0UoWpH4QWNbZ7z963PpUZKWMCzs/6iV59RdVnjOGHFPASR9WTC9r7bahGH1Ezx+8DU0+MkczP2ZKkNcc1Pd5qExPRINc/MH7/TRekI0uLJlKC/9CtEKTbchK0eoZv2dw7xcOjk1q3NeTNR5xQTaxvrioXXtZwqwPa6p8dtz2QP3I0TRpcBaBY5lC9xfdDjSNuE9YdHyAoB7Nxnkd1xzyvWHh
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <F3B0B5C4FA4E68448A0826967862B17E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd0b9b6-102a-4f4a-07d3-08d6ab850d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:35:27.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 06:13:42PM +0100, Vitaly Kuznetsov wrote:
> When userspace initializes guest vCPUs it may want to zero all supported
> MSRs including Hyper-V related ones including HV_X64_MSR_STIMERn_CONFIG/
> HV_X64_MSR_STIMERn_COUNT. With commit f3b138c5d89a ("kvm/x86: Update SynI=
C
> timers on guest entry only") we began doing stimer_mark_pending()
> unconditionally on every config change.
>=20
> The issue I'm observing manifests itself as following:
> - Qemu writes 0 to STIMERn_{CONFIG,COUNT} MSRs and marks all stimers as
>   pending in stimer_pending_bitmap, arms KVM_REQ_HV_STIMER;
> - kvm_hv_has_stimer_pending() starts returning true;
> - kvm_vcpu_has_events() starts returning true;
> - kvm_arch_vcpu_runnable() starts returning true;
> - when kvm_arch_vcpu_ioctl_run() gets into
>   (vcpu->arch.mp_state =3D=3D KVM_MP_STATE_UNINITIALIZED) case:
>   - kvm_vcpu_block() gets in 'kvm_vcpu_check_block(vcpu) < 0' and returns
>     immediately, avoiding normal wait path;
>   - -EAGAIN is returned from kvm_arch_vcpu_ioctl_run() immediately forcin=
g
>     userspace to retry.
>=20
> So instead of normal wait path we get a busy loop on all secondary vCPUs
> before they get INIT signal. This seems to be undesirable, especially giv=
en
> that this happens even when Hyper-V extensions are not used.
>=20
> Generally, it seems to be pointless to mark an stimer as pending in
> stimer_pending_bitmap and arm KVM_REQ_HV_STIMER as the only thing
> kvm_hv_process_stimers() will do is clear the corresponding bit. We may
> just not mark disabled timers as pending instead.
>=20
> Fixes: f3b138c5d89a ("kvm/x86: Update SynIC timers on guest entry only")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
