Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2016C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6DE2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLQGpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:45:12 -0500
Received: from olimex.com ([184.105.72.32]:36342 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLQGpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:45:11 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:45:11 -0800
Subject: Re: [PATCH 1/1] drm/sun4i: hdmi: Check for null pointer before
 cleanup
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20191216144348.7540-1-stefan@olimex.com>
 <20191216161258.lmkq2ersfm746t7q@gilmour.lan>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <cebda755-2649-79a1-fd08-79b13edef1a5@olimex.com>
Date:   Tue, 17 Dec 2019 08:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191216161258.lmkq2ersfm746t7q@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/16/19 6:12 PM, Maxime Ripard wrote:
> Hi,
>
> On Mon, Dec 16, 2019 at 04:43:48PM +0200, Stefan Mavrodiev wrote:
>> It's possible hdmi->connector and hdmi->encoder divices to be NULL.
>> This can happen when building as kernel module and you try to remove
>> the module.
>>
>> This patch make simple null check, before calling the cleanup functions.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> index a7c4654445c7..b61e00f2ecb8 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> @@ -685,8 +685,10 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
>>   	struct sun4i_hdmi *hdmi = dev_get_drvdata(dev);
>>
>>   	cec_unregister_adapter(hdmi->cec_adap);
>> -	drm_connector_cleanup(&hdmi->connector);
>> -	drm_encoder_cleanup(&hdmi->encoder);
>> +	if (hdmi->connector.dev)
>> +		drm_connector_cleanup(&hdmi->connector);
>> +	if (hdmi->encoder.dev)
>> +		drm_encoder_cleanup(&hdmi->encoder);
> Hmmm, this doesn't look right. Do you have more information on how you
> can reproduce it?

Just build sun4i_drm_hdmi as module (CONFIG_DRM_SUN4I_HDMI=m). Then try 
to unload the module:

# rmmod sun4i_drm_hdmi

And you get this:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 6b032436
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in: sun4i_drm_hdmi(-)
CPU: 0 PID: 1081 Comm: rmmod Not tainted 5.5.0-rc1-00030-g6ec417030d93 #33
Hardware name: Allwinner sun7i (A20) Family
PC is at drm_connector_cleanup+0x40/0x208
LR is at sun4i_hdmi_unbind+0x10/0x54 [sun4i_drm_hdmi]
...


I've tested that with sunxi/for-next branch on A20-OLinuXino board.

Best regards,
Stefan

>
> Maxime
