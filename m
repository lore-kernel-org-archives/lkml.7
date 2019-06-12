Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31DC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775202082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438063AbfFLKkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:40:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36565 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438050AbfFLKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:40:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so5998220wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=coVyfpvXPJCAOdjEJog8oxLYcOdt2ks8N3/iSzlLkjo=;
        b=Lbhwv+aIOee2spcFvpEy4ofJt2rBGedfEgHdUI/3x94K6l4R8XwXBgDTJZIrSKXsjo
         MGISUv2XzcBhluZzszS23djrQ3B366R5OGsgYJA4uC+gb5adst+byP9NhUIYIVuAw58i
         pYIreSivj7Uz91D4SDgCq1HV8T34GazheXJEVBAojmex0JvV9Xs1BXq+DdIXvlK76BKG
         b5zMFZ4MH1+Wemgo4UkA7XTvqa6uxiKKvreyQqCwznf2qZopXPc45SA31hMUNF2r2x/H
         7Yc0keo3M2mT9O8y3ROw/9TE/V6HKv+fS6J81aBfBp2rxUuVPcXfQVVBYY+ij6yUksFn
         xDeA==
X-Gm-Message-State: APjAAAUh0+7CRNWKcT6DfXMUDqTVvKlh2HHcffxcQXktUxdkqlMLdK4N
        eoDouTda1qn6oOxSHkzW595chA==
X-Google-Smtp-Source: APXvYqytNtBYrV48yNCxQWNZ1Wwwzi+FBFSmmQ0IkV3kL4qSlmB0hFbGM23kQv/y4nnaLlaz2k4oIQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr22622706wmi.50.1560336030451;
        Wed, 12 Jun 2019 03:40:30 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d18sm18854753wrn.26.2019.06.12.03.40.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:40:29 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 4/5] HID: hv: Remove dependencies on PAGE_SIZE for ring buffer
In-Reply-To: <0e9385a241dc7c26445eb7e104d08e2e2c5d30de.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <0e9385a241dc7c26445eb7e104d08e2e2c5d30de.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:40:29 +0200
Message-ID: <87h88vdr36.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Define the ring buffer size as a constant expression because it should
> not depend on the guest page size.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  drivers/hid/hid-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index d3311d714d35..e8b154fa38e2 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -112,8 +112,8 @@ struct synthhid_input_report {
>  
>  #pragma pack(pop)
>  
> -#define INPUTVSC_SEND_RING_BUFFER_SIZE		(10*PAGE_SIZE)
> -#define INPUTVSC_RECV_RING_BUFFER_SIZE		(10*PAGE_SIZE)
> +#define INPUTVSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
> +#define INPUTVSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
>  

My understanding is that this size is pretty arbitrary and as I see you
use it for hyperv-keyboard.c as well. It may make sense to have a
define, something like HYPERV_STD_RINGBUFFER_SIZE.

>  
>  enum pipe_prot_msg_type {

-- 
Vitaly
