Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E37C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB8B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="Kr2Xrua8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfCTDUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:20:40 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:30900 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfCTDUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:20:40 -0400
Date:   Wed, 20 Mar 2019 03:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553052036;
        bh=oGA/F6+EWdH8V0ESdZimZJfOgURvdmw1yqK3eidZ+LQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=Kr2Xrua85IdyhvpdmxEANNGZZAPYjJX5a/nxi0V2W708duUYXQGnxFlYQM7HHmzkR
         7RVuuOFRrXuQMCeYk31m2NR/r7tw5mxbrNgMyvrDyxZ5OuwuLFHi1+mu4nr/AVGfNm
         meOXqhp6WnLB8asjeg4xgltK/iht53pKav3noCxE=
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
Subject: [PATCH v3] perf tools: Add missing case value
Message-ID: <PF2cGMeKmyLsYmtoatcC6SV8XK45pcXs-AI2V6BllH1iILYBAVjIz-u2VWanTWH4pT0Qe4pdKY1h8q02Fy4yE0GhAoV3T_jnIYu4oDfsaDo=@protonmail.ch>
Feedback-ID: idpJ9Qep05LI5f2mQoaoGmmCIit-QceKL6uqbHgV_NOtNjcF0QNi56ai_biFv0uPMue2gAtmoKKy4wfiVgSKGg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------9ce944852934f0cd8cae2e958980ecbd"; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------9ce944852934f0cd8cae2e958980ecbd
Content-Type: multipart/mixed;boundary=---------------------46b1135b4de303739107faad905e8579

-----------------------46b1135b4de303739107faad905e8579
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

Because `OCSD_INSTR_WFI_WFE` case was only added after v0.11.0, the minimu=
m
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
 =


 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/=
util/cs-etm-decoder/cs-etm-decoder.c
index 8c155575c6c5..2a8bf6b45a30 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -374,6 +374,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *de=
coder,
                break;
        case OCSD_INSTR_ISB:
        case OCSD_INSTR_DSB_DMB:
+       case OCSD_INSTR_WFI_WFE:
        case OCSD_INSTR_OTHER:
        default:
                packet->last_instr_taken_branch =3D false;
-- =


2.19.1

-----------------------46b1135b4de303739107faad905e8579
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
-----------------------46b1135b4de303739107faad905e8579--

-----------------------9ce944852934f0cd8cae2e958980ecbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail
Comment: https://protonmail.com

wsBcBAEBCAAGBQJckbF+AAoJEO+0Z6zIgommBk4IAJUhUc5Lr7ObzxuCVpWu
EjDfWG9Veu9yzzs9nZ8IAOKDxSIQFHu2DpIaNCA0vqUcZJzLQOuN/DcUvh8q
IECjM5N/6MQ3TWwRBW8UIhK9CB5B7kvBmRsOf/nsD/gGDO4Ez5qc0RF+0QP8
SBszS0XPX9eLXkNQtVLhRthu/EvHcRal6k5j59utu47T7zXFhsm8QCQ3UMQg
qudz4KtDpQPhf7r270vZrnbs/GST1FvxDjeZRznuu8z0F+XT26mKugpBPegr
JN78tlzV1210WcwtSUeUpjS5za0JTB9nPyGRTHsjQOhT8SUCJatkWRgCMpde
y2r4giZ+d5Ooa8HRz034zh8=
=LPck
-----END PGP SIGNATURE-----


-----------------------9ce944852934f0cd8cae2e958980ecbd--

