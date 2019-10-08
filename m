Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF1C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA72070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dUwJpYxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfJHRbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:31:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34495 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfJHRbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:31:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191008173058euoutp026b3f94a8c5edc405f9589070e6f4891d~LvDt7pdfn0090700907euoutp028
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 17:30:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191008173058euoutp026b3f94a8c5edc405f9589070e6f4891d~LvDt7pdfn0090700907euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570555858;
        bh=1andqKfOFGQItmqD6T1v34f5NE14TvB9mAiT5Q9ZwA0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dUwJpYxOQw1YeUo8xuc9Sf7ZalaUXCcfMj3ZEeyNTB5RMdFE08MZo6vyztCjcVl28
         5EguX3+oV9SZ0QfmL60AdYYImnPcOfe146NweD8z5djRT9WyNNYjlRNgC4k+j6mi6X
         wrxhiRGI6fG8ftnnBG/4/V2L4BPJ/BSCJyJ28IC0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191008173058eucas1p10315dfbb5e10619d614d477de5a1f1c1~LvDtxeo6e0487004870eucas1p1d;
        Tue,  8 Oct 2019 17:30:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.87.04309.2D7CC9D5; Tue,  8
        Oct 2019 18:30:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191008173058eucas1p2545297c2f5920c4e935334cc29d54244~LvDtWJByp2973029730eucas1p2M;
        Tue,  8 Oct 2019 17:30:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191008173058eusmtrp258149df40795bab03dc3a0f10d6bf8df~LvDtVgUe41415214152eusmtrp2M;
        Tue,  8 Oct 2019 17:30:58 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-20-5d9cc7d2d877
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.9F.04166.1D7CC9D5; Tue,  8
        Oct 2019 18:30:58 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191008173057eusmtip2f0e04e97fc013b33574c6f65da7db2dc~LvDs0YsbP2048920489eusmtip2P;
        Tue,  8 Oct 2019 17:30:57 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: s3c64xx: Fix init order of clock providers
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <ceede424-e4a2-03f1-3ce0-04f405688721@samsung.com>
Date:   Tue, 8 Oct 2019 19:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008165917.23908-1-krzk@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3f3Y3WpynYoPVmZLCINcmtWgUAupiQX2IyrD7JY3FZ3Krloz
        KEkz50wkidWcaGa1VprOWKZRodYQI0vTWUmuNBiG/lDDlqbprpL/znnOeZ/zHHgpTHqb8KNS
        0rNYdTqTJiPFuPWNq3trj80Yv63eHqCo6nhHKLq7G4QKy3A/oehtMZKKm90vBIpvJRVkJKm0
        mLWksqn2krLppxNTTlr8Y/E48Z5ENi0lh1XLw0+Jk12mPiLTSZ43OS1EHuojipGIAjoMRg1a
        rBiJKSltQvC3YA7xZArBHaeL4MkkgorhcXz5ySO7bUm4j6ChpmuJjCForXS4XV50NBQUlGOL
        2JuOgZbpfHcIRl9F8La3zi2QdAhce12KFrGEDgdtnoNcxDgdCOUDg26PD30MJhztBO/xhM5b
        I+4AEb0DLAWfhYsYo33h8tQDgscb4OmY0R0GdI0QrGbLgkAtkCiof3WUr+AFo7YnQh6vg/ln
        VQLen4+gpPWLkCdlCIZs1Yh37YZ22wf3IowOgsctcn68F34M2Ul+vwcMjHnyN3jAdase48cS
        KCqU8u5AmDHrBTz2A93IPF6GZIYVzQwr2hhWtDH8z61GuBn5stmcKonlQtPZc8Eco+Ky05OC
        z2SoLGjh43TN2aaaUcvs6TZEU0i2RhKZa4yXEkwOp1G1IaAwmbekxrAwkiQymlxWnZGgzk5j
        uTa0lsJlvpILqxwnpHQSk8Wmsmwmq15WBZTILw+FRhUebhT1DMRoM983HpJsl8s1/kE+mw58
        f3nwky424itZWy14OF0OHKszRF+8sbp1dJdu576IP6keyE7MbvwY0MxM373XP2gaLtWvj4oV
        dRZWFj0PS7hycnLkyPH9Ln/9L6c0bsSpCTs7btsc7aqHeXP+TH1n3W+fiTmrRNkhw7lkJmQL
        puaYf9HRWJ40AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7qXjs+JNVi4nNFi/pFzrBbnz29g
        t9j0+BqrxeVdc9gsZpzfx2TxsGc2mwObx6ZVnWwem5fUe2x+/YLZ4/MmuQCWKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mnyuusha8YKtY8WIT
        awPjVdYuRk4OCQETiTXXjwPZXBxCAksZJQ6fnsHUxcgBlJCSmN+iBFEjLPHnWhcbRM1rRon5
        cxuZQRLCAp4SLS2TwWwRAW+JXd+bmUGKmAXaGSX63/1hhujoYJS4vuoBG0gVm4ChRO/RPkYQ
        m1fATqKzASLOIqAiMfnGHbBJogIREod3zIKqEZQ4OfMJC4jNKWAqsanlFjuIzSygLvFn3iVm
        CFtcounLSlYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L
        10vOz93ECIywbcd+bt7BeGlj8CFGAQ5GJR5eh6o5sUKsiWXFlbmHGCU4mJVEeBfNAgrxpiRW
        VqUW5ccXleakFh9iNAV6biKzlGhyPjD680riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRm
        p6YWpBbB9DFxcEo1MEZ4HRNauuDQWXPzt5f3T2gwSNV45xRwU/L3U02nOPXQ7K5XT7PU9U2N
        dywUCxdTlNMWz71/+7eH/irXuOuL0tcFTWiUFfi+4zHnUyXOi4U+XaqfWy/O/BboEeVnnvdF
        jr3CdR7Hyt1JadkvH2Zw7FdVLjNZmRhnzLXZ9wDXedFZXW6/dkg9U2Ipzkg01GIuKk4EAIfK
        gxDGAgAA
X-CMS-MailID: 20191008173058eucas1p2545297c2f5920c4e935334cc29d54244
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008165931epcas3p2dd2937d851ed06948dd7746e5a2674b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008165931epcas3p2dd2937d851ed06948dd7746e5a2674b4
References: <CGME20191008165931epcas3p2dd2937d851ed06948dd7746e5a2674b4@epcas3p2.samsung.com>
        <20191008165917.23908-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/19 18:59, Krzysztof Kozlowski wrote:
> From: Lihua Yao <ylhuajnu@outlook.com>
> 
> fin_pll is the parent of clock-controller@7e00f000, specify
> the dependency to ensure proper initialization order of clock
> providers.

> Fixes: 3f6d439f2022 ("clk: reverse default clk provider initialization order in of_clk_init()")

The patch looks good but I'm not sure above tag points to the right commit.
That commit is just a regression fix for
1771b10d605d26cc "clk: respect the clock dependencies in of_clk_init"
 
How about picking some commit touching the dts files itself, e.g.
a43736deb47d21bd "ARM: dts: Add dts file for S3C6410-based Mini6410 board" ?

> Signed-off-by: Lihua Yao <ylhuajnu@outlook.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
