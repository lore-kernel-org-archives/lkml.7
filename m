Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DE1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B02E2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="LhvJkAqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJDSvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:51:23 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:41915 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570215082; x=1601751082;
  h=from:to:cc:subject:date:message-id;
  bh=zeBRvpLS7yocFhDOcjTM7Sf+v5207KV1o2FMvWYXbvw=;
  b=LhvJkAqw9bninny2Yl/dKzVJFwLjVkWVDK5VPkfFT+p/3v2pMAsESzd1
   J6g2tUBPBEsshqWbv3NFDhP3f35VCUHFDoOPxZgpxxTSgeM6mZvvgaKTm
   pJeoPpzuZXLc5nNJkS4q01rfI4qASj5i3XKxlRf3MbUsjkNzqmrd3OhJm
   USfOmEP0eb4J2LCC0skfR2za/hn2kxnDsK2tr4sP48mn1Kf2WT3N8XbaY
   hR12NnYbk7eXPqoS1Xgz+yAFH0SazGq6XNvh0ZJoP8ZjaDQZmLQV9Rht5
   79koapLPjoUmjH03ei+/dnVHGmSW7kTdo62H8HsYHLIxMjDVQ7phUU1bv
   w==;
IronPort-SDR: YHq1As9sju1vpZE/rQZLdfkKIGODMvRT1dN4kRrUlquTCTRWU1RhGBo8DsnevXnJhR1RSKbBpv
 cxkkVBfX8ZqV2JmFGfQofe2sP3MQR/3uOkUMYhVqk6Imm4TwwAqba/MrZ0T53cCxHKKo8N5Zom
 lo5AafRf3wIRbOKPftOhGItP5opGRZs0oOLCKVj/CBYK3NxEDKmWYV55oQojRKZa6rtqnUxzO/
 pKqw53mA7zOxdPopkcmTU9xN/wHL/PkFvVsJxT2P9JSmlBfS6Vo+r2DHXmB3P/UJNNJAAaQcYs
 WlM=
IronPort-PHdr: =?us-ascii?q?9a23=3AmqIOFhXt2HtuHjd2Bi+u0VWCqRLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBaFt8tkgFKBZ4jH8fUM07OQ7/m7HzFZqs/b6jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMkbjZZtJqos1B?=
 =?us-ascii?q?fFvGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI68aooPD/EaPeZZqYn9qEYFowWnCwKxCuPvyyFHhnvr0qYn1+?=
 =?us-ascii?q?gsHx3K0AkmEt0JrHnZosn5OLoLXeyp0aXD0DHPY+5W1Dv47oXDbxIvruyWXb?=
 =?us-ascii?q?9occTf11QhGQ3GgFuXsoHpIy+Z2/4Rv2WB8+ZsSeSigHMnpQFrpTivw98hhY?=
 =?us-ascii?q?vIhoMUylDE6CJ5y5syKNy4SU97YcSrEJpMuy2GOYZ7Wd4iTH1yuCog1LIJpI?=
 =?us-ascii?q?O7cTEMxZ86xBDfc+SKf5aU7h/nTuqcIjd1iGh7dL6iiBu+61asxvHgWsWszV?=
 =?us-ascii?q?pHry5InsPSun0D1xHf8NaLR/pn8kqj1juC0R3Y5PteLkAuj6XbLoYswrs3lp?=
 =?us-ascii?q?UOr0vOBjT2mEDqjK+OcUUk5/So5/znYrr4op+cMJd5igTkPaQvnsyzGPw4Mg?=
 =?us-ascii?q?wTU2SC9+SwyqHv8VHjTLVFif02labZsJTEKsgBuqG5BApV3p4i6xa5ETimzM?=
 =?us-ascii?q?wVkWcbIF9BYh6KjIjkN0vQLPzlAvqzmUqgnCt3y/zeO73uGJTNLnzNkLf7er?=
 =?us-ascii?q?Z97lZRyQoyzNBf/Z1UC60NLO79V0LqqdzXEgU5PxaqzOn6FdVxzpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5uYuI+mKeY8Uty/xK/s76P70i382h1sdcLK33ZsYdn+4BO5qI0?=
 =?us-ascii?q?aHbnr2hNcOD2MKshA5TOzwh13RGRBJYHPnbqMu5iw8QNa3H4fKR9j125Sc1z?=
 =?us-ascii?q?39E5FLMDMVQmuQGGvlIt3XE8wHbzifd4o8zzE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FXAwDkk5ddh8jWVdFmgh6DXkwQjSS?=
 =?us-ascii?q?GMQaLJxhxhXqIM4F7AQgBAQEMAQEtAgEBhECCSiM1CA4CAwkBAQUBAQEBAQU?=
 =?us-ascii?q?EAQECEAEBAQgNCQgphUCCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWifoEDPIw?=
 =?us-ascii?q?lM4hmAQkNgUgJAQiBIoc1hFmBEIEHg25zhA2DWIJEBIE3AQEBlSuWUgEGAoI?=
 =?us-ascii?q?RFIF4kxQnhDyJP4tEAS2nLwIKBwYPI4ExA4INTSWBbAqBRFAQFIFpjkwhM4E?=
 =?us-ascii?q?IjhOCVAE?=
X-IPAS-Result: =?us-ascii?q?A2FXAwDkk5ddh8jWVdFmgh6DXkwQjSSGMQaLJxhxhXqIM?=
 =?us-ascii?q?4F7AQgBAQEMAQEtAgEBhECCSiM1CA4CAwkBAQUBAQEBAQUEAQECEAEBAQgNC?=
 =?us-ascii?q?QgphUCCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWifoEDPIwlM4hmAQkNgUgJA?=
 =?us-ascii?q?QiBIoc1hFmBEIEHg25zhA2DWIJEBIE3AQEBlSuWUgEGAoIRFIF4kxQnhDyJP?=
 =?us-ascii?q?4tEAS2nLwIKBwYPI4ExA4INTSWBbAqBRFAQFIFpjkwhM4EIjhOCVAE?=
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="80713781"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2019 11:51:22 -0700
Received: by mail-pl1-f200.google.com with SMTP id y2so4459578plk.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nx7Raw+8VvaKmHv7iUq+/mNfi5w+U2K2Q09elPzOslc=;
        b=QT/z2Fm9lXCgjt6h6+BDpvP6gLKu0iXH5ok7jT6KH/QISIlphZkTBR89bfw+p6Dcx+
         Aab3JbHJdMgUh1ECSPNZ2OseyQO6u+xI/hHFZPbV2NfFl/+5OJIcmkxuydY+usk9Xgkx
         GGVQ6rrAzzzRekp5P0hwFG+FS5KF08Kmlg0iSQVeUVuoK0fbshRifuNaDMHj4mGqzD6X
         851fXiTM35qYVFKHLrEEHQ8Cm2HELB8i5SFUCr41YuyO5neZ21dEJaerIz7l0s8teW0G
         FG1euGYsdiFq2XySnEEZ19rRKfCihHzIwtFJ68DhHTt2TUubgGKLhylkyxhA1tj/6xg8
         R8iA==
X-Gm-Message-State: APjAAAUzy/Cfnv64dctEHf3QaTOnk8U3kXLOgpWf+UveFo6l7RoNy6P7
        Q4EetFa4a15/xn2yIOTpPAQYR8E05h5GusVVkk3sqQoxCYdkyzEJI3DozC6M//CblpRvGsWe8nG
        qWuRoWFz4uvzWLtd+euNktC2oJg==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr16691791plk.302.1570215080757;
        Fri, 04 Oct 2019 11:51:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5QtwmXyYfQo5M6IJC7lIS0EJ1qWyQ73hBNC1cEHpkJbeVfKj1RyhZkECc6mcP1X5ruAFGHg==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr16691773plk.302.1570215080459;
        Fri, 04 Oct 2019 11:51:20 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id e192sm8101014pfh.83.2019.10.04.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:51:19 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: snvs: fix uninitialized usage of "lpcr" in snvs_rtc_enable()
Date:   Fri,  4 Oct 2019 11:52:06 -0700
Message-Id: <20191004185206.7466-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function snvs_rtc_enable(), variable "lpcr" could be
uninitialized if regmap_read() returns -EINVAL. However,"lpcr"
is used later in the if statement, which is potentially unsafe.

Similar cases happened in function snvs_rtc_irq_handler() with
variable "lpsr" and function snvs_rtc_read_alarm() with variables
"lptar", "lpsr". The patch for those two are not easy since
-EINVAL is not an acceptable return value for these functions.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/rtc/rtc-snvs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 757f4daa7181..dadcc3e193b2 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -124,12 +124,16 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 {
 	int timeout = 1000;
 	u32 lpcr;
+	int ret;
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_SRTC_ENV,
 			   enable ? SNVS_LPCR_SRTC_ENV : 0);
 
 	while (--timeout) {
-		regmap_read(data->regmap, data->offset + SNVS_LPCR, &lpcr);
+		ret = regmap_read(data->regmap,
+					data->offset + SNVS_LPCR, &lpcr);
+		if (ret)
+			return ret;
 
 		if (enable) {
 			if (lpcr & SNVS_LPCR_SRTC_ENV)
-- 
2.17.1

