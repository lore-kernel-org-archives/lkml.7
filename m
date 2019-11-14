Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E400120709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKNGJw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:09:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35206 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNGJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:09:51 -0500
Received: from marcel-macpro.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 33EBDCED06;
        Thu, 14 Nov 2019 07:18:55 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v4 3/4] Bluetooth: hci_bcm: Support pcm params in dts
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mUxBLGfDd+mR7R1RTK70PRhbHjV8whDJOucpap_qmgN3A@mail.gmail.com>
Date:   Thu, 14 Nov 2019 07:09:49 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C6EE827D-4CE7-4A5F-B9FC-C10647B0B8C4@holtmann.org>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
 <20191112230944.48716-4-abhishekpandit@chromium.org>
 <DCCD0A71-D696-4701-9BBB-ED6D8FECC7FB@holtmann.org>
 <CANFp7mX0tXmBdJOkBUbar6Niwv9D60Fo9CvAcUkEKZKLnt--hQ@mail.gmail.com>
 <102CFB68-22A0-4DF7-B5CE-F3146AA36746@holtmann.org>
 <CANFp7mUxBLGfDd+mR7R1RTK70PRhbHjV8whDJOucpap_qmgN3A@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

>>>>> BCM chips may require configuration of PCM to operate correctly and
>>>>> there is a vendor specific HCI command to do this. Add support in the
>>>>> hci_bcm driver to parse this from devicetree and configure the chip.
>>>>> 
>>>>> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>>>> ---
>>>>> 
>>>>> Changes in v4: None
>>>>> Changes in v3: None
>>>>> Changes in v2: None
>>>>> 
>>>>> drivers/bluetooth/hci_bcm.c | 32 ++++++++++++++++++++++++++++++++
>>>>> 1 file changed, 32 insertions(+)
>>>>> 
>>>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>>>> index 6134bff58748..4ee0b45be7e2 100644
>>>>> --- a/drivers/bluetooth/hci_bcm.c
>>>>> +++ b/drivers/bluetooth/hci_bcm.c
>>>>> @@ -88,6 +88,8 @@ struct bcm_device_data {
>>>>> *    used to disable flow control during runtime suspend and system sleep
>>>>> * @is_suspended: whether flow control is currently disabled
>>>>> * @disallow_set_baudrate: don't allow set_baudrate
>>>>> + * @has_pcm_params: whether PCM parameters need to be configured
>>>>> + * @pcm_params: PCM and routing parameters
>>>>> */
>>>>> struct bcm_device {
>>>>>     /* Must be the first member, hci_serdev.c expects this. */
>>>>> @@ -122,6 +124,9 @@ struct bcm_device {
>>>>>     bool                    is_suspended;
>>>>> #endif
>>>>>     bool                    disallow_set_baudrate;
>>>>> +
>>>>> +     bool                            has_pcm_params;
>>>>> +     struct bcm_set_pcm_int_params   pcm_params;
>>>>> };
>>>>> 
>>>>> /* generic bcm uart resources */
>>>>> @@ -596,6 +601,16 @@ static int bcm_setup(struct hci_uart *hu)
>>>>>                     host_set_baudrate(hu, speed);
>>>>>     }
>>>>> 
>>>>> +     /* PCM parameters if any*/
>>>>> +     if (bcm->dev && bcm->dev->has_pcm_params) {
>>>>> +             err = btbcm_set_pcm_int_params(hu->hdev, &bcm->dev->pcm_params);
>>>>> +
>>>>> +             if (err) {
>>>>> +                     bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
>>>>> +                                 err);
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> finalize:
>>>>>     release_firmware(fw);
>>>>> 
>>>>> @@ -1132,7 +1147,24 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>>>>> 
>>>>> static int bcm_of_probe(struct bcm_device *bdev)
>>>>> {
>>>>> +     int err;
>>>>> +
>>>>>     device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
>>>>> +
>>>>> +     err = device_property_read_u8(bdev->dev, "brcm,bt-sco-routing",
>>>>> +                                   &bdev->pcm_params.routing);
>>>>> +     if (!err)
>>>>> +             bdev->has_pcm_params = true;
>>>> 
>>>> I think in case of HCI as routing path, these should be using the default or zero values as defined by Broadcom.
>>> 
>>> I'm not sure what these default values should be. Wouldn't it be
>>> reasonable to expect the user/developer to set the various brcm
>>> parameters in device tree?
>>> If unset, it's just 0.
>> 
>> if that works with the hardware I am fine with that. The other option is to actually first read the current values. And then only change the ones that are supplied by the DT.
> 
> I don't know of a read pcm params command (this would be nice to have).
> 
> I think it might be prudent to default the frame_mode and clock_mode
> to master (0x1). I'll test how the hardware responds to 0x0 and update
> the default to 0x1 if things fail badly.

it is either one opcode down or one opcode up. Look at monitor/broadcom.c since we do actually decode some of these.

Regards

Marcel

