Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE9C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724E24C43
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ha1kdGk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFDIyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:54:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1828 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFDIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:54:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf631a10000>; Tue, 04 Jun 2019 01:53:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 01:54:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Jun 2019 01:54:06 -0700
Received: from [10.19.120.158] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 08:54:04 +0000
Subject: Re: [PATCH v11 0/2] usb: xhci: Add Clear_TT_Buffer
To:     Greg KH <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>
References: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
 <20190603122303.GA16267@kroah.com>
CC:     <mathias.nyman@intel.com>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <Thinh.Nguyen@synopsys.com>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jim Lin <jilin@nvidia.com>
Message-ID: <e7ccbc27-2ff4-b1b9-aa1b-c77da5e122ca@nvidia.com>
Date:   Tue, 4 Jun 2019 16:53:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190603122303.GA16267@kroah.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559638434; bh=mLYTPQ/PfK0tfvP0/dpg+Xz6JZOJSrJlWomfCeFvWF0=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=Ha1kdGk8vETSu44OZuYpp04n6UVlNEIZa2AkRiukbCzOe6wCs/l2MCJnx/tG8eW/0
         T6rHuCxPRov8L9y1pH9vGiKTuXeKMUlDbGIC6GZOPnPXVPrnNwK6ieY3D2TNW7NuLx
         omS65L97W8yDVe06AGeGrPO40aNmLMEcj4IwU/pGGXX5+yCUNoS+OctYiaspZ61Qa0
         Us/eClklU2+ZX1YD8yzE0/BxYV5eMstMXNmHsp1dAz/ygfxVVBR6EjzrpKFLnGFkAA
         os/ImDtfVuE77QuhfTdZCmQQD4xmnPN0LyZoFCYJmgB38ZdaKnQE1ItAxEXZBvTdYJ
         Jlm5elF24Mv6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019=E5=B9=B406=E6=9C=8803=E6=97=A5 20:23, Greg KH wrote:
> On Mon, Jun 03, 2019 at 06:53:42PM +0800, Jim Lin wrote:
>> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
>> processing for full-/low-speed endpoints connected via a TT, the host
>> software must use the Clear_TT_Buffer request to the TT to ensure
>> that the buffer is not in the busy state".
>>
>> In our case, a full-speed speaker (ConferenceCam) is behind a high-
>> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
>> request we may continue to get STALL with the folllowing requests,
>> like Set_Interface.
>>
>> Solution is to invoke usb_hub_clear_tt_buffer() to send
>> Clear_TT_Buffer request to the hub of the device for the following
>> Set_Interface requests to the device to get ACK successfully.
>>
>> The Clear_TT_Buffer request sent to the hub includes the address of
>> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
>> uses udev->devnum to set the address wValue. This won't work for
>> devices connected to xHC.
>>
>> For other host controllers udev->devnum is the same as the address of
>> the usb device, chosen and set by usb core. With xHC the controller
>> hardware assigns the address, and won't be the same as devnum.
>>
>> Here we have two patches.
>> One is to add devaddr in struct usb_device for
>> usb_hub_clear_tt_buffer() to use.
>> Another is to invoke usb_hub_clear_tt_buffer() for halt processing.
> Why did you resend patch series 11?
Didn't get response in 2 or 3 days.
Will be more patient next time.

May I get patch v11 1/2 acked or reviewed by Alan?

Thanks,
Jim
