Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B520ECA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7210B20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572339879;
	bh=IbQkjMguEXcLEaRwhCuLeXjDzwQdVquZPVX8W/lviKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aVaDMqPWyvUJXvddY4y1w+JRsH3G0M/o24XzQvKIQSdUdSyA7fEl2wsXvPH836eB8
	 K0K1N9cQsE/TW+obg4AGYYANfUKa8DUnlIZ6o3xZbxzfNwp1yTKfKEPtiKpMv9L54v
	 3mnrZd9NhHF53km7AQOzfdKSqX0fJitsarHM4aIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfJ2JEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfJ2JEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:04:38 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D85220717;
        Tue, 29 Oct 2019 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572339877;
        bh=IbQkjMguEXcLEaRwhCuLeXjDzwQdVquZPVX8W/lviKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0mtnxGHmEXBt6yS2fKXZGQbFQrC5WwQwo06fbCZFtkj/zq6Qp7C65laj9VBFfNbL
         iz7eUSSaCvLEFeSxSh+ja53yFpQeQb3zVnAWvPCl9pZefXXFvXUuqPGTgmSKHHwLqn
         8yXeGePrih8sWBtQparb0MBWo+ANNibjtA/KExko=
Date:   Tue, 29 Oct 2019 05:04:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 095/100] USB: usb-skeleton: fix
 use-after-free after driver unbind
Message-ID: <20191029090435.GJ1554@sasha-vm>
References: <20191018220525.9042-1-sashal@kernel.org>
 <20191018220525.9042-95-sashal@kernel.org>
 <20191018222205.GA6978@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191018222205.GA6978@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:22:05PM -0400, Greg Kroah-Hartman wrote:
>On Fri, Oct 18, 2019 at 06:05:20PM -0400, Sasha Levin wrote:
>> From: Johan Hovold <johan@kernel.org>
>>
>> [ Upstream commit 6353001852776e7eeaab4da78922d4c6f2b076af ]
>>
>> The driver failed to stop its read URB on disconnect, something which
>> could lead to a use-after-free in the completion handler after driver
>> unbind in case the character device has been closed.
>>
>> Fixes: e7389cc9a7ff ("USB: skel_read really sucks royally")
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> Link: https://lore.kernel.org/r/20191009170944.30057-3-johan@kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/usb/usb-skeleton.c | 1 +
>>  1 file changed, 1 insertion(+)
>
>This file does not even get built in the kernel tree, no need to
>backport anything for it :)

I'll drop it, but you're taking patches for this driver:
https://lore.kernel.org/patchwork/patch/1140673/ .

-- 
Thanks,
Sasha
