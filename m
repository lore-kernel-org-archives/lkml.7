Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E56C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E9C206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vfgeBc2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfCGB1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:27:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27671 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfCGB1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:27:12 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190307012709epoutp01cc3945fa8bcbfe0ac73928ebb97d2582~JiN0dUdX90601006010epoutp01q
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 01:27:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190307012709epoutp01cc3945fa8bcbfe0ac73928ebb97d2582~JiN0dUdX90601006010epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551922029;
        bh=ek4+oFwVU8GlDLyXhecoPj+lFwjZ5Jg1NZTfTGI5pwM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vfgeBc2MpotID4+Q6wPSQ9elfn7ZP8gJj9rZduva8+K4hL72YGYE8Lk8ECyiVWy0t
         isI8xdgJR1Mv8qWJ8smhS2kPJ0dVfRfsXWUZ93kY1xXWvLntig0VbLXti1OpxvoxtQ
         glZcBjbSl2KQY7uJS4SpTgjll0fo8WLeptHu6IcU=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190307012705epcas1p4d0b57a2a4294a77f72669ccd8cb873ef~JiNwcoIhb0549505495epcas1p4D;
        Thu,  7 Mar 2019 01:27:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.99.04173.663708C5; Thu,  7 Mar 2019 10:27:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190307012702epcas1p12c8946bc55d6fb216dc29e79f8c3452a~JiNtnko4r1110411104epcas1p1p;
        Thu,  7 Mar 2019 01:27:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190307012702epsmtrp2869d031eef2954b4866782d2d71a36cc~JiNtmXPZp0643206432epsmtrp2T;
        Thu,  7 Mar 2019 01:27:02 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-73-5c80736633bd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.47.03601.663708C5; Thu,  7 Mar 2019 10:27:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190307012702epsmtip134587974676293132bd22b00fcac85e6~JiNtZ-UKZ3161031610epsmtip1G;
        Thu,  7 Mar 2019 01:27:02 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
To:     Pavel Machek <pavel@ucw.cz>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5621c652-6786-6bbb-ffbd-71567d8d882e@samsung.com>
Date:   Thu, 7 Mar 2019 10:27:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306231014.GE7915@amd>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TWUwTURSGvZ122hIrY0E4olEYfFAiywDF0QBqQFMDMY0aQwymjnSkSLd0
        ilF4oKiA4q4xYiFgFLCCBkUwiAIRikY0FAWDshhU3IhBIy6VB7XtSOTtO/cs//3vIsHkzXiQ
        JMtgYc0GRkfiPsJbncsiwndx1vSol7+j6Rul9SLa6bwupgetC+m+lnKcnjzmQHSps01Af3S4
        EH3NMSKmhwrsOD3S3YWv8VEODucrG2oP48p7E3cFyuONtUhpr/spVk42LFLh27LjtSyjYc3B
        rCHDqMkyZCaQKZvVSWpFXBQVTq2kV5DBBkbPJpDJqarw9Vk698bI4D2MLse9pGI4joxMjDcb
        cyxssNbIWRJI1qTRmVaaIjhGz+UYMiMyjPpVVFRUtMJduCNbO/wr0VQ7e2/Z/QrMil5JS5BU
        AkQsNJc6BCXIRyInmhH0VBSK+OArgmuDhWI++IHgZI1DON3iLGrC+UQrgorO/UI++IxgzG4V
        ear8iGQ4Udwj9rA/kQpnW4q8IhjRKoC6Kpc3gRNh0P7hOe5hXyIEnrneIA/LiER4/fGxwMNC
        Ygm46qxe6XlEGnx+e0fI18yFh+fHvCwllsLQ15+YhzEiEAbHKgU8L4YDTWWYRxiIYjF8+zQi
        4D0kw/6WDxjPfjD+oFHMcxBMTrTiPOfBlYcOnG8+hKCxvVfEJ2KgvfqMe5DErbAM6lsiebE5
        MPH9qMizDIQMDhXJ+epQ6Budlp0Pl4oP/xuvhPc3B7CTKMQ2w45thgXbDAu2/2IXkLAWBbAm
        Tp/JcpQpeuZ1NyDvqw2La0YXe1I7ECFB5GxZ2qP8dLmI2cPt03cgkGCkv+y03poul2mYfbms
        2ag25+hYrgMp3Kd9Cgual2F0/wGDRU0pomNiYuhYKk5BUWSgrH5NUrqcyGQsbDbLmljzdJ9A
        Ig2yotYXTVkyLmzd+HB5P1Ww88dA/NTBUBVZIL+atEi76V33rC8RvqsX9Eo35m9N5YpV2t01
        sZOntpiqJ74dPWufe6IkuVL+ZMNo1do+rlI9cMSv62nKXuWqc88KG6xTub7ankd5QxrNcODy
        toDR9u2uxqncywdqbncb0o4X1Tz+02/vc5JCTstQYZiZY/4C/KVT8csDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnG5acUOMweMDMhYbZ6xntTh/fgO7
        xa0GGYvLu+awWXzuPcJoMeP8PiaLl0d+MFqsPXKX3eJ24wo2i7unjrI5cHnculPvsWlVJ5vH
        wXd7mDz6tqxi9Fix+ju7x+dNcgFsUVw2Kak5mWWpRfp2CVwZd37aFaziqZh9bB5zA+NDzi5G
        Tg4JAROJ821b2boYuTiEBHYzSkxvOsQIkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxJLpliC2
        sICLRH/7OXYQW0TAR2LqrjYmEJtZYD+TxI//jBAz1zJKPHsxH2wmm4CWxP4XN9hAbH4BRYmr
        Px6DxXkF7CQevTwD1swioCLxY3UDC4gtKhAhcffiCxaIGkGJkzOfgNmcAhoStz99B7uNWUBd
        Yv08IYi94hK3nsyHukFeonnrbOYJjMKzkHTPQuiYhaRjFpKOBYwsqxglUwuKc9Nziw0LjPJS
        y/WKE3OLS/PS9ZLzczcxgmNNS2sH44kT8YcYBTgYlXh4I07XxwixJpYVV+YeYpTgYFYS4Z2U
        2xAjxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTF8Nvta
        PymewPIHkV/VFMU4E6VlD4T7Vjxw8I6sY1L7Kp+jX//uboVsmuM/tYbZBQd+KX7mUfww/Wna
        +5OJ2dM2ivC+q8jv2aWRL3zYtWrJVD/+3RtOHzMRzE3hsJyu1M2am3Jm6T/pzZzOMzzEt9dx
        r9eQOXS1fJeSTmzaljlTJyty7DE9q8RSnJFoqMVcVJwIAMyAR3yxAgAA
X-CMS-MailID: 20190307012702epcas1p12c8946bc55d6fb216dc29e79f8c3452a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
        <20190125135403.10228-1-m.szyprowski@samsung.com>
        <20190306231014.GE7915@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 19. 3. 7. 오전 8:10, Pavel Machek wrote:
> On Fri 2019-01-25 14:54:03, Marek Szyprowski wrote:
>> This way devfreq core ensures that all its devices will be set to safe
>> operation points before reboot operation. There are board on which some
>> aggressive power saving operation points are behind the capabilities of
>> the bootloader to properly reset the hardware and boot the board. This
>> way one can avoid board crash early after reboot.
>>
>> Similar pattern is used in CPUfreq subsystem.
> 
> This looks somehow dangerous to me. I guess this will break someone's
> shutdown, and on battery-powered devices, that's quite bad thing to
> do.

This patch executes the devfreq_suspend() for all devfreq devices.
The devfreq_suspend() does the following:
	1. (mandatory) stop the polling of governor.
	2. (optional)  If devfreq device specifies the 'opp-suspend'
	property in DT, the devfreq changes the frequency by using
	the devfreq->suspend_freq.

If the user of devfreq device doesn't want to change the frequency
during the system shutdown, just don't add the 'opp-suspend' property
in DT. And the devfreq_suspend() will just stop the polling for governor.

Even if on battery-powered devices, I think it is not problem
to stop the polling of governor during the system shutdown.

In my case, I don't know what is dangerous.
Could you explain it more detailed.

> 
> Could we explicitely do it only for devices that need it?
> 								Pavel
> 								
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
