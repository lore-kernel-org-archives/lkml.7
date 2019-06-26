Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF10C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29D2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfFZG1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:27:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:53074 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfFZG13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:27:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 23:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,418,1557212400"; 
   d="scan'208";a="166931790"
Received: from mylly.fi.intel.com (HELO [10.237.72.158]) ([10.237.72.158])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2019 23:27:27 -0700
Subject: Re: [PATCH] i2c: designware: Add disable runtime pm quirk
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190625083051.30332-1-acelan.kao@canonical.com>
 <a3469010-829c-16dc-be83-6fe9b3021530@linux.intel.com>
 <CAFv23QnaKMs9bjS9ry_L4K7wskUqNR2AsgDG-v+fah2XO7EpKw@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <5c14537d-b6aa-b478-fdd8-29f690b15e07@linux.intel.com>
Date:   Wed, 26 Jun 2019 09:27:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFv23QnaKMs9bjS9ry_L4K7wskUqNR2AsgDG-v+fah2XO7EpKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 5:32 AM, AceLan Kao wrote:
> Adding I2C_HID_QUIRK_NO_RUNTIME_PM quirk doesn't help on this issue.
> Actually, Goodix touchpad already has that PM quirk in the list for other issue.
>          { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> I also modify the code as you suggested, but no luck.
> 
Yeah, I realized it won't help as the i2c-hid device is anyway powered 
on constantly when the device is open by the pm_runtime_get_sync() call 
in i2c_hid_open().

> It's not Goodix takes time to wakeup, it's designware I2C controller.
> Designware doesn't do anything wrong here, it's Goodix set the interrupt timeout
> that leads to the issue, so we have to prevent designware from runtime
> suspended.
> But only on that bus where Goodix is connected and open by user space. 
What I mean something like below:

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c 
b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fed08d3..bbeaa39ddc23 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -795,6 +795,9 @@ static int i2c_hid_open(struct hid_device *hid)
  	struct i2c_hid *ihid = i2c_get_clientdata(client);
  	int ret = 0;

+	/* some quirk test here */
+	pm_runtime_get_sync(&client->adapter->dev);
+
  	ret = pm_runtime_get_sync(&client->dev);
  	if (ret < 0)
  		return ret;
@@ -812,6 +815,9 @@ static void i2c_hid_close(struct hid_device *hid)

  	/* Save some power */
  	pm_runtime_put(&client->dev);
+
+	/* some quirk test here */
+	pm_runtime_put(&client->adapter->dev);
  }

  static int i2c_hid_power(struct hid_device *hid, int lvl)

-- 
Jarkko
