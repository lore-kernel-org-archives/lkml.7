Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE945C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3CC2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGKLXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:23:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfGKLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:23:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so5917024wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 04:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xkQj6rXd6jhqOpnOodbdLnJbizN7yitMYfeVThGNA4=;
        b=GspZzNvT47KtNY/8rlHjhi0PVNi+xZr3uTTTGZtCMaDMVdBYVdfwlacYOfz2aFAuVh
         0PW8bBUoXb9BIVsZqilTDLeEHYIlXTsuEh6rGWZliUaccDlUaPhYFM+Ic5EY+9Wz75J0
         uoO50wql4TEhoGPnfed+cFl306TWE3c+ajs+4Ac6sVU9cO7jydSB21IOpaTW7nZ7CS8W
         btFKVSO2ZjZ7bf7nG+YZWcyqaMxk0P8hMIJQ2QB1rN7OGKffrccLZm9/eotTVd1foDoA
         ayMfg3k4uYfnp5HZ0Yglzoo/naaL9ZCc62ocdzH2qmNz515oDCxNZWAWEVIdVShM6wTh
         VqlQ==
X-Gm-Message-State: APjAAAW9PZRhmLnNZEpqoPoZxNQgoH7+6C1DqmrVUbCESmqIfGJC45kD
        ZAwGEmoOhvWIn4q7fpRZ8THAbQ==
X-Google-Smtp-Source: APXvYqzYt0fhDogZwESZ0arD5eENr8od2gwLRRRfIBfJIOSu6WS+kRxhX99b+wAH8Ri/NQOohNvXXw==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr4641153wrn.285.1562844179011;
        Thu, 11 Jul 2019 04:22:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id y2sm3690485wrl.4.2019.07.11.04.22.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 04:22:58 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Eric Hankland <ehankland@google.com>,
        Wei Wang <wei.w.wang@intel.com>, rkrcmar@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30b7a0a1-1dc7-7ab0-938a-e34e61152ec8@redhat.com>
Date:   Thu, 11 Jul 2019 13:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19 03:25, Eric Hankland wrote:
> 
> +/* for KVM_CAP_PMU_EVENT_FILTER */
> +struct kvm_pmu_event_filter {
> +       __u32 type;
> +       __u32 nevents;
> +       __u64 events[0];
> +};
> +
> +#define KVM_PMU_EVENT_WHITELIST 0
> +#define KVM_PMU_EVENT_BLACKLIST 1
> +

"type" is a bit vague, so I am thinking of replacing it with "action"
and rename the constants to KVM_PMU_EVENT_ACCEPT/REJECT.  What do you think?

Paolo
