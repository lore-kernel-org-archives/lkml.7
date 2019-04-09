Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AB72084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDIP0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:26:11 -0400
Received: from smtp.radex.nl ([178.250.146.7]:33297 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDIP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:26:11 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 11:26:10 EDT
Received: from [192.168.1.22] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id B9AC224052;
        Tue,  9 Apr 2019 17:17:41 +0200 (CEST)
Subject: Re: [PATCH] Bluetooth: btbcm: Add default address for BCM43341B
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     wagi@monom.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190409141550.19458-1-ftoth@exalondelft.nl>
 <20190409144511.GO9224@smile.fi.intel.com>
From:   Ferry Toth <ftoth@exalondelft.nl>
Message-ID: <c9d4f373-8c2c-19cf-54c1-e3f0fa6b083d@exalondelft.nl>
Date:   Tue, 9 Apr 2019 17:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409144511.GO9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Op 09-04-19 om 16:45 schreef Andy Shevchenko:
> On Tue, Apr 09, 2019 at 04:15:50PM +0200, Ferry Toth wrote:
>> The BCM43341B has the default MAC address 43:34:1B:00:1F:AC if none
>> is given. This address was found when enabling Bluetooth on multiple
>> Intel Edison modules. It also contains the sequence 43341B, the name
>> the chip identifies itself as. Using the same BD_ADDR is problematic
>> when having multiple Intel Edison modules in each others range.
>> The default address also has the LAA (locally administered address)
>> bit set which prevents a BNEP device from being created, needed for
>> BT tethering.
>>
>> Add this to the list of black listed default MAC addresses and let
>> the user configure a valid one using f.i.
>> `btmgmt -i hci0 public-addr xx:xx:xx:xx:xx:xx`
>>
> Thank you!
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> P.S. It seems the To: field was empty, dunno if it prevents bots to parse the
> original message.
>
Sorry, is my first kernel patch. Seems it has been picked up by 
marc.info and gmane, so I hope those are representative.
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
>> ---
>>   drivers/bluetooth/btbcm.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index d5d6e6e5da3b..62d3aa2b26f6 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -37,6 +37,7 @@
>>   #define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 0x43}})
>>   #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
>>   #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
>> +#define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
>>   
>>   int btbcm_check_bdaddr(struct hci_dev *hdev)
>>   {
>> @@ -82,7 +83,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
>>   	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
>>   	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
>>   	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
>> -	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0)) {
>> +	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
>> +	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
>>   		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
>>   			    &bda->bdaddr);
>>   		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>> -- 
>> 2.19.1
>>
