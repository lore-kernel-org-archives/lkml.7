Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F2CC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B39821D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcYqS8G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLSIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:30:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54728 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726609AbfLSIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576744248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewCaJOfBy9nGeq4Yo9i7Tisg8do5u5i6meu8ilRSTEg=;
        b=AcYqS8G6ARWDTs6BdzFV43vMMHQ6pghjTMuk8u/2Xl+2Ak48mzj52Q9i0LH86yJ6WXkbHI
        ld3N7C/FRsDL377MWO7Qitp5UXF0retCXBiBpKUm7YPkeo+aYioSapsM9XPvrKANwSnW4E
        ZPKSEfAPcqlrXNUeABnRLMYGatXLVZY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-h0mgv-GBMdKdrvS_ZDI-TQ-1; Thu, 19 Dec 2019 03:30:41 -0500
X-MC-Unique: h0mgv-GBMdKdrvS_ZDI-TQ-1
Received: by mail-wr1-f71.google.com with SMTP id o6so2057707wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 00:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ewCaJOfBy9nGeq4Yo9i7Tisg8do5u5i6meu8ilRSTEg=;
        b=NIzqBhek4q6gQP366KuuVRCYCza/4ve6kwQsEKwL8PC2Zyx/ZBN3gky0KTDe9nbKfW
         MLVjVz6aI5MkgueVw6rSz7zBjjGa4gS+udyUlzVMel8KzwLaHJesmQEUy/q8Gvyx9H9Y
         ZMpfOJ787XLEt6FfW2501ckDUkywnl+eZJER0z9ZzATHes3daU/hsC+y5F+wEJcwGEAw
         TpS82iPNRmercz6TE4dxZ2/NvIaPdUUYnL8HIa8eXKStfWdj7KZErDd3iJxLhOMYXyOA
         zndKbzt6OdNt63kl7CWfISyGs/ghcyZJlgbF7zz6G6+kgoJljqIxgULISAQXFFyuwCkO
         Bfcg==
X-Gm-Message-State: APjAAAUWoYe9o/yGrr1eCQKHXFDeMFiBvUP2dZvzVs5whI/GpBjzU5Pa
        gVRWpbedxCUGDQ/nZWNMGUd4BLjXXTj3eu/Tj6qTMtG3Eipk6/j8gEsLkI2npCD2TirJ1ehPg1T
        dzj+1dT2dCdBlB2pgW5LAh74C
X-Received: by 2002:a5d:5708:: with SMTP id a8mr8421054wrv.79.1576744240550;
        Thu, 19 Dec 2019 00:30:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqza16homzGLdCX3FZ2ghQQQEoyB9HUoq4Lc+0whtn5OtM6iey5RpTK+S2JgsXBTOpT2hWKVDg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr8421038wrv.79.1576744240393;
        Thu, 19 Dec 2019 00:30:40 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id e6sm5586381wru.44.2019.12.19.00.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 00:30:39 -0800 (PST)
Subject: Re: [PATCH] serdev: Don't claim unsupported serial devices
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        shrirang.bagul@canonical.com, stable@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20191218065646.817493-1-punit1.agrawal@toshiba.co.jp>
 <096046b6-324a-8496-8599-ed7e5ffc6e3c@redhat.com>
 <87eex1noak.fsf@kokedama.swc.toshiba.co.jp>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a2e86d54-287a-16b4-3dac-9e3fe3dee753@redhat.com>
Date:   Thu, 19 Dec 2019 09:30:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87eex1noak.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-12-2019 01:37, Punit Agrawal wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
>> Hi,
>>
>> On 18-12-2019 07:56, Punit Agrawal wrote:
>>> Serdev sub-system claims all serial devices that are not already
>>> enumerated. As a result, no device node is created for serial port on
>>> certain boards such as the Apollo Lake based UP2. This has the
>>> unintended consequence of not being able to raise the login prompt via
>>> serial connection.
>>>
>>> Introduce a blacklist to reject devices that should not be treated as
>>> a serdev device. Add the Intel HS UART peripheral ids to the blacklist
>>> to bring back serial port on SoCs carrying them.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Johan Hovold <johan@kernel.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>
>> Thank you for addressing this long standing issue.
> 
> I am surprised there hasn't been more people complaining! Maybe even on
> x86 mainline isn't that widely used on development boards.

I think it is also a case of there not being that manu x86 development
boards.

Regards,

Hans

