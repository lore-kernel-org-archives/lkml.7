Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED8820663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bmag2R2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfLJIz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:55:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38134 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLJIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:55:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so19057116wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WJMZcMT5U6/PxyRWHHDkiisysRfnrUDp7BQ62iDzKRI=;
        b=bmag2R2m7kYpRwCp4ityG/nO7FGl8CBWYymJGOH5S73fBCk920O7X5a4ssyafDzpjd
         OXKnrHEE/4EXXcLdPYWVyM6j5avsJJLjlwO8Fs5Sf9hakNAemu9tAzJA+wB5o865ssWf
         DqQzL9Qbw+OPgDUDoQIRFGGUXoPxrxmillZhpFlfXQj6UHFzz8qBbC1zj1lU228Lu86m
         xx4/LrPzQ3+HrdxdX/Z7w8rdJXwL0bcx8tWHwUPJqQvMKzavnxyn4Q6Alat5WfwbgCpV
         Gmg+TyfhiNaPZXyDQdu0suXrDw82d53HTKovkvR7AoekMWwNkjbNsfvgAlofQUBQlqYT
         XgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WJMZcMT5U6/PxyRWHHDkiisysRfnrUDp7BQ62iDzKRI=;
        b=O4uSAkpkCgnXgPKar60ayjMBtSaqXR8td8//wLXMRpfJAP7JahcWkbwo2bRU1xS/GT
         8hpWlfguNh6BU/VIUiCyy7KspyQJKrO1+mdch8VCYERA6xatpcw6tgLGoC7ZgZegjxi7
         ybtBy1iXLYpshIGSGBbqcCdhR+ddXOXuVr5T2oykNLLGSX96R3GwkeKVTufSq955+5UU
         e3QEw6q9RuSipiNjzpX1cJHBRxQgU1+sYO5nkk5YlmxcY5L3sXeFdxmyg+3iMxutX17/
         EQfL8JJtF5A9moJNXlg4+91xwtjIfQ32LTcqL6FQuAaySnW9crtw+KkEG9APC8BwwTC8
         xTrw==
X-Gm-Message-State: APjAAAV8bVuHFbvONJEbvo0OacDi1/ikH9f+ojJH0YZ1SDwC1vJ5x6ji
        nN+sUb4LXrIrWCADMmIZDZkByA==
X-Google-Smtp-Source: APXvYqwX9k1zWkayKQA7gpWyntCDmmjP6qoXQ9E/JUxy1pTJr/Wr5HqyiAJkqqKKk+mjmEpNxWF9kQ==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr1837211wrt.362.1575968151891;
        Tue, 10 Dec 2019 00:55:51 -0800 (PST)
Received: from [10.2.4.229] (lfbn-1-7161-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x18sm2461907wrr.75.2019.12.10.00.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 00:55:51 -0800 (PST)
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>
Cc:     Tim <elatllat@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh@kernel.org>
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com>
 <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
 <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com>
 <c32007f5-88b9-45c5-b542-b1dc4dbc76ea@baylibre.com>
 <CAKgpwJVHF6Ytdt9kq5SwiixFDLym_UPG51aXag1nVVay0pzofQ@mail.gmail.com>
 <45212db9-e366-2669-5c0a-3c5bd06287f6@synopsys.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ce35b6d2-7ed1-be2d-6e38-4c6e89340a40@baylibre.com>
Date:   Tue, 10 Dec 2019 09:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <45212db9-e366-2669-5c0a-3c5bd06287f6@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/11/2019 21:03, Thinh Nguyen wrote:
> Hi,
> 
> Jun Li wrote:
>> This bug exists on all current versions per information I got from Synopsys.
>> + Thinh Nguyen <thinhn@synopsys.com>.
>>
>> Li Jun
> 
> The GUCTL1.PARKMODE_DISABLE_SS is only available in dwc_usb3 controller 
> running in host mode. This should not be set for other IPs.
> 
> This can be disabled by default based on IP, but I recommend to have a 
> property to enable this feature for devices that need this.

Thanks, so this patchset is the right way to solve this.

Felipe, would it be possible to have it merged for next release ?
Should I resend it ?

Thanks,
Neil

> 
> 
>>
>> Neil Armstrong <narmstrong@baylibre.com> 于2019年11月12日周二 下午5:00写道：
>>> Hi Li,
>>>
>>> On 11/11/2019 02:58, Jun Li wrote:
>>>> Hi Neil
>>>>
>>>> As I got the information from Synopsys, this bug exists on current IP versions,
>>>> and per my tests with external USB3 hub + 2 Super speed udisks on data
>>>> read by dd, I can reproduce this issue with different kernel versions, also I
>>>> didn't see obvious performance drop by dd tests after disable park mode for
>>>> super speed, so should we just disable it by default so no need a quirk?
>>> I don't have any opinion on this, I think the USB & DWC3 maintainers should decide
>>> how to handle this.
>>>
>>> Did Synopsys specified a range of affected IP version ?
>>>
>>> Neil
>>>
>>>> Li Jun
>>>>
>>>> Tim <elatllat@gmail.com> 于2019年11月11日周一 上午8:42写道：
>>>>> Thanks for working on this Neil,
>>>>> Is there something that needs doing for this patch to make it into 5.3 or 5.4?
>>>>> As previously mentioned the patch set fixes the issue on affected hardware;
>>>>>      https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_11164515_&d=DwIFaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=u9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=BCfRHM9e86039Su0-QvK_yUjNnYrnl_BcvxTtViypT8&s=aV5u7uxNX6oTLB3_-qNuzrNvyiqx_rPC6P9TMqG-LNE&e=
>>>>>
>>>>>
>>>>>
>>>>> On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
>>>>>> On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
>>>>>>> This patch updates the documentation with the information related
>>>>>>> to the quirks that needs to be added for disabling all SuperSpeed XHCi
>>>>>>> instances in park mode.
>>>>>>>
>>>>>>> CC: Dongjin Kim <tobetter@gmail.com>
>>>>>>> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
>>>>>>> Reported-by: Tim <elatllat@gmail.com>
>>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>>> ---
>>>>>>>   Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
>>>>>>>   1 file changed, 2 insertions(+)
>>>>>> Sigh, what's one more to the never ending list of quirks...
>>>>>>
>>>>>> Acked-by: Rob Herring <robh@kernel.org>
> 
> BR,
> Thinh
> 

