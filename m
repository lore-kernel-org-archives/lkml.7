Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2651BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E833020650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lginjuMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfJNGuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:50:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47900 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbfJNGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:50:44 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191014065041epoutp033d2f3d04079ee7772a227924e3305e18~NcMZCzsP90990509905epoutp03G
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:50:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191014065041epoutp033d2f3d04079ee7772a227924e3305e18~NcMZCzsP90990509905epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571035841;
        bh=1eQGo33uKjTdCkkdKahf1ARNyu1XQkPjhgfubEbxddw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lginjuMi+IaIM6K5HCv0ec661XLxMEJYP1prYNou+rNtOuvzUHmIpF9QXioW6u7sy
         RuHZIacTbjA/iBw+Pj3+SpgZBfoZVt+yj0SlxS1TwVbGfyvzn8sL0nTQEmW+M4YNzP
         AKgKkfNlpZF1HdCAAsTOQFvYjdfTBKNZyljsY7+c=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191014065041epcas1p358c1ec08078fb7c3a8713c609fd83d1e~NcMYqLBoq1509415094epcas1p3T;
        Mon, 14 Oct 2019 06:50:41 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46s8Mg1RcBzMqYkh; Mon, 14 Oct
        2019 06:50:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.A8.04085.FBA14AD5; Mon, 14 Oct 2019 15:50:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191014065038epcas1p38813e16958dbdacf5d3201b677429f22~NcMWDZjvH1290112901epcas1p34;
        Mon, 14 Oct 2019 06:50:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191014065038epsmtrp269318e5e70208b7ddacaf8a128ce1695~NcMWCkLmu1524115241epsmtrp20;
        Mon, 14 Oct 2019 06:50:38 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-58-5da41abf4ee3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.0D.04081.EBA14AD5; Mon, 14 Oct 2019 15:50:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191014065038epsmtip1a31c68c943611dcbd837e7577bf5392a~NcMVuCBb50984009840epsmtip1a;
        Mon, 14 Oct 2019 06:50:38 +0000 (GMT)
Subject: Re: clk: samsung: Checking a kmemdup() call in
 _samsung_clk_register_pll()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <725ace30-a4a7-25dd-2351-f007bb8b35ed@samsung.com>
Date:   Mon, 14 Oct 2019 15:55:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c1bc5e4d-0802-4485-2c07-248bab2a3330@web.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmge5+qSWxBk8Oclo8a5zOarH1lrTF
        iXln2S0+9txjtbi8aw6bxYzz+5gs/s96zmpx8ZSrxeLlPxktDr9pZ7X4d20ji8W0L4vYLVbt
        +sPowOvx/kYru8fOWXfZPTat6mTz6NuyitHj6sImdo/Pm+Q8bj/bxhLAHpVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2PR3X7mgt2cFb93
        /GdvYPzL3sXIySEhYCLxc+ku5i5GLg4hgR2MEhMffmKBcD4xSvS/OcYI4XxjlPg47QgLTMuB
        3u3sEIm9jBJb7r2Ect4zSrz+OYENpEpYIFRixZO7rCAJEYE+Jom2favBqpgFLjJKLLz3jwmk
        ik1AS2L/ixtgHfwCihJXfzxmBLF5Bewk1p34DWazCKhKLFw+Bcjm4BAViJA4/TURokRQ4uTM
        J2AncQpYSSx+8w+snFlAXOLWk/lMELa8RPPW2WDfSQisYpe4O/cdE8QPLhJ7DhxkhLCFJV4d
        3wINDimJz+/2skHY1RIrTx5hg2juAPpz/wVWiISxxP6lk5lADmIW0JRYv0sfIqwosfP3XKgj
        +CTefe1hBSmREOCV6GgTgihRlrj84C7UCZISi9s72SYwKs1C8s4sJC/MQvLCLIRlCxhZVjGK
        pRYU56anFhsWGCPH9yZGcFLWMt/BuOGczyFGAQ5GJR5ehbTFsUKsiWXFlbmHGCU4mJVEeBkm
        LIgV4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnAjJFXEm9oamRsbGxhYmhmamioJM7Lyjg/
        VkggPbEkNTs1tSC1CKaPiYNTqoExu2u/ikPa/Yhd2c3XC3Wq+p399k1UN+KyYbSYMWFThxb/
        RN/S205KPxJPpm07qPdb9to1lxeWpupp3A1LxNTWPBd7EqnCfnZSU57+Cb6rCyZNfWrJZPTr
        Co92fjzfxJP9bjF7ko7Od5nKw6FqyhxW1/X856Zfu66rPd3/IijuR8+ZgoSLm1YrsRRnJBpq
        MRcVJwIABv194uADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO4+qSWxBtuPKlk8a5zOarH1lrTF
        iXln2S0+9txjtbi8aw6bxYzz+5gs/s96zmpx8ZSrxeLlPxktDr9pZ7X4d20ji8W0L4vYLVbt
        +sPowOvx/kYru8fOWXfZPTat6mTz6NuyitHj6sImdo/Pm+Q8bj/bxhLAHsVlk5Kak1mWWqRv
        l8CVsehuP3PBbs6K3zv+szcw/mXvYuTkkBAwkTjQux3I5uIQEtjNKNGzuIERIiEpMe3iUeYu
        Rg4gW1ji8OFiiJq3jBKz3jWzgNQIC4RKrHhylxUkISIwgUliz865jCAOs8BFRolD/9azQrT0
        MkqsO/UVrIVNQEti/4sbbCA2v4CixNUfj8HW8QrYSaw78RvMZhFQlVi4fAqYLSoQIfF8+w2o
        GkGJkzOfgM3hFLCSWPzmH1icWUBd4s+8S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywk
        LbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcn1qaOxgvL4k/xCjAwajE
        w3sieXGsEGtiWXFl7iFGCQ5mJRFehgkLYoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07Fikk
        kJ5YkpqdmlqQWgSTZeLglGpgrH2yJuJb7TWDadv+PwpLys84lzlH9PNUuf/W3to6zQlXzWX3
        Bf3p3eIau7g0cJ55ionA3dQdu8Iu9xbc9PniljNlRskG1h3+AWsyV58M+8VTrzfR+rdDVcfL
        AhXWu34TF2h82Pug5kiHiRWf7L8l0lvaWTpP1dn8UVkQfe3m3W8N/zec/1b7RImlOCPRUIu5
        qDgRAISKLRHLAgAA
X-CMS-MailID: 20191014065038epcas1p38813e16958dbdacf5d3201b677429f22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191012141739epcas3p31e41c151b30d49c94aeb933aa42dc9f7
References: <CGME20191012141739epcas3p31e41c151b30d49c94aeb933aa42dc9f7@epcas3p3.samsung.com>
        <c1bc5e4d-0802-4485-2c07-248bab2a3330@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 19. 10. 12. 오후 11:17, Markus Elfring wrote:
> Hello,
> 
> I tried another script for the semantic patch language out.
> This source code analysis approach points out that the implementation
> of the function “_samsung_clk_register_pll” contains also a call
> of the function “kmemdup”.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/samsung/clk-pll.c?id=1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#n1275
> https://protect2.fireeye.com/url?k=7e77b0ebee9a0c3e.7e763ba4-43f341fdfe1d32b1&u=https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/samsung/clk-pll.c#L1275
> 
> * Do you find the usage of the format string “%s: could not allocate
>   rate table for %s\n” still appropriate at this place?
> 
> * Is there a need to adjust the error handling here?

drivers/clk/samsung/clk-pll.c considers the case of 'pll->rate_table is NULL'
So, maybe just show the warning message if failed to allocate memory
of 'pll->rate_table'. Bu, IMHO, the error handling is necessary
in order to support what 'pll_clk->rate_table' isn't NULL.

> 
> Regards,
> Markus
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
