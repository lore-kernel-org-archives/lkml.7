Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB82C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64E42083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfFFUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:19:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37491 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFFUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:19:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so1212033wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fAkfn85/lqdX0osdVxNuElygntohyc34l0gKSlhr3ag=;
        b=QX4XuCyRyFsDNvSGtX0I2vOmyex3tE7F3UVU8bq3XVYWMLpe+T5ReFdNrE9Opcy6JS
         isSG6SIwrW4zHdFcRrSAT3HvAJXb0mEKE4iAezloVHlp3oz4As7fsE5sjasXHkaU2mwf
         C2D2DxzxJfppmhmRHTdLeJHvW3fmJ/8weuSqR361wIalS6spLy6K7ga2zP5IAvFqU8lg
         lj6Q3ieFoEYQ66IxSdHfkcx2co3t1NDAgWdigpk5FjV7sAa79DW2oaYCr731JPQwfcWI
         5sYW8M8QQa368EDTmBHv5eBlbSIFsAofh2fIXrdunKxBG0olxa1SXxyEZmeonpOhYP2P
         WMyg==
X-Gm-Message-State: APjAAAW6BQeqwqxG0CYtum7QhFXn8U5n7nWhX+EtgxRhah+Bx3tNvYTt
        xAq54bUAobdLyu7Clw9Zu5129A==
X-Google-Smtp-Source: APXvYqz48mChkyOODV0ajnbXZEGl5Ke1m19drYd50JUK+efjQXEu/HUD/f9LmnXacpx2Wf2aaiFrEA==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr1201738wmg.63.1559852345364;
        Thu, 06 Jun 2019 13:19:05 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id c129sm2700570wma.27.2019.06.06.13.19.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 13:19:04 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Rename prepare_vmcs02_*_full to
 prepare_vmcs02_*_extra
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1559834652-105872-1-git-send-email-pbonzini@redhat.com>
 <20190606184117.GJ23169@linux.intel.com>
 <89dd5d66-0d37-ea41-3f6d-72d5a8a9815d@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd3f30e2-32ed-4bba-0456-f7ab7e24d792@redhat.com>
Date:   Thu, 6 Jun 2019 22:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <89dd5d66-0d37-ea41-3f6d-72d5a8a9815d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/19 21:19, Krish Sadhukhan wrote:
> 
> The big chunk of the work in this function is done via
> prepare_vmcs02_constant_state(). It seems cleaner to get rid of
> prepare_vmcs02_early_full(), call prepare_vmcs02_constant_state()
> directly from prepare_vmcs02_early() and move the three vmcs_write16()
> calls to prepare_vmcs02_early().
> 

This is just a mechanical search and replace, you can send a patch on
top to inline it in the caller.

Paolo
