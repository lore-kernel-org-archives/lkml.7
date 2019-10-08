Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27714C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0DE2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qGMvm+2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfJHQCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:02:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40297 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfJHQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:02:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191008160209euoutp01841cd8d992d677716d8fe6fb5f0fd4ab~Lt2K5e-Qh2295322953euoutp019
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 16:02:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191008160209euoutp01841cd8d992d677716d8fe6fb5f0fd4ab~Lt2K5e-Qh2295322953euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570550529;
        bh=BCc/Qqs2WfjDX6ovn/o7YnWTV1oZSv54+rW4zjmhABo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qGMvm+2QotfDQkWPSvp8QGFNnNfrITDMmuUePoF49F5qT0jaSyXi9PZozSAzrtgU+
         wHV2kR4GOjSLhb3O+8Z8nucUROLk/CsEK0gxB/5daynwmbgeg/T+6OlXyBuE6YYuw3
         qlegoJlgnXQs9CY78I9X44LtxLZAFmy2afDGJG2Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191008160209eucas1p155ddc06b8fad76e3b2576add32d61040~Lt2Kjw58e1601816018eucas1p1_;
        Tue,  8 Oct 2019 16:02:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.98.04469.103BC9D5; Tue,  8
        Oct 2019 17:02:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191008160208eucas1p2e9ad389fc2843c811c75cc67e19d0bbc~Lt2KIZskR2583825838eucas1p2j;
        Tue,  8 Oct 2019 16:02:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191008160208eusmtrp2606ccc70cbf904fc248e07e7fa63a657~Lt2KHJ9_w2351923519eusmtrp2C;
        Tue,  8 Oct 2019 16:02:08 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-31-5d9cb301d180
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.A1.04117.003BC9D5; Tue,  8
        Oct 2019 17:02:08 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191008160208eusmtip16c1310b5cc70442ea478899f3d1d7f5e~Lt2Jn41Bh2692826928eusmtip1a;
        Tue,  8 Oct 2019 16:02:08 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <86eb668d-7bcf-798b-dabb-95071d16cbb6@samsung.com>
Date:   Tue, 8 Oct 2019 18:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008154844.GM4382@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH+z5399zj9NjjaPeZWuy0LI1O0zz6YWr9cav144+2dEUOT8e6
        O7oHRWvZmMPmd6TbidGoQ34Twx/HMrVYxGjJiT+wqTkusZDzZPPf6/Pj/fl83tuH4Il7BG5E
        jDae0WmVaiku4re9Xxv0Qc3GUNnUM4oump7F6ZqlGUSXW0sE9NBQg5C2lE5g9O8vGRg90mnE
        6ZKhHoyu65sU0o02ebBI3mGYFMqbTJm4/NtYFy7P3ZDJc1pMSL7cdPg6rhCdjWLUMYmM7kRQ
        uCi6tnmZHzdIPhovXBCmoBzHLORAAOUP0z9b8SwkIsTUawSGbBvGBSsIBlqqEBcsI1hrrsF2
        JXXtQ0KuUI2gvtIk4IJFBO3zuTtdLtQ9KFhY4dvZlfKE0dXuHeZRMxiY/0rsjFOnIV9v2l5B
        ECQVBNO1IfY0nzoC9a8sQjsfoELAaukV2JmknGHgxezOGAfKD/Tr6zg3UgZ9FUYBxxL4OluG
        cewO7YtGnv02oMaEsFpdxOMcXISpumwBxy6w0N8i5PgQbHWUYZzgLYKNjLn/6nYE1YWbONd1
        Bnr7PwvsVwN1HtJqozh0gvFFZ26xExS0PedxaRIy0sWc8Cg0VDXgu6uyOt7w8pDUsMeaYY8d
        wx47hj12yhHfhCRMAqtRMayflnnoyyo1bIJW5RsZq2lC21/1cbPf+g7ZhiPMiCKQdD8ZnGwM
        FQuUiWySxoyA4EldyQrDdoqMUiYlM7rYu7oENcOa0UGCL5WQj/dZbosplTKeuc8wcYxut4oR
        Dm4pKF3tWFqc6W27cLVg+nusNkOuzA8fHZkf9vv0Uv/AVHbZrLc9DZMUe6KJuhuKXI/iqT8R
        Cnf3pa5zHgr/yEqv1puZ6EPYrfVGVHH8SWxh1y82uFSVP1fcSS54+cSlBlqvxB/r0aYFXFrf
        KvnRoQ9QpS7JAk8GQFdet+ma+lT+HSmfjVb6efN0rPIf6lxn1FEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7oMm+fEGiz7Z2wx9eETNovVHx8z
        Wiz4NIPV4vz5DewWD+beZLL4dqWDyeLyrjlsFjPO72OyWHvkLrvFxq8eDlweO2fdZffYtKqT
        zePOtT1sHv1/DTz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEvY83mzywF53grbkx+xd7A2MfdxcjJISFgIrF2+3n2LkYuDiGB
        pYwSpxrmMXUxcgAlZCSOry+DqBGW+HOtiw3EFhJ4zSgxeaIxiC0skCZx//BjRhBbREBZ4ur3
        vSwgc5gFHjNJnJ5whBVi6BlmiZ1rGllBqtgErCQmtq9iBFnAK2An8XBNBEiYRUBFYv2SB+wg
        tqhAhMThHbPAhvIKCEqcnPmEBcTmFDCUaP/1C+wIZgE9iR3Xf7FC2OISt57MZ4Kw5SW2v53D
        PIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwLjcduznlh2M
        Xe+CDzEKcDAq8fA6VM2JFWJNLCuuzD3EKMHBrCTCu2gWUIg3JbGyKrUoP76oNCe1+BCjKdBz
        E5mlRJPzgSkjryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY0ZC
        ZWb8aXvO6el1eZ/Na1s2BSofev95o6IKc1FmTXeZYpK0DUN6R0vyzxsuio9vJCUm9b80tax7
        U1NbyGYlVhO05+DlI/u2Vygznni36o+4zQ+BqxmRVuyGZWc+nnvJcEfr4rFp+y+cmF/0yS5M
        kXNywO4dgRGHYq6W7Ct9wiNZNeed/b4yJZbijERDLeai4kQANVD/u+ECAAA=
X-CMS-MailID: 20191008160208eucas1p2e9ad389fc2843c811c75cc67e19d0bbc
X-Msg-Generator: CA
X-RootMTR: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008101720eucas1p2e0d1bca6e696848bf689067e05620679
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
        <20191008101709.13827-1-m.szyprowski@samsung.com>
        <20191008115025.GF4382@sirena.co.uk>
        <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
        <20191008120611.GG4382@sirena.co.uk>
        <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
        <20191008124736.GJ4382@sirena.co.uk>
        <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
        <20191008154844.GM4382@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/8/19 5:48 PM, Mark Brown wrote:
> On Tue, Oct 08, 2019 at 03:24:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
>> Commit 7f93ff73f7c8 ("opp: core: add regulators enable and disable")
>> currently can be safely reverted as all affected users use always-on
>> regulators. However IMHO it should be possible to enable always-on
>> regulator without side-effects.
> 
> With coupled regulators you might have something kicking in because a
> change was made on a completely different regulator...  If we don't take
> account of coupling requirements we'd doubtless have issues with that at
> some point.

OK, I have not considered this.

>> When it comes to setting regulator constraints before doing enable
>> operation, it also seems to be possible solution but would require
>> splitting regulator_set_voltage() operation on two functions:
> 
>> - one for setting constraints (before regulator_enable() operation)
> 
>> - the other one actually setting voltage (after enable operation)
> 
> I don't follow?  What would a "constraint" be in this context and how
> would it be different to the voltage range you'd set in normal operation?

The constraint here would be just the voltage range. I just wanted to
point out that the actual voltage set operation (on the hardware itself
not the internal subsystem bookkeeping) shouldn't be done before enable
operation (especially in context of non-coupled regulators).

Taking into account your remark about enable operation on coupled
regulators and Dmitry's mail about cpufreq issue I think now that just
dropping opp change is the most straightforward fix.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
