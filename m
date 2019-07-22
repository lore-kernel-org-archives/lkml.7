Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79029C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5AA21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BPFPMudH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfGVRGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:06:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46541 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbfGVRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:06:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722170602euoutp023be76a4fc0b9a6f3d4c85453288bf1ef~zyZq8U6UB0606206062euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 17:06:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722170602euoutp023be76a4fc0b9a6f3d4c85453288bf1ef~zyZq8U6UB0606206062euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563815162;
        bh=h9F4Z6mWP2kJFj4GDIDE7XlzqiPz4IWFRNno8xzQMsc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BPFPMudHL1kmW5SlvkKB1T/IC/TO+UUyglQ9KPepRV67IUtxx3wohsFb1UIYYTIae
         X/McN8cBfYoW1dl8HpnLzIn3YwWPOrz1R8Z+9bPVRvrkbkK0Yw1RlaKorcGGUOVXI2
         e/yHEyD782eUd+Mp1fS0+O0Epr04tr7fb/y30S6o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190722170601eucas1p29e2842b5c4434ab9b9fede0c80873fa7~zyZqYH_4r3216432164eucas1p2Z;
        Mon, 22 Jul 2019 17:06:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.2C.04298.9FCE53D5; Mon, 22
        Jul 2019 18:06:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722170600eucas1p165ca6a27805a03b469559e7a4b670b12~zyZpd4xxD2813328133eucas1p1m;
        Mon, 22 Jul 2019 17:06:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722170600eusmtrp1552603ea67c243fa01657608046b11e1~zyZpPzcS22475524755eusmtrp1U;
        Mon, 22 Jul 2019 17:06:00 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-00-5d35ecf9db63
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.7E.04140.8FCE53D5; Mon, 22
        Jul 2019 18:06:00 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190722170559eusmtip1f0bbeb46c0102b7356ce7f3941f01d6b~zyZo936uI1424814248eusmtip1c;
        Mon, 22 Jul 2019 17:05:59 +0000 (GMT)
Subject: Re: drm/exynos: scaler: Reset hardware before starting the
 operation (bug report)
To:     Colin Ian King <colin.king@canonical.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9ceb6d17-6d1b-3d6d-2baa-1a31e57fe21d@samsung.com>
Date:   Mon, 22 Jul 2019 19:05:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c67b4671-aabc-df13-e9c7-ccbc25337b7c@canonical.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87o/35jGGvQ9Ybf4vbqXzWLS/Qks
        Fpd3zWGzmHF+H5MDi8eshl42j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4MpYub2m4B9XxYVf
        TawNjA0cXYycHBICJhKTFn1g6mLk4hASWMEocejkcijnC6PEvUWfoZzPjBIPtnxjh2l5vfQJ
        G0RiOaPE0imfWEASQgJvGSUO3OQDsYUFYiS+3p0P1i0isIRR4tzCj0wgCWYBBYlf9zaxgths
        AoYSXW+72EBsXgE7idnb9wNt4OBgEVCVWNXqDBIWBZqz800PM0SJoMTJmU/AdnEKOEpsXbSW
        EWKkvMT2t3OYIWxxiVtPIPZKCPSzSzxvO8oMcbWLxP2fB5ggbGGJV8e3QH0jI3F6cg8LREMz
        o8TDc2vZIZweRonLTTMYIaqsJQ4fv8gKch2zgKbE+l36EGFHiU+ta9lAwhICfBI33gpCHMEn
        MWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IsJK/NQvLOLCTvzELYu4CRZRWjeGppcW56
        arFhXmq5XnFibnFpXrpecn7uJkZgQjn97/inHYxfLyUdYhTgYFTi4d2wxzRWiDWxrLgy9xCj
        BAezkghvngFQiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dU
        A6PCh7RAs1ohiwnvfzN8ClCblHH3m9FHEU/dlklzXrGL7z9/wJVBbv4yT2mO3xnfcrh3K/95
        bL7xgTHTngfKnjnGveXcNXtbvPML5L0ykuudZkWsOaKaudf7o+zc1IuPxGanGSxrLfjBYdZZ
        8Nf16u/Hq4PiZy7zX3Pi3NFK8Q6RWcYlAv0irEosxRmJhlrMRcWJAJYlzqkkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7o/3pjGGrx7wG0x62U7i8Xv1b1s
        FpPuT2CxuLxrDpvFjPP7mBxYPWY19LJ59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbK7TUF/7gqLvxqYm1gbODoYuTkkBAw
        kXi99AlbFyMXh5DAUkaJ+3OvsUAkZCROTmtghbCFJf5c64Iqes0o0fV1HnMXIweHsECMxNff
        BSA1IgJLGCWmrIgCsZkFFCR+3dvEClE/hVHie/tcsKFsAoYSXW9BBnFy8ArYSczevp8dZA6L
        gKrEqlZnkLAo0Mh9Z7azQ5QISpyc+QSslVPAUWLrorWMEPPNJOZtfsgMYctLbH87B8oWl7j1
        ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI2nbsZ9b
        djB2vQs+xCjAwajEw7thj2msEGtiWXFl7iFGCQ5mJRHePAOgEG9KYmVValF+fFFpTmrxIUZT
        oN8mMkuJJucDozyvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANj
        2tUyk9Y//me2mXqJa8U7H7Wcbrmp6PV0zs2HJodV8RWWPgxdZjujSFxN+VB35SuerRfXW1oG
        H2Qqus//5P72aeeCwh+f0N0x/5ezj8nXkPYmjocPU9lMz95e0CE1a84Kbq6OMws1TMNczSxy
        v1mdPr1o2YKmVexfitUe/4g4NOVCjJzYjVppJZbijERDLeai4kQA0qBy5LoCAAA=
X-CMS-MailID: 20190722170600eucas1p165ca6a27805a03b469559e7a4b670b12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190705160911epcas2p2754c2c703cc6086f7f1715e1840deb1b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190705160911epcas2p2754c2c703cc6086f7f1715e1840deb1b
References: <CGME20190705160911epcas2p2754c2c703cc6086f7f1715e1840deb1b@epcas2p2.samsung.com>
        <c67b4671-aabc-df13-e9c7-ccbc25337b7c@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-07-05 18:09, Colin Ian King wrote:
> Static analysis on today's linux-next has found a potential error in the
> following commit:
>
> commit 280e54c9f614c88292685383cf2d65057586e9fb
> Author: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Date:   Thu Jun 7 13:06:08 2018 +0200
>
>      drm/exynos: scaler: Reset hardware before starting the operation
>
> In the following code the retry counter does not appear to be
> decremented, so potentially the loop could get stuck forever if the H/W
> does not change state:
>
> static inline int scaler_reset(struct scaler_context *scaler)
> {
>          int retry = SCALER_RESET_WAIT_RETRIES;
>
>          scaler_write(SCALER_CFG_SOFT_RESET, SCALER_CFG);
>          do {
>                  cpu_relax();
>          } while (retry > 1 &&
>                   scaler_read(SCALER_CFG) & SCALER_CFG_SOFT_RESET);
>
>          do {
>                  cpu_relax();
>                  scaler_write(1, SCALER_INT_EN);
>          } while (retry > 0 && scaler_read(SCALER_INT_EN) != 1);
>
>          return retry ? 0 : -EIO;
> }
>
> Maybe I'm missing something here subtle.

Right. Indeed there is missing decrementation of the 'retry' variable. I 
suggest to add it to both loops and reset retry value to 
SCALER_RESET_WAIT_RETRIES between them.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

