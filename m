Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E49C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909F62343A
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="eROQqqpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfHaFuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 01:50:04 -0400
Received: from mail-eopbgr710138.outbound.protection.outlook.com ([40.107.71.138]:46777
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfHaFuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 01:50:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKGp0jkADfMCCqmTVJJCf4E99tUSqj1cRfyga9fRFwvYz8nXDhPj+dXn5X51rHT9cqQKNN5N5WVu1XAuzWj4ch3/h3z1sc75c9sglb2EsROMY7v4FngYsCd8jDo2qbQyCEkL0KNQaF+P3dCV0AmDx+B2RIYwEd6b1PwR4RwY9tAq50b1/IbdkpLXUiC0Jry9Slv3BBS4CV4qT+w8gkvg3ZxW0LJf9D9iJeKuiY57IcKMZy6V7ZvPsaZI0z6Y94z+kSeLRKlhWfs6U4Jm+oSYaGWeHeaSptLk7ojkJ73WfYV7p0wHY3qWENdsK3apCMH60CP5BCqUjs+6LkiUjuNu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBBmlZndKnGlsYKEusg3CZZTtWy48sLuyIpHphVn/WU=;
 b=DWfGiM/u40YrpfgvQ3dAWTGuU5hXAtzsfTd6IOZbxc5sAUDejXNpXlGkMLklUZUSYv0+Xwxycw+ImKAjE8NdXIp8nlLkeTIkRiCgj7CXkehqmCBJc/LTQP4ijDRe7hSCeaISxvhVfT0boSx6/877UXcLZAIPCK9eJqQvaOyhB7NBrqiD1Pje+UbC3XzNUn7a3uly1kCrkEoUW+RlVD9EqASgsBNhwHnqPLo51prOy6fUrXy/ln+979567yid40ZKIpYRyKQ6xy1a8pI31CZAhPQIIMgoLS5/N8JoYSGe6JIMitTF/QCXUo9LW7fGB3R7dS6dr6P3ZKek+ybpwWgUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBBmlZndKnGlsYKEusg3CZZTtWy48sLuyIpHphVn/WU=;
 b=eROQqqpEBKIWI6MH1eSyKLhBAsKTb/vX7FECQWsBj+k1+gwxSm/xnuGRFU3bOwDUxPnoMsCZwbfmziknlC7GEUJhdZDl5XClUrikwxaBDQvLd3U66Dopmid0zaMv41j6QgKWlM97UR01iabS4J7ZPP4p8DH9v+BgylV/0uyscWE=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2283.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 31 Aug 2019 05:50:02 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410%6]) with mapi id 15.20.2199.021; Sat, 31 Aug 2019
 05:50:02 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Enrico Weigelt <info@metux.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jethro Beekman <jethro@fortanix.com>
Subject: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel Cannon
 Lake SPI flash
Thread-Topic: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Thread-Index: AQHVX7/uG6L6vrB8AkqYpiaKUWq+UA==
Date:   Sat, 31 Aug 2019 05:50:02 +0000
Message-ID: <035a46f6-dc82-7607-0f39-6cb46b7a5292@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.236.28.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b16a120-2520-4fa6-6842-08d72dd710e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);SRVR:DM5PR1101MB2283;
x-ms-traffictypediagnostic: DM5PR1101MB2283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB228380C558F821637CEADAB7AABC0@DM5PR1101MB2283.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39830400003)(396003)(346002)(189003)(199004)(99936001)(6436002)(31696002)(7736002)(86362001)(99286004)(6486002)(2201001)(5660300002)(81166006)(66556008)(14454004)(71190400001)(64756008)(66476007)(486006)(476003)(478600001)(26005)(71200400001)(52116002)(66946007)(256004)(66446008)(81156014)(3846002)(31686004)(36756003)(8676002)(2501003)(316002)(6512007)(386003)(2616005)(25786009)(7416002)(4326008)(186003)(107886003)(66066001)(66616009)(53936002)(305945005)(1250700005)(102836004)(8936002)(110136005)(6506007)(6116002)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2283;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LkAaCplr8lzUCNAC7Xm9nX+FpU6LqEXBFyEJuhI1fQoNDFrDa8MX/mP6afXWuAHRjZRuTNS2APP8pXRx3BzOEiWXJCKFmtrv0pwwEk73dwmpHFyoHwg4GWisjJIrLKIpXY+YpDhu3QWU6ovmYjNs7QLphLf3AHiT/Bq1HQUx3ysXX7OvYNWNOB0niohVaBOf8EcmifwtuTZjOisTrUjpQlyxJrq5DTmSB3dfh6sKcewiU0QWhHjOPf541yKObIMzU2BIITVa1zH4Bbd1yESXyPMx6uqcNwvBH5AlufABHnTni2pWYH+/357ZnmePr1IkRP29YjWhxDAvsnYgyQnKACU5QszyvaLVC/oFhJ/8z70CnqVkjbgRSbYAzQWQvUBwtbj8P+YdseSXyUJL4++KNwYmmpZ/hCOheqlahSvGWgM=
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070901050804080602030003"
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b16a120-2520-4fa6-6842-08d72dd710e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 05:50:02.2677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6SRN4cELUWvDJvR79Mj4Gd+11uFLWnLlYZ2ka34qTYll6XBFnetgpcmFO1U8vmk7Lgnwrez8wmnhRSvSLcRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms070901050804080602030003
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Now that SPI flash controllers without a software sequencer are
supported, it's trivial to add support for CNL and its PCI ID.

Signed-off-by: Jethro Beekman <jethro@fortanix.com>
---
  drivers/mtd/spi-nor/intel-spi-pci.c     |  5 +++++
  drivers/mtd/spi-nor/intel-spi.c         | 11 +++++++++++
  include/linux/platform_data/intel-spi.h |  1 +
  3 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/intel-spi-pci.c=20
b/drivers/mtd/spi-nor/intel-spi-pci.c
index b83c4ab6..195a09d 100644
--- a/drivers/mtd/spi-nor/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/intel-spi-pci.c
@@ -20,6 +20,10 @@ static const struct intel_spi_boardinfo bxt_info =3D {=

  	.type =3D INTEL_SPI_BXT,
  };
  +static const struct intel_spi_boardinfo cnl_info =3D {
+	.type =3D INTEL_SPI_CNL,
+};
+
  static int intel_spi_pci_probe(struct pci_dev *pdev,
  			       const struct pci_device_id *id)
  {
@@ -67,6 +71,7 @@ static const struct pci_device_id intel_spi_pci_ids[] =3D=
 {
  	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
  	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
  	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
  	{ },
  };
  MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
diff --git a/drivers/mtd/spi-nor/intel-spi.c=20
b/drivers/mtd/spi-nor/intel-spi.c
index 195cdca..91b7851 100644
--- a/drivers/mtd/spi-nor/intel-spi.c
+++ b/drivers/mtd/spi-nor/intel-spi.c
@@ -108,6 +108,10 @@
  #define BXT_FREG_NUM			12
  #define BXT_PR_NUM			6
  +#define CNL_PR				0x84
+#define CNL_FREG_NUM			6
+#define CNL_PR_NUM			5
+
  #define LVSCC				0xc4
  #define UVSCC				0xc8
  #define ERASE_OPCODE_SHIFT		8
@@ -344,6 +348,13 @@ static int intel_spi_init(struct intel_spi *ispi)
  		ispi->erase_64k =3D true;
  		break;
  +	case INTEL_SPI_CNL:
+		ispi->sregs =3D NULL;
+		ispi->pregs =3D ispi->base + CNL_PR;
+		ispi->nregions =3D CNL_FREG_NUM;
+		ispi->pr_num =3D CNL_PR_NUM;
+		break;
+
  	default:
  		return -EINVAL;
  	}
diff --git a/include/linux/platform_data/intel-spi.h=20
b/include/linux/platform_data/intel-spi.h
index ebb4f33..7f53a5c 100644
--- a/include/linux/platform_data/intel-spi.h
+++ b/include/linux/platform_data/intel-spi.h
@@ -13,6 +13,7 @@ enum intel_spi_type {
  	INTEL_SPI_BYT =3D 1,
  	INTEL_SPI_LPT,
  	INTEL_SPI_BXT,
+	INTEL_SPI_CNL,
  };
   /**
--=20
2.7.4



--------------ms070901050804080602030003
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Cx8wggUxMIIEGaADAgECAhBdZC9mIseKJlmxx1xn+g00MA0GCSqGSIb3DQEBCwUAMIGXMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xODA5MTUwMDAw
MDBaFw0xOTA5MTUyMzU5NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2pldGhyb0Bmb3J0YW5peC5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRQDOQsroKjy2xAQCXLyqryJt4
Xwj8hcweJCzOnjILKHIoWlOQ0b9yIbFLIWBRt/9zdxlE5ZabDVHnkIyhcVgtU/BA73e78Wx2
LOObdg0wfs9U2CVRYhz2EPHFjGvkYKihItt69ye91hj1w7RKCrYC8KZGSZ/+sbkJzQdXVy32
lxmiNEt17GNRebpkJCaFnznd6C2a8tBAS2Fa/UNyFdEs4eoRoYSKswclRhbe81aVhqY2hjcd
O6puyyaYp5hkmau2UPih6OpRSOhbe6Tuebceg1yvumoVX3OZtGPS1VdQ+p0bxB0RE6gNs140
ZKUhrvAJDETuGaaQD4A2/6ksLunjAgMBAAGjggHpMIIB5TAfBgNVHSMEGDAWgBSCr2yM+MX+
lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUsFUcmGtaJBU7/52LyTYHC/M+LscwDgYDVR0PAQH/
BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUC
MBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsG
AQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBL
hklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlv
bmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0
dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNv
bTAeBgNVHREEFzAVgRNqZXRocm9AZm9ydGFuaXguY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB6
v3tFEUSGv9+yY4wUjvcMyz3126nJrX5LkfEvrnCEpEiImECuoYvxOYNLYYynell7BQGtTaZg
shMfDvwpy2isoi3w1AWAfbn6npnSKLzu0BMRvcCPWY8VPmePPizTqXoPkLwgTJfSaWkxMP1u
rfL9S5NeRdkjwjHklX5IWuwwDu1hsKVZrxSSY2unCtvq67UHWz+z6rG1JQrP2YDfb98xun3y
eLBNe/LFBNnGISbkT5q6D+e5c0bgzoH9nH4bsw3t8aDqJTfT3BqQdWr4pF05ODzzeOmEqeYE
qGlD9hIL2AbmTZLjunAnARr6Fv7Sfqt23ptsGkmoZ9ZQNjT3TlwvMIIF5jCCA86gAwIBAgIQ
apvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNV
BAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09N
T0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9
NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+Ul
NEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2
qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZ
jrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGj
ggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9s
jPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
EQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2Rv
Y2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEB
BGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRk
VHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkq
hkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+js
QgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDcZoFD
7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwpWZT89RY0wpJO
+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNMUH4Tam85S1j6
E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyvB8czm12F
gX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiO
SEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz
/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSa
m9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpO
UvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIxggQ1MIIEMQIBATCB
rDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9E
TyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEF1kL2Yi
x4omWbHHXGf6DTQwDQYJYIZIAWUDBAIBBQCgggJZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgzMTA1NDk1OVowLwYJKoZIhvcNAQkEMSIEIK9Tue/9
5++gfHtLGcrQnILzvf0bW3iEzSKb5fojd1VxMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgb0GCSsGAQQBgjcQBDGBrzCBrDCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEF1kL2Yix4omWbHH
XGf6DTQwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8g
Q0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQQIQXWQvZiLHiiZZscdcZ/oNNDANBgkqhkiG9w0BAQEFAASC
AQC/mQGONBej6YL84kZcKTLaAVwB0Ehb/ZXWGhh61RMjF5iXll8esjC3fz3+4s9Xd48cjSnF
BoVUQBvJ4H79tqoOSqFc7Ky8WR676qRm9s32bDRM+3vcfSbkWccs5sfhv1xyrmGqIO4hbPNM
N9Y8aPn8bUllhsZlm33pAj2fSnTs2cJgzfetcY0yM0OTWPPX+WF6ogE+80Gz/oT74T4b5GsQ
LYhPuLt94SCLzytANWcBxLEVKFt+pfnP13rTziMR/rL12K66h6x/s6JiGewmXO2HFOSBPsqB
i1MUIcSbD/5IohTUJu1VHsMkAFVHMYS+rFxo0LFXrlXiUDeWyeVf6MtWAAAAAAAA

--------------ms070901050804080602030003--
