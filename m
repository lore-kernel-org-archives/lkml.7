Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648AAC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359B3206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PgSJLnrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfJHMBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:01:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35147 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:01:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191008120117euoutp01b1f320022a4bfe35b79a5835eae2a3ea~Lqj3QeTwl1455714557euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 12:01:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191008120117euoutp01b1f320022a4bfe35b79a5835eae2a3ea~Lqj3QeTwl1455714557euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570536077;
        bh=29kiwqVOEaiKlMxTYLYcsXxmyGzt/l2voELEUoFOCR8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PgSJLnrSr1e/KHhEq7QXzClJogEOY9SKt5lGvnbmoHAtHSQDMOx7T8GLilOHzNta7
         6gWfik5HYW7qaWNcG9UQh3CN/sONLcf3NjQrCWkd3rpzInhPcN+xaTcMqIYvAuyPVu
         OA7SD8+nUuSXk5Y5aT6ux148IRbuQMxmHCkXlFIo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191008120117eucas1p24da17d2002057bcbe401ea23f4a36cae~Lqj20NzTF0092000920eucas1p23;
        Tue,  8 Oct 2019 12:01:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.35.04374.C8A7C9D5; Tue,  8
        Oct 2019 13:01:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191008120116eucas1p2b0f2d2cbb230ca77b388b1d2530a1703~Lqj2cj7e00093200932eucas1p29;
        Tue,  8 Oct 2019 12:01:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191008120116eusmtrp1bb48ba15bdfb853306c3593cf13bea24~Lqj2b5Pud2889428894eusmtrp1X;
        Tue,  8 Oct 2019 12:01:16 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-10-5d9c7a8cd848
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.A2.04117.C8A7C9D5; Tue,  8
        Oct 2019 13:01:16 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191008120116eusmtip183663f56246c99fdabd1de4356c94c25~Lqj2A4SN70181301813eusmtip1I;
        Tue,  8 Oct 2019 12:01:16 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
Date:   Tue, 8 Oct 2019 14:01:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008115025.GF4382@sirena.co.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87q9VXNiDX7WWmycsZ7VYurDJ2wW
        qz8+ZrQ4f34Du8WDuTeZLL5d6WCyuLxrDpvFjPP7mBw4PHbOusvusWlVJ5tH/18Dj74tqxg9
        Pm+SC2CN4rJJSc3JLEst0rdL4Mp4sfY3Y8FB4Yrm7++YGxgnC3QxcnJICJhInNh/kKmLkYtD
        SGAFo8Shb2fYQRJCAl8YJfo2GEIkPjNKnJ5xhRmmY13XDWaIxHJGiaMXD0E5bxklDm89BdYu
        LJAmMenVFxYQW0RAWeLq970sIEXMAlOZJB78/MYIkmATMJToetvFBmLzCthJnN99DyzOIqAi
        sXTffSYQW1QgVuLej+PMEDWCEidnPgEbygnUe7T1OSuIzSwgL7H97RxmCFtc4taT+WAPSQjs
        Y5e4s2UiI8TdLhKHpk1kgbCFJV4d38IOYctInJ7cwwLR0Mwo8fDcWnYIp4dR4nLTDKhua4nD
        xy8CreMAWqEpsX6XPogpIeAo0bImBcLkk7jxVhDiBj6JSdumM0OEeSU62oQgZqhJzDq+Dm7r
        wQuXmCcwKs1C8tksJN/MQvLNLIS1CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSm
        otP/jn/dwbjvT9IhRgEORiUeXgdgihJiTSwrrsw9xCjBwawkwiu3dEasEG9KYmVValF+fFFp
        TmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsZ6xd3a3tvD3/LdmeUudl5z9qmY
        db1hC4/7BAYr5c6c8Uh1x+buyd9CXNQPH/3h/TLw0gKZ84uELVmb1xye8jPn2uPgOcxpO9/s
        TZimsD7Pr0j2AkexOcv6x0KXnoRu3yA7xW5Z9psHua1/BWPqjYXmZX5KCqktrtsTkLzoRI3W
        TAU+gaBFKhlKLMUZiYZazEXFiQBBVwamQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7o9VXNiDc7fULbYOGM9q8XUh0/Y
        LFZ/fMxocf78BnaLB3NvMll8u9LBZHF51xw2ixnn9zE5cHjsnHWX3WPTqk42j/6/Bh59W1Yx
        enzeJBfAGqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CX8WLtb8aCg8IVzd/fMTcwThboYuTkkBAwkVjXdYO5i5GLQ0hgKaPEuzd9LBAJGYmT0xpY
        IWxhiT/Xutggil4zSnw+/JkRJCEskCZx//BjMFtEQFni6ve9LCBFzAJTmSQ27d7KDpIQEtjB
        KLHuuRSIzSZgKNH1FmQSJwevgJ3E+d33wJpZBFQklu67z9TFyMEhKhArsWmvGUSJoMTJmU/A
        DuIEaj3a+hzsIGYBM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sq
        RpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOjbduznlh2MXe+CDzEKcDAq8fA6AKNSiDWxrLgy
        9xCjBAezkgiv3NIZsUK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0wMeSXxhqaG5haWhubG
        5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGE9ZtuZEHXpRVnRy+jpjm2tVjBnsRRv+
        zjVsv8DOMmnKhR+c026tvmC6pdS0q5NNTqxGcXLopWLxgGalw6rKqyXXTXhyX3+nX9TG3Hq+
        n0fLLJ5MWxkZz3H0ao7/j9s1pyq+rhc8x3xqwjafLrE1d3i8jgqdv/aK6feSBUcVlzxelaHO
        MrFu3nklluKMREMt5qLiRAA6XMZw1AIAAA==
X-CMS-MailID: 20191008120116eucas1p2b0f2d2cbb230ca77b388b1d2530a1703
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
        <20191008101709.13827-1-m.szyprowski@samsung.com>
        <20191008115025.GF4382@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 08.10.2019 13:50, Mark Brown wrote:
> On Tue, Oct 08, 2019 at 12:17:09PM +0200, Marek Szyprowski wrote:
>> Commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators
>> locking"), regardless of the subject, added additional call to
>> regulator_balance_voltage() during regulator_enable(). This is basically
>> a good idea, however it causes some issue for the regulators which are
>> already enabled at boot and are critical for system operation (for example
>> provides supply to the CPU).
> If regulators are essential to system operation they should be marked as
> always-on...

The are marked as always on:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos5800-peach-pi.dts#n253

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos5800-peach-pi.dts#n265

>> CPUfreq or other drivers typically call regulator_enable() on such
>> regulators during their probe, although the regulators are already enabled
>> by bootloader. The mentioned patch however added a call to
>> regulator_balance_voltage(), what in case of system boot, where no
>> additional requirements are set yet, typically causes to limit the voltage
>> to the minimal value defined at regulator constraints. This causes a crash
>> of the system when voltage on the CPU regulator is set to the lowest
>> possible value without adjusting the operation frequency. Fix this by
>> adding a check if regulator is already enabled - if so, then skip the
>> balancing procedure. The voltage will be balanced later anyway once the
>> required voltage value is requested.
> This then means that for users that might legitimately enable and
> disable regulators that need to be constrained are forced to change the
> voltage when they enable the regualtors in order to have their
> constraints take effect which seems bad.  I'd rather change the the
> cpufreq consumers to either not do the enable (since there really should
> be an always-on constraint this should be redundant, we might need to
> fix the core to take account of their settings though I think we lost
> that) or to set the voltage to whatever they need prior to doing their
> first enable, that seems more robust.

Well, I'm open for other ways of fixing this issue. Calling enable on 
always-on regulator imho should not change its rate...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

