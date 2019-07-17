Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62DC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F4C217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGQKW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:22:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37073 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:22:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so21545506wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jLTb8XaQwDXkfXSX6rjJzVtQ/s+CDif4rrylvctVb1E=;
        b=rjIm1sTI7lJvIf7GRKp+8il9hLMb7IiMTP5Z6Zab1TUZ0MDbrwh0LiqSszS6oDF7H9
         C0SQlzHhrFkoBvJ2CVzrKI5NfxbWvpfteRlieq6oNEdjI2EHEekJyf0f4vAzDrufBVho
         kG00djgytYCE99EBaLVQJdzgQsJboPPnrV5CmHXllVfyhdlD8DnYsCVk/X8x//xaLSAY
         MeyCzl9EIkSDW+lFvBcnPEVN/WLNfxaZqC6xLhDONcoorDvnkkrAvS4gwz9Oy10cdN+6
         gDmeNDJoTZbs92EC+dhWA7h02wfJEYsXAhg3Wseg9HmbCmwOYh83zEh9EugMm3D614xp
         KnaQ==
X-Gm-Message-State: APjAAAWmjrJ674cVIR/fcBMAH3eQ8TzN1ZKF/XvWtoc51MVhtUEB+MQp
        6rZtvbKg+esYrJFf+OkAJBpW/w==
X-Google-Smtp-Source: APXvYqxg7asgftVlbHdDAy8AZswsqWfMo4yX1870wYoGzbxKjR9+cxc4Cqnn60F61CBtgD5q5kG7wg==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr4545813wmi.88.1563358945785;
        Wed, 17 Jul 2019 03:22:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id h133sm24198066wme.28.2019.07.17.03.22.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:22:25 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Wei Wang <wei.w.wang@intel.com>,
        Eric Hankland <ehankland@google.com>
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
 <5D27FE26.1050002@intel.com>
 <CAOyeoRV5=6pR7=sFZ+gU68L4rORjRaYDLxQrZb1enaWO=d_zpA@mail.gmail.com>
 <5D2D8FB4.3020505@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5580889b-e357-e7bc-88e6-d68c4a23dd64@redhat.com>
Date:   Wed, 17 Jul 2019 12:22:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5D2D8FB4.3020505@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/19 10:49, Wei Wang wrote:
> {
>   KVM_PMU_EVENT_ACTION_GP_NONE = 0,
>   KVM_PMU_EVENT_ACTION_GP_ACCEPT = 1,
>   KVM_PMU_EVENT_ACTION_GP_REJECT = 2,
>   KVM_PMU_EVENT_ACTION_MAX
> };
> 
> and add comments to explain something like below:
> 
> Those GP actions are for the filtering of guest events running on the
> virtual general
> purpose counters. The actions to filter guest events running on the
> virtual fixed
> function counters are not added currently as they all seem fine to be
> used by the
> guest so far, but that could be supported on demand in the future via
> adding new
> actions.
> 

Let's just implement the bitmap of fixed counters (it's okay to follow
the same action as gp counters), and add it to struct
kvm_pmu_event_filter.  While at it, we can add a bunch of padding u32s
and a flags field that can come in handy later (it would fail the ioctl
if nonzero).

Wei, Eric, who's going to do it? :)

Paolo
