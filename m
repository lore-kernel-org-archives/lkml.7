Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057092082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="HJrUtb9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfCEI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:28:58 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:17668 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfCEI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:28:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 51EA640673;
        Tue,  5 Mar 2019 09:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1551774532; x=1553588933; bh=sELKssvtLJMrTcCuI5qCNVECnNLnOloztw0
        3SKUmsNU=; b=HJrUtb9nJMlEVm+JX4cWHBmF7xhUNwJqy1hH7VIQfv5EvSJJfFj
        wNZkSZXlbYfanqm1z230rsiKgaUqFW34/A2zI9My4FaBg06uUeBZJzwcnshxyTPD
        ClRUfZJaEzf1amAG6ojj/EKibtN9chHiKHwNanB35kabrs22l9GfHa3VP1xlQ6D7
        907qaEOH/cfPZDYVfDujJmNipt8vBpOLLimX/kQZV7W43pUbUPz+LbQc+mCM04Ad
        VcyOQzTuvDra6C/1Cc3f2IyqcBsVVRA1fpgGuivQEORJwBBN5x2PevfeaOsRYDTL
        YLta32O3gEe0dNO15gYQfpTxMO9zZsKXx9xLQcZ2eYWV91WoLkZ6bNIQad5y39D2
        IH7uSK+nIMPZcJN6uFgajKo6KDnNmgz+F8bdBarSLXRpbhcPsiCU5t4ilO6DGmxi
        L9MuUoKc4iq7g7SnqUG6z/EDAuq3aI/zHZaJvciP0exPl2QwvCW372KpmuPm79/w
        jK6fDbc0TVtqV5NdscK9a//DHMvlGW38ap6Pjv9ulJaN9xLyPfchcvVHpWIcyJzX
        2jK8wA0SqPSkogKji5xm6wkkPOtbcC8egHQgsDU99icdfE0/dCBYMP/w4oURkjG4
        47c89k9kHAw+vbNfT5Ic5WkRMEFMw6NrYbMNi08+bBfhRNRYxKWKdF6k=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uC7LNs64VVJo; Tue,  5 Mar 2019 09:28:52 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id C25064042E;
        Tue,  5 Mar 2019 09:28:52 +0100 (CET)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 6E1E4202C;
        Tue,  5 Mar 2019 09:28:42 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Mar 2019 09:28:39 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Li Yang <leoli@freescale.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        =?UTF-8?Q?Linux_Kernel_?=
         =?UTF-8?Q?=E4=B8=AD=E6=96=87=E7=A4=BE=E5=8C=BA?= 
        <linux-kernel@zh-kernel.org>, linux-doc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, harryxiyou@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
In-Reply-To: <CADRPPNT6=848XjB3uNAhgDRwFb+KsLY7pR3xFVaMLkGjqGpy5g@mail.gmail.com>
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
 <20190304035744.155203-2-alex.shi@linux.alibaba.com>
 <CADRPPNT6=848XjB3uNAhgDRwFb+KsLY7pR3xFVaMLkGjqGpy5g@mail.gmail.com>
Message-ID: <d221117e002b42150d785cfc47cac7cd@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-04 23:06, Li Yang wrote:
> On Sun, Mar 3, 2019 at 10:03 PM Alex Shi <alex.shi@linux.alibaba.com> 
> wrote:
>> 
>> This a disclaimer file which will be included in Chinese files
>> as header. To reduce the same common contents copy.
> 
> It is great for reducing the duplication.  But since this is in the
> translation folder, probably it will be even better to include a
> translated version of this disclaimer too?

In the Italian translation I wrote the disclaimer in English because it
contains information also for non-Italian readers.
I understand both prospectives and I do not have a strong opinion. The 
only
strong opinion that I have concern consistency: we should do all the 
same.

I will propose an RFC patch with a compromise solution (it will be 
easier
than explaining it) based on the Italian translation (no need to know 
Italian)

> Regards,
> Leo
> 
>> 
>> Most of contents quoted from Federico Vaga's file:
>> Documentation/translations/it_IT/disclaimer-ita.rst.
>> Thanks a lot!
>> 
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Harry Wei <harryxiyou@gmail.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Li Zefan <lizefan@huawei.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Coly Li <colyli@suse.de>
>> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
>> ---
>>  Documentation/translations/zh_CN/disclaimer-zh_CN.rst | 11 
>> +++++++++++
>>  1 file changed, 11 insertions(+)
>>  create mode 100644 
>> Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>> 
>> diff --git a/Documentation/translations/zh_CN/disclaimer-zh_CN.rst 
>> b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>> new file mode 100644
>> index 000000000000..0de5dfb069ca
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>> @@ -0,0 +1,11 @@
>> +:orphan:
>> +
>> +.. warning::
>> +   The purpose of this file is to be easier to read and understand 
>> for Chinese
>> +   speakers and is not intended as a fork. So, if you have any 
>> comments or
>> +   updates for this file please try to update the original English 
>> file first.
>> +
>> +.. note::
>> +   If you find any difference between this document and the original 
>> file or a
>> +   problem with the translation, please contact the maintainer of 
>> this file,
>> +   or get help from Alex Shi <alex.shi@linux.alibaba.com>
>> --
>> 2.19.1.856.g8858448bb
>> 

-- 
Federico Vaga
http://www.federicovaga.it/
