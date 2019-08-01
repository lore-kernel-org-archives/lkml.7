Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14088C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE6320657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfHANa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:30:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbfHANa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:30:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F2BC928C4A8
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating
 script
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org, rrangel@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>
References: <20190730134704.44515-1-tzungbi@google.com>
 <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
 <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com>
 <CA+Px+wU=V0cGZeAxoqSJeVTLcO+v9=tPQKxKBTp-npsgqXo3yQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <89aac768-b096-c51c-2ec7-5c135b089a31@collabora.com>
Date:   Thu, 1 Aug 2019 15:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wU=V0cGZeAxoqSJeVTLcO+v9=tPQKxKBTp-npsgqXo3yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

On 1/8/19 15:04, Tzung-Bi Shih wrote:
> On Thu, Aug 1, 2019 at 6:59 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Tzung-Bi
>>
>> On 30/7/19 16:07, Tzung-Bi Shih wrote:
>>> Hi Enric,
>>>
>>> I found it is error-prone to replace the EC_CMDS after updated.
>>> Perhaps, we should introduce an intermediate file "cros_ec_trace.inc".
>>
>> I am not sure I get you here, a .inc? could you explain a bit more?
>>
> Manually generate .inc for all EC host commands:
> sed ... include/linux/mfd/cros_ec_commands.h | awk ...
>> drivers/platform/chrome/cros_ec_trace.inc
> 
> In cros_ec_trace.c:
> #include "cros_ec_trace.inc"
> 

Got it. I don't think this is a "kernel" way to do it. Also, I don't see a big
value on doing this.

> cros_ec_trace.inc:
> #ifndef EC_CMDS
> #define EC_CMDS \
>     ...
> #endif
> 
> Override the whole file instead of replacing part of file to prevent
> cut-and-paste error.
> 

The way I see all this is that bulk updates of that file "shouldn't be allowed"
or are not preferable. Ideally, _we_ (the maintainers), should take care on have
cros_ec_commands and cros_ec_trace sync. For that, when someone sends a patch
that touches the cros_ec_commands _we_ (them maintainers) should tell him to
update also the cros_ec_trace file in the same patchset, and the script, is
simply a helper to do that.

Note that the cros_ec_trace needs an update to match current cros_ec_commands
but I'm waiting to do the sync because we have a patchset that moves the
cros_ec_commands.h file from include/linux/mfd to include/linux/platform_data.
Once moved I'll sync the cros_ec_trace file with current cros_ec_commands

Note also that actually, we want:

- cros_ec_commands (kernel) sync with ec_commands (EC firmware)
- cros_ec_commands (kernel) sync with cros_ec_trace (kernel)

Hopefully we will have all sync soon.

Thanks,
~ Enric
