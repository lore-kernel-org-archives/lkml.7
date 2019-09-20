Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC22AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C12D20C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QykhAfC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437550AbfITHht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:37:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35244 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437540AbfITHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:37:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190920073746epoutp01e8718e566cdf2c1ceea76902c9be553c~GFWo0xcK02871128711epoutp01l
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:37:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190920073746epoutp01e8718e566cdf2c1ceea76902c9be553c~GFWo0xcK02871128711epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568965066;
        bh=A9VwLK2HONaKzxMqWgpKvIUR94gfyUFzLGSLLzZCFMU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QykhAfC6w8h/mlp867Rbkrvfn3n2E8IcyYJ8bzSGfY8gvKkhEwKSoGcZJMB3K5UY0
         UlJcM4h+PVS0IP+Y+nlpQFXMGKLoqyHrKD1YEHwgY+MmpiJ0wcfP7TxmPGQOqQh4ZN
         nhq+4+JaeLLDOdKxaLOwGxs0hTEXWWDQR2GE8OiY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190920073745epcas1p4d5fc1fe31d4c2233dc4ba6103960ad0f~GFWoR6F_q1921319213epcas1p4l;
        Fri, 20 Sep 2019 07:37:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46ZQY21VjkzMqYkY; Fri, 20 Sep
        2019 07:37:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.28.04160.2C1848D5; Fri, 20 Sep 2019 16:37:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190920073737epcas1p44cdee180e028790bc569eeae9e548488~GFWhHWEFp1927219272epcas1p45;
        Fri, 20 Sep 2019 07:37:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190920073737epsmtrp2f5e9ad6d10cd67b7ee1afe95faf9bdad~GFWhGo-Rx0892108921epsmtrp2i;
        Fri, 20 Sep 2019 07:37:37 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-e0-5d8481c2bf5e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.5D.03706.1C1848D5; Fri, 20 Sep 2019 16:37:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190920073737epsmtip11776f254ad97af8314ff63adf9fee920~GFWg71cZm0598005980epsmtip1H;
        Fri, 20 Sep 2019 07:37:37 +0000 (GMT)
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8435e5df-711b-1669-0980-2ae49c6c412d@samsung.com>
Date:   Fri, 20 Sep 2019 16:42:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeRBW4W0vEr+KZzdJWMf5ANQP_LEAXXK8SPC8BC+97Yyg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e1ud1dp9WuWnfyj1q0IB7Nd3fIWKUVig/pDieiFrJteprlX
        u9MyI3yUmfSwh67mkx5Q9oJpvsosF4RBYplRliklZWJaSi8qaHe3yP8+fM85v/M953coQl1B
        RlAZdjfvsnNWmgyVN/ojdbqO/AMp+nPFWvZogUfGfij1I3b0QYDuXb+oYHtaK0n2Zf4lchVp
        avH2K03Vncmm8Tu9pOlYQx0yTfrmJSm2Zq5M57k03qXh7amOtAy7JY5et8G8xmxcpmd0zHI2
        ltbYORsfRyesT9IlZlgDBmhNNmfNCkhJnCDQS+NXuhxZbl6T7hDccTTvTLM6lzujBM4mZNkt
        UakO2wpGr482BhK3Z6Z/evKEdJbN2NP17LEsDxVPK0EhFGADXDj4VF6CQik1bkZwdaxJLgbU
        eALBgHeXFPiKwOu9g0oQFax40xYv6W0IBk+fJ6SCcQTve6JFDsObYLC3O5g/C2+Esmt6USaw
        H8GRR7tEJrEW2oefkyLPwAug9/vbYLoKx8Mz/w5RluPFMDn6GIk8G2+GiUG/QmQVngmdZ4eC
        NkNwMrTdOqmUnp8DfUM1MonnQ+HNCkK0CXicBF9fLZIGToArhUN/OQxGHjQoJY6AybE2UuJc
        uNx5n5SKixE0tHcrpEAMtF88JRONEjgSbrQuleQF0PKzCkmNp8PYlyMKaVUqKC5SSykLoWew
        XybxXDh/6DBZimjvlHG8U0bwThnB+79ZLZLXoXDeKdgsvMA4DVN/2oeCh6llm9HtrvUdCFOI
        nqbS7C5MUSu4bCHH1oGAIuhZqkpjQYpalcbl7OVdDrMry8oLHcgY2PYJImJ2qiNw5na3mTFG
        x8TEsAZmmZFh6DkqkyUvRY0tnJvP5Hkn7/pXJ6NCIvLQ/kUj5K/E4caa1V323OE4j+fy3bJ+
        WZ/5s+7M/e+KfPO+U2vffVRGNiQZCrSNsZ3lL3JOH6deGcIf1r4dSNj2q/nbqiJfS6hzy63y
        z7nzu5bktVpXE3UHwo9VT5T2NJ2pehrv8V2or8/OiXKHv+4eqPjh+R3LKsPmGXZqPpYX7e1L
        pOVCOsdoCZfA/QFiJv/urgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTvdgY0uswd152ha9TdOZLF5OOMxo
        8eY4kHVw3VJWi8u75rBZ3G5cwebA5rFz1l12j3knAz3e77vK5tG3ZRWjx+dNcgGsUVw2Kak5
        mWWpRfp2CVwZHy5dYiuYyl9x7tpFpgbGDp4uRg4OCQETiUd77boYOTmEBHYzSmy6FAFiSwhI
        Sky7eJQZokRY4vDh4i5GLqCSt4wSdz4sZgapERYIl3hw9QIjiC0iECrxdM52ZpAiZoHDjBIX
        Np9kh+i4ySSx9cMOdpAqNgEtif0vbrCB2PwCihJXfzxmBNnAK2Ance1wEkiYRUBV4vObi2BD
        RQUiJA7vmAVm8woISpyc+YQFxOYUCJTYu3sS2EhmAXWJP/MuMUPY4hK3nsxngrDlJZq3zmae
        wCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnD8aGnu
        YLy8JP4QowAHoxIPr0J5c6wQa2JZcWXuIUYJDmYlEd45pk2xQrwpiZVVqUX58UWlOanFhxil
        OViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTDO1Wfq/scYwXH8vOzGrV9rkrtkIqLnCb+t
        PzHpzrXKl6eaM/c9rbhbrG3gWNDwNlK4RmK5Bzfft/R9cxUr8iXl/Avn/p2Zbh6qdMNM4eyR
        G2res6+9VuWWrPnL9fLiwnSDFtNMnr79PicSV+RbTlFliRdp2ffms6jJjB3RD77e9Nulyjeh
        0EeJpTgj0VCLuag4EQB30NUNmwIAAA==
X-CMS-MailID: 20190920073737epcas1p44cdee180e028790bc569eeae9e548488
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190918071722epcas5p2891fbda9c34518a3d3e3b767f02fde7f
References: <20190916211536.29646-1-jekhor@gmail.com>
        <20190916211536.29646-2-jekhor@gmail.com>
        <20190917111322.GD2680@smile.fi.intel.com>
        <20190917132547.GA4226@jeknote.loshitsa1.net>
        <CGME20190918071722epcas5p2891fbda9c34518a3d3e3b767f02fde7f@epcas5p2.samsung.com>
        <CAHp75VeRBW4W0vEr+KZzdJWMf5ANQP_LEAXXK8SPC8BC+97Yyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 19. 9. 18. 오후 4:17, Andy Shevchenko wrote:
> On Wed, Sep 18, 2019 at 2:04 AM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>>
>> On Tue, Sep 17, 2019 at 02:13:22PM +0300, Andy Shevchenko wrote:
>>> On Tue, Sep 17, 2019 at 12:15:36AM +0300, Yauhen Kharuzhy wrote:
>>>> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
>>>> PMIC at driver probing for further charger detection. This causes reset of
>>>> USB data sessions and removing all devices from bus. If system was
>>>> booted from Live CD or USB dongle, this makes system unusable.
>>>>
>>>> Check if USB ID pin is floating and re-route data lines in this case
>>>> only, don't touch otherwise.
>>>
>>>> +   ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
>>>> +   if (ret) {
>>>> +           dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
>>>> +           goto disable_sw_control;
>>>> +   }
>>>> +
>>>> +   id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
>>>
>>> We have second implementation of this. Would it make sense to split to some
>>> helper?
>>
>> Do you mean the combination of regmap_read(...CHT_WC_PWRSRC_STS,
>> &pwrsrc_sts) with cht_wc_extcon_get_id()?
> 
> Yes.
> 
>> In the cht_wc_extcon_pwrsrc_event() function the pwrsrc_sts is checked
>> for other bits also, so separation of PWRSRC_STS read and id calculation
>> to one routine will cause non-clear function calls like as
>> get_powersrc_and_check_id(..., &powersrc_sts, &id) which is not looks
>> better than current code duplication.
> 
> I see. Thanks for answer.
> 
>> Or we need to spend some time for
>> refactoring and testing of cht_wc_extcon_pwrsrc_event() code.
> 
> Perhaps, In any case I'm not objecting of the current approach.
> 

If you think it is OK, could you reply with your tag?
and I'll fix the multi-line comment by myself.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
