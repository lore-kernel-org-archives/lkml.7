Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC13C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A6421849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbfGQRaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:30:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39963 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGQRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:30:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so22991752wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okpiWpdfnwyM1YLlRg9SVp2HCONGDPFvxji/Vr8VZhQ=;
        b=kxf7AZ/9S6AkyOy8eZe9RSKDX7ezjC6bdIHcMtCEO+t3a6wlS67l/jeyWh2JKo5VdO
         f8GI+oPuw4aBIWRVWlThEHNhiHAIGa3Spp3hYOpIgWpeYTBVzMLlTA7VsUmj/zvVqjfa
         k54rTHbdA1sT1NcCt9yUrZ3yohjbpseupX34fiCQeTDo892Rpkb6rYbZ2gnddy5F1K9i
         lVtxTSYzc94yAYt2OCWR178yNmV+1lbHRLJfaOw0RLjc+QDdtynD8ty9L6IJHJsca5GF
         XJtqavKR3uQZ5HbZrDczDq96r4tLQVKDYB5Viq4iR426tUWCnQ3HeCiHZ/wboi0LdmpU
         NcQQ==
X-Gm-Message-State: APjAAAWYJChqtVPhjvnvkRto6j/AxCkG6sFUPmQMBVVtuiZdPy0aeEco
        Ih35FbdUXnzrD8isatRGWWMxjA==
X-Google-Smtp-Source: APXvYqw4wLFosMCJsKcqyu21VYl8wlKY1wom+uuOIwtMWn3hdWHXZB+88Xz1muoOJYlZ3/Z6MxyDWg==
X-Received: by 2002:a1c:f515:: with SMTP id t21mr39364355wmh.39.1563384608699;
        Wed, 17 Jul 2019 10:30:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id i18sm29599639wrp.91.2019.07.17.10.30.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 10:30:08 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Eric Hankland <ehankland@google.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
 <5D27FE26.1050002@intel.com>
 <CAOyeoRV5=6pR7=sFZ+gU68L4rORjRaYDLxQrZb1enaWO=d_zpA@mail.gmail.com>
 <5D2D8FB4.3020505@intel.com>
 <5580889b-e357-e7bc-88e6-d68c4a23dd64@redhat.com>
 <CAOyeoRUOqMmG6KkGXUMeK2gz8CmN=TiiuqhtVcM-kekPoHb4wA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0c1655c8-3a5b-f961-ab52-290a69ef4af6@redhat.com>
Date:   Wed, 17 Jul 2019 19:30:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOyeoRUOqMmG6KkGXUMeK2gz8CmN=TiiuqhtVcM-kekPoHb4wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/19 19:05, Eric Hankland wrote:
>> Let's just implement the bitmap of fixed counters (it's okay to follow
>> the same action as gp counters), and add it to struct
>> kvm_pmu_event_filter.  While at it, we can add a bunch of padding u32s
>> and a flags field that can come in handy later (it would fail the ioctl
>> if nonzero).
>>
>> Wei, Eric, who's going to do it? :)
> 
> I'm happy to do it - I'll send out a v3.

Please send a patch on top of what is currently in Linus's tree.

Thanks!

Paolo

