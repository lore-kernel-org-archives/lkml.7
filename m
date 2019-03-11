Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80702C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfCKKJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:09:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:09:29 -0400
Received: from [192.168.1.110] ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXYAj-1hYw9W1iFr-00YyVh; Mon, 11 Mar 2019 11:09:13 +0100
Subject: Re: [PATCH] leds: fix a potential NULL pointer dereference
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Riku Voipio <riku.voipio@iki.fi>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190309060411.29074-1-kjlu@umn.edu>
 <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <32c84850-85e8-e063-b104-220afe0554f8@metux.net>
Date:   Mon, 11 Mar 2019 11:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l4WWnk0lhDdM6zcHsosPQv0MZ2ja7pssbyUY4v5jX2yUALokfsS
 iHEUoMMfEHzlZUCiTLF0pWIlERFJDjBDvbTJdnloqLSO+cob/GP1CEhPwsY2gPIJSVt7fRR
 hD+YcWAPT7QO/0QGtf/rsL13dpQmIdSONEXt8eIqD2Zv0Pbm50DZjut97QSnuBgeEQLLaA9
 2UGVogY0kngl+dp5qrZmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oz041aZd7qo=:cNuckBhySI5nv+8WwA33GK
 FGywX1Fg88RZ5ypUC0hlFf5xxtp+LIsUpnSA3o3nFOGWoTbznf+HCmin4z66djTpsdJ3Tkxwh
 I5zw3Xu3qawgel9QCOS2+ZPcQiPta/1l5Ryhk0Eh6Ft7royaJI7zCfBSgklQfwGOn2js/fMJ/
 QuNDTsoIkcct8IKMMIlCAEF3wmtg/ATEPCeAn34EpgSuSmjwd3V/iwyked48VKvVpW3WgRvVZ
 zNkC3RBkhrtjSvIpus/1Jk/tphmM7fLAlngYU7KO9LrrW8JhaWVYlFiAHJNh3BmLaCM/b3zqJ
 vTzC37psTonArOoMIwyF7Xk18399/repAO9+O16F/8wGtsV4CmrGMpooUTg/Zu6YMiodGzVzZ
 0wvGJmO6VlTSNgGouNS3dKnUFP/cdJRiHY+yuSjJ83+lfbxX1rrKTSs0cpYGCMlsSig7UuVRf
 L6dpPNxIA2QzRsE3EUpaoywVbd5ydmaUNQqZTR6wrbepDD2xOENPAYJOHJqtdVs9eStjeG7kG
 whYu1uBixIQWJ67mCddhDLDh5BgNmTQLTTl5AC1IU4thGUYHKmrpfIik5Vep559ZL+I3h7EK2
 lROl0wRie6naOH5w9sjE9sxGqJrG000esg3lVq4hq+5eyPQVrLKQsoPeMrqhmghQR+SIt+poq
 81iqhcqtythH5ASFAFosbBgF/KOdew8xnPv7NzsOsEEaLTYcyEjzYd8/D0faSQP19XQsBm29E
 bMP0DbQurzH0DsOZv/uQc6Sm7bZuSJ45u8NhXI80bmQkbZDLluSQ3NUTrbg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.19 21:27, Jacek Anaszewski wrote:
> Hi Kangjie,
> 
> Thank you for the patch.
> 
> On 3/9/19 7:04 AM, Kangjie Lu wrote:
>> In case of_match_device cannot find a match, the fixes returns
>> -EINVAL to avoid NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   drivers/leds/leds-pca9532.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
>> index 7fea18b0c15d..4b0335591728 100644
>> --- a/drivers/leds/leds-pca9532.c
>> +++ b/drivers/leds/leds-pca9532.c
>> @@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
>>       const struct i2c_device_id *id)
>>   {
>>       int devid;
>> +    const struct of_device_id *of_id;

Looks like an indention mismatch that might call for the
Great White Handkerchief ;-)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
