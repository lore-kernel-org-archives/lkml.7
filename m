Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2EC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E47121743
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z3d6z5te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGXKb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:31:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47562 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfGXKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:31:27 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190724103124epoutp0358c3381faaf6bc9f34b33ea397c896f1~0UTsSMBe32039720397epoutp03I
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:31:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190724103124epoutp0358c3381faaf6bc9f34b33ea397c896f1~0UTsSMBe32039720397epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563964284;
        bh=vQ+ZBBplUooWGOfTWfz0ycwrOTM0wQcfKH8z1rjtWLE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Z3d6z5te+lACFdPVuR0bLEmyePK7xJVBFxaeSUPHQePWNFyRY+oxapr9KrJs1+xaF
         THKsBZp/GUAH0tLEagn0MtNoy4QGKsi1xHPi9g01OjSHSE8OlEnOZR27q4+Veb4mFh
         nABWq0pumFuZ5AizeyVwfgIjlJCnKFS0WyAfnnoc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190724103124epcas1p300ffc135029c53e09919f071c5bd35af~0UTrnT1Fc2185321853epcas1p3O;
        Wed, 24 Jul 2019 10:31:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45ts896ZsnzMqYlp; Wed, 24 Jul
        2019 10:31:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.5B.04088.973383D5; Wed, 24 Jul 2019 19:31:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190724103121epcas1p44469b2e9edfc5305f5e8fe7d1abcbb8f~0UTpGTjr92385623856epcas1p4m;
        Wed, 24 Jul 2019 10:31:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190724103121epsmtrp27cf559953d6380f2435189d92ce78b1e~0UTpFnmzR2038020380epsmtrp2k;
        Wed, 24 Jul 2019 10:31:21 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-89-5d383379f804
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.D3.03706.973383D5; Wed, 24 Jul 2019 19:31:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190724103121epsmtip10798b70fe4f19d0f7875abd9f5206da1~0UTo5KgBv1821118211epsmtip1G;
        Wed, 24 Jul 2019 10:31:21 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: Add IRQ_ONESHOT
To:     Vasyl Gomonovych <gomonovych@gmail.com>, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2ff0d8e8-6916-666d-5757-657594b5238d@samsung.com>
Date:   Wed, 24 Jul 2019 19:34:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719162806.1926-1-gomonovych@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTX7fS2CLW4Ms/Q4vDD9+yWlzeNYfN
        4nbjCjYHZo+ds+6ye/RtWcXo8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtAiJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        ZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xscDq1kKNrFXfP/5gLmB8RNrFyMHh4SAicSv5ZJd
        jFwcQgI7GCUWvNrCAuF8YpSY8e8iK4TzjVFi45w5QA4nWMesf4fZIBJ7GSXOPLsP1fKeUWL5
        /aOMIFXCQFUrlr5jArFFBFwltjy5yQ5iMwsoSPy6twlsEpuAlsT+FzfYQGx+AUWJqz8eg/Xy
        CthJ9DVuBLNZBFQl3i86ClYjKhAh8enBYVaIGkGJkzOfsIDYnAKWEnPPd7BCzBeXuPVkPhOE
        LS/RvHU2M8hxEgIH2CQmd59hhHjBRaJp9nNmCFtY4tXxLewQtpTE53d72SDsaomVJ4+wQTR3
        MEps2X8B6n9jif1LJzOBQo9ZQFNi/S59iLCixM7fcxkhFvNJvPvaAw1gXomONiGIEmWJyw/u
        MkHYkhKL2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxYYIsf2JkZwItQy3cE4
        5ZzPIUYBDkYlHt4KJvNYIdbEsuLK3EOMEhzMSiK8gQ1msUK8KYmVValF+fFFpTmpxYcYTYGh
        PZFZSjQ5H5ik80riDU2NjI2NLUwMzUwNDZXEeef90YwVEkhPLEnNTk0tSC2C6WPi4JRqYNQV
        rD/oH9H/ac4asegT246zBqtXdU6Ye/5+U+LFB9du3bFmlfvTvYnNwTht1f+vW+wjs69U1gWu
        e7tuDut3CYeF3Ca/uAw45eQ23lUz+TKrqnLGmsAJ1rPyu7alhWr94fQ6c73Yw3tj5volt/pP
        nTKNee3TfsEv0sHnhZ/kgu0/5fZFaEcoVimxFGckGmoxFxUnAgBT0ar3mgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnG6lsUWswdOZvBaHH75ltbi8aw6b
        xe3GFWwOzB47Z91l9+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6MjwdWsxRsYq/4/vMBcwPj
        J9YuRk4OCQETiVn/DrN1MXJxCAnsZpT4Ne0II0RCUmLaxaPMXYwcQLawxOHDxRA1bxklZj9r
        ZgepEQZqXrH0HROILSLgKrHlyU2wOLOAgsSve5tYIRp6GCXO/N3ADJJgE9CS2P/iBhuIzS+g
        KHH1x2OwZbwCdhJ9jRvBbBYBVYn3i46C1YgKREgc3jELqkZQ4uTMJywgNqeApcTc8x2sEMvU
        Jf7Mu8QMYYtL3HoynwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWG
        eanlesWJucWleel6yfm5mxjBMaGluYPx8pL4Q4wCHIxKPLwKDOaxQqyJZcWVuYcYJTiYlUR4
        AxvMYoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgXLve
        z625Q8y1SvLejcy3LqXJy03PdnB3tm3N5PsRV+a7Pn7rd1app9ZfbJ9bzF/ZyPUvanX3ivRU
        GcG2y12zk/Y3JW48f06taJmY4V7H7Z37xCsYvtat6zUpOf/+dY7IL4/F8Y66q/1ucV75xHij
        ym6F1gaR8xJPpwQqtpsLeF4q3NCxdvc2JZbijERDLeai4kQAmSZ8OYUCAAA=
X-CMS-MailID: 20190724103121epcas1p44469b2e9edfc5305f5e8fe7d1abcbb8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190719162821epcas3p17fcf008cf87a010463aad86fbcf4f7e3
References: <CGME20190719162821epcas3p17fcf008cf87a010463aad86fbcf4f7e3@epcas3p1.samsung.com>
        <20190719162806.1926-1-gomonovych@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 20. 오전 1:28, Vasyl Gomonovych wrote:
> Do not fire irq again until thread done
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
> Can you please look on this from false positives point of view
> ---
>  drivers/extcon/extcon-sm5502.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index 98e4f616b8f1..dc43847ad2b0 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -597,7 +597,7 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
>  
>  		ret = devm_request_threaded_irq(info->dev, virq, NULL,
>  						sm5502_muic_irq_handler,
> -						IRQF_NO_SUSPEND,
> +						IRQF_NO_SUSPEND | IRQF_ONESHOT,
>  						muic_irq->name, info);
>  		if (ret) {
>  			dev_err(info->dev,
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
