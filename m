Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C417C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2712F206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKWu/Ijo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgAHJhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:37:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727224AbgAHJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578476220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68cyakBuuqykyYfuVPtYJRYgfAWVoYk6H/O1x5botQ4=;
        b=TKWu/IjoXLrV7Dq6he93ntbiVdZ86CenNo/c+fBX4bLXanOeiXFqb4gJ+qzlyHKJs1faOe
        QJvhQHU4yNOMz3m6u0O7JlOsThqMXRZf3+L1HbqP4/2crFI8STf26D64qHvemcT9hfPQnq
        SiBbs+eQnxWX5EverffID/NnqyPBIls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-vtPIEzLhPiu5LuqOSatMyQ-1; Wed, 08 Jan 2020 04:36:59 -0500
X-MC-Unique: vtPIEzLhPiu5LuqOSatMyQ-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1186622wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68cyakBuuqykyYfuVPtYJRYgfAWVoYk6H/O1x5botQ4=;
        b=WfyJ8MWrIJyXTgrOzJGk8XPNsCQ3Emw00KJZF4b2wo3yJ5UC8FkPxhacipwDxIO4rc
         TlGxpHB3bnpHyZamfzhPKL5P9/bjks7osmECGEH9sbjkg4H14LzbmEQEoowwsZdiq37E
         9pz1EbmmDMsucqpT56HnOFhwIuGFIH1gDRk74HD7XjVJu6qco35bK3bBBCazRalJM7kg
         cUQdF9Ok6OC2ohJC8bWbmsg5LdVUllhrwQ4k/WwYHqM00+QuT/AE+5jXuzTJW/DRsioc
         wEThRJu1l26Gxo5hMZ+MLk11fVEGvKqv0jxML4p1CJGRTIwMA7L4andXMwt90qvbJ5Lr
         r1Ww==
X-Gm-Message-State: APjAAAX5/k2xfV8jvNNUz4Ww8t4OQaRerru3Rcj8hhM5DZotnJl8BFJ1
        keiamqjb128oVmwqMKvM4LenYPWztFBn/T8lljJvcHPxkhCobwQvGrZicY6TxwO8lzL0w5xeEkf
        Svk/r7p6WsAqDSqRmlA0O+Gwo
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr2563067wmk.141.1578476218056;
        Wed, 08 Jan 2020 01:36:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOYbwL71jHMFOLZ5jV8xy/fR+AF+ZAxn6+Tt8MCWEEuGa8Xg+blvSitd6myXj3yx8d2Rz0jg==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr2563033wmk.141.1578476217779;
        Wed, 08 Jan 2020 01:36:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bc4e:7fe8:2916:6a59? ([2001:b07:6468:f312:bc4e:7fe8:2916:6a59])
        by smtp.gmail.com with ESMTPSA id q68sm3371147wme.14.2020.01.08.01.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 01:36:57 -0800 (PST)
Subject: Re: discuss about pvpanic
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     "yelu@bytedance.com" <yelu@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        Michal Privoznik <mprivozn@redhat.com>,
        "libvir-list@redhat.com" <libvir-list@redhat.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
Date:   Wed, 8 Jan 2020 10:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 09:25, zhenwei pi wrote:
> Hey, Paolo
> 
> Currently, pvpapic only supports bit 0(PVPANIC_PANICKED).
> We usually expect that guest writes ioport (typical 0x505) in panic_notifier_list callback
> during handling panic, then we can handle pvpapic event PVPANIC_PANICKED in QEMU.
> 
> On the other hand, guest wants to handle the crash by kdump-tools, and reboots without any
> panic_notifier_list callback. So QEMU only knows that guest has rebooted (because guest
> write 0xcf9 ioport for RCR request), but QEMU can't identify why guest resets.
> 
> In production environment, we hit about 100+ guest reboot event everyday, sadly we 
> can't separate the abnormal reboot from normal operation.
> 
> We want to add a new bit for pvpanic event(maybe PVPANIC_CRASHLOADED) to represent the guest has crashed, 
> and the panic is handled by the guest kernel. (here is the previous patch https://lkml.org/lkml/2019/12/14/265)
> 
> What do you think about this solution? Or do you have any other suggestions?

Hi Zhenwei,

the kernel-side patch certainly makes sense.  I assume that you want the
event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
would need to declare a new event (qapi/misc.json) and send it in
handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
adding the respective list.

Another possibility is to simply not write to pvpanic if
kexec_crash_loaded() returns true; this would match what xen_panic_event
does for example.  The kexec kernel would then log the panic normally,
without the need for MMIO at all.  However, I have no problem with
adding a new bit to the pvpanic I/O port so once you post the QEMU patch
I will certainly ack the kernel side.

Thanks,

Paolo

