Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8A8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC39A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g9k6XiBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfJHMjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:39:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57128 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbfJHMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:38:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191008123857euoutp02d071b56861b57cc4ba6ad40436fb0cfb~LrEv-K1ml1639816398euoutp02P
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 12:38:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191008123857euoutp02d071b56861b57cc4ba6ad40436fb0cfb~LrEv-K1ml1639816398euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570538337;
        bh=V4BbM92IgPN1F7h3ef4+UfXL3HknJSrjrDy/wscVA0o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=g9k6XiBrd4mKf7Bn+ujSlrl60Ay0T9raNKq3Xr7LIHmEY0Gr5dTIPXjD6ATQ5jUIa
         uXKJ1zPtu/IHMGWgbkkzx/NrJY/UeOIH7OuJMJVk/lKKtyjw9qIb9CcL+vJaoPS7fy
         tvYgDRUMrbExPkLMYy5ZLNO57XZcW3wt2D0npE34=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191008123857eucas1p1afeed565aa401556191363efc41a9cc5~LrEvk-xEo1784517845eucas1p1W;
        Tue,  8 Oct 2019 12:38:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.5C.04469.0638C9D5; Tue,  8
        Oct 2019 13:38:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191008123856eucas1p2b9536096c0f7a5f84f2232a5a1ca7b01~LrEvRhevX0896008960eucas1p2S;
        Tue,  8 Oct 2019 12:38:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191008123856eusmtrp2ed968efc8dc1c4adc652a3a9fc7d30e9~LrEvQ0Qz02484724847eusmtrp2k;
        Tue,  8 Oct 2019 12:38:56 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-57-5d9c8360072f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.C7.04117.0638C9D5; Tue,  8
        Oct 2019 13:38:56 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191008123856eusmtip2dd1d4901801c5d5a68a9668b90a2542f~LrEuxNrL42907529075eusmtip21;
        Tue,  8 Oct 2019 12:38:56 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
Date:   Tue, 8 Oct 2019 14:38:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008120611.GG4382@sirena.co.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7oJzXNiDRo6rC02zljPajH14RM2
        i9UfHzNaLPg0g9Xi/PkN7BYP5t5ksvh2pYPJ4vKuOWwWM87vY7LY+NXDgctj56y77B6bVnWy
        edy5tofNo/+vgUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlrLj4nrXgIm/F9J1FDYzfuLoY
        OTkkBEwkdi3qYu5i5OIQEljBKNHRPJcNwvnCKDGh+xmU85lRYvbtWYwwLRdO7WeESCxnlLix
        4BErhPOWUWJ+w3cWkCphgTSJSa++gNkiAsoSV7/vZQEpYhZ4xSTR+mUdK0iCTcBQouttFxuI
        zStgJ3Hq3E/2LkYODhYBFYlX9zJAwqICsRL3fhxnhigRlDg58wnYTE6g1mnvHoK1MgvIS2x/
        O4cZwhaXuPVkPhPILgmBc+wSV9YfY4M420ViTdsWZghbWOLV8S3sELaMxP+dMA3NjBIPz61l
        h3B6GCUuN82Aetpa4vDxi6wg1zELaEqs36UPYkoIOEq0rEmBMPkkbrwVhLiBT2LStunMEGFe
        iY42IYgZahKzjq+D23rwwiXmCYxKs5B8NgvJN7OQfDMLYe0CRpZVjOKppcW56anFhnmp5XrF
        ibnFpXnpesn5uZsYgWnq9L/jn3Ywfr2UdIhRgINRiYfXoWpOrBBrYllxZe4hRgkOZiURXrml
        M2KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MAqJndcz
        2eWV06qxj+e0+3TnO92bmyq2Ce1lNn2w5ErBhcXXnTTzwlZO1lji8uCs8KkJk1j45ZtiLxlk
        r9M7IfChbh/D8kc8XEV8/y4d/ivgyRwdvWext7Ch/4vMoNlldkejlUJWux0wuXw8cMr3CNnJ
        /4/etinhEN20lOfJCRdbJyePlybn25VYijMSDbWYi4oTAZqrQUlPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7oJzXNiDXpeqlpsnLGe1WLqwyds
        Fqs/Pma0WPBpBqvF+fMb2C0ezL3JZPHtSgeTxeVdc9gsZpzfx2Sx8auHA5fHzll32T02repk
        87hzbQ+bR/9fA4++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLWHHxPWvBRd6K6TuLGhi/cXUxcnJICJhIXDi1n7GLkYtDSGAp
        o8SzBxeZIBIyEienNbBC2MISf651sYHYQgKvGSVmX7IFsYUF0iTuH37MCGKLCChLXP2+lwVk
        ELPAGyaJ5Zv+Qk2dwiTRf7UNbCqbgKFE11uISbwCdhKnzv1k72Lk4GARUJF4dS8DxBQViJXY
        tNcMokJQ4uTMJywgNidQ57R3D8E6mQXMJOZtfsgMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFp
        mYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3LbsZ9bdjB2vQs+xCjAwajE
        w+tQNSdWiDWxrLgy9xCjBAezkgiv3NIZsUK8KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wY
        eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGP1nP5GY+32T34a9
        Bw1Eylx6OzcYTHihtPjN/t1LQzhfFBTqZfdrVs4OMtgZ7Ze6seOc0YnGqzdOPzVv+fc5lp9T
        OPjwzkTZzjf2G09fubHN6dr+nffTuvOWi+zNSb8YfZB7+0SvgLWLzEv1dHpFqzv/iHxRn5LH
        Mak6eKvyx4UHNyRUd+zh/6rEUpyRaKjFXFScCADujN2J4AIAAA==
X-CMS-MailID: 20191008123856eucas1p2b9536096c0f7a5f84f2232a5a1ca7b01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
        <20191008101709.13827-1-m.szyprowski@samsung.com>
        <20191008115025.GF4382@sirena.co.uk>
        <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
        <20191008120611.GG4382@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 08.10.2019 14:06, Mark Brown wrote:
> On Tue, Oct 08, 2019 at 02:01:15PM +0200, Marek Szyprowski wrote:
>> On 08.10.2019 13:50, Mark Brown wrote:
>>> This then means that for users that might legitimately enable and
>>> disable regulators that need to be constrained are forced to change the
>>> voltage when they enable the regualtors in order to have their
>>> constraints take effect which seems bad.  I'd rather change the the
>>> cpufreq consumers to either not do the enable (since there really should
>>> be an always-on constraint this should be redundant, we might need to
>>> fix the core to take account of their settings though I think we lost
>>> that) or to set the voltage to whatever they need prior to doing their
>>> first enable, that seems more robust.
>> Well, I'm open for other ways of fixing this issue. Calling enable on
>> always-on regulator imho should not change its rate...
> Yes, although there is the whole "don't touch things until a consumer
> tells us to" thing going on.  I had expected that this was kicking in
> because we weren't paying attention to the constraints of disabled
> regulators but I can't see the code implementing that any more so I
> guess we removed it at some point (it was always debatable).

Then if I get it right, the issue is caused by the commit 7f93ff73f7c8 
("opp: core: add regulators enable and disable"). I've checked and 
indeed reverting it fixes Peach Pi to boot properly. The question is if 
this is desired behavior or not?

I've CC: Viresh, Kamil and Bartlomiej, here is the link to the beginning 
of this thread:

https://lkml.org/lkml/2019/10/8/265

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

