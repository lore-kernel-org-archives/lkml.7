Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1173C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E22214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfKFMCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:02:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:36492 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfKFMCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:02:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 04:02:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="196184483"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2019 04:02:01 -0800
Subject: Re: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to
 complete data requests if needed
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
 <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
 <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com>
 <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com>
Date:   Wed, 6 Nov 2019 14:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 12:48 PM, Baolin Wang wrote:
> On Wed, 6 Nov 2019 at 18:10, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 29/10/19 7:43 AM, Baolin Wang wrote:
>>> When using the host software queue, it will trigger the next request in
>>> irq handler without a context switch. But the sdhci_request() can not be
>>> called in interrupt context when using host software queue for some host
>>> drivers, due to the get_cd() ops can be sleepable.
>>>
>>> But for some host drivers, such as Spreadtrum host driver, the card is
>>> nonremovable, so the get_cd() ops is not sleepable, which means we can
>>> complete the data request and trigger the next request in irq handler
>>> to remove the context switch for the Spreadtrum host driver.
>>>
>>> Thus we still need introduce a variable in struct sdhci_host to indicate
>>> that we will always to defer to complete data requests if the sdhci_request()
>>> can not be called in interrupt context for some host drivers, when using
>>> the host software queue.
>>>
>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c |    2 +-
>>>  drivers/mmc/host/sdhci.h |    1 +
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 850241f..9cf2130 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
>>>  {
>>>       struct mmc_data *data = mrq->data;
>>>
>>> -     return host->pending_reset ||
>>> +     return host->pending_reset || (host->always_defer_done && data) ||

To move ahead in the meantime without a new host API, just defer always i.e.

+     return host->pending_reset || host->always_defer_done ||

>>
>> I didn't realize you still wanted to call the request function in interrupt
>> context.  In my view that needs a new host API
>> i.e. int (*request_atomic)(struct mmc_host *mmc, struct mmc_request *mrq)
> 
> Actually there are no documentation said that the
> mmc_host_ops->request() is a sleepable API, so I introduce a
> host->always_defer_done flag to decide if the request can be called in
> interrupt context or not, since for some host drivers, the request()
> implementation can be called in interrupt context.
> 
> Yes, I agree a new host API is more reasonable, if you do not like the
> current approach, I can add new patches to introduce the new
> request_atomic() API. But can I create another separate patch set to
> do this? since in this patch set, the Spreadtrum host driver's
> request() implementation can be called in interrupt context. Or you
> still want these changes introducing new request_atomic() can be done
> in this patch set? Thanks.
> 
>>
>>>              ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>>>               data->host_cookie == COOKIE_MAPPED);
>>>  }
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index d89cdb9..38fbd18 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -533,6 +533,7 @@ struct sdhci_host {
>>>       bool pending_reset;     /* Cmd/data reset is pending */
>>>       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>>>       bool v4_mode;           /* Host Version 4 Enable */
>>> +     bool always_defer_done; /* Always defer to complete data requests */
>>>
>>>       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>>>       struct mmc_command *cmd;        /* Current command */
>>>
>>
> 
> 

