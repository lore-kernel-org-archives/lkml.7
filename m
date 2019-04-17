Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8581206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfDQQDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:03:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36241 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbfDQQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:03:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so20821845edm.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=TrOSUukhnqSg/DvgTstF5Ra/HwZaX5omSNw3ixRKxT4=;
        b=UdkeRi+sMRUVlnGWlzj61SnqTpKLx4bMOa8YX1RpqX6YyItksxy0hnTgIv5OdGDkV9
         saqp91jKiQwDQPZF7yMjZBTyD/8GMc9EgCp2rLxVkk1JzFjHz59KB3UPTC4mOFlfJM3q
         Hk2OQsMztrrkHPpvm8G3B06jOtDt58T5dfbxBqa7iyftp64T94zkvBmmjl8VNHVFdHA8
         10VgK4HJYhNlZ04WPJFIgL82KUXPlqbSzl6WdtZqbOMwCTP3Xx1qvSV+hxaxNrFSAH9l
         tT2CXkNGLNkwF9l3tQoXDwiVVAARMvoSrpUvBYdbVcHS+rhsMucSpyc6qAUEYDk8k+FU
         MA3g==
X-Gm-Message-State: APjAAAWAmBuaV5C01gA4wY8DSX9m5Y5TO7BOJ+yCS/Qon8lLcIcOnzsJ
        wjG0UM5ZHW5MNUtlSrtksMZWeQ==
X-Google-Smtp-Source: APXvYqxWr0QLqtiFtdv0dgY9WvcEWr1O2Jmxx2IgDRDN0ZU4uOYaN0tLN8hmV2cRcCclrgA2osXEjg==
X-Received: by 2002:a17:906:6d58:: with SMTP id a24mr48618747ejt.195.1555516985764;
        Wed, 17 Apr 2019 09:03:05 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s14sm6590730eda.26.2019.04.17.09.03.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 09:03:04 -0700 (PDT)
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <20190417093252.GO1747@kuha.fi.intel.com>
 <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
 <20190417104454.GQ1747@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb7cf930-cf76-ef73-49de-222895b133ea@redhat.com>
Date:   Wed, 17 Apr 2019 18:03:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417104454.GQ1747@kuha.fi.intel.com>
Content-Type: multipart/mixed;
 boundary="------------C16F2A63C9CF340E7A34C72F"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C16F2A63C9CF340E7A34C72F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17-04-19 12:44, Heikki Krogerus wrote:
> On Wed, Apr 17, 2019 at 12:15:18PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 17-04-19 11:32, Heikki Krogerus wrote:
>>> On Wed, Apr 17, 2019 at 11:19:28AM +0200, Hans de Goede wrote:
>>
>> <snip>
>>
>>>> That is not going to work since the (virtual) mux / orientation-switch
>>>> devices are only registered once the driver binds to the piusb30532 i2c
>>>> device, so when creating the nodes we only have the piusb30532 i2c device.
>>>
>>> It's not a problem, that's why we have the software nodes. The nodes
>>> can be created before the device entires. The node for pi3usb30532
>>> will just be the parent node for the new nodes we add for the mux and
>>> switch.
>>>
>>>> I've been thinking some more about this and an easy fix is to have separate
>>>> fwnode_match functions for typec_switch_match and typec_mux_match and have
>>>> them check that the dev_name ends in "-mux" resp. "-switch" that requires
>>>> only a very minimal change to "usb: typec: Registering real device entries for the muxes"
>>>> and then everything should be fine.
>>>
>>> I don't want to do anymore device name matching unless we have to, and
>>> here we don't have to. We can name the nodes for those virtual mux and
>>> switch, and then just do fwnode_find_named_child_node() in
>>> pi3usb30532.c for both of them.
>>
>> Thinking more about this, I have a feeling that this makes things needlessly
>> complicated, checking the dev_name *ends* in "-mux" resp. "-switch" should be
>> 100% reliable since we call:
>>
>>          dev_set_name(&sw->dev, "%s-switch", dev_name(parent));
>>          dev_set_name(&mux->dev, "%s-mux", dev_name(parent));
>>
>> When registering the switch / mux, so I believe doing name (suffix) comparison
>> here is fine and much simpler. Anyways this is just my 2 cents on this, I'm
>> happy with either solution, your choice.
> 
> You do have a point. I'll take a look how the two options look like,
> but maybe your way is better after all.

I whipped up a quick fix using my approach so that I can start working
on debugging the usb_role_switch_get call in tcpm.c returning NULL.

I've attached it, feel free to use this for v4 of the series if you
decide to go with this approach.

Regards,

Hans


> 
> thanks,
> 

--------------C16F2A63C9CF340E7A34C72F
Content-Type: text/x-patch;
 name="0001-FIXUP-usb-typec-Registering-real-device-entries-for-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-FIXUP-usb-typec-Registering-real-device-entries-for-.pa";
 filename*1="tch"

From 47154195c05dc7c8b3373de9603b06c2f435588a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 17 Apr 2019 17:58:17 +0200
Subject: [PATCH v2] FIXUP: "usb: typec: Registering real device entries for
 the muxes"

Check the dev_name suffix so that we do not return the first registered
device when a mux and switch share the same parent and fwnode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/typec/mux.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index c7d4a2dd454e..a28803544301 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -22,9 +22,21 @@ static int name_match(struct device *dev, const void *name)
 	return !strcmp((const char *)name, dev_name(dev));
 }
 
-static int fwnode_match(struct device *dev, const void *fwnode)
+static bool dev_name_ends_with(struct device *dev, const char *suffix)
 {
-	return dev_fwnode(dev) == fwnode;
+	const char *name = dev_name(dev);
+	const int name_len = strlen(name);
+	const int suffix_len = strlen(suffix);
+
+	if (suffix_len > name_len)
+		return false;
+
+	return strcmp(name + (name_len - suffix_len), suffix) == 0;
+}
+
+static int switch_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
 }
 
 static void *typec_switch_match(struct device_connection *con, int ep,
@@ -37,7 +49,7 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 			return NULL;
 
 		dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
-					fwnode_match);
+					switch_fwnode_match);
 	} else {
 		dev = class_find_device(&typec_mux_class, NULL,
 					con->endpoint[ep], name_match);
@@ -167,6 +179,11 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
 
 /* ------------------------------------------------------------------------- */
 
+static int mux_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
+}
+
 static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
 	const struct typec_altmode_desc *desc = data;
@@ -226,7 +243,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 
 find_mux:
 	dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
-				fwnode_match);
+				mux_fwnode_match);
 
 	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
-- 
2.21.0


--------------C16F2A63C9CF340E7A34C72F--
