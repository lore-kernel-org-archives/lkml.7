Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99196C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718BB2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfDOM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:27:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36592 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDOM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:27:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so20215898wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NFkaEcrMcC+TkQE3T7eDIT8t/gt8OW6BPDneAKgJs0E=;
        b=ogZtf4FLmuzZVfPTgDkqECF8c4yLmwQP0rWALNz15YURZrVGQvzxEl4p+bkGZpvIUc
         KN2kmFd5+j9ulwNWyOJVXKahRd1l+37Y6iIqq13GWbWifJXIDTpy4LLeOTtoG9KWp0QK
         OrW7T0sI5qVyWacbprtz8wGpg6gehBzHiT/hewJsa/8IA7x9y9glsUO/7XwraJnF+dqO
         kuaFTvTJsRZt3+N+ZKIKo3YmN7QgCNfr2x4cUjcQIjlRGhZarBGzS3R2toHOQmsLKayC
         SObBc7EuVRZ4Whml6uJ3I13iWjOnNYyywTgw+VwCXv+nHjHy3kZmi4Q0AInKl+gwLMo/
         8Vzw==
X-Gm-Message-State: APjAAAUJ1ZhePs8FmKhHk6zNMrSd3QBZrgCGOK1tUXVELl69HoUzzEqI
        jPdNtG+yJsrYw7FLRmZpefEDXg==
X-Google-Smtp-Source: APXvYqy10B54Sg22aN8scwrJY70VAnPjGpILUNo7T8gOq70S1eMMaCDd8f8pJBO2stBk04EayG0PsQ==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr22390739wmh.123.1555331257642;
        Mon, 15 Apr 2019 05:27:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o1sm19020108wmh.47.2019.04.15.05.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 05:27:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Long Li <longli@microsoft.com>, Simon Xiao <sixiao@microsoft.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] x86/hyper-v: implement EOI assist
In-Reply-To: <20190403170309.4107-1-vkuznets@redhat.com>
References: <20190403170309.4107-1-vkuznets@redhat.com>
Date:   Mon, 15 Apr 2019 14:27:36 +0200
Message-ID: <87v9zfh2rr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Hyper-V TLFS suggests an optimization to avoid imminent VMExit on EOI:
> "The OS performs an EOI by atomically writing zero to the EOI Assist field
> of the virtual VP assist page and checking whether the "No EOI required"
> field was previously zero. If it was, the OS must write to the
> HV_X64_APIC_EOI MSR thereby triggering an intercept into the hypervisor."
>
> Implement the optimization in Linux.
>

Simon, Long,

did you get a chance to run some tests with this?

-- 
Vitaly
