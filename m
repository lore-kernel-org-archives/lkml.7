Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AA2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A292321473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfDHPub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:50:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46128 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfDHPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:50:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BB0162817F8
Subject: Re: [PATCH v2] mfd: cros_ec: check for NULL transfer function
To:     =?UTF-8?Q?Jett_=e2=9c=88_Rink?= <jettrink@google.com>,
        egranata@chromium.org
Cc:     Guenter Roeck <groeck@google.com>,
        Benson Leung <bleung@chromium.org>, gwendal@chromium.org,
        amstan@chromium.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
 <20190403224036.203632-1-egranata@chromium.org>
 <CAK+PMK7cGVy-o_GX_p4asEMSsB9KoNK+x5WdNo2b+pXUFzJZGw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ffc12c5b-2481-ac02-5093-2f14d362ff26@collabora.com>
Date:   Mon, 8 Apr 2019 17:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK+PMK7cGVy-o_GX_p4asEMSsB9KoNK+x5WdNo2b+pXUFzJZGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

Many thanks to send this upstream.

On 4/4/19 18:00, Jett ✈ Rink wrote:
> Reviewed-by: Jett Rink <jettrink@chromium.org>
> 
> On Wed, Apr 3, 2019 at 4:40 PM <egranata@chromium.org> wrote:
>>
>> From: Enrico Granata <egranata@chromium.org>
>>
>> As new transfer mechanisms are added to the EC codebase, they may
>> not support v2 of the EC protocol.
>>
>> If the v3 initial handshake transfer fails, the kernel will try
>> and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
>> will be NULL, and the code will end up causing a kernel panic.
>>
>> Add a check for NULL before calling the transfer function, along
>> with a helpful comment explaining how one might end up in this
>> situation.
>>
>> Signed-off-by: Enrico Granata <egranata@chromium.org>
>> ---
>>  drivers/platform/chrome/cros_ec_proto.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>> index 97a068dff192d..55691656a3c27 100644
>> --- a/drivers/platform/chrome/cros_ec_proto.c
>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>> @@ -56,6 +56,16 @@ static int send_command(struct cros_ec_device *ec_dev,
>>         else
>>                 xfer_fxn = ec_dev->cmd_xfer;
>>
>> +       if (xfer_fxn == NULL) {
>> +               /* This error can happen if a communication error happened and

Like Guenter I personally don't like the networking-style multi-line comments.
We try to use the default kernel-style so if you don't mind I'll change this.


>> +                * the EC is trying to use protocol v2, on an underlying
>> +                * communication mechanism that does not support v2.
>> +                */
>> +               dev_err_once(ec_dev->dev,
>> +                       "missing EC transfer API, cannot send command\n");
>> +               return -EIO;
>> +       }
>> +
>>         ret = (*xfer_fxn)(ec_dev, msg);
>>         if (msg->result == EC_RES_IN_PROGRESS) {
>>                 int i;
>> --
>> 2.21.0.392.gf8f6787159e-goog
>>

I'll add the patch to the for-next branch in chrome-platform repository for
auto-builders to play with. If all goes well I'll queue the patch for
chrome-platform-5.2.

Thanks,
 Enric

