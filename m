Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96841C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A0218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="v93d6uuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCUB3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:29:20 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:20203 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCUB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:29:20 -0400
Date:   Thu, 21 Mar 2019 01:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553131756;
        bh=912iqiIr4XC8S9eHn6h7beePGT6myjMMssSk8a5TjMA=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=v93d6uuUJHDu8GZpOuUNR01bHRlyIMknYzSt0hj1eRkSAN59A95yuIhIx+EctskrW
         PWkmHzJCPcqKavNeAvhID+zBVAsJMJ4tIFIjA8ULQhxyJT4vsH7F1zQozA36wsXZTE
         6YGW0huBZQReIIDDKP9ypKIg3dgoBb4H4IMGKNPw=
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "robert.walker@arm.com" <robert.walker@arm.com>,
        "acme@redhat.com" <acme@redhat.com>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: [PATCH v4] perf tools: Add missing case value
Message-ID: <iXDQnAbT-yValKlLnwDyoyBCwymrdxjykuMsgI4Cxau_e2ib9QYVroNDbJgZz3kuxTTaPJnyzRWmEY0TpEZDVQBSdElz9K9R0tAz79Qkp2s=@protonmail.ch>
Feedback-ID: idpJ9Qep05LI5f2mQoaoGmmCIit-QceKL6uqbHgV_NOtNjcF0QNi56ai_biFv0uPMue2gAtmoKKy4wfiVgSKGg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------c54533f3f9ad8fb079b2a615a820b327"; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------c54533f3f9ad8fb079b2a615a820b327
Content-Type: multipart/mixed;boundary=---------------------2108b41cedeb08d4a300ff618b20164f

-----------------------2108b41cedeb08d4a300ff618b20164f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

The following error was thrown when compiling `tools/perf` using OpenCSD
v0.11.1. This patch fixes said error.
```
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/cs-etm-decoder/cs-etm-decoder.o
util/cs-etm-decoder/cs-etm-decoder.c: In function
=E2=80=98cs_etm_decoder__buffer_range=E2=80=99:
util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value =E2=80=
=98OCSD_INSTR_WFI_WFE=E2=80=99 not handled in switch [-Werror=3Dswitch-en=
um]
  switch (elem->last_i_type) {
  ^~~~~~
  CC       util/intel-pt-decoder/intel-pt-decoder.o
cc1: all warnings being treated as errors
```

Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimum
required OpenCSD library version for this patch is no longer v0.10.0.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/t=
est-libopencsd.c
index d68eb4fb40cc..2b0e02c38870 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required featur=
es
  */
-#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >=3D 0.10.0 is required"
+#error "OpenCSD >=3D 0.11.0 is required"
 #endif

 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/=
util/cs-etm-decoder/cs-etm-decoder.c
index ba4c623cd8de..39fe21e1cf93 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *de=
coder,
                break;
        case OCSD_INSTR_ISB:
        case OCSD_INSTR_DSB_DMB:
+       case OCSD_INSTR_WFI_WFE:
        case OCSD_INSTR_OTHER:
        default:
                packet->last_instr_taken_branch =3D false;
--
2.19.1


-----------------------2108b41cedeb08d4a300ff618b20164f
Content-Type: application/pgp-keys; filename="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"; name="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"; name="publickey - solomonbstoner@protonmail.ch - 0xA77658B9.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjQuMTANCkNvbW1lbnQ6IGh0dHBzOi8vb3BlbnBncGpzLm9yZw0KDQp4c0JOQkZyeTVGWUJD
QUNWZG9oN1pvYnFaMTI2RUFPVDNjaktZalVIMURtQkxHeWEvWmxQV0xaVVBmMjkNCk5aMUduSHcx
K0ZnYXZPODRPY3ZPK0RORm51eVllUG9ZM3NsaVVwNWpPT0xRNHhoQmVIL0U3ZWgybDhUVg0KdW9t
ZFZLK1hsQ0NzcGFXZU9BR3ovSkt0dDgrV0RtbytsOUsrQTNHcXdnZHZPTjI3dTA0L3VYd1MyeE5W
DQpHQWhBY0RVVGZBL3NMNTdUbWV0NU5KNXdoZ0dXM3d5alNPOSs0Zkw4aWtXaDlBMGJvL3BxVFo5
L3NFTVcNCjdTOGllYXUxbklKUER5ZXBzeTU4TnE0ZFRnMTBIVll5WkMyZTdER0x4MXR4YzVPeE81
V3hJcTgwazJXdQ0KeFhqRFU5aVhPT2I1ZElDeDJZSExTTGZmdTQ1VGw0bXBVam9tY3F2WFVZdmpM
NEZYRGszTWtTVFhBQkVCDQpBQUhOTzNOdmJHOXRiMjVpYzNSdmJtVnlRSEJ5YjNSdmJtMWhhV3d1
WTJnZ1BITnZiRzl0YjI1aWMzUnYNCmJtVnlRSEJ5YjNSdmJtMWhhV3d1WTJnK3dzQi9CQkFCQ0FB
cEJRSmE4dVJXQmdzSkJ3Z0RBZ2tRNzdSbg0Kck1pQ2lhWUVGUWdLQWdNV0FnRUNHUUVDR3dNQ0hn
RUFDZ2tRNzdSbnJNaUNpYWIweXdnQWxBemthWVZSDQpDMHFvL0lhY000NXRVVGJyTnlVYmVLeUds
Mi9tTU9ma3JOTDcvcTBWemtxcmJxY2NTWjRzUVVta25IYU0NCk1Cdm1STnJiMXR4elNkTlZuS1ZQ
VlJRSGE4eDlDcDVUQnhBTFV3NDdHOW81SnYrYVNueHRwWEFMSldldA0KbUt1WWlSaHRzUWxBazlF
RlZJYzY3ajkvK2s5bkpTUkRtWnRLeU9jOGhXZkxjcFlGV0s2UXFLSWt1NG9xDQp3d0xFRzE0T0Nl
c3VqV2E4Sm9iVy8rb1Irelh3QmJCOE55dWRGSm13b0FYLzdud2NTSlZ0bGRZeUdYbWoNCkt1VFFp
eFJpWFh1TjhsNHBSdGRRdUdGdVhERjM4WVRrMDlNYyt1SmdjaVRZYmNSL3pmMGRhUktVbDB0aA0K
RzBOVE85YzErZG02M0FHWjdMSkJIOFB1N0NrMi9hT3d4czdBVFFSYTh1UldBUWdBNVZWdCtKVGRa
VXhwDQpuZSs2dzljSE0zTzY1Q1ZzcWFMNkI4VCtBcVF6a0VJbGJhQkI4RlV5citGa1BZZGRiNGVw
SjlQVHNJLzYNCk1jeThTRTdWUUVuU2NuYVQvREtkbk1OUXJibngrRWgyM2NWNFNJVncveWVBT0hP
Z1BvT0dHekZmVk0ySw0KZkVhQjJvTDk4eThNcUlRLzNEak9CYUpwZFdhQS9mQldEcVJ6aENqQzhX
MkhndDIvRElQY2JWalpISUFtDQptZXBGSWo4R2JLZDhOVjhYVU1QcUtjWEVNTVZIdW1ndHNSVVBX
eE9DN29wZjI3WmFLcjRteVd2NFdCVDANClo5RzAzT2VLUmEvU3ZoVUlYcjVMZzRyaWpkbTZWMVFL
aFpvS3R4Wi9RR0RqdDg3dUtQb0M1ZTNwa2tQYg0KOXlvbHNFQVQ2U0xRcDd2TEVwWjRlUjFmd1Ju
eDV3QVJBUUFCd3NCcEJCZ0JDQUFUQlFKYTh1UlhDUkR2DQp0R2VzeUlLSnBnSWJEQUFLQ1JEdnRH
ZXN5SUtKcGk5N0IvOXhYU3VMRjc2QUd6ZWtwdFdiTVo2eXVYeWQNCmZza2IwL0NjL0xjR2tMV21V
Y1hkbGRLWVdTLzg3ZXZTalZXZTFTbUhCQzVrZWhvVXp1bEpCZmx0SGpqMQ0KcVZCTWY0eHB6ckVz
aGFCWUNxbllhTnpCa2NINlFINGNRT3cvMUw1WTZ5QjRPQVZGQjJ2d3UzN2dSNUJ4DQpEQWN2NHFD
b1lvT1ZDRklDRFprV3lQWkFReFNLb3hHd3BXK2ZNOTdXOXBwV0Q4WEw5b2RlU29UVmN6a0INCnJK
WTFrakltUnhONU5wMkg5UVRKY0EyMHNQNDJ0VnNQVzRuaC9HYkQ4cmc2Tkl3TFg3RWJVWkh2VjJE
Mg0KRDJxRThSM1ZNTGNob3BSbGFIQjVHU1AzNWxpTkVuY2tKMmV0dTRUWVY4SXB6NkNseW16TnZy
RjR1MkhkDQowZktFU0hRM2U3SEVWMGpQDQo9TTRBNA0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkg
QkxPQ0stLS0tLQ0K
-----------------------2108b41cedeb08d4a300ff618b20164f--

-----------------------c54533f3f9ad8fb079b2a615a820b327
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail
Comment: https://protonmail.com

wsBcBAEBCAAGBQJckujmAAoJEO+0Z6zIgommSIAH/0qwoDgHbWI80ibrtjuJ
l1iKBGTCrOAa40TmZ+XpEX/NYSNyHHv7ykcmA+bIeWZGBI6wfDtCtznmiSPH
TqkBeLJkl20YACYZSgmJ7eoyKDswa+M5Iv5ipH5FxGwa6HXiXVlhrG/M/Clm
OxIEyaqh6MOii+bD+8lARD2a6Fwsf8wxLmtWdmZ+4g8toZC84Y3vUTLhSujP
4RuUijU2vdYVpyt2FRS2F4kq2TJS11PryrfORFOrSKagrB3NP6faqMd5QdBi
udaWOcSey1rzSoDWWukwdNMgdVendNwDMhhTCusuljgnZ69SR94dgqGxhPFF
YZbL2f8Mz8DgLYiqbeJFQzY=
=BYC9
-----END PGP SIGNATURE-----


-----------------------c54533f3f9ad8fb079b2a615a820b327--

