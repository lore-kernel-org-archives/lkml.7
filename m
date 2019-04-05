Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81639C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A2A217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SiHV6jnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfDEBVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:21:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13473 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEBU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:20:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190405012055epoutp02bec688efb472c0cb3cafd06f8ed084c4~Sb1p_L_aA0645606456epoutp02Z
        for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2019 01:20:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190405012055epoutp02bec688efb472c0cb3cafd06f8ed084c4~Sb1p_L_aA0645606456epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554427255;
        bh=bhVMELYHYZovoVfQGXFkkHBNAa3/6HjTxbmtCVIWVZM=;
        h=To:Cc:From:Subject:Date:References:From;
        b=SiHV6jnt484BopScIEK3kzQKOXNMGQwZm8z+KN6I0SkEDYM1S2aBI1gVArN2qNBZK
         8Hhw2Zk89fpdEtoBvduALkk2G7r1eIy6muaRiDnu5elwG5D+SKQuEsRYRVgOFo+qOj
         OkdTCmRMcpnqKzvR9rvFBub0O/RfrExqMDv6GIYI=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190405012053epcas1p2d0eee362d547151d94f13c30bf19e563~Sb1niGSZ_3247932479epcas1p2i;
        Fri,  5 Apr 2019 01:20:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.E5.04143.47DA6AC5; Fri,  5 Apr 2019 10:20:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096~Sb1mHxR3B0958709587epcas1p15;
        Fri,  5 Apr 2019 01:20:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190405012051epsmtrp1efddb7f38679cee75d99462fd35d6f8b~Sb1mHGGmT3103131031epsmtrp1b;
        Fri,  5 Apr 2019 01:20:51 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-a2-5ca6ad741c51
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.36.03662.37DA6AC5; Fri,  5 Apr 2019 10:20:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190405012051epsmtip27d958c7767030a4cadb1054701c7a089~Sb1l_8GcP0722807228epsmtip2Y;
        Fri,  5 Apr 2019 01:20:51 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon fixes for v5.1-rc4
Organization: Samsung Electronics
Message-ID: <b0dadf5d-ce6f-3767-3d0e-8972f718938f@samsung.com>
Date:   Fri, 5 Apr 2019 10:21:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvm7J2mUxBo27uSwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iw1P78xF5xjq3h6YQFz
        A+Nx1i5GTg4JAROJJSe6gWwuDiGBHYwSS27sYIZwPjFKbPx2G8r5BpSZ8pwdpmVdz1EmEFtI
        YC+jxLcpNhBF7xklTh45ztbFyMEhIpAp8a6VCSTOLLCEUaJn6llmkAY2AS2J/S9usIHYwgK6
        EosaT7KA2PwCihJXfzxmBLF5BewkVrasYASZwyKgInG6ywckLCoQIfH+6W4WiBJBiZMzn4DZ
        zALiEreezGeCsOUltr+dA3a0hMABNom5b2dC/eki8WTSKyYIW1ji1fEtUM9ISbzsb4OyqyVW
        njzCBtHcwSixZf8FqGZjif1LJzOBHMQsoCmxfpc+xDI+iXdfe1hBwhICvBIdbUIQ1coSlx/c
        hVolKbG4vZMNwvaQ2PbmBdhbQgKxEm+e+kxgVJiF5JtZSL6ZheSbWQh7FzCyrGIUSy0ozk1P
        LTYsMEaO602M4BSpZb6DccM5n0OMAhyMSjy8GkzLYoRYE8uKK3MPMUpwMCuJ8MqtBArxpiRW
        VqUW5ccXleakFh9iNAWG9URmKdHkfGD6ziuJNzQ1MjY2tjAxNDM1NFQS513v4BwjJJCeWJKa
        nZpakFoE08fEwSnVwKh3WTFVQF6rozDkMcu3ivQH8QznVv+e4Zg1T6tByPH+gie/VVJbv1ZZ
        JS7IvxdkXFq8mnGZgNyZdbFFq/jZYj/btPTaJ22pvmmdayqecmznnuovMWdmuHW2lgcypDrx
        Lro+fY28/4w5gn9nXxXhXMPf+oS7Vmdp4/6unW83sx1gbytx8XnHocRSnJFoqMVcVJwIACu0
        bGinAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvG7x2mUxBgfeqltMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GWt+fmMuOMdW8fTCAuYGxuOsXYycHBICJhLreo4ydTFycQgJ7GaUuDRpITNEQlJi2sWjQDYH
        kC0scfhwMUTNW0aJ9o67TCA1IgKZEhM7trCCJJgFljBKLP/fwgiSYBPQktj/4gYbiC0soCux
        qPEkC4jNL6AocfXHY7AaXgE7iZUtKxhBFrAIqEic7vIBCYsKREjcvfiCBaJEUOLkzCdgNrOA
        usSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDgLScssJC2zkLTMQtKygJFlFaNkakFxbnpusWGB
        UV5quV5xYm5xaV66XnJ+7iZGcPhrae1gPHEi/hCjAAejEg9vA8uyGCHWxLLiytxDjBIczEoi
        vHIrgUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoY05TX
        zZrCeW9vYXB23F6Hjy3x++Uki7mNJ8wJsln87Kh86ZNzIvOmzCxiP33ymZne0aapIbzfIsMn
        dU9RaAuYdVezInBP+PK6ukS7U7oRPMKivEL1zzxV/k/dKt8juPFLpSKTbEoKj/9Mxw02cy66
        abz0716+8HPI3XsH9C4IZbhuK3WT8GhWYinOSDTUYi4qTgQABzLNiHsCAAA=
X-CMS-MailID: 20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096
References: <CGME20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-fixes pull request for v5.1-rc4. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-5.1-rc4

for you to fetch changes up to 86baf800de84eb89615c138d368b14bff5ee7d8a:

  extcon: ptn5150: fix COMPILE_TEST dependencies (2019-04-05 10:08:37 +0900)

----------------------------------------------------------------
Arnd Bergmann (1):
      extcon: ptn5150: fix COMPILE_TEST dependencies

 drivers/extcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
