Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB1C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B14521911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfGVOPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:15:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37018 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:15:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E289928A49D
Subject: Re: [PATCH] mfd: cros_ec: Update cros_ec_commands.h
To:     Gwendal Grignou <gwendal@chromium.org>,
        Yicheng Li <yichengli@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20190708181536.2125-1-yichengli@chromium.org>
 <CAPUE2uvnPfA8y1bqppC3-vZyRKRwdF4evGY8X4c-xP=YZi4HRw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e241dc48-5cb0-3b60-9b84-cad8e80eb617@collabora.com>
Date:   Mon, 22 Jul 2019 16:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUE2uvnPfA8y1bqppC3-vZyRKRwdF4evGY8X4c-xP=YZi4HRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 11/7/19 19:17, Gwendal Grignou wrote:
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> 
> Note there is a patch series that move cros_ec_commands.h from
> nclude/linux/mfd/ to include/linux/platform_data.
> 

I just sent a new version of the patches mentioned above now that rc1 is out [1]

As Gwendal said this patch will conflict with them, so we have two options.

1. If Lee picks that patch I can rebase again my series on top of it.
2. If not, we can wait for Lee reviewing my patch series and then I don't mind
to rebase that patch on top of my series and carry the patch through
chrome-platform. Anyway I'll need an immutable branch from Lee.

> On Mon, Jul 8, 2019 at 11:16 AM Yicheng Li <yichengli@chromium.org> wrote:
>>
>> Update cros_ec_commands.h to match the fingerprint MCU section in
>> the current ec_commands.h
>>
>> Signed-off-by: Yicheng Li <yichengli@chromium.org>

For the first case:
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
~ Enric

[1] https://lkml.org/lkml/2019/7/22/497

>> ---
>>
>>  include/linux/mfd/cros_ec_commands.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
>> index 7ccb8757b79d..98415686cbfa 100644
>> --- a/include/linux/mfd/cros_ec_commands.h
>> +++ b/include/linux/mfd/cros_ec_commands.h
>> @@ -5513,6 +5513,18 @@ struct ec_params_fp_seed {
>>         uint8_t seed[FP_CONTEXT_TPM_BYTES];
>>  } __ec_align4;
>>
>> +#define EC_CMD_FP_ENC_STATUS 0x0409
>> +
>> +/* FP TPM seed has been set or not */
>> +#define FP_ENC_STATUS_SEED_SET BIT(0)
>> +
>> +struct ec_response_fp_encryption_status {
>> +       /* Used bits in encryption engine status */
>> +       uint32_t valid_flags;
>> +       /* Encryption engine status */
>> +       uint32_t status;
>> +} __ec_align4;
>> +
>>  /*****************************************************************************/
>>  /* Touchpad MCU commands: range 0x0500-0x05FF */
>>
>> --
>> 2.20.1
>>
