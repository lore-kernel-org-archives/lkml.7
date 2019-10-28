Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBCB214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfJ1JLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:11:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:41383 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfJ1JLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:11:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 02:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="198026515"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by fmsmga008.fm.intel.com with ESMTP; 28 Oct 2019 02:11:17 -0700
Subject: Re: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct
 sdhci_ops
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
 <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
 <50696230-75f4-3de4-7424-c33d531ee159@intel.com>
 <CAMz4kuJAwV7f=pjUqs1nO3+L5NbcwCQrCi-HGUPPXgp7rWUs=g@mail.gmail.com>
 <CAMz4kuKfqMoM3WdaG8o0JHpXeUZHYpLt4P15BsOriU2h2OV--A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <60aabcc6-9def-1472-0e1f-3fec391ef1cd@intel.com>
Date:   Mon, 28 Oct 2019 11:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKfqMoM3WdaG8o0JHpXeUZHYpLt4P15BsOriU2h2OV--A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/19 10:38 AM, Baolin Wang wrote:
> On Mon, 28 Oct 2019 at 16:27, Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> Hi Adrian,
>>
>> On Mon, 28 Oct 2019 at 16:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 22/10/19 8:58 AM, Baolin Wang wrote:
>>>> Add request_done ops for struct sdhci_ops as a preparation in case some
>>>> host controllers have different method to complete one request, such as
>>>> supporting request completion of MMC software queue.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c |   12 ++++++++++--
>>>>  drivers/mmc/host/sdhci.h |    2 ++
>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index b056400..850241f 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>>
>>>>       spin_unlock_irqrestore(&host->lock, flags);
>>>>
>>>> -     mmc_request_done(host->mmc, mrq);
>>>> +     if (host->ops->request_done)
>>>> +             host->ops->request_done(host, mrq);
>>>
>>> For hsq, couldn't this result in sdhci_request() being called interrupt
>>> context here.
>>
>> Right, now it did not support.
>>
>>>
>>> To prevent that you would need to add a condition to sdhci_defer_done() so
>>> it always defers when using hsq.
>>
>> Yes, but now the condition can be matched in sdhci_defer_done()  when
>> using hsq. So no need to worry that the sdhci_request() will be called
>> in interrupt
>> context in this patch set. Thanks.
>>
> 
> Wait, sorry, I realized some drivers may not select the
> SDHCI_REQ_USE_DMA flag in sdhci_defer_done()  when using hsq. OK, So
> how about below changes?
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 850241f..6c7a396 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
> sdhci_host *host,
>  {
>         struct mmc_data *data = mrq->data;
> 
> -       return host->pending_reset ||
> +       return IS_ENABLED(CONFIG_MMC_HSQ) || host->pending_reset ||

Just because it is configured does not mean it is used.  How about adding a
variable host->always_defer_done and set it in sdhci_sprd_probe().

>                ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>                 data->host_cookie == COOKIE_MAPPED);
>  }
> 

