Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8DFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972A72070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfE1Lpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:45:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:10312 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfE1Lpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:45:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 04:45:36 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 04:45:31 -0700
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
 <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
 <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com>
 <aa8e526f-b382-f3b7-74a5-e0fee09ae096@broadcom.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2d6fa51d-27af-4f90-2bd6-144112ce75ad@intel.com>
Date:   Tue, 28 May 2019 14:45:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aa8e526f-b382-f3b7-74a5-e0fee09ae096@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/19 2:21 PM, Arend Van Spriel wrote:
> 
> 
> On 5/28/2019 12:04 PM, Adrian Hunter wrote:
>> On 26/05/19 9:42 PM, Arend Van Spriel wrote:
>>> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
>>>> Normally when the MMC core sees an "-EILSEQ" error returned by a host
>>>> controller then it will trigger a retuning of the card.  This is
>>>> generally a good idea.
>>>
>>> Probably a question for Adrian, but how is this retuning scheduled. I recall
>>> seeing something in mmc_request_done. How about deferring the retuning upon
>>> a release host or is that too sdio specific.
>>
>> Below is what I have been carrying the last 4 years.  But according to
>> Douglas'
>> patch, the release would need to be further down.  See 2nd diff below.
>> Would that work?
> 
> That makes sense. The loop is needed because the device can be a bit bone
> headed. So indeed after the loop the device should be awake and able to
> handle CMD19.

What if tuning is needed to read SBSDIO_FUNC1_SLEEPCSR successfully?
