Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48659C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BABF218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfB1Re2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:34:28 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:48658 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732729AbfB1Re1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:34:27 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D8E2715632; Thu, 28 Feb 2019 17:34:25 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] dt-bindings: usb: add non-removable device property
References: <20190228143344.16312-1-mans@mansr.com>
        <20190228151330.GA1360@kroah.com> <yw1x8sy0uedr.fsf@mansr.com>
        <20190228155241.GC12050@kroah.com>
Date:   Thu, 28 Feb 2019 17:34:25 +0000
In-Reply-To: <20190228155241.GC12050@kroah.com> (Greg Kroah-Hartman's message
        of "Thu, 28 Feb 2019 16:52:41 +0100")
Message-ID: <yw1x4l8nvmu6.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Feb 28, 2019 at 03:22:24PM +0000, Måns Rullgård wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Thu, Feb 28, 2019 at 02:33:44PM +0000, Mans Rullgard wrote:
>> >> Add a boolean property indicating that a device is hardwired to the
>> >> upstream port.  Although hubs can provide this information, they are not
>> >> always configured correctly.  An alternate means of indicating this for
>> >> built-in USB devices is thus useful.
>> >> 
>> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> >> ---
>> >> I have a situation where userspace would like to know which USB devices
>> >> are built-in, but the on-board hub doesn't have the right setting.
>> >> Also, the hub itself can't be indicated as fixed in any other way that
>> >> I'm aware of.
>> >
>> > Then that's a firmware bug, right?  We have a way for firmware to export
>> > this to the USB core, why not use that?  Your on-board hub should get a
>> > firmware update with this information, let's not try to create
>> > yet-another-way to define this type of information please.
>> 
>> What firmware?  This is not an ACPI system, obviously, so DT _is_ the
>> firmware.
>
> Firmware in your hub.  There's a whole crazy software stack in that
> beast :)

The hub chip itself (SMSC/Microchip USB2512B in the case at hand) is
fine.  The problem is that whoever designed the PCB didn't add the
pull-ups marking the ports non-removable.  Besides, the hub can't
indicate that it itself is hardwired to the host port.  That information
needs to be supplied elsewhere.

>> >> In a way, adding this property seems a bit silly since dt can only
>> >> sensibly be used for hardwired devices in the first place.  Thus the
>> >> mere presence of a dt node could be taken to indicate the same thing.
>> >> On the other hand, it's conceivable that someone might dynamically
>> >> generate a devicetree based on what happens to be connected on boot or
>> >> something.  For that reason, and explicit property seems safer.
>> >> ---
>> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 8 ++++++++
>> >>  1 file changed, 8 insertions(+)
>> >
>> > Can you show some code actually using this?  Again, this should "just
>> > work" for USB today unless your platform is really broken (and if it is,
>> > go complain to the vendor...)
>> 
>> You know full well that complaining to the vendor is rarely something
>> that works.  Especially not when there are already thousands of the
>> devices in the field.
>
> Understood, but constantly working around broken hardware is annoying at
> times.

It's annoying, sure.  It is also the reality, and we have to deal with it.
Ignoring such hardware won't make it go away.

>> This is how I meant to use it:
>> 
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 3adff4da2ee1..81ef3cb705b7 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2392,6 +2392,14 @@ static void set_usb_port_removable(struct usb_device *udev)
>>                 break;
>>         }
>>  
>> +       /*
>> +        * Otherwise, check whether DT indicates this device is non-removable.
>> +        */
>> +       if (of_property_read_bool(udev->dev.of_node, "non-removable")) {
>> +               udev->removable = USB_DEVICE_FIXED;
>> +               return;
>> +       }
>
> Shouldn't this be an attribute of the USB hub's port, not the device
> itself?  That's the way it works with ACPI, and odds are any description
> of USB devices in DT is also going to look much like how ACPI describes
> the devices, let's not try to diverge when it is not necessary.

Fine with me.  That's why I asked.

How about a non-removable-ports property in the hub node listing the
hardwired ports?

-- 
Måns Rullgård
