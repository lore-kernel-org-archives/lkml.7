Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21151C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D220838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TBSJbzMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGJKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:16:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59651 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfGJKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:16:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190710101646euoutp01b204ea7a4a4a069fc3b5130531d82e27~wBE6af-wU0173301733euoutp01d
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:16:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190710101646euoutp01b204ea7a4a4a069fc3b5130531d82e27~wBE6af-wU0173301733euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562753806;
        bh=B4VI75DzOb0316kWv6RhO/oBUVPr+GEuotYGBS3iEu8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TBSJbzMy5kqkW110RVHSPaEdP6o8zk9m8wEDOWDXkanDLxKLNxFilvHPw+mwccGQv
         ccIDgcLh67rMo+bUDOQx8pKmFIkQLqiPlLM7emn8LQf2iC/6lrjGSUAOviXSDM8kty
         OPQbu+Msv+H85J6iEUWTuiOJjV83tCygvCNultjY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190710101645eucas1p2ff4a8f09e430b473ccf8fc703071dbfc~wBE5r1Wad2938829388eucas1p2N;
        Wed, 10 Jul 2019 10:16:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A3.30.04377.D0BB52D5; Wed, 10
        Jul 2019 11:16:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190710101644eucas1p1b45f7baae6aee103a8ee4d0cad6f6c3c~wBE4zZ6Pm1160611606eucas1p1m;
        Wed, 10 Jul 2019 10:16:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190710101644eusmtrp2baf5f104ff72c4e3214f48392dbab250~wBE4lHnOs2639226392eusmtrp2a;
        Wed, 10 Jul 2019 10:16:44 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-8f-5d25bb0db73b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.E0.04146.C0BB52D5; Wed, 10
        Jul 2019 11:16:44 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190710101643eusmtip110f0bb0893c859850ea2c09b582ad2cf~wBE3punTa1539415394eusmtip1R;
        Wed, 10 Jul 2019 10:16:43 +0000 (GMT)
Subject: Re: [PATCH 1/3] opp: core: add regulators enable and disable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <3d6eacb8-ed8d-d4ac-1c36-6224ab88a5dc@partner.samsung.com>
Date:   Wed, 10 Jul 2019 12:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709054014.o3g4e6gbovrq3vvn@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH+/6eu7n2dWV9xGSntmSlML7GDBOXh41hjIWj38pch/uVPMyc
        PPVAyda6a+2u0Gq30F0p8pybUx5OQ4VsTarpCSvGQvz8Mv33+nw+7/c+n/f2EWhNNxsk7DQm
        iyaj3qDlVEz1g+/eCPWN0LionCw1cVqusKR5sIsldvdTluS099DE663gyZO0Xp642ptY8ry2
        kCMDZ9yIWLy3KXLJ/ZYnJc2NFHlztIwjvd+eUOTELTdPfjU5GeL8oiOVbQ+4hRpdua0c6VyO
        DE7X2nST01VePKLLrnIgnaelhtINuCat5jep5seLhp37RNP0BdtUiVcteewer2p/Z2UaZUbv
        hEzkKwCeBWWnq6lMpBI0uAxBc/vQSDGIoMOWg5RiAEHL5Vb6n6X76seRQSmCzvpPI0Ufgof5
        R5Gs8scx8NJe+schCAE4HD68EmUNjb8zUPHcycsaDs+BdzWPKZnVeClkna9kZWZwKLRmpnEy
        j8MbocFtYxTNWKi3vv/Lvngu9Gd9/auncSC8fm+nFA6Gmr5CWl4GOFcAl7Vo5Owl0F/SiBT2
        h25PFa/wRBi+rpgBp0JHcTavmI8jaDv1mVEG8+C+p5GV09B4Klypna60F0F7xn1KbgP2g5a+
        scoNfnCuOp9W2mpIP6lR1BFgG37MKjwBMocvs2eRtmBUsoJRaQpGpSn4v7cIMQ4UKKZISQmi
        NMMopkZK+iQpxZgQuWN3kgv9+cBHvzyD11Dtj+11CAtIO0YNx0PiNKx+n3QgqQ6BQGsD1LeX
        TYnTqOP1Bw6Kpt1bTSkGUapDEwRGG6g+5NO2WYMT9MniLlHcI5r+TSnBN8iMotLi+Jiu9aUr
        8+PbDId7hjxrlt/JY7jtL7JTwxokp6NhxtdvNm9XpFbliC2KCvphPRJdbJ+cYDYnr0g/1jDx
        zcx+VwzqMi955jP0yT47wCfRutDSe+GZIcceFjH+wuK10xw9JXfDrSEQG5xitDhW5VbtDb7X
        uiX4y0/Rto7UbNAyUqI+Opw2SfrfhNBzEH0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7o8u1VjDW5MYrPYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxcavHhabHxxjcxDyWDNvDaPHplWdbB53ru1h89i8pN6j
        b8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXsXXGVNaC81wVzzY3MTUwPuLoYuTkkBAwkXi19T1jFyMXh5DAUkaJb5/b
        2SAS0hKNp1czQdjCEn+udbFBFL1mlDgx+xQzSEJYwFXi6vzlQDYHh4iAlsTLm6kgNcwCv1kk
        9i88D9XQxCSx+9hBsKlsAuYSj7afAZvKK+Am0b1oMyuIzSKgKnGnqwmsRlQgQmLStZ0sEDWC
        EidnPgGzOQUsJd51fwOrZxZQl/gz7xIzhC0ucevJfCYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZ
        SFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIz6bcd+bt7BeGlj8CFGAQ5GJR5eiRaV
        WCHWxLLiytxDjBIczEoivPvclWOFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YkPJK4g1N
        Dc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCWrRO4P1/+VVINJ4/Xjalc
        ZVzTPr/pWnV0lZCGzkFXlX9VLbPVjBbqno/eW2zv/DNsT1tz+uvFLLanM1cs3H5xpmfprJ2z
        1A8UVkRyh7cw3z9mtJF1UQtDa61z1ZsjHzy+dS9R6Qvaf+l5yW6FmO0n+Wd/NLjCV2xwp3Kl
        TY5k7lTnTC91F2MlluKMREMt5qLiRADyK6LrEAMAAA==
X-CMS-MailID: 20190710101644eucas1p1b45f7baae6aee103a8ee4d0cad6f6c3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190708141159eucas1p1751506975ff96a436e14940916623722
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190708141159eucas1p1751506975ff96a436e14940916623722
References: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
        <CGME20190708141159eucas1p1751506975ff96a436e14940916623722@eucas1p1.samsung.com>
        <20190708141140.24379-2-k.konieczny@partner.samsung.com>
        <20190709054014.o3g4e6gbovrq3vvn@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.07.2019 07:40, Viresh Kumar wrote:
> On 08-07-19, 16:11, k.konieczny@partner.samsung.com wrote:
>> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>
>> Add enable regulators to dev_pm_opp_set_regulators() and disable
>> regulators to dev_pm_opp_put_regulators(). This prepares for
>> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  drivers/opp/core.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 0e7703fe733f..947cac452854 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1580,8 +1580,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>>  	if (ret)
>>  		goto free_regulators;
>>  
>> +	for (i = 0; i < opp_table->regulator_count; i++) {
>> +		ret = regulator_enable(opp_table->regulators[i]);
>> +		if (ret < 0)
>> +			goto disable;
>> +	}
> 
> I am wondering on why is this really required as this isn't done for
> any other platform, probably because the regulators are enabled by
> bootloader and are always on.

It was not enabled for historical reasons, from design point regualtors
should be enabled before use.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

