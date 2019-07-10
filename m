Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F637C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1689520693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGJGeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:34:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42957 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:34:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id v15so1010048eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 23:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J5KipV70foUU8ZDHSfbxKtNUPFs4vS9J459AyOxAvGM=;
        b=m44bwsFepRbM1TyvN9blBbrkC8X44eTQOSj5dmiAPmFMLNLU5g8QX7849r1f+MnOUH
         westRnqQpE8k1A1CISqRNmBiqaXcUYk72Kw25ACmKJsJ5mBmgSzQr6qSUmgLECfvTaG0
         pY1+2bSZ57xRfN6GZQzuW/aL2XDeA/MR0UxeEeGV+n8we2Cd9S6SFWAP6hQ6ODLJ9eGt
         DHG/AhXpmgrsxSDpwpBay1H7dq575+7p/eW+5GHY4Ldj/7KIap4EiBj1vafJmKJnbECH
         nNAX3sctkwxsShgsztB4mEUYQwq77KHHpNP2RgG++7E3/MUagqohHgZc3BwGwgyb/X1m
         ChmA==
X-Gm-Message-State: APjAAAWECErAxpi80HEgOnGqSHMYnjXxvz7Do6TR74c3k4NAa1WMOeOg
        3MoYsYg52rTO3rP2I0RnwkVmfg==
X-Google-Smtp-Source: APXvYqzqTMPNjCwtT/7mZ0wnEqoDGAx/LQ2+vzGyWcOQdNOsLF0bRspAi2qapk8oaWANI1ig6TID8g==
X-Received: by 2002:a05:6402:1456:: with SMTP id d22mr29919969edx.57.1562740446759;
        Tue, 09 Jul 2019 23:34:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id y16sm1041817wrw.33.2019.07.09.23.34.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 23:34:06 -0700 (PDT)
Subject: Re: [PATCH 5/5] KVM: cpuid: remove has_leaf_count from struct
 kvm_cpuid_param
To:     Jing Liu <jing2.liu@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190704140715.31181-1-pbonzini@redhat.com>
 <20190704140715.31181-6-pbonzini@redhat.com>
 <bb5e81f4-bb34-2841-0fa1-63876b97e54c@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a7d222e-3c49-2485-e11d-45c9e9ece8c8@redhat.com>
Date:   Wed, 10 Jul 2019 08:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bb5e81f4-bb34-2841-0fa1-63876b97e54c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/19 09:09, Jing Liu wrote:
> It seems the two func are introduced by 2b5e97e, as paravirtual cpuid.
> But when searching KVM_CPUID_SIGNATURE, there seems no caller requesting
> this cpuid. Meanwhile, I felt curious if KVM_CPUID_FEATURES is still in
> use but it seems kvm_update_cpuid() uses that. Not sure which spec
> introduces the latest pv cpuid.

Yes, KVM_CPUID_SIGNATURE is generally not very interesting for
userspace.  But KVM_CPUID_FEATURES is called here:

        for (w = 0; w < FEATURE_WORDS; w++) {
            /* Override only features that weren't set explicitly
             * by the user.
             */
            env->features[w] |=
                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
                ~env->user_features[w] & \
                ~feature_word_info[w].no_autoenable_flags;
        }

Paolo
