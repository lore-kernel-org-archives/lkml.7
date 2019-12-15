Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A3C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99320726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQnKpsiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfLOQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:41:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726136AbfLOQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576428073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZXNOLSmIO4QRRkxs/U8mDeREkMLpc0KHW6n8y5dmes=;
        b=iQnKpsiNwCVyxdauVzUGl25a9dq7P4hOpGJvW4/zaYQNiKaEODdjFcRbvGSObKjeuTAR2R
        R1PvBkCCBgnckfQr3YyNTycqvxcLNgRz9O4gsmJkH8qOvcslE3M+vPOtbtq03GJUgyY7TB
        HDfBJuBAH26rUUuLrrWOEzL6Qd8fyDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-hzEcZ-MNO0qIj_904EWVPg-1; Sun, 15 Dec 2019 11:41:09 -0500
X-MC-Unique: hzEcZ-MNO0qIj_904EWVPg-1
Received: by mail-wr1-f70.google.com with SMTP id f10so2415000wro.14
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 08:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZXNOLSmIO4QRRkxs/U8mDeREkMLpc0KHW6n8y5dmes=;
        b=cabKi4J4Z6pbdu/wIWGj4ind1chK3gigq7Zf1+hh48YZrqLsSD4YonltM17H8ErF4x
         xKcJop+JnmG5GUaO8KpLw5hVLMtLqPbzUsgWcZn2mqbTIZTWwOHU5HsuoOEFw3i5aoTx
         LcekRJLMbwDBkRh3JZf8M+GODoMZQ8ZOUR8oCDoKetF4A5oFRiu8iwJQxmC5yfVKI02Y
         rMLWbSh9C6LEyKAoOfUsl4+MYlURrUi7ThUvK8AKGUte0f1ljbtqaWzk0pdk2JHn9yAW
         8DYAbDg4E1wqGllDqbleP2vr5X8zcFWvdtdT6EoUBufzByc1JXi9PmQ3juToOGCnE2i7
         X2Jg==
X-Gm-Message-State: APjAAAVzWNpBiWr0J/YAV6s6chnroLSWpCeJmJ8nxeNj05s5S9SeMWEb
        A4EVvQcuWZjxKaYOoUgs4QgcNK7WrJGXN50ezUVrPio7AblEAghNlX8vC1BkTcFrgoVE2Dq0755
        aPpBh2zckVdZoIcHBqf5walSF
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr26179936wru.150.1576428068031;
        Sun, 15 Dec 2019 08:41:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZpHMRDXlQMMSABQl81Zs6vH911Sv5c05gA8+uaC03Yib3ITofNGLMXO4++fjZuO82cMlHjA==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr26179919wru.150.1576428067834;
        Sun, 15 Dec 2019 08:41:07 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x10sm18280784wrv.60.2019.12.15.08.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 08:41:07 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: use proper initializers for property entries
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191213174623.GA20267@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a8a5e6b-9372-978e-03d0-350ab65a2d0a@redhat.com>
Date:   Sun, 15 Dec 2019 17:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213174623.GA20267@dtor-ws>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-12-2019 18:46, Dmitry Torokhov wrote:
> We should not be reaching into property entries and initialize them by
> hand, but rather use proper initializer macros. This way we can alter
> internal representation of property entries with no visible changes to
> their users.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> It would be good if this could go through Rafael's tree as it is needed
> for the rest of my software_node/property_entry rework patch series
> which I would love not to delay till 5.6.

Patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> Thanks!
> 
>   drivers/usb/dwc3/host.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 5567ed2cddbec..fa252870c926f 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -88,10 +88,10 @@ int dwc3_host_init(struct dwc3 *dwc)
>   	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>   
>   	if (dwc->usb3_lpm_capable)
> -		props[prop_idx++].name = "usb3-lpm-capable";
> +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
>   
>   	if (dwc->usb2_lpm_disable)
> -		props[prop_idx++].name = "usb2-lpm-disable";
> +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
>   
>   	/**
>   	 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
> @@ -103,7 +103,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>   	 * This following flag tells XHCI to do just that.
>   	 */
>   	if (dwc->revision <= DWC3_REVISION_300A)
> -		props[prop_idx++].name = "quirk-broken-port-ped";
> +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
>   
>   	if (prop_idx) {
>   		ret = platform_device_add_properties(xhci, props);
> 

