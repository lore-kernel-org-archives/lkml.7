Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD42ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8CB206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfJKPIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:08:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:08:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 54C4C29102D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v4] wilco_ec: Add Dell's USB PowerShare Policy control
To:     Nick Crews <ncrews@chromium.org>,
        Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>
References: <20191008161749.1.I4476e6e2b1026ff388eb11813310264e25aa9cc9@changeid>
 <CAHX4x85WTGKMDn22T6SmaemVS1km8yNRgXNj3AgyAzB=69B3nA@mail.gmail.com>
Message-ID: <8a4d9abb-7230-7e65-ceb7-e2983c8486cc@collabora.com>
Date:   Fri, 11 Oct 2019 17:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHX4x85WTGKMDn22T6SmaemVS1km8yNRgXNj3AgyAzB=69B3nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Nick

On 9/10/19 17:00, Nick Crews wrote:
> On Tue, Oct 8, 2019 at 4:18 PM Daniel Campello <campello@chromium.org> wrote:
>>
>> USB PowerShare is a policy which affects charging via the special
>> USB PowerShare port (marked with a small lightning bolt or battery icon)
>> when in low power states:
>> - In S0, the port will always provide power.
>> - In S0ix, if usb_charge is enabled, then power will be supplied to
>>   the port when on AC or if battery is > 50%. Else no power is supplied.
>> - In S5, if usb_charge is enabled, then power will be supplied to
>>   the port when on AC. Else no power is supplied.
>>
>> Signed-off-by: Daniel Campello <campello@chromium.org>
>> Signed-off-by: Nick Crews <ncrews@chromium.org>
>> ---
>>
>> v4 changes:
>> - Renamed from usb_power_share to usb_charge to match existing feature
>> in other platforms in the kernel (i.e., sony-laptop, samsung-laptop,
>> lg-laptop)
> 
> Daniel and I put in considerable effort trying to get this integrated
> with the USB subsystem. However, it was becoming much too
> complicated, so we hoped that if we made this more consistent
> with the three existing examples it would be acceptable.
> 

Agree, let's land as is for now. Prefixed the patch subject with
"platform/chrome: ", replaced tabs for space in the documentation (to be
coherent with the rest of the file) and queued for autobuilders to play with. If
all goes well will be applied for 5.5.

Thanks,
 Enric


> Thanks for the thoughts,
> Nick
> 
>> v3 changes:
>> - Drop a silly blank line
>> - Use val > 1 instead of val != 0 && val != 1
>> v2 changes:
>> - Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec
>> - Zero out reserved bytes in requests.
>>
>>  .../ABI/testing/sysfs-platform-wilco-ec       | 17 ++++
>>  drivers/platform/chrome/wilco_ec/sysfs.c      | 91 +++++++++++++++++++
>>  2 files changed, 108 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
>> index 8827a734f933..bb7ba67cae97 100644
>> --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
>> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
>> @@ -31,6 +31,23 @@ Description:
>>                 Output will a version string be similar to the example below:
>>                 08B6
>>
>> +What:          /sys/bus/platform/devices/GOOG000C\:00/usb_charge
>> +Date:          October 2019
>> +KernelVersion: 5.5
>> +Description:
>> +               Control the USB PowerShare Policy. USB PowerShare is a policy
>> +               which affects charging via the special USB PowerShare port
>> +               (marked with a small lightning bolt or battery icon) when in
>> +               low power states:
>> +               - In S0, the port will always provide power.
>> +               - In S0ix, if usb_charge is enabled, then power will be
>> +                 supplied to the port when on AC or if battery is > 50%.
>> +                 Else no power is supplied.
>> +               - In S5, if usb_charge is enabled, then power will be supplied
>> +                 to the port when on AC. Else no power is supplied.
>> +
>> +               Input should be either "0" or "1".
>> +
>>  What:          /sys/bus/platform/devices/GOOG000C\:00/version
>>  Date:          May 2019
>>  KernelVersion: 5.3
>> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
>> index 3b86a21005d3..f0d174b6bb21 100644
>> --- a/drivers/platform/chrome/wilco_ec/sysfs.c
>> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
>> @@ -23,6 +23,26 @@ struct boot_on_ac_request {
>>         u8 reserved7;
>>  } __packed;
>>
>> +#define CMD_USB_CHARGE 0x39
>> +
>> +enum usb_charge_op {
>> +       USB_CHARGE_GET = 0,
>> +       USB_CHARGE_SET = 1,
>> +};
>> +
>> +struct usb_charge_request {
>> +       u8 cmd;         /* Always CMD_USB_CHARGE */
>> +       u8 reserved;
>> +       u8 op;          /* One of enum usb_charge_op */
>> +       u8 val;         /* When setting, either 0 or 1 */
>> +} __packed;
>> +
>> +struct usb_charge_response {
>> +       u8 reserved;
>> +       u8 status;      /* Set by EC to 0 on success, other value on failure */
>> +       u8 val;         /* When getting, set by EC to either 0 or 1 */
>> +} __packed;
>> +
>>  #define CMD_EC_INFO                    0x38
>>  enum get_ec_info_op {
>>         CMD_GET_EC_LABEL        = 0,
>> @@ -131,12 +151,83 @@ static ssize_t model_number_show(struct device *dev,
>>
>>  static DEVICE_ATTR_RO(model_number);
>>
>> +static int send_usb_charge(struct wilco_ec_device *ec,
>> +                               struct usb_charge_request *rq,
>> +                               struct usb_charge_response *rs)
>> +{
>> +       struct wilco_ec_message msg;
>> +       int ret;
>> +
>> +       memset(&msg, 0, sizeof(msg));
>> +       msg.type = WILCO_EC_MSG_LEGACY;
>> +       msg.request_data = rq;
>> +       msg.request_size = sizeof(*rq);
>> +       msg.response_data = rs;
>> +       msg.response_size = sizeof(*rs);
>> +       ret = wilco_ec_mailbox(ec, &msg);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (rs->status)
>> +               return -EIO;
>> +
>> +       return 0;
>> +}
>> +
>> +static ssize_t usb_charge_show(struct device *dev,
>> +                                   struct device_attribute *attr, char *buf)
>> +{
>> +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
>> +       struct usb_charge_request rq;
>> +       struct usb_charge_response rs;
>> +       int ret;
>> +
>> +       memset(&rq, 0, sizeof(rq));
>> +       rq.cmd = CMD_USB_CHARGE;
>> +       rq.op = USB_CHARGE_GET;
>> +
>> +       ret = send_usb_charge(ec, &rq, &rs);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return sprintf(buf, "%d\n", rs.val);
>> +}
>> +
>> +static ssize_t usb_charge_store(struct device *dev,
>> +                                    struct device_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
>> +       struct usb_charge_request rq;
>> +       struct usb_charge_response rs;
>> +       int ret;
>> +       u8 val;
>> +
>> +       ret = kstrtou8(buf, 10, &val);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (val > 1)
>> +               return -EINVAL;
>> +
>> +       memset(&rq, 0, sizeof(rq));
>> +       rq.cmd = CMD_USB_CHARGE;
>> +       rq.op = USB_CHARGE_SET;
>> +       rq.val = val;
>> +
>> +       ret = send_usb_charge(ec, &rq, &rs);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(usb_charge);
>>
>>  static struct attribute *wilco_dev_attrs[] = {
>>         &dev_attr_boot_on_ac.attr,
>>         &dev_attr_build_date.attr,
>>         &dev_attr_build_revision.attr,
>>         &dev_attr_model_number.attr,
>> +       &dev_attr_usb_charge.attr,
>>         &dev_attr_version.attr,
>>         NULL,
>>  };
>> --
>> 2.23.0.581.g78d2f28ef7-goog
>>
