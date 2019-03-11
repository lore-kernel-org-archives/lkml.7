Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA57C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933962084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="Jezd4UuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfCKNFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:05:12 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:53921
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfCKNFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkDx24DafrWVUfGbxh7atP2lY5TfirHSJtLrC/+t8sc=;
 b=Jezd4UuSKPPOFkFv9O0UKEREF+0Xr73ic/7ktLNFVkS6WC876fGtI5/k2oEs1wEUZ1xUSsmTi7dBdI7S5mMzh0JxNhd09X1uvVnKDhuFttQ1euYa9YNLv1t1diMfiAKtVnSivAzKlwOWxXmpYZ1FBnpNJ4L7r+AcYcDz+HpKm2kKas1F5uWw84sIaFjzqZYFCSOhi0O9qbJnaMq8swMmPgl7Esiq0JTiM5Iny+451Tel4Bo7RgYkdKtWvH5dLrKhRoC90hGu7Bchnnt8fnEaosr68zbIxbWibdH6Ei1Nmxl7nXbSpxuQFIcAqvlJW60LwYflUBziCaOXIIGi84PnMw==
Received: from AM0PR03MB4148.eurprd03.prod.outlook.com (20.176.214.210) by
 AM0PR03MB5042.eurprd03.prod.outlook.com (20.178.23.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 13:04:26 +0000
Received: from AM0PR03MB4148.eurprd03.prod.outlook.com
 ([fe80::9013:1c64:1291:d587]) by AM0PR03MB4148.eurprd03.prod.outlook.com
 ([fe80::9013:1c64:1291:d587%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 13:04:26 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
CC:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Subject: [PATCH v3] optee: allow to work without static shared memory
Thread-Topic: [PATCH v3] optee: allow to work without static shared memory
Thread-Index: AQHU2Ar0RRs0JSf/0ESohOEYE85Khg==
Date:   Mon, 11 Mar 2019 13:04:26 +0000
Message-ID: <20190311130348.2157-1-volodymyr_babchuk@epam.com>
References: <1536345427-31425-1-git-send-email-volodymyr_babchuk@epam.com>
In-Reply-To: <1536345427-31425-1-git-send-email-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Volodymyr_Babchuk@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdb24c9d-9eeb-4b55-7930-08d6a62216de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:AM0PR03MB5042;
x-ms-traffictypediagnostic: AM0PR03MB5042:
x-microsoft-exchange-diagnostics: 1;AM0PR03MB5042;20:AY/dnt/qo/sf4SNsPKJCX1FLZPiAMH2PG8EwcP7YdAYgf2fc6LIBlsbPNOjWV3gCWpi7raykVc2minGDMKOPYxO6Y1Kk2xxvkTs2S4pxLsmzyTOJrbdG1lkQXBGCE3P1W4lOpQtSK19qdXLtGfCgip+rAurvGPhBjbzjgSlb/dU=
x-microsoft-antispam-prvs: <AM0PR03MB504257589F6DF835A69201C8E6480@AM0PR03MB5042.eurprd03.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(446003)(25786009)(80792005)(1076003)(72206003)(478600001)(316002)(97736004)(99286004)(2501003)(476003)(2906002)(3846002)(11346002)(66066001)(2616005)(6116002)(76176011)(305945005)(486006)(55236004)(102836004)(6506007)(7736002)(5660300002)(186003)(110136005)(68736007)(71190400001)(8936002)(26005)(4326008)(256004)(14454004)(106356001)(6486002)(8676002)(105586002)(81156014)(81166006)(53936002)(36756003)(6512007)(71200400001)(6436002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR03MB5042;H:AM0PR03MB4148.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OC84vBW6w4jKQE0CgdJwS8hYdGpuhUCpzQXLpDGM8t3F7/GlkoBA4LC1aHBd4/xI2WB/eNtO2LQf1DTN9om6U7MoWpRg6RZpck2KqHBPaqexypFyo9bA6U0SwfBp0SJ657kpILLZXsVbCu8dI0z7FqxEpeJqNU/hMPlHciDW+YxepGUCKs+LY+3uujkH1mB2B7TRLtLnOi/7apeX/1oyPXs5vLCN/B5TK6AmebFXLKhULb9GzkTLsjvxIDnuNbBR9GxHUQ68+I/ce883iNTB82uhNUf/qUfCvL1bGhOHNL8qBNZ11qRrui8MXUynPi3Qfc8qHNtBmSaIBUj1HkaTjCxBH68OP3/0POuY9z9lk8qMKNbURLlXhTJ9eflnJnFV90BRNZne0MmTMPrss2CyRHZsLgx8Oph7StghuhjcvCM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb24c9d-9eeb-4b55-7930-08d6a62216de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 13:04:26.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

On virtualized systems it is possible that OP-TEE will provide
only dynamic shared memory support. So it is fine to boot
without static SHM enabled if dymanic one is supported.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---

 Changes from V2:
  - rebased onto upstream

 drivers/tee/optee/core.c | 80 ++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 0842b6e6af82..48963eab32f5 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -419,9 +419,35 @@ static bool optee_msg_exchange_capabilities(optee_invo=
ke_fn *invoke_fn,
 	return true;
 }
=20
+static struct tee_shm_pool *optee_config_dyn_shm(void)
+{
+	struct tee_shm_pool_mgr *priv_mgr;
+	struct tee_shm_pool_mgr *dmabuf_mgr;
+	void *rc;
+
+	rc =3D optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc))
+		return rc;
+	priv_mgr =3D rc;
+
+	rc =3D optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		return rc;
+	}
+	dmabuf_mgr =3D rc;
+
+	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		tee_shm_pool_mgr_destroy(dmabuf_mgr);
+	}
+
+	return rc;
+}
+
 static struct tee_shm_pool *
-optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_sh=
m,
-			  u32 sec_caps)
+optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_sh=
m)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -436,10 +462,11 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn,=
 void **memremaped_shm,
 	struct tee_shm_pool_mgr *priv_mgr;
 	struct tee_shm_pool_mgr *dmabuf_mgr;
 	void *rc;
+	const int sz =3D OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
=20
 	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
 	if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
-		pr_info("shm service not available\n");
+		pr_err("static shm service not available\n");
 		return ERR_PTR(-ENOENT);
 	}
=20
@@ -465,28 +492,15 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn,=
 void **memremaped_shm,
 	}
 	vaddr =3D (unsigned long)va;
=20
-	/*
-	 * If OP-TEE can work with unregistered SHM, we will use own pool
-	 * for private shm
-	 */
-	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
-		rc =3D optee_shm_pool_alloc_pages();
-		if (IS_ERR(rc))
-			goto err_memunmap;
-		priv_mgr =3D rc;
-	} else {
-		const size_t sz =3D OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
-
-		rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
-						    3 /* 8 bytes aligned */);
-		if (IS_ERR(rc))
-			goto err_memunmap;
-		priv_mgr =3D rc;
-
-		vaddr +=3D sz;
-		paddr +=3D sz;
-		size -=3D sz;
-	}
+	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
+					    3 /* 8 bytes aligned */);
+	if (IS_ERR(rc))
+		goto err_memunmap;
+	priv_mgr =3D rc;
+
+	vaddr +=3D sz;
+	paddr +=3D sz;
+	size -=3D sz;
=20
 	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
 	if (IS_ERR(rc))
@@ -552,7 +566,7 @@ static optee_invoke_fn *get_invoke_func(struct device_n=
ode *np)
 static struct optee *optee_probe(struct device_node *np)
 {
 	optee_invoke_fn *invoke_fn;
-	struct tee_shm_pool *pool;
+	struct tee_shm_pool *pool =3D ERR_PTR(-EINVAL);
 	struct optee *optee =3D NULL;
 	void *memremaped_shm =3D NULL;
 	struct tee_device *teedev;
@@ -581,13 +595,17 @@ static struct optee *optee_probe(struct device_node *=
np)
 	}
=20
 	/*
-	 * We have no other option for shared memory, if secure world
-	 * doesn't have any reserved memory we can use we can't continue.
+	 * Try to use dynamic shared memory if possible
 	 */
-	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
-		return ERR_PTR(-EINVAL);
+	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+		pool =3D optee_config_dyn_shm();
+
+	/*
+	 * If dynamic shared memory is not available or failed - try static one
+	 */
+	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
+		pool =3D optee_config_shm_memremap(invoke_fn, &memremaped_shm);
=20
-	pool =3D optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
 	if (IS_ERR(pool))
 		return (void *)pool;
=20
--=20
2.21.0
