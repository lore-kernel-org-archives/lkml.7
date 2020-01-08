Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC7BC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FB42070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X10OJcrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgAHKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:05:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34369 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgAHKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578477908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4beEKrqHATjYJuEXNr0cR9Rg2zzgVL9SSX9UcNxrak=;
        b=X10OJcrpcOIuM80lN01O6y1Mk/v96zh3UAbaj3YffOsnbfwk4un847pQR6IhKzRzsuLTvg
        0gATLFa7plzA7PxrpJZJ+kWN5E/Rcydlq066E5KBwEe9LJET/an4S/ErCLDp7oBo/juPCg
        b/V8OrKilB7tgwu8Hc/LT1k+vKkX3AU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-kU4Ben72OlufA4AmQ1w6FQ-1; Wed, 08 Jan 2020 05:05:05 -0500
X-MC-Unique: kU4Ben72OlufA4AmQ1w6FQ-1
Received: by mail-wr1-f72.google.com with SMTP id c17so1225541wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4beEKrqHATjYJuEXNr0cR9Rg2zzgVL9SSX9UcNxrak=;
        b=Nl33hyuOT9rFBLgujiRJW1d8Tl9lncSv9qSA3Ayd/dTZ4XlYXNj5L/dAyO3crKzioH
         Iqwy4p+eTSyfJyId+U4uTbpQgGGeEf4CdUTc0DWfXdTpyoJ1Tqehp0U+daAo63nz9qJJ
         QqCRxY4nNu8WlidhGdbd0mhgQZCRZb2QPQIiOoew9GCD3lXvECTLI45OHqTHdsugO3Uk
         aWMpB4K+79Le3cD+MRdv5aWMpxep/0ued4Js84bzC9BVYxvUuB1m57INPEk5pEKNmwCa
         d+kXMWgBMTO6csu0E0nPYMQs7JJQwY/fwZZEUvUj1Y9Kg5oseYYbOKfUAokhOUbgmCuw
         IkMg==
X-Gm-Message-State: APjAAAX7nD4IQJfDwQBo3WmGrTnhdxvDNaCpFIR1yEqeevHDG0OK/EMG
        JCIBq7i9ZcRnynLduEXlFG2a33au+RNMHF9spIMX4ik/0lBqlk7FDVBx6DhjR0u/95iIhRIEnzu
        IPxKK+ioCLOEmECWX7HfiuRZG
X-Received: by 2002:a7b:c957:: with SMTP id i23mr2891754wml.49.1578477904197;
        Wed, 08 Jan 2020 02:05:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqziUmw9W8yhAHlahv30N0G04pKPNxtKR0xm2qkfb8M/Sag2dfhARGjmDQ8cmE+BiUuVDFCc+g==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr2891730wml.49.1578477904019;
        Wed, 08 Jan 2020 02:05:04 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id q3sm3045679wmj.38.2020.01.08.02.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 02:05:03 -0800 (PST)
Subject: Re: discuss about pvpanic
To:     Michal Privoznik <mprivozn@redhat.com>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     "yelu@bytedance.com" <yelu@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        "libvir-list@redhat.com" <libvir-list@redhat.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
 <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com>
Date:   Wed, 8 Jan 2020 11:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 10:58, Michal Privoznik wrote:
>> the kernel-side patch certainly makes sense.  I assume that you want the
>> event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
>> would need to declare a new event (qapi/misc.json) and send it in
>> handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
>> adding the respective list.
> 
> Adding an event is fairly easy, if everything you want libvirt to do is
> report the event to upper layers. I volunteer to do it. Question is, how
> qemu is going to report this, whether some attributes to GUEST_PANICKED
> event or some new event.

I think it should be a new event, using GUEST_PANICKED could cause upper
layers to react by shutting down or rebooting the guest.

Thanks,

Paolo

