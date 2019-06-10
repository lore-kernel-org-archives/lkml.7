Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FBFC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0A5206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lk8F+SqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbfFJHrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:47:18 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47064 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387761AbfFJHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:47:18 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190610074715epoutp048cc6226d5663fa55ee7dd0b226fc0f69~mxrzz5l6d0131701317epoutp04m
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 07:47:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190610074715epoutp048cc6226d5663fa55ee7dd0b226fc0f69~mxrzz5l6d0131701317epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560152835;
        bh=z/G1igbwiUep1NIceSc0CppCqkrly7VeDS7GZ1WcTWU=;
        h=From:To:Subject:Date:References:From;
        b=Lk8F+SqZo9pUTSKTAENoqTFC6837HmWDemKrsdY5C46oXF/GrGH81PC56HY9IUivx
         qQ++zLDAN7P3b05neYMJpOFLEEFAWi1FDFSRGSMG1IoAnOa2F+2sloh3eiCpj3Pqnu
         k8merTPj5X3c9zKFJpGzrlPQTHifUfMZUnEXSzkQ=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.186]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190610074713epcas2p4b09d92f4d01b499234b62ad5d7e9a735~mxrxfVyQ80810508105epcas2p40;
        Mon, 10 Jun 2019 07:47:13 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.89.04206.DFA0EFC5; Mon, 10 Jun 2019 16:47:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20190610074708epcas2p3dcbdc49d114c544c1de721666d574b43~mxrtRLTuM2375123751epcas2p3H;
        Mon, 10 Jun 2019 07:47:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190610074708epsmtrp15ec3a7b12cab19a17cb55846105b4ed6~mxrtN9V2F0888208882epsmtrp1i;
        Mon, 10 Jun 2019 07:47:08 +0000 (GMT)
X-AuditID: b6c32a47-14bff7000000106e-6d-5cfe0afd7f89
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.D9.03692.CFA0EFC5; Mon, 10 Jun 2019 16:47:08 +0900 (KST)
Received: from KORND000991 (unknown [12.36.165.95]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190610074708epsmtip1e63acca72f837ec89ce264c295db796c~mxrs86WOc3251532515epsmtip1J;
        Mon, 10 Jun 2019 07:47:08 +0000 (GMT)
From:   =?UTF-8?B?64Ko7JiB66+8?= <youngmin.nam@samsung.com>
To:     <pmladek@suse.com>, <andriy.shevchenko@linux.intel.com>,
        <sergey.senozhatsky@gmail.com>, <geert+renesas@glider.be>,
        <rostedt@goodmis.org>, <me@tobin.cc>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] vsprintf: fix data type of variable in string_nocheck()
Date:   Mon, 10 Jun 2019 16:47:07 +0900
Message-ID: <040301d51f60$b4959100$1dc0b300$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdUfX+j/BHVROm56QV+h+YfouHIpCg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmue5frn8xBgtn8Fj0Nk1nspg7exKj
        xeVdc9gsbrcdY7X4//grq8W+jgdMFms/P2Z3YPeYeFbXY+esu+weLftusXvMOxnosX7LVRaP
        L9dfM3p83iQXwB6VY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQsECvODG3uDQvXS85
        P9fK0MDAyBSoMiEn48gqx4L5rBWbJx9na2CcydLFyMkhIWAi8fjzNLYuRi4OIYEdjBIHT99l
        h3A+MUp8/X2TBcL5xihxo/EGE0zLqum/oFr2AiWaJzJDOC8YJabvfscKUsUmYCnx6s9JsCoR
        gQOMEh8WtgAlODiEBTwk9v6sAzFZBFQltl5KBTF5gcp3HcwC6eQVEJQ4OfMJ2HnMAtoSyxa+
        ZobYqyCx4+xrRpByEQE9idf/XCBKRCRmd7ZBlZxhk2g+XgVSIiHgInHnohlEWFji1fEt7BC2
        lMTL/jYou15i8balYMdLCExglJi/6QNUwlhi1rN2sFXMApoS63fpQ4xUljhyC+owPomOw3/Z
        IcK8Eh1tQhCNahK/pmxghLBlJHYvXgF1mIfE6Z27wCEjJBArsezCI+YJjAqzkLw7C8m7s5D8
        NQvhhgWMLKsYxVILinPTU4uNCoyR43kTIziVarnvYNx2zucQowAHoxIPr4TT3xgh1sSy4src
        Q4wSHMxKIrxvj/6JEeJNSaysSi3Kjy8qzUktPsRoCoyLicxSosn5wDSfVxJvaGpkZmZgaWph
        amZkoSTOu4n7ZoyQQHpiSWp2ampBahFMHxMHp1QDY8a6Z57FZh+dDaVfx0tPsvgQYstUW+Lt
        06XYn9u45MyRoF9xq+9ruRRNr+tbK+SoHHoteN71iye/HZzO8/wfZ5NyYvrPE/J8vQm+O6uM
        S17vsD3t1fpxzoY9vbuyd6zbzSP4uOJJx6yfhqwlCf1rrb2mxtsnrWlrPGAWsbEts3xCeAVb
        q5WaEktxRqKhFnNRcSIA4kUFZ7sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO4frn8xBmfmKVv0Nk1nspg7exKj
        xeVdc9gsbrcdY7X4//grq8W+jgdMFms/P2Z3YPeYeFbXY+esu+weLftusXvMOxnosX7LVRaP
        L9dfM3p83iQXwB7FZZOSmpNZllqkb5fAlbHpeitbQT9rxY6J75kbGDtZuhg5OSQETCRWTf/F
        BmILCexmlNg7SR0iLiNxe+VlVghbWOJ+yxEgmwuo5hmjxJc3q8Aa2AQsJV79OckGkhAROMEo
        MfvlfiCHg0NYwENi7886EJNFQFVi66VUEJMXqHzXwSyQTl4BQYmTM5+AncAsoC3R+7CVEcZe
        tvA1M8RaBYkdZ18zgrSKCOhJvP7nAlEiIjG7s415AqPALCSTZiGZNAvJpFlIWhYwsqxilEwt
        KM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOBy3NHYyXl8QfYhTgYFTi4ZVw+hsjxJpYVlyZ
        e4hRgoNZSYT37dE/MUK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJ
        MnFwSjUwasZvu8bzyf3FicU323RPyXoa8N07Z3vz7R+Fbcet+ue0GD9fli2q9LrQScH3enLZ
        lwP75fvtFcV5UvnevWX15i27fy4g8YOnQNbZSa/feflOsv/PsoiHvW7uVh5eyTMqDyex7Jyz
        SDi0WtjEvtJI7rvqztPO3VUHzBe4fo692xPBdXjH8a9GSizFGYmGWsxFxYkAmKzed4MCAAA=
X-CMS-MailID: 20190610074708epcas2p3dcbdc49d114c544c1de721666d574b43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190610074708epcas2p3dcbdc49d114c544c1de721666d574b43
References: <CGME20190610074708epcas2p3dcbdc49d114c544c1de721666d574b43@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes data type of precision with int.
The precision is declared as signed int in struct printf_spec.

Signed-off-by: Youngmin Nam <youngmin.nam=40samsung.com>
---
 lib/vsprintf.c =7C 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 63937044c57d..cd0cd9279b12 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
=40=40 -599,7 +599,7 =40=40 static char *string_nocheck(char *buf, char *en=
d, const char *s,
 			    struct printf_spec spec)
 =7B
 	int len =3D 0;
-	size_t lim =3D spec.precision;
+	int lim =3D spec.precision;
=20
 	while (lim--) =7B
 		char c =3D *s++;
--=20
2.21.0

