Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D458DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7920679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571846118;
	bh=Y7Lr0dSo9vPkjoOvo8jyQHCOR5ujworwo+eRGqcgAag=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xILpuXkPKjRy/C0l8XmMwf3gn+xtNGmqdRKzTCR4Yqp/WLnsjogBqrc7tRnYHVXTx
	 WpZKbVs89tV8n9JfrlJAwbkERyJtOf+Wkv3+pOae95+gUSVPyvuJ+8bXAoJW7k/762
	 f3Z52Qv/qeQ7tMfVp9+1zXOurhzhFunUAusWFPkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbfJWPzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390909AbfJWPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:55:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354432086D;
        Wed, 23 Oct 2019 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571846116;
        bh=Y7Lr0dSo9vPkjoOvo8jyQHCOR5ujworwo+eRGqcgAag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A2m/3DgN3LZVEw2SKZeypXEA3sbaslgNkWzggAAlTdPpxHX7wBuxYjY/STyNCtnwk
         eTfoBoUmihaVKi2SOpWBzk9y78VKv9lt0K35sz2JHIE/9Xe0XqtTAqX1pEB+hSdCUk
         4D/7jeVpDgg94i2xV1Ohb+TBqwpK35CnUXBspFzU=
Subject: Re: [PATCH v2] usbip: Fix free of unallocated memory in vhci tx
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Suwan Kim <suwan.kim027@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
        kbuild test robot <lkp@intel.com>, shuah <shuah@kernel.org>
References: <20191022093017.8027-1-suwan.kim027@gmail.com>
 <alpine.DEB.2.21.1910221151180.2637@hadrien>
From:   shuah <shuah@kernel.org>
Message-ID: <2c3acd02-9687-80fb-27c9-d64d7932b7ab@kernel.org>
Date:   Wed, 23 Oct 2019 09:55:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910221151180.2637@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 3:51 AM, Julia Lawall wrote:
> 
> 
> On Tue, 22 Oct 2019, Suwan Kim wrote:
> 
>> iso_buffer should be set to NULL after use and free in the while loop.
>> In the case of isochronous URB in the while loop, iso_buffer is
>> allocated and after sending it to server, buffer is deallocated. And
>> then, if the next URB in the while loop is not a isochronous pipe,
>> iso_buffer still holds the previously deallocated buffer address and
>> kfree tries to free wrong buffer address.
>>
>> Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> 
> Reviewed-by: Julia Lawall <julia.lawall@lip6.fr>
> 
>> ---
>> v1 - v2: Move the setting NULL after kfree() and add the comment
>> ---

Thanks.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
