Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEAC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C06218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfGEMhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:37:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53560 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfGEMhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:37:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so8714515wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMEfTsFYfJMndGqPjo03pluC2RJFLgJPB47NoVMy6DM=;
        b=iEDMMBUz51cMfiLmLwvr6sbNBWXm2bMeAGE0aMpbDLnhYOl91WAFpRY92AhRPtLgrw
         s6/4gmCc8/68siw1kLuws7yjpAr44kL1NZsd9RT72xXGxXK92OCcHWHZCUpOm5Z0iVTC
         NVI5k7qCtOuwmU4V2+HuA1uHelSlwor+mR/xxvf3Ef5FLSAD0EudURpfKtIlT+F68fIy
         v9DhiHwi0svceDqiGgEWmKN0k2Q8FOQ4Kb0tnDr0uigQRbTG5PJ2tZWlwlB+QMCAKLYU
         ZMh4da2s1tzJufhfXCzMSNWuydx5NewOe9lmmI3OlHWc+s5Rsygnc2oSvSlIhQtlcuCN
         iO2Q==
X-Gm-Message-State: APjAAAULwUSVpjHFsiUfmir6F7DsthcQqV+LD1xI1XCuMy7srP8xYv4t
        2iVbmsCASiQD5A4OYU922/ew6Q==
X-Google-Smtp-Source: APXvYqzTxkUxVcI3WUEckO89s+RKrelZQJ/tSe+7p+Csnzma0UWsucyj9RicaSopIlzmC0mhGsBBkA==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr3382337wml.157.1562330265650;
        Fri, 05 Jul 2019 05:37:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id l2sm1859000wmj.4.2019.07.05.05.37.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 05:37:45 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] KVM: LAPIC: Inject timer interrupt via posted
 interrupt
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1561110002-4438-1-git-send-email-wanpengli@tencent.com>
 <1561110002-4438-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <587f329a-4920-fcbf-b2b1-9265a1d6d364@redhat.com>
Date:   Fri, 5 Jul 2019 14:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561110002-4438-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/19 11:40, Wanpeng Li wrote:
> +bool __read_mostly pi_inject_timer = 0;
> +module_param(pi_inject_timer, bool, S_IRUGO | S_IWUSR);
> +
>  #define KVM_NR_SHARED_MSRS 16
>  
>  struct kvm_shared_msrs_global {
> @@ -7032,6 +7036,7 @@ int kvm_arch_init(void *opaque)
>  		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>  
>  	kvm_lapic_init();
> +	pi_inject_timer = housekeeping_enabled(HK_FLAG_TIMER);

This overwrites whatever the user specified, so perhaps:

u8 __read_mostly pi_inject_timer = -1;
module_param(pi_inject_timer, bool, S_IRUGO | S_IWUSR);

...
	if (pi_inject_timer == -1)
		pi_inject_timer = housekeeping_enabled(HK_FLAG_TIMER);

Also, do you want to disable the preemption timer if pi_inject_timer and
enable_apicv are both true?

Paolo
