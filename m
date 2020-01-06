Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCD8C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA402075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgAFLaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:30:05 -0500
Received: from mail.netline.ch ([148.251.143.178]:38581 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAFLaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:30:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id E24142A604E;
        Mon,  6 Jan 2020 12:30:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1F-LcxBlJexm; Mon,  6 Jan 2020 12:30:01 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch [83.76.80.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 207DA2A604B;
        Mon,  6 Jan 2020 12:30:00 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.93)
        (envelope-from <michel@daenzer.net>)
        id 1ioQa8-003Crs-2y; Mon, 06 Jan 2020 12:30:00 +0100
Subject: Re: Warning: check cp_fw_version and update it to realize GRBM
 requires 1-cycle delay in cp firmware
To:     Alex Deucher <alexdeucher@gmail.com>,
        Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chang Zhu <Changfeng.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <745c5951-5304-9651-34f1-6b3f6a713ece@molgen.mpg.de>
 <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <3553af46-c9c5-cd33-e7f9-bf7a1a5f49a7@daenzer.net>
Date:   Mon, 6 Jan 2020 12:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-26 5:53 p.m., Alex Deucher wrote:
> On Thu, Dec 26, 2019 at 5:11 AM Paul Menzel
>>
>>> [   13.446975] [drm] Warning: check cp_fw_version and update it to realize                          GRBM requires 1-cycle delay in cp firmware
>>
>> Chang, it looks like you added that warning in commit 11c6108934.
>>
>>> drm/amdgpu: add warning for GRBM 1-cycle delay issue in gfx9
>>>
>>> It needs to add warning to update firmware in gfx9
>>> in case that firmware is too old to have function to
>>> realize dummy read in cp firmware.
>>
>> Unfortunately, it looks like you did not even check how the warning is
>> formatted (needless spaces), so I guess this was totally untested. Also,
>> what is that warning about, and what is the user supposed to do? I am
>> unable to find `cp_fw_version` in the source code at all.
>>
> 
> The code looks fine.  Not sure why it's rendering funny in your log.
>                DRM_WARN_ONCE("Warning: check cp_fw_version and update
> it to realize \
>                              GRBM requires 1-cycle delay in cp firmware\n");

Looks like the leading spaces after the backslash are included in the
string. Something like this should be better:

        DRM_WARN_ONCE("Warning: check cp_fw_version and update "
                      "GRBM requires 1-cycle delay in cp firmware\n");

(or maybe the intention was to put the second sentence on a new line?)


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
