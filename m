Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE17C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4933F205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YUm4ZS0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfEBMdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:33:11 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7814 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:33:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae3660000>; Thu, 02 May 2019 05:32:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:33:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 May 2019 05:33:09 -0700
Received: from [10.19.120.147] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:33:08 +0000
Subject: Re: [PATCH v3 1/1] usb: xhci: Add Clear_TT_Buffer
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
References: <1556593592-3078-1-git-send-email-jilin@nvidia.com>
 <f1688e22-05d9-ca43-5df2-2a5436631851@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
From:   Jim Lin <jilin@nvidia.com>
Message-ID: <e82d0e4b-3621-ed5b-b25c-ebf3feec91bd@nvidia.com>
Date:   Thu, 2 May 2019 20:32:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <f1688e22-05d9-ca43-5df2-2a5436631851@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556800358; bh=ZS8vh8KD8anSfPWwEZxAwvj2iOB9xyaClvsaxRdp4e0=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=YUm4ZS0s9B2rGQNv6BXsxM0TguIl26kD0X296JliOvM/M2foKWqlE8EHk4IJiQzas
         CIk0H75bQ9EYAUjk2UNvTUJ+KBmLLbmhgrf14eBd7H7+FUnlNKoo7+/ugcviicO1ot
         /un0YxBTalQMM8k3JdF7Sem0/Ao52Im1gzFtDkEOk/IzFNQkkn6Bw1OqEV5Lsn39rV
         Lt0HpRr2PnxhbscpOORgNY/L9BEuCOsLQpPKqAue0sprjzcOxTkgtPwZp+e/jK2QdU
         b+uAuW+uvM0CCkFRSRpAIkeDImHn8PGViGwgmes/hhoka20pZ1+PE4Wwn4od4k4CyK
         J3mW3pTgd0pmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019=E5=B9=B405=E6=9C=8802=E6=97=A5 18:56, Mathias Nyman wrote:
> On 30.4.2019 6.06, Jim Lin wrote:
>> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
>> processing for full-/low-speed endpoints connected via a TT, the host
>> software must use the Clear_TT_Buffer request to the TT to ensure
>> that the buffer is not in the busy state".
>
> Good point, xhci isn't making sure TT buffers get cleared when they=20
> should.
>
>>
>> In our case, a full-speed speaker (ConferenceCam) is behind a high-
>> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
>> request we may continue to get STALL with the folllowing requests,
>> like Set_Interface.
>>
>> Here we add Clear_TT_Buffer for the following Set_Interface requests
>> to get ACK successfully.
>>
>> Signed-off-by: Jim Lin <jilin@nvidia.com>
>> ---
>> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>>      , remove its claiming in xhci.h
>> v3: Add description for clearing_tt (xhci.h)
>>
>>   drivers/usb/host/xhci-ring.c | 28 ++++++++++++++++++++++++++++
>>   drivers/usb/host/xhci.c      |  7 +++++++
>>   drivers/usb/host/xhci.h      |  2 ++
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index 9215a28dad40..02b1ebad81e7 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -1786,6 +1786,33 @@ struct xhci_segment *trb_in_td(struct xhci_hcd=20
>> *xhci,
>>       return NULL;
>>   }
>>   +static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci,
>> +    unsigned int slot_id, struct xhci_td *td)
>> +{
>> +    struct xhci_virt_device *dev;
>> +    struct xhci_slot_ctx *slot_ctx;
>> +    int saved_devnum;
>> +
>> +    /*
>> +     * As part of low/full-speed endpoint-halt processing
>> +     * we must clear the TT buffer (USB 2.0 specification 11.17.5).
>> +     */
>> +    if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
>> +        (td->urb->dev->tt->hub !=3D xhci_to_hcd(xhci)->self.root_hub) &=
&
>> +        !xhci->clearing_tt) {
>> +        xhci->clearing_tt =3D 1;
>
> one xhci->clearing_tt under is not enough, there might be several HS=20
> hubs, or
> multi TT hubs with halted endpoints at the same time that need TT=20
> clearing.
>
> How about a flag per endpoint?
>
> For example Aadding a EP_CLEARING_TT flag for ep_state in struct=20
> xhci_virt_ep?
> just like EP_STOP_CMD_PENDING, or EP_HALTED
>
>> +        dev =3D xhci->devs[slot_id];
>> +        slot_ctx =3D xhci_get_slot_ctx(xhci, dev->out_ctx);
>> +        /* Update devnum temporarily for usb_hub_clear_tt_buffer */
>> +        saved_devnum =3D td->urb->dev->devnum;
>> +        td->urb->dev->devnum =3D (int) le32_to_cpu(slot_ctx->dev_state)=
 &
>> +            DEV_ADDR_MASK;
>
> Changing the struct usb_device devnum on the fly seems like a bit of a=20
> hack, and probably
> causes issues elsewhere. Devnum is tied to uevents, usbfs, sysfs etc.
>
> We need another solution, some options:
>
> - Let usb_hub_clear_tt_buffer() figure out address and not just use=20
> devnum if host =3D=3D xhci.
> - Add address to struct usb_device, (would have both address and=20
> devnum), use it when needed.
> - Provide address as parameter to usb_clear_tt_buffer() (api change,=20
> changes other host drivers)
> - Force devnum to be same as address, usb core can't choose address=20
> for xhci devices.
>
> -Mathias
Thanks for review. Will try.

--nvpublic
