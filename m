Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E42CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6000A20663
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mncWvdLf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mncWvdLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442605AbfJRLTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:19:01 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:56547
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442552AbfJRLS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0HwUS/171CrvA9PxKZFmJDHipTup7/01LdEeCEKdSs=;
 b=mncWvdLfwLCUejqfTCgrQMPFpnfHzFjnln+tIMRlELJZvBoqxh3iWrFSqEzimVnJJIbRZF4KZ2wNNSVnSTChDJsq367XrCiFc+8KBcN7blGwnG7ye0WIHXT1Y2Q9pU3NVabzoTCgh/dI2Yd4Tg0BQQHmnA9zZEkRY8kSb6hPFX4=
Received: from DB6PR0801CA0043.eurprd08.prod.outlook.com (2603:10a6:4:2b::11)
 by VI1PR08MB4624.eurprd08.prod.outlook.com (2603:10a6:803:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 18 Oct
 2019 11:18:46 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by DB6PR0801CA0043.outlook.office365.com
 (2603:10a6:4:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Fri, 18 Oct 2019 11:18:46 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 11:18:45 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 18 Oct 2019 11:18:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 093389d160be563a
X-CR-MTA-TID: 64aa7808
Received: from d30aed036abe.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FA7FCABF-0A6E-4E1E-97B2-4150FD7E1B85.1;
        Fri, 18 Oct 2019 11:18:37 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d30aed036abe.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 11:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec7FMQs4HxwL8G8MMh5rlo6JawH8Hesv946JW9WDJ4feisHkLljNklLOU1Z6G7tSY9hwPjBLBKNQgW5Q0ER7a1JT+0YcQFzEveIyf3w9p986H4MhZN7lbGNcnNBmLOx3Slyv/keAocXiEbeiZLwog1ZUVQPdELlkRdChyugDLPcnAGkSJdgFCGFzlufMIIyM1gh32D9Y7WpAgUd3NfY4ylUYqqllbEyZj32vW5SG4hI9k/QiqMMEABQmIFfBeyrSkyJRhLGHmRARhL/uzuL4/kCnf+he2SwSmv1w0q4/9A7s9XG4AL4mrmImUL0mtk1ae2PlC5ncckUwaJDdkYfNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0HwUS/171CrvA9PxKZFmJDHipTup7/01LdEeCEKdSs=;
 b=K0z94AMA6UeRuO+lBIMvl3EXytOWnkcmcZieyZN3Empbo23Mxah/wkf8mjGT8kKfeotTw9bU6+pu2V4SVznzWEe+KCoNLOYov9OtBo0sojwvrUpeemJXfIgcp9KZpjTsXlq9HhrvO7zvRg4p1S+0UjyPztb6L/KCns+1YxtpTCymZpfM87Hf7DvoJB1DLEm9z6PPgiiYuzQpb40PA3vDn/0mP5nS1dc2gd+5J2j8y9m0yrwwgpQuiWH8IpPON54uPu25dew4S7RQPJKrgpQkdDYiGqo5CLO4RlMprgYXmYXzO1B3KqZ2mWAZPcEgr2oxcv30UlhTb4xvLVp/WlHPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0HwUS/171CrvA9PxKZFmJDHipTup7/01LdEeCEKdSs=;
 b=mncWvdLfwLCUejqfTCgrQMPFpnfHzFjnln+tIMRlELJZvBoqxh3iWrFSqEzimVnJJIbRZF4KZ2wNNSVnSTChDJsq367XrCiFc+8KBcN7blGwnG7ye0WIHXT1Y2Q9pU3NVabzoTCgh/dI2Yd4Tg0BQQHmnA9zZEkRY8kSb6hPFX4=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4231.eurprd08.prod.outlook.com (20.179.18.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 11:18:34 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 11:18:34 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v12 1/5] dma-buf: Add dma-buf heaps framework
Thread-Topic: [PATCH v12 1/5] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHVhXQuL0D7Z4fi0UChemDv0BA9l6dgQKQA
Date:   Fri, 18 Oct 2019 11:18:33 +0000
Message-ID: <20191018111832.o7wx3x54jm3ic6cq@DESKTOP-E1NTVVP.localdomain>
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-2-john.stultz@linaro.org>
In-Reply-To: <20191018052323.21659-2-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::24) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 47d96852-38d9-41c5-22be-08d753bcf08f
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB4231:|AM6PR08MB4231:|VI1PR08MB4624:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4624B06A3F6080D618D33352F06C0@VI1PR08MB4624.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3631;OLM:3631;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(71190400001)(476003)(6512007)(71200400001)(6246003)(81156014)(8676002)(102836004)(9686003)(86362001)(81166006)(1076003)(14454004)(11346002)(229853002)(446003)(186003)(99286004)(6116002)(3846002)(2906002)(4326008)(66556008)(64756008)(66446008)(8936002)(305945005)(66476007)(7736002)(66946007)(6916009)(316002)(26005)(6436002)(58126008)(25786009)(76176011)(256004)(7416002)(486006)(44832011)(52116002)(66066001)(478600001)(6506007)(6486002)(54906003)(5660300002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4231;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YsmxL4WUAfrS3xWv26Vd2pz0ahldXNeUNYAck9Z5XXsuaPyWmFcIn6jp/35WB7LF1gq3nSf+HCTmjpFkIhV7fCE6ckdxWYyW/yFxjgICw4UI52CveT22xcG1Tch3eeRXuw6OzkI3YJbZGNI2IezJA+2r6ZShlHJ71uvR3MBpMYmZvvdFU0hkyL+DqT5SbtohxkoV+dMYC0J/HBsbRF+WHCtLiijl8WEk9FAf1f1TqFWI+tf7xiOIOFKyGo5hCrw7Ra5c/jFIP/eNI8l8zmy4DjsRsEZcxh/GuzaNvIlTVbZO3X5x7zpTDTpBP9SE8T4SGVaZEWqUjRdXohKAWXDcRdA1TERPUmTG1qKTXjh9N8IZ8ffi8g8rR+Gd8Q2gF+o5RpJZSYMEtJIzgMgxgKLAdZoskIatKMWedk1gUvnaxpw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E50E73799F579541AA924FB0B9D97D68@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4231
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(4326008)(26826003)(47776003)(66066001)(478600001)(8676002)(86362001)(14454004)(356004)(58126008)(54906003)(50466002)(1076003)(46406003)(316002)(5660300002)(76176011)(11346002)(229853002)(446003)(486006)(126002)(63350400001)(476003)(97756001)(22756006)(70206006)(76130400001)(386003)(6506007)(70586007)(8936002)(7736002)(8746002)(305945005)(81166006)(81156014)(6862004)(6246003)(6512007)(9686003)(336012)(25786009)(186003)(26005)(102836004)(23726003)(3846002)(6116002)(99286004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4624;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 94550478-fdf6-441e-d4cc-08d753bce9d1
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4kp4XP6HuMJ5FGisbhS/zzIWnuto6KlOSHAdgVzuuDS2MBXRw3y6Phh0VYAcIOc7ifDgRcb9Ci1Xlq4FpGcqzuWxNfwEYsxsHFCrTS1WJs7sx/F061f9UYcKIva1RRevWoJ8Bzmekide9cS3J+17KGx8XP0IVZpGtoPfmTSFweUseyBQnLzRcLGMqgYVyd2UU3SUr9dDZvRtLtrHAhLQdtSloiiMV2P7ni1F6L1hxHlFY4qmMFQb3SxULVKaNsk3PbGuTZSCk/RGYDrcEXKbr9Ll4vPMW/IWB4RDuCnSbDGIhOV41wSzX1ePZxEd2/eE4Awl7Vihui06uCtjBzf8tgWVnCedXS0ibIlFdT5Z6mabQi/djKpW3I1pbMTopo2IeOxldq5vbN91ArBnoDUtMuKfu8iPa7YXHzrhLVT2b4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 11:18:45.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d96852-38d9-41c5-22be-08d753bcf08f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Oct 18, 2019 at 05:23:19AM +0000, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>
>=20
> This framework allows a unified userspace interface for dma-buf
> exporters, allowing userland to allocate specific types of memory
> for use in dma-buf sharing.
>=20
> Each heap is given its own device node, which a user can allocate
> a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
>=20
> This code is an evoluiton of the Android ION implementation,
> and a big thanks is due to its authors/maintainers over time
> for their effort:
>   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
>   Laura Abbott, and many other contributors!
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Laura Abbott <labbott@redhat.com>
> Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Folded down fixes I had previously shared in implementing
>   heaps
> * Make flags a u64 (Suggested by Laura)
> * Add PAGE_ALIGN() fix to the core alloc funciton
> * IOCTL fixups suggested by Brian
> * Added fixes suggested by Benjamin
> * Removed core stats mgmt, as that should be implemented by
>   per-heap code
> * Changed alloc to return a dma-buf fd, rather than a buffer
>   (as it simplifies error handling)
> v3:
> * Removed scare-quotes in MAINTAINERS email address
> * Get rid of .release function as it didn't do anything (from
>   Christoph)
> * Renamed filp to file (suggested by Christoph)
> * Split out ioctl handling to separate function (suggested by
>   Christoph)
> * Add comment documenting PAGE_ALIGN usage (suggested by Brian)
> * Switch from idr to Xarray (suggested by Brian)
> * Fixup cdev creation (suggested by Brian)
> * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
>   Brian)
> * Make struct dma_heap internal only (folded in from Andrew)
> * Small cleanups suggested by GregKH
> * Provide class->devnode callback to get consistent /dev/
>   subdirectory naming (Suggested by Bjorn)
> v4:
> * Folded down dma-heap.h change that was in a following patch
> * Added fd_flags entry to allocation structure and pass it
>   through to heap code for use on dma-buf fd creation (suggested
>   by Benjamin)
> v5:
> * Minor cleanups
> v6:
> * Improved error path handling, minor whitespace fixes, both
>   suggested by Brian
> v7:
> * Longer Kconfig description to quiet checkpatch warnings
> * Re-add compat_ioctl bits (Hridya noticed 32bit userland wasn't
>   working)
> v8:
> * Make struct dma_heap_ops consts (Suggested by Christoph)
> * Checkpatch whitespace fixups
> v9:
> * Minor cleanups suggested by Brian Starkey
> * Rename dma_heap_get_data->dma_heap_get_drvdata suggested
>   by Hilf Danton
> v11:
> * Kconfig text improvements suggested by Randy Dunlap
> v12:
> * Add logic to prevent duplicately named heaps being added
> * Add symbol exports for heaps as modules

As in v3:

 * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
   Brian)

Did something change in that regard? I still think letting modules
register heaps without a way to remove them is a recipe for issues.

Thanks,
-Brian

