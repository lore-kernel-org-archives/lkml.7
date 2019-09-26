Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A0C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B8B20872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfIZKZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:25:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfIZKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:25:24 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 703B081F0D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:25:24 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id o8so953787wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wg1F6fhHfjGl1CmkFUDQZE8b2uXlEUi5cZIaWD+93Ng=;
        b=YSlxCMLVRGPrDOwlFbwdp836zQyzh0jZMIREthXIDQFk8Saf7qeOGBg/whFkfLcJ9i
         UpyBAQrFnK4i8AYCTo15a/xpS36xRkO0qBfOKbX3kP/Fwn42rM7MlZkJAs/Ll7S/4KWi
         H2fBI8B4YdJg8GvXCQLImZpk7eYEbsRztLQhMR3UvGqq01oIyBta8pjfJ8x46qBXVNZ8
         Y62TsNEMXuO+5mIrm+n5bZC38a//kmefR/fIVrI+nd3u+ESHwlbhxlOiIPYvZxnJqjz5
         D3DA7IqS/nNXnwzP12vKY9wTT7yvAM0+zezkkBY+TRL4viJe0cUfOktKztLP1FPONkww
         9Q8g==
X-Gm-Message-State: APjAAAV1D6DU2P0wLGJrl2vurfoSuf4KyhSF3IpHJG3k0ehMXKtepVMx
        Sra8ifwHCcOMItkGqfr8FH5DO6BPDN1QZc0aMrVxR9nFjn7RNaOJyRCRgefEveEJsynqHidRJEz
        4vN07uvaAjvd1fILULABxbTZ9
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr2286927wmb.158.1569493523028;
        Thu, 26 Sep 2019 03:25:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8yGv+a6tmqUttSQfZ1O++o0RvOjj04j7ifv0aGAkM22LS/PTzhHvNMrwLsv4fuUKFDDqmMQ==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr2286906wmb.158.1569493522778;
        Thu, 26 Sep 2019 03:25:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id o9sm3012505wrh.46.2019.09.26.03.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 03:25:22 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: LAPIC: Loose fluctuation filter for auto tune
 lapic_timer_advance_ns
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1569459243-21950-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ea06c6bb-c6ff-ef34-55ca-c58cb77ed39e@redhat.com>
Date:   Thu, 26 Sep 2019 12:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569459243-21950-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/19 02:54, Wanpeng Li wrote:
> -#define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100
> -#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 5000
> -#define LAPIC_TIMER_ADVANCE_ADJUST_INIT 1000
> +#define LAPIC_TIMER_ADVANCE_EXPIRE_MIN	100
> +#define LAPIC_TIMER_ADVANCE_EXPIRE_MAX	10000
> +#define LAPIC_TIMER_ADVANCE_NS_INIT	1000
> +#define LAPIC_TIMER_ADVANCE_NS_MAX     5000

I think the old #define value is good.  What about:

-#define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100
-#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 5000
-#define LAPIC_TIMER_ADVANCE_ADJUST_INIT 1000
+#define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100	/* clock cycles */
+#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 10000	/* clock cycles */
+#define LAPIC_TIMER_ADVANCE_NS_INIT	1000
+#define LAPIC_TIMER_ADVANCE_NS_MAX     5000

?

Thanks,

Paolo
