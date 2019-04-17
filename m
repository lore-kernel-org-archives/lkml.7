Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F8C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0D217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbfDQVOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:14:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40529 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfDQVOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:14:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id d46so20688eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=rvhXfISQ7guv1dC5rFPpKfGzEoCWMWQYMb15jsxNn0U=;
        b=CCZUQy4QSr8xkwTkDxVt4ExMCEchLPSaLoL/qz2hue+bhydCucXmBsmxjGuosIsOKi
         V8zUL6sPk4N24Z9luPOgBhcDyj3/Jw4+us2VPQmp7QjrR+07huuq30Iswstsd3ZcemSX
         bDWM5W3A9KTSty45k93UQ0+Zle/3oP2SyWvCQ7QvLPaU/2TI5P0qNKRUbSGWoxDBH/of
         1AxjoctlYCrLLb3w/QE0qZ+lIgKBVDgEgc6aG3FnR4X2xdUAjetFZb2zo+BBwQ4MA6zE
         WHbJWVGuPyI/oWYJsT4xi3y/lzkpjSwjyl5tB1YXeoLxIvRaEfY6G3ewIItrKx55HzHX
         LEUw==
X-Gm-Message-State: APjAAAWUOlc0xPmsHVQQ+cmhyrNJM77eiyhPLWUj8pgGlLT5joc0OW5k
        MxAgS3rsAIBOx8PZ3rk3bW1FSA==
X-Google-Smtp-Source: APXvYqyVGU9BerZ/mw5GMj61gG+a284w/dfQZCSugtLtMtB0SblY5WAKUz5hVdGB8EuRksfbVSMUYQ==
X-Received: by 2002:a17:906:27da:: with SMTP id k26mr48207770ejc.175.1555535663142;
        Wed, 17 Apr 2019 14:14:23 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j10sm10340751eja.58.2019.04.17.14.14.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 14:14:21 -0700 (PDT)
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
From:   Hans de Goede <hdegoede@redhat.com>
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
Message-ID: <6f08b4b6-8303-5dc9-eb9e-30196bd95692@redhat.com>
Date:   Wed, 17 Apr 2019 23:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------D211A57CD2C7E9759BD27377"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D211A57CD2C7E9759BD27377
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17-04-19 11:19, Hans de Goede wrote:
> Note that another problem with this series which I noticed while testing
> is that the usb-role-switch is not being found at all anymore after
> this ("Replacing the old connections with references") patch. I still need
> start debugging that.

Ok, I've just finished debugging this and I'm attaching 2 FIXUP
patches (to be squased) and a new patch, which those 3 small fixes
added the problem of tcpm.c being unable to get the role-switch
goes away.

The second FIXUP patch might be a bit controversial; and we may
need another solution for the problem it fixes. I've tried to
explain it in more detail in the commit msg.

Regards,

Hans

--------------D211A57CD2C7E9759BD27377
Content-Type: text/x-patch;
 name="0001-FIXUP-platform-x86-intel_cht_int33fe-Link-with-exter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-FIXUP-platform-x86-intel_cht_int33fe-Link-with-exter.pa";
 filename*1="tch"

From 3a2e047608a53caaefe8364eceb7e315ec413698 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 17 Apr 2019 22:54:47 +0200
Subject: [PATCH v2 1/3] FIXUP: "platform/x86: intel_cht_int33fe: Link with
 external dependencies using fwnodes"

In the else path of: if (dev->fwnode) ... else ..., we should set
dev->fwnode to our own fwnode not to dev->fwnode, which is NULL as we
just tested.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index e6a1ea7f33af..07bf92ece6cd 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -189,7 +189,7 @@ static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
 		data->node[INT33FE_NODE_ROLE_SWITCH] = dev->fwnode;
 	} else {
 		/* The node can be tied to the lifetime of the device. */
-		dev->fwnode = fwnode_handle_get(dev->fwnode);
+		dev->fwnode = fwnode_handle_get(fwnode);
 	}
 
 	put_device(dev);
-- 
2.21.0


--------------D211A57CD2C7E9759BD27377
Content-Type: text/x-patch;
 name="0002-FIXUP-device-connection-Find-connections-also-by-che.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-FIXUP-device-connection-Find-connections-also-by-che.pa";
 filename*1="tch"

From 5133467f116dff6e111d4bc0610ccbcedb397f1d Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 17 Apr 2019 23:00:59 +0200
Subject: [PATCH v2 2/3] FIXUP: "device connection: Find connections also by
 checking the references"

The reference we are looking for might be in a child node, rather then
directly in the device's own fwnode. A typical example of this is a
usb connector node with references to various muxes / switches.

Note that we do not hit this problem for the device_connection_find_match
calls in typec_switch_get and typec_mux_get because these get called
from typec_register_port and typec_register_port creates a new device
with its fwnode pointing to the usb-connector fwnode and that new
device (rather then the parent) is passed to typec_switch/mux_get and
thus to device_connection_find_match.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/devcon.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 4cdf95532b63..6f6f870c21eb 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -76,7 +76,7 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 void *device_connection_find_match(struct device *dev, const char *con_id,
 				   void *data, devcon_match_fn_t match)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct fwnode_handle *child, *fwnode = dev_fwnode(dev);
 	const char *devname = dev_name(dev);
 	struct device_connection *con;
 	void *ret = NULL;
@@ -93,6 +93,12 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 		ret = fwnode_devcon_match(fwnode, con_id, data, match);
 		if (ret)
 			return ret;
+
+		fwnode_for_each_child_node(fwnode, child) {
+			ret = fwnode_devcon_match(child, con_id, data, match);
+			if (ret)
+				return ret;
+		}
 	}
 
 	mutex_lock(&devcon_lock);
-- 
2.21.0


--------------D211A57CD2C7E9759BD27377
Content-Type: text/x-patch;
 name="0003-usb-roles-Check-for-NULL-con_id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-usb-roles-Check-for-NULL-con_id.patch"

From a69f76993dfe5f43d3e6c4b2bcfbaacf2c247d6e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 17 Apr 2019 22:57:00 +0200
Subject: [PATCH v2 3/3] usb: roles: Check for NULL con_id

When usb_role_switch_match gets called by device_connection_find_match
because of a fwnode_reference matching the con_id passed to
device_connection_find_match, then con->id will be NULL and in this
case we do not need to check it since our caller has already checked it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/roles/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index f45d8df5cfb8..86defca6623e 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -101,7 +101,7 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 	struct device *dev;
 
 	if (con->fwnode) {
-		if (!fwnode_property_present(con->fwnode, con->id))
+		if (con->id && !fwnode_property_present(con->fwnode, con->id))
 			return NULL;
 
 		dev = class_find_device(role_class, NULL, con->fwnode,
-- 
2.21.0


--------------D211A57CD2C7E9759BD27377--
