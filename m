Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADCC742BC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E3920645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGLMn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:43:29 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49192 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfGLMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:43:29 -0400
Received: from [167.98.27.226] (helo=[10.35.6.255])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hlutW-0005sm-6E; Fri, 12 Jul 2019 13:43:22 +0100
Subject: Re: [PATCH v1 06/11] ti948: Reconfigure in the alive check when
 device returns
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-7-michael.drake@codethink.co.uk>
 <20190611181046.GU5016@pendragon.ideasonboard.com>
From:   Michael Drake <michael.drake@codethink.co.uk>
Message-ID: <8aed947d-91ae-c67b-9911-9365bf80aac3@codethink.co.uk>
Date:   Fri, 12 Jul 2019 13:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190611181046.GU5016@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 11/06/2019 19:10, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.

My pleasure, and thank you for the feedback!

> On Tue, Jun 11, 2019 at 03:04:07PM +0100, Michael Drake wrote:
>> If the alive check detects a transition to the alive state,
>> the device configuration is rewritten.
> 
> This seems like a big hack. You will have at the very least to explain
> why this is needed, and why you can't configure the device in response
> to drm_bridge operation calls.

The ti948 device is situated inside the housing of the LCD
panel.  The ti949 is a normal i2c device on the system i2c
bus.  In order for the ti948 to appear on the system's i2c
bus, the ti949 must be powered up and configured.

The panel is connected to the system via the FPD-Link III.
If a connector for the wire to the display is unplugged and
re-inserted, then the ti948 will drop out and come back.

Application note AN-2173, "I2C Communication Over
FPD-LinkIII with Bidirectional Control Channel" describes
this:

  http://www.ti.com/lit/an/snla131a/snla131a.pdf

Perhaps I need to expand the commit message to explain this?

Alternatively is there a more standard way of dealing with
remotely connected i2c devices?

>> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  drivers/gpu/drm/bridge/ti948.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
>> index 86daa3701b91..b5c766711c4b 100644
>> --- a/drivers/gpu/drm/bridge/ti948.c
>> +++ b/drivers/gpu/drm/bridge/ti948.c
>> @@ -132,6 +132,8 @@ struct ti948_reg_val {
>>   * @reg_names:   Array of regulator names, or NULL.
>>   * @regs:        Array of regulators, or NULL.
>>   * @reg_count:   Number of entries in reg_names and regs arrays.
>> + * @alive_check: Context for the alive checking work item.
>> + * @alive:       Whether the device is alive or not (alive_check).
>>   */
>>  struct ti948_ctx {
>>  	struct i2c_client *i2c;
>> @@ -141,6 +143,8 @@ struct ti948_ctx {
>>  	const char **reg_names;
>>  	struct regulator **regs;
>>  	size_t reg_count;
>> +	struct delayed_work alive_check;
>> +	bool alive;
>>  };
>>  
>>  static bool ti948_readable_reg(struct device *dev, unsigned int reg)
>> @@ -346,6 +350,8 @@ static int ti948_power_on(struct ti948_ctx *ti948)
>>  	if (ret != 0)
>>  		return ret;
>>  
>> +	ti948->alive = true;
>> +
>>  	msleep(500);
>>  
>>  	return 0;
>> @@ -356,6 +362,8 @@ static int ti948_power_off(struct ti948_ctx *ti948)
>>  	int i;
>>  	int ret;
>>  
>> +	ti948->alive = false;
>> +
>>  	for (i = ti948->reg_count; i > 0; i--) {
>>  		dev_info(&ti948->i2c->dev, "Disabling %s regulator\n",
>>  				ti948->reg_names[i - 1]);
>> @@ -388,8 +396,17 @@ static void ti948_alive_check(struct work_struct *work)
>>  {
>>  	struct delayed_work *dwork = to_delayed_work(work);
>>  	struct ti948_ctx *ti948 = delayed_work_to_ti948_ctx(dwork);
>> +	int ret = ti948_device_check(ti948);
>>  
>> -	dev_info(&ti948->i2c->dev, "%s Alive check!\n", __func__);
>> +	if (ti948->alive == false && ret == 0) {
>> +		dev_info(&ti948->i2c->dev, "Device has come back to life!\n");
>> +		ti948_write_config_seq(ti948);
>> +		ti948->alive = true;
>> +
>> +	} else if (ti948->alive == true && ret != 0) {
>> +		dev_info(&ti948->i2c->dev, "Device has stopped responding\n");
>> +		ti948->alive = false;
>> +	}
>>  
>>  	/* Reschedule ourself for the next check. */
>>  	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
> 

-- 
Michael Drake                 https://www.codethink.co.uk/
