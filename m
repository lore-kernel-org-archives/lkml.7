Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FEB20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F+VcR4+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfDACbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:31:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:56940 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfDACbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:31:08 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190401023104epoutp04da2fa56f566bb9e431c3a560bd995478~RONwnpBmJ0977309773epoutp04u
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 02:31:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190401023104epoutp04da2fa56f566bb9e431c3a560bd995478~RONwnpBmJ0977309773epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554085864;
        bh=p215Nw9ojHoHyStauLGQUl59d9hLA/l+1GdV84x/O9A=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=F+VcR4+Dgxn7DU+UpL282c0J5W0381jxM/RWis0DpE4iF34rm+X/cpLU5NvHuFsxz
         kHINVbNgMv3kCB9XHbzn7z1wtwLjvIHOm5+QatOBq0099Q5w051Vfo7lnPFxU4CQ9M
         CkscZaWIP4iyMyjh75i1leJRSgm8xR2XIbSkyoTo=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190401023056epcas1p1ec2fe7f2d7af9adf14a5c61743c95b68~RONpUMv870160301603epcas1p1h;
        Mon,  1 Apr 2019 02:30:56 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-e6-5ca177d72ad0
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.67.04142.7D771AC5; Mon,  1 Apr 2019 11:30:47 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 2/4] opp: add API which get max freq by voltage
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190401023047epcms1p888e2dba45fcbc1de98d71d8a37acb976@epcms1p8>
Date:   Mon, 01 Apr 2019 11:30:47 +0900
X-CMS-MailID: 20190401023047epcms1p888e2dba45fcbc1de98d71d8a37acb976
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmnu718oUxBtMuK1hsX/+C1eLlIU2L
        61+es1rMP3KO1eLbnd9MFmeb3rBbbHp8jdXi8q45bBaXmy8yWnzuPcJosfT6RSaLphZjizOn
        L7FatO49wm4x/a6QxcavHg4CHmvmrWH02DnrLrvHplWdbB53ru1h89i8pN6j5eR+Fo8tV9tZ
        PPq2rGL0+LxJLoAzKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+gFJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5y
        fq6VoYGBkSlQYUJ2xqpPO9kL7rNXzP/XxdjAuIeti5GDQ0LAROLzlIouRi4OIYEdjBLNF9aw
        gMR5BQQl/u4Q7mLk5BAWcJO4MeMTC4gtJKAk0XBzHzNEXF+i48E2RhCbTUBXYuuGuywgc0QE
        5jBJnDi0AsxhFvjNLNH+5QA7SJWEAK/EjPanLBC2tMT25VvBujkFfCV+HPkJVSMqcXP1Wzj7
        /bH5jBC2iETrvbPMELagxIOfuxlh5syY8h9qZrXEtemL2UEWSwi0MEr0rp4CVaQvcWbuSTYQ
        mxdo2dkVM8EWsAioSny9t4YJosZFonfFObAaZgF5ie1v5zCDQoJZQFNi/S59mPsbNv5mR2cz
        C/BJvPvawwoT3zHvCdRINYlDu5dA1ctInJ6+EOp+D4m+FR9YJzAqzkKE9Swki2chLF7AyLyK
        USy1oDg3PbXYsMAIOXY3MYKTs5bZDsZF53wOMQpwMCrx8CowLIwRYk0sK67MPcQowcGsJMJ7
        pn9BjBBvSmJlVWpRfnxRaU5q8SFGU6D/JzJLiSbnAzNHXkm8oamRsbGxhYmhmamhoZI473oH
        5xghgfTEktTs1NSC1CKYPiYOTqkGxvoFJSK+fDmKwa8u9/1K39NtfMH5r8+y7mCpKXP5xFjD
        hVu71a98KG02ELEuPtw6uyJ7Ztyt2THeXBk2UQ5xuVyW1xK1dC2dl89xzeWJVP0bUrnk74mZ
        8TZfzoZuiXiffGiTXyKXjezJIOmXbq93vbf/P69N5tzt267XLQpmOZiu2XS+Y0aEEktxRqKh
        FnNRcSIAKOOq9+QDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190329064632epcas2p4d10ea099bfea4ad682d7312a75bfbe68
References: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
        <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190329064632epcas2p4d10ea099bfea4ad682d7312a75bfbe68@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This API will get voltage as input parameter.
>Search all opp items for the item which with max frequency,
>and the voltae is smaller than provided voltage.
>
>Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>---
> drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
> include/linux/pm_opp.h |  8 ++++++++
> 2 files changed, 63 insertions(+)
>
>diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>index 24c757a..57deef9 100644
>--- a/include/linux/pm_opp.h
>+++ b/include/linux/pm_opp.h
>@@ -102,6 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
> 
> struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
> 					      unsigned long *freq);
>+struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
>+					      unsigned long u_volt);

For the symmetricity, wouldn't it be better to name it
dev_pm_opp_find_volt_ceiling(dev, u_volt); ?

Cheers,
MyungJoo


