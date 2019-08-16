Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9CC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14682171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfHPToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:44:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37832 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfHPTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:43:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id f22so6104739edt.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 12:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1hrkUO28cUop5d6z7bM1Ct06/R0vJu27ZXRTE5mPYI=;
        b=dBFq7s2DmT9GCxpYMw8tT9X4uj8+1SxzQ5ol3e1xMK5zOnLUljWR/gRK3eW5mO6wjM
         XLG9loLasc1JNf1l0swnleQLGIHA3nx4GC2zV7Z24iFJ7z0kcG3anpIZ88b9dRyHVx2r
         K1diVcRtCdi6tu9hr8DEh0htYvAxKLkjmrPVwszJEtAXZlYQdOeDnx37SpG1jUdbXGEX
         57xAAw6ltaG2JKQZ1O8CAqH9qUCANKBtxgBqaV+pX9R4TQ/CFL1+GsVpPg5kW2LhaMi7
         kgjIi3r0tHkgTf0zcnlfaRORCE/So++e0OpjgWDxFFx1ExbAQwh8frs5tCV6YOMOzeeb
         e4TA==
X-Gm-Message-State: APjAAAVrPxzKYd7vE0sKSZPD6c89hZk2aBTbqoo1khmbLbJtal+bylDK
        g4ASsRyQRo+AJBjVa7Kdv6qNdbf+5cA=
X-Google-Smtp-Source: APXvYqyUWS38O43CxXQEbDtyQPVOnPlwhdtgLI83xy8bpr5/eYxfFXkszhCQUHeaZ4ZlOHVECJQjGA==
X-Received: by 2002:a50:da02:: with SMTP id z2mr7685693edj.254.1565984634208;
        Fri, 16 Aug 2019 12:43:54 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id y37sm1261080edb.42.2019.08.16.12.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 12:43:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] usb: roles: intel_xhci: Supplying software node
 for the role mux
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190816104515.63613-1-heikki.krogerus@linux.intel.com>
 <20190816104515.63613-3-heikki.krogerus@linux.intel.com>
 <CAHp75VcuR+X5=-+VQ9HxU5Nh-uexzDbmZzX_JbZZ2B6tYXQmAQ@mail.gmail.com>
 <20190816135231.GA5356@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f611d227-e1a9-0ca5-b10c-02a0a396e14c@redhat.com>
Date:   Fri, 16 Aug 2019 21:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816135231.GA5356@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/16/19 3:52 PM, Heikki Krogerus wrote:
> On Fri, Aug 16, 2019 at 04:45:50PM +0300, Andy Shevchenko wrote:
>> On Fri, Aug 16, 2019 at 1:45 PM Heikki Krogerus
>> <heikki.krogerus@linux.intel.com> wrote:
>>>
>>> The primary purpose for this node will be to allow linking
>>> the users of the switch to it. The users will be for example
>>> USB Type-C connectors. By supplying a reference to this
>>> node in the software nodes representing the USB Type-C
>>> controllers or connectors, the drivers for those devices can
>>> access the switch.
>>
>>> +       ret = software_node_register(&intel_xhci_usb_node);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       sw_desc.set = intel_xhci_usb_set_role,
>>> +       sw_desc.get = intel_xhci_usb_get_role,
>>> +       sw_desc.allow_userspace_control = true,
>>> +       sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
>>> +
>>>          data->role_sw = usb_role_switch_register(dev, &sw_desc);
>>>          if (IS_ERR(data->role_sw))
>>>                  return PTR_ERR(data->role_sw);
>>
>> Sounds to me like more fwnode_handle_put() calls are missed.
> 
> True. I'll fix it.

I will wait for v3 before testing again then.

Regards,

Hans

