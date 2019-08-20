Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A281EC3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9252087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aMjqSFEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfHTQyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:54:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40355 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfHTQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:54:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820165420euoutp01e3ad90a829524c8ec8bc1a4441ba125a~8r8vfzuIs1234912349euoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820165420euoutp01e3ad90a829524c8ec8bc1a4441ba125a~8r8vfzuIs1234912349euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566320060;
        bh=sbqiTCRUpZ3MshofYCStwXRk7Cczn3P1TKPmG9TczRU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aMjqSFEd+c6TguN/mfCPyNAHI2Vg16jt50Gfa7cPqoJNxaSZX87VHm/8QEJkD84L+
         VhvqQwhf8mMgXK1tzTxU0rQb76vF8SW6KJGfVpkTIrE8bCpMN88Ti3mNJT8BrsE7HW
         2CEomD7UfARMVmY7OHBNusvImPZcroGWRw7WBiMg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820165419eucas1p2c7de6259732141c1739d283c7b487e0c~8r8uJ2KF20356503565eucas1p2V;
        Tue, 20 Aug 2019 16:54:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E7.37.04309.AB52C5D5; Tue, 20
        Aug 2019 17:54:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820165418eucas1p11fc68b37267466fcd04148f211f0f18c~8r8tHo1991197511975eucas1p1q;
        Tue, 20 Aug 2019 16:54:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820165417eusmtrp2f2a1ad829afc6d411b947e914f674e7d~8r8s5jQf80379003790eusmtrp2W;
        Tue, 20 Aug 2019 16:54:17 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-cf-5d5c25ba53e8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.C8.04166.9B52C5D5; Tue, 20
        Aug 2019 17:54:17 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820165417eusmtip297537e3d007ee7057597c630a273e12d~8r8sc91H81887318873eusmtip2B;
        Tue, 20 Aug 2019 16:54:17 +0000 (GMT)
Subject: Re: [PATCH v5] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <75af4479-da1c-9f5f-cff1-1428065ea4ad@samsung.com>
Date:   Tue, 20 Aug 2019 18:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <89894d50-0e3c-4d43-37b2-ff5be407e58c@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87q7VGNiDZpeG1usvtvPZvHs1l4m
        i9nvlS2O7XjEZHF51xw2i93v7zNaPGz6wGQxt3U6uwOHx+Gvm9k8ds66y+5x+Wypx6HDHYwe
        B8+dY/T4vEkugC2KyyYlNSezLLVI3y6BK+Nd/yTGggn8Ff3HnrA3MH7g7mLk5JAQMJH4+mcy
        E4gtJLCCUeL2gvwuRi4g+wuQveEtK4TzmVHi+s5nzDAd5748YoNILGeUmD1tDzuE85ZRYum2
        c2CzhAUCJWa8f8wOYosIyEl8bL3KCFLELLCNUeLo6VdgCTYBK4mJ7asYQWxeATuJvWdawJpZ
        BFQl9j5oA1snKhAhcf/YBlaIGkGJkzOfsIDYnAK2EmtnHgSrZxYQl7j1ZD6ULS+x/e0cZpBl
        EgLH2CVWTb0N1MAB5LhI9D0UgHhBWOLV8S3sELaMxP+dIL0g9esYJf52vIBq3s4osXzyPzaI
        KmuJw8cvsoIMYhbQlFi/Sx8i7Cix+/suJoj5fBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxIZl
        G9hg1nbtXMk8gVFpFpLPZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/
        dxMjMCmd/nf8yw7GXX+SDjEKcDAq8fDuuBkdK8SaWFZcmXuIUYKDWUmEt2JOVKwQb0piZVVq
        UX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRi3mG+GiwryVeheXiO2/
        yGKUUOPJlbXqucCHj55VP1QfnuG3OXO92Z9ZMzTX6smE2Q+0DykKGzF6Ce2dcf/28mvT62f1
        cC24+PbEAZXJv/9Uf1bhOrxRNXKi2IVupbN27Du+uVitTfp6eWP1w2brWweanlY+vMZnLrR3
        /svFS/XMVAL5XbcGzVBiKc5INNRiLipOBAAiuaFPRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7o7VWNiDd7f17dYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsa7/kmMBRP4K/qPPWFvYPzA3cXIySEhYCJx7ssjti5GLg4hgaWMEv+OrGfqYuQA
        SshIHF9fBlEjLPHnWhcbSFhI4DWjxN1SkLCwQKDEjPeP2UFsEQE5iY+tVxlBxjALbGOU+Hpt
        OiPEzHeMEp+OvmQCqWITsJKY2L6KEcTmFbCT2HumBSzOIqAqsfdBGzOILSoQIXHm/QoWiBpB
        iZMzn4DZnAK2EmtnHgSrZxZQl/gz7xIzhC0ucevJfKi4vMT2t3OYJzAKzULSPgtJyywkLbOQ
        tCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGIPbjv3cvIPx0sbgQ4wCHIxKPLw7bkbH
        CrEmlhVX5h5ilOBgVhLhrZgTFSvEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cD0kFcSb2hq
        aG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbFZ7++L/fttb2+5uj5xyk2D
        j9v9rvpMNmS9cj25KZz7ELNE9XapOSeuPWp/IG50/pSdkwBzVN+d3zou/IufuzpopL25uET8
        uncw27rvDZuvbf8s1vQyPY/bn599c/SZa7vWmeVdfDorK0W/zkzzoNSxMFbWI+/uXeqebN+/
        yEr1/s9le2RcZRqVWIozEg21mIuKEwH/W7Sm1wIAAA==
X-CMS-MailID: 20190820165418eucas1p11fc68b37267466fcd04148f211f0f18c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c
References: <CGME20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c@epcas2p4.samsung.com>
        <20190812164830.16244-1-max@enpas.org>
        <9966f79c-278b-5ec9-3c4b-e1de55af55f0@samsung.com>
        <89894d50-0e3c-4d43-37b2-ff5be407e58c@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 5:59 PM, Max Staudt wrote:
> Hi Bartlomiej,
> 
> Thank you very much for your review!
> 
> Question below.
> 
> 
> On 08/20/2019 02:06 PM, Bartlomiej Zolnierkiewicz wrote:
>>> +	/* Workaround for X-Surf: Save drvdata in case zorro8390 has set it */
>>> +	old_drvdata = dev_get_drvdata(&z->dev);
>>
>> This should be done only for type == BOARD_XSURF.
> 
> Agreed, as I want to keep unloading functional for Buddha/Catweasel - see below.
> 
> 
>>> +static struct zorro_driver pata_buddha_driver = {
>>> +	.name           = "pata_buddha",
>>> +	.id_table       = pata_buddha_zorro_tbl,
>>> +	.probe          = pata_buddha_probe,
>>> +	.remove         = pata_buddha_remove,
>>
>> I think that we should also add:
>>
>> 	.driver  = {
>> 		.suppress_bind_attrs = true,
>> 	},
>>
>> to prevent the device from being unbinded (and thus ->remove called)
>> from the driver using sysfs interface.
> 
> Interesting idea - here's my question now:
> 
> My intention is to allow remove() for boards where we support IDE only (Buddha, Catweasel) - these are autoprobed via zorro_register_driver().
> This shouldn't affect the X-Surf case, as it's not autoprobed in this way anyway - and thus pata_buddha_driver isn't even used.
> 
> Am I missing something? We want to inhibit module unloading (hence no module_exit()), but driver unbinding for Buddha/Catweasel should be fine to remain, right?

Indeed, pata_buddha_driver is not even used for X-Surf so this is not
an issue (please disregard my comment about suppress_bind_attrs).

>> Please also always check your patches with scripts/checkpatch.pl and
>> fix the reported issues:
> 
> Apologies, must've been something in my coffee. I will.
> 
> 
> Thanks for the review, I'll send a new patch once my question above is resolved.
> 
> Max
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
