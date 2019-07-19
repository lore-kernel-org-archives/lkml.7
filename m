Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCC6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9461A2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A5Gv9zEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfGSJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:52:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39832 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:52:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190719095255euoutp01b9933b23a3a6c3878e0d298759624048~yxjqGMkCh1719117191euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:52:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190719095255euoutp01b9933b23a3a6c3878e0d298759624048~yxjqGMkCh1719117191euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563529975;
        bh=24T3A28SosJC8MyaHhiGeUg1hqsvNYUj7VMLtMfMHOE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=A5Gv9zEa+JO5PDr45Ro2GRJqBtFHUR3Q3UhiOLtRv/hReJzqPcB2O+LOIkY6e/oAI
         f+3dUYJidsFkg2fgYaMBajHIUawzClPeHdsMs9Q2ihlVAkY8WuscfHpBlq4tSaBfWw
         KtoyBhKEB4xj+aTT88OeFVKalenHMHIElrePt0PA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719095254eucas1p2b2bb9a402bbce8e847370dc9b6317957~yxjpvEnZE2084820848eucas1p2i;
        Fri, 19 Jul 2019 09:52:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.55.04377.6F2913D5; Fri, 19
        Jul 2019 10:52:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485~yxjo_5ELw2084820848eucas1p2h;
        Fri, 19 Jul 2019 09:52:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719095254eusmtrp23e635a321dba676a9fe289638cd3e1ce~yxjo_Tu-C2986729867eusmtrp2T;
        Fri, 19 Jul 2019 09:52:54 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-e0-5d3192f6facf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3A.04.04140.5F2913D5; Fri, 19
        Jul 2019 10:52:54 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719095253eusmtip1fd8598824a9077f63724d3157d3d42db~yxjonc0TH2663426634eusmtip1G;
        Fri, 19 Jul 2019 09:52:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] phy: core: document calibrate() method
Date:   Fri, 19 Jul 2019 11:52:45 +0200
Message-Id: <20190719095245.17401-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7djP87rfJhnGGtz4qmSxccZ6VosLT3vY
        LC7vmsNmMeP8PiaLRctamS3WHrnL7sDm0bdlFaPH8RvbmTw+b5ILYI7isklJzcksSy3St0vg
        ymia95m14CtnxdJXIQ2MjRxdjJwcEgImEi+m32TsYuTiEBJYwSjx+GEfM4TzhVHi5aFHLBDO
        Z0aJll8n2WFaZhw4wQZiCwksB0psM4fr+LNwJzNIgk3AUKLrbRdYkYiAg8SSpXfYQIqYBdYz
        Sqxc/B1oEgeHsIC5xNNtCSA1LAKqEts3LmEFsXkFbCW29P1ihVgmL7F6wwGwkyQEDrBJrH93
        lBki4SLRvGcLI4QtLPHq+Bao62Qk/u+czwTR0Mwo8fDcWnYIp4dR4nLTDKgOa4nDxy+yglzB
        LKApsX6XPkTYUWL7xDYWkLCEAJ/EjbeCIGFmIHPStunMEGFeiY42IYhqNYlZx9fBrT144RLU
        aR4Stzs/M0ECKFaifddqpgmMcrMQdi1gZFzFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kR
        GO2n/x3/soNx15+kQ4wCHIxKPLwBuQaxQqyJZcWVuYcYJTiYlUR4b7/UjxXiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAKJEmzr8+nmuvYmFluo3JrjXe
        7L2mPCULni1YOvHUm332ohG1MspxRwL7W1rzA7aye7dekLPXZ9dwfrZ588O4TQa/RVjenjgl
        f2jT90midhI28y+u16wvv7Cp+0PW9LJVe3TSXmfPetObbOeYpft61Q527tRZFd2S9SZX2x5v
        jgs5nfehSP+AEktxRqKhFnNRcSIAFWpAuvICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsVy+t/xu7rfJhnGGny9yWSxccZ6VosLT3vY
        LC7vmsNmMeP8PiaLRctamS3WHrnL7sDm0bdlFaPH8RvbmTw+b5ILYI7SsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy2ia95m14CtnxdJXIQ2MjRxd
        jJwcEgImEjMOnGDrYuTiEBJYyijx8vU6ZoiEjMTJaQ2sELawxJ9rXVBFnxglriz6zwSSYBMw
        lOh6C5Lg5BARcJLoXHsarIhZYCOjxNOdVxm7GDk4hAXMJZ5uSwCpYRFQldi+cQnYUF4BW4kt
        fb+gFshLrN5wgHkCI88CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgUG27djPLTsYu94F
        H2IU4GBU4uENyDWIFWJNLCuuzD3EKMHBrCTCe/ulfqwQb0piZVVqUX58UWlOavEhRlOg5ROZ
        pUST84ERkFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbFgjRc/
        +86Fh9eWW1b++dO77fjcuwKrVkhrfnNvt/VZafYgw3HGidM3fef9KFc0mJapuz/lStK22NlP
        d7wR3LDJRT7k5UGnBZuEJacX3Kzpm8X1aXJ6ec9SViHTJKEUo/JfhWy8hY8PXJbZenRuVFDy
        bF9etc3nol/8nh/KwFK3bsu3eceUb6xTYinOSDTUYi4qTgQAcVtSdUgCAAA=
X-CMS-MailID: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
References: <CGME20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 36914111e682 ("drivers: phy: add calibrate method") added support
for generic phy_calibrate() method, but it didn't explain in detail when
such method is supposed to be called. Add some more documentation directly
to the phy.h to make it clean that it is intended to be called after every
host controller reset.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/phy/phy.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f145063..46775e8b0ed9 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -101,6 +101,18 @@ struct phy_ops {
 	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
+
+	/**
+	 * @calibrate:
+	 *
+	 * Optional.
+	 *
+	 * Used to calibrate phy, typically by adjusting some parameters
+	 * in runtime, which are otherwise lost after host controller
+	 * reset and cannot be set in phy_init() and phy_power_on().
+	 *
+	 * Returns: 0 if successful, an negative error code otherwise
+	 */
 	int	(*calibrate)(struct phy *phy);
 	void	(*release)(struct phy *phy);
 	struct module *owner;
-- 
2.17.1

