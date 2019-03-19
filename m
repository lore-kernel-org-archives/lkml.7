Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F69B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="OtIb8oGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCSQLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:11:45 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:33738 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:11:44 -0400
Date:   Tue, 19 Mar 2019 16:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553011900;
        bh=qcKFsrt69tjfqhjKk12VwFYaiSqOMd203Gn6mKMnTx8=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=OtIb8oGkrtyVUID0ipK6Egk9UO/IbxcsV5MzKc4LwD7KTX+wLku7ToL7n6nct5H1g
         REypU88h/81rhs0OPEjDg5NPnWfzzsT3s3Ve3AFLbV80nPNaUGY93ERLe+3td0xv6Q
         OUXPHaxRVORpelVcjiWBstBA6w6yh8yeIzrSlQ2U=
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Cc:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: [PATCH] perf tools: Add missing case value
Message-ID: <3nn0Oz_O4h6XtTJG1laQxwROZTgcDRxgu5Cq-bAgZNZsSDHYZzofDlIOMhBzkh1KAXok8Ekqk9Ev68umhEZPS7SyRgoJ-eA02GFC2QNbaLs=@protonmail.ch>
Feedback-ID: idpJ9Qep05LI5f2mQoaoGmmCIit-QceKL6uqbHgV_NOtNjcF0QNi56ai_biFv0uPMue2gAtmoKKy4wfiVgSKGg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------720f6080cc9d6cfc0203e14b3e082965"; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------720f6080cc9d6cfc0203e14b3e082965
Content-Type: multipart/mixed;boundary=---------------------e04cf835b5c8496770429e2b0ee7ab7a

-----------------------e04cf835b5c8496770429e2b0ee7ab7a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

This patch fixes the following error message during compilation of `tools/=
perf`, as seen in https://github.com/Linaro/OpenCSD/issues/17.

```
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/cs-etm-decoder/cs-etm-decoder.o
util/cs-etm-decoder/cs-etm-decoder.c: In function =E2=80=98cs_etm_decoder_=
_buffer_range=E2=80=99:
util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value =E2=80=
=98OCSD_INSTR_WFI_WFE=E2=80=99 not handled in switch [-Werror=3Dswitch-en=
um]
  switch (elem->last_i_type) {
  ^~~~~~
  CC       util/intel-pt-decoder/intel-pt-decoder.o
cc1: all warnings being treated as errors
```

Signed-off-by: solomon-ubuntu <solomonbstoner@protonmail.ch>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
 1 file changed, 1 insertion(+)

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
+	case OCSD_INSTR_WFI_WFE:
 	case OCSD_INSTR_OTHER:
 	default:
 		packet->last_instr_taken_branch =3D false;
-- =


2.17.1
-----------------------e04cf835b5c8496770429e2b0ee7ab7a--

-----------------------720f6080cc9d6cfc0203e14b3e082965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail
Comment: https://protonmail.com

wsBcBAEBCAAGBQJckRS3AAoJEO+0Z6zIgommn3AH/3xVFHa5rTmcWy+8t8W5
Ootyr0ZuHQud7H3zozRpQAXwGqbEHU+pLWcPX8wsgFHmIOmeTCC06V3exEzv
GGiR+YaOLYhN4ktJLaBfAJzYNUhoZIAi6D+e4Z5MJnm3rZorHazFA/eF10jo
mDJWevt1yf3bWtvbCr52IqUkcuTmWIArhkZvKT1PK3Wqitv1jOsDn0+AM4ZF
LXLDoiE1bebgK+jJGYsbJq9QHlFIvrb4BXS6gykrKE7g5y84MDAH8DRDdEcb
iexvKvi/SQp8GqBvv+LaeaSAHeqipFk0dK9plIjMepDIDOS4gnAxmPEQ+dWE
sX7wZvoxTF5LDA6oEzyUV+M=
=ecoY
-----END PGP SIGNATURE-----


-----------------------720f6080cc9d6cfc0203e14b3e082965--

