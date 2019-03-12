Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF087C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E29214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ry0B4Y2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCLHRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:17:23 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35237 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCLHRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:17:22 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190312071720epoutp03078b53e711c12a5bff9858b3ebbffd87~LJN-qRSau2625126251epoutp03L
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:17:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190312071720epoutp03078b53e711c12a5bff9858b3ebbffd87~LJN-qRSau2625126251epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552375040;
        bh=1IBBrG+WqDmcIXONxlC9RellrcYTCsmaFnxlYD9xyHw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ry0B4Y2ohcqWbXdhxG/6sEtOZy3lvZPdIFwkcR2160e7sviEyV5apj6pv+occSWQ4
         4c4zYxeIjJ0VG/JHzeSZ1b93iYGeVjC50JWzFzG7g6pP356DN0JBRpQCarwAhfenJa
         Wm1kWtCokb2Mpx1mc+0bL5BcWqmT6rD9wLxeSfig=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190312071717epcas1p2b7342c992e6b3087f62739a2593a023e~LJN9Gt1bf1340513405epcas1p2V;
        Tue, 12 Mar 2019 07:17:17 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-31-5c875cfa7ed9
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.42.04143.AFC578C5; Tue, 12 Mar 2019 16:17:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v5] PM / devfreq: Restart previous governor if new
 governor fails to start
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm-owner@vger.kernel.org" 
        <linux-arm-msm-owner@vger.kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190311100630.12952-1-sibis@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51@epcms1p2>
Date:   Tue, 12 Mar 2019 16:17:14 +0900
X-CMS-MailID: 20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmvu6vmPYYgyuvrC2uf3nOanG26Q27
        xe/FE9gtLu+aw2bxufcIo8W1he9ZLQ5cnMjmwO5xua+XyaNvyypGj8+b5AKYo7JtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM/Ye/8ZcsIej
        Yvf3FtYGxpdsXYycHBICJhIfdjewdzFycQgJ7GCUOPn2HpDDwcErICjxd4cwSI2wQILEq1UH
        GUFsIQEliYab+5gh4voSHQ+2gcXZBHQltm64ywLSKiLgI7H4qiTISGaBRUwSH88cYYXYxSsx
        o/0pC4QtLbF9+VZGkHpOASuJv1sFIcKiEjdXv2WHsd8fm88IYYtItN47ywxhC0o8+LmbEWbM
        jCn/oUZWS1ybvhjsFQmBFkaJ3tVToIr0Jc7MPQn2L6+Ar8SmCQ/B4iwCqhJ7fz6FqnGRWH4F
        4hdmAXmJ7W/nMIPcxiygKbF+lz5EmE/i3dceuFd2zHvCBGGrSRzavQTqZhmJ09MXQt3pIXH3
        9AMWSNA2Mkr0/DvJNIFRfhYidGch2TYLYdsCRuZVjGKpBcW56anFhgXGyBG6iRGc9rTMdzBu
        OOdziFGAg1GJh9ehuC1GiDWxrLgy9xCjBAezkghvl317jBBvSmJlVWpRfnxRaU5q8SFGU6Cn
        JzJLiSbnA1NyXkm8oamRsbGxhYmhmamhoZI473oH5xghgfTEktTs1NSC1CKYPiYOTqkGxpK0
        q93vV9t16FRstLW1cX9plrUivdFJNqhfzN6avX7Tal6OfF29yFINpZpHpTH9rl9Wbl/dU8r2
        fTl3nuFB109HZ7xQuexzWWhRN3+KyAmVVpFrx6WKN3z1+uIaesRB5vbjjLoDgn/OyzdPPT5/
        0cMl3FW7Gvt/xf7KOF6X3S38eBFDQes7JZbijERDLeai4kQAPyZexJEDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190311100759epcas5p41fc634cd67a99b39cd25c4129e489c4c
References: <20190311100630.12952-1-sibis@codeaurora.org>
        <CGME20190311100759epcas5p41fc634cd67a99b39cd25c4129e489c4c@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Saravana Kannan <skannan@codeaurora.org>
>
>If the new governor fails to start, switch back to old governor so that the
>devfreq state is not left in some weird limbo.
>
>[Mjungjoo: assume fatal on revert failure and set df->governor to NULL]
>Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

I'll modify WARN->ERROR for the case when it's fatal:

>+		if (ret) {
>+			dev_warn(dev,
>+				 "%s: reverting to Governor %s failed (%d)\n",
>+				 __func__, df->governor_name, ret);
>+			df->governor = NULL;
>+		}

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


>---
>V5:
>* assume fatal on revert failure and set df->governor to NULL
>
>V4:
>* Removed prev_governor check.
>
>V3:
>* Fix NULL deref for real this time.
>* Addressed some style preferences.
>
>V2:
>* Fixed typo in commit text
>* Fixed potential NULL deref
>
> drivers/devfreq/devfreq.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
