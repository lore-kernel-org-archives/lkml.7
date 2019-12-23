Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BAC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 00:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C742C206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 00:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oUnepm1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLWAj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 19:39:28 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:52551 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLWAj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 19:39:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191223003925epoutp020bae17def5bdbac8164b9d6ee9f4c20c~i2SNJlM2y1496614966epoutp02Q
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 00:39:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191223003925epoutp020bae17def5bdbac8164b9d6ee9f4c20c~i2SNJlM2y1496614966epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577061565;
        bh=A0qyH1Pt3ssgrcHMjqA2FH+JelElbtNnYWsoeXN2zs8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oUnepm1TOQO26R6XRB+YsJvNHJQQq7jE2Pyv7MvTZnIGGCuHgjcNqAAIcTlcxi8nY
         dFXmLcx/cLf4cGDxCMxJqRqMGrT5nBlpymmlwUpS3K0L2HeZUS4fpk2Eu3Zl+gGSYl
         yvZ3gVNb2r5g9NqQy5WwomrFNTWN2sZNiKx1b3KE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191223003924epcas1p2d7100ef1212559343eff440f96bf3e9e~i2SMcP1-j2951929519epcas1p2m;
        Mon, 23 Dec 2019 00:39:24 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47h0px3StGzMqYkg; Mon, 23 Dec
        2019 00:39:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.C9.48498.8BC000E5; Mon, 23 Dec 2019 09:39:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191223003919epcas1p2f2035e39b9afe60f880bef5929fe3924~i2SICTarQ2951929519epcas1p2S;
        Mon, 23 Dec 2019 00:39:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191223003919epsmtrp256bbc266c2fb848bca9b753c26ea9980~i2SIBt4cq1173511735epsmtrp2O;
        Mon, 23 Dec 2019 00:39:19 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-55-5e000cb8378a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.3E.06569.7BC000E5; Mon, 23 Dec 2019 09:39:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191223003919epsmtip166b598df44c58ce9f58d77c38222a1e7~i2SHzQKsI2548725487epsmtip1D;
        Mon, 23 Dec 2019 00:39:19 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3] PM / devfreq: exynos-bus: Disable devfreq-event device
 when fails
Date:   Mon, 23 Dec 2019 09:46:03 +0900
Message-Id: <20191223004603.7849-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7bCmvu4OHoY4gwX/dCyuf3nOanG26Q27
        xeVdc9gsPvceYbS43biCzWLu7wlsDmweO2fdZffo27KK0ePzJrkA5qhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IzulTcZC3ZwVmxtm8He
        wPiOvYuRk0NCwETi9fUJjCC2kMAORokzswq6GLmA7E+MEl0901ggEt8YJba/54RpeNb5kw2i
        aC+jxIVth6CcL4wS+y4cAetgE9CS2P/iBhuILSIgIzH1yn5WkCJmgSmMEm2nesGKhAXCJe6e
        6WPqYuTgYBFQlXi/qw4kzCtgKbF3yVU2iG3yEqs3HGAG6ZUQ+Mgq0bHoB9TdLhKNt76xQNjC
        Eq+Ob4GKS0l8frcXqrlaYuXJI2wQzR2MElv2X2CFSBhL7F86GWwxs4CmxPpd+hBhRYmdv+eC
        w4JZgE/i3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO6FWeUh0HmqChlasxL6bF5gnMMrO
        QliwgJFxFaNYakFxbnpqsWGBEXIkbWIEJyUtsx2Mi875HGIU4GBU4uHlmPU/Vog1say4MvcQ
        owQHs5II7+7av7FCvCmJlVWpRfnxRaU5qcWHGE2BgTeRWUo0OR+YMPNK4g1NjYyNjS1MDM1M
        DQ2VxHk5flyMFRJITyxJzU5NLUgtgulj4uCUamCM3+2xdaVhjJNwhvl8F5t6VrMfi5btqnjm
        9HiBXHOWx+6HQhUmcg2uuZu7HJlU5C2el1ZMnuaz69Z1R9c/S08dv7nZ+HfJbBljnVvlx78o
        OpUa6FueMy/0vh2x6whDSPPjbbcuBJ5acy+tRsV+VxLrr53t27pjPdncuPWEw+Qmrly5fboV
        u5YSS3FGoqEWc1FxIgD2zselYAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSnO52HoY4g/tt8hbXvzxntTjb9Ibd
        4vKuOWwWn3uPMFrcblzBZjH39wQ2BzaPnbPusnv0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        RvfKm4wFOzgrtrbNYG9gfMfexcjJISFgIvGs8ycbiC0ksJtRonOZI0RcUmLaxaPMXYwcQLaw
        xOHDxV2MXEAlnxgllncuYwWpYRPQktj/4gZYr4iAjMTUK/tZQYqYBWYwSkw7vIQFJCEsECqx
        5PUPNpBBLAKqEu931YGEeQUsJfYuucoGsUteYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIDhItrR2MJ07EH2IU4GBU4uHlmPU/Vog1say4MvcQowQHs5II7+7a
        v7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGDv2NETv
        yF3g+9fxieLG7qZ/wd2GOrahfXltHeuu6PMEXVA89DIk81bSYSHJufYMn6/MVtz7tVExiJlF
        rMdHO7AoQ2PBcu76aD5+xn/l6Vc3WJ54K3X3252HV+qvBUxtCw0tZhE42HiB6xuT3BV3j9Ir
        ux9FT/T0en8ibnnjFfMqpSXPnW5cVmIpzkg01GIuKk4EAIln2TwOAgAA
X-CMS-MailID: 20191223003919epcas1p2f2035e39b9afe60f880bef5929fe3924
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191223003919epcas1p2f2035e39b9afe60f880bef5929fe3924
References: <CGME20191223003919epcas1p2f2035e39b9afe60f880bef5929fe3924@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

The exynos_bus_profile_init process may fail, but the devfreq event device
remains enabled. Call devfreq_event_disable_edev on the error return path.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v2:
- Just check the return value of exynos_bus_disable_edev()
  and return the error value before jumped goto.

 drivers/devfreq/exynos-bus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 7f5917d59072..1259a0da7db7 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -335,10 +335,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ret = exynos_bus_set_event(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		return ret;
+		goto err_edev;
 	}
 
 	return 0;
+
+err_edev:
+	if (exynos_bus_disable_edev(bus))
+		dev_warn(dev, "failed to disable the devfreq-event devices\n");
+
+	return ret;
 }
 
 static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
-- 
2.17.1

