Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F959C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B4C21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TT1WrZOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGDJlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:41:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfGDJlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:41:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fXzc3XCvz9s4Y;
        Thu,  4 Jul 2019 19:41:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562233276;
        bh=KPBAXAj2VjT/jRC79Sr8QAn/rQoLUXTncM1LjP5awKY=;
        h=Date:From:To:Cc:Subject:From;
        b=TT1WrZOH40pU6/TSAxu6tEQOqx0gZe/GZkxYTdZEPH3dqQfDDpZloUBK6pRYDVh0Y
         w4qgwYstT/9SSqp1W9rM99tinlH8cquXhGL+bvUJR+Ap64LHZzaxqTZHgMCmMRm6ND
         unRDKnMXY3imCKEI/z0lNUDQbP8ucrandlxSsZUGDWdVMfkfd1DtcnAg0xupPlWyTR
         GGu0UuxBKedgDi9fSxQhMAapEksWoCz2DYFHbP5WqWGhtG7nWzFe78MC+/5uyzK3o3
         WvomLRxeeATCK8+Hs+oQaLg4a6mZjjTzV0lTs1hHZ08YBjfJ6VtvPLXYXub+VpoIZ1
         ds8LdDPzXatTA==
Date:   Thu, 4 Jul 2019 19:41:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20190704194114.086d6a17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PC+IMRzf5QsJ15+ZcDHtYm3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PC+IMRzf5QsJ15+ZcDHtYm3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

In file included from kernel/power/qos.c:33:
include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
include/linux/pm_qos.h:205:9: error: expected '(' before 'type'
  switch type {
         ^~~~
         (
include/linux/pm_qos.h:205:9: warning: statement with no effect [-Wunused-v=
alue]
  switch type {
         ^~~~
include/linux/pm_qos.h:216:1: warning: no return statement in function retu=
rning non-void [-Wreturn-type]
 }
 ^
include/linux/pm_qos.h: At top level:
include/linux/pm_qos.h:231:4: error: expected identifier or '(' before '{' =
token
    { return 0; }
    ^
In file included from kernel/power/qos.c:33:
include/linux/pm_qos.h:228:19: warning: 'dev_pm_qos_add_notifier' declared =
'static' but never defined [-Wunused-function]
 static inline int dev_pm_qos_add_notifier(struct device *dev,
                   ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commits

  024a47a2732d ("PM / QOS: Pass request type to dev_pm_qos_{add|remove}_not=
ifier()")
  57fa6137402b ("PM / QOS: Pass request type to dev_pm_qos_read_value()")

I applied the following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 4 Jul 2019 19:36:25 +1000
Subject: [PATCH] PM / QOS: fix typos

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/pm_qos.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 17132b10b233..2aebbc5b9950 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -202,7 +202,7 @@ static inline s32 __dev_pm_qos_resume_latency(struct de=
vice *dev)
 static inline s32 dev_pm_qos_read_value(struct device *dev,
 					enum dev_pm_qos_req_type type)
 {
-	switch type {
+	switch (type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	case DEV_PM_QOS_MIN_FREQUENCY:
@@ -227,7 +227,7 @@ static inline int dev_pm_qos_remove_request(struct dev_=
pm_qos_request *req)
 			{ return 0; }
 static inline int dev_pm_qos_add_notifier(struct device *dev,
 					  struct notifier_block *notifier,
-					  enum dev_pm_qos_req_type type);
+					  enum dev_pm_qos_req_type type)
 			{ return 0; }
 static inline int dev_pm_qos_remove_notifier(struct device *dev,
 					     struct notifier_block *notifier,
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/PC+IMRzf5QsJ15+ZcDHtYm3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dyboACgkQAVBC80lX
0Gys4ggAk14ArElBNaBOoFMMOihbwI5iA25Uk96mHMx9116o/HbQCnrt4dp+eNd+
mHzHSGV6OOMU4W4reegSJMXSPhQbAMcTJva+mKsJ4NIt5WmjIURM461odtdBtAWt
lB6ebSTp9MySq7Z/IdmAdZc35Paa49AnY8KNM3WcyMEF4a2DvCFEqMQoRR4YvmVA
mxbaVd+Ng+f2ASuB1C4dtG9rUw70USnEQrewAtcum/G+7YKWphx8t8LBY8pSpQVa
i1s0NfMNH3p+LeQFydSZM/k9QHXP2A0S21UDT2rpukFE40khm6hsQ0Y64Lng9SaT
ZZjMqwO7Pd+Uyv+vjZZ9jcoLZslPuw==
=z5Ri
-----END PGP SIGNATURE-----

--Sig_/PC+IMRzf5QsJ15+ZcDHtYm3--
