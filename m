Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1617C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E020868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfFGSNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:13:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34668 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbfFGSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:13:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so3080310wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EosIO25kscDdg4/deIdAXrXIX/FDoWhyB9PaERsqjT8=;
        b=iLENssuFeym6tV8GWZW8fPY8LqNLBNmmSEGCna/wVR2Qdj/mhFRwT7rtIg47bG/EZ+
         28km3jAEZCaVMApDCUlAivoJ9k4RfToXcCjSEtI5nt+dWxQ9yRTOtQrELRb8tlgV465R
         I7cCNgq1nITph4HpWUsqKnDJprMCEkw/8r82BARLyftmPSe+jlO7vbZNN2dBEwFtS3zZ
         IkXMH2RtRp1Tmko4+gd4qdQzKZGkxC/9bizEcsTjytCvrdsdq6nqZkT+b1wa2Anr0KA6
         cKzHmH8rW0p6e3orEQXPF9IuGDKp/9tHCV1q1SRH71qYU5aocU+cTp4pVy5A1bHpk8Mr
         hvug==
X-Gm-Message-State: APjAAAUhviITsHBpMNSXDrUIAOz/3tPgkha9rHfqf3vvbL/GFmXVAqDB
        QqhUeweGkLdTW4ltRDE3U4uJMg==
X-Google-Smtp-Source: APXvYqxP6cfcdMrFlzUn4io5BVLKCM01R591Zj4sqsIG/1P3jh9zZMqspSJglpTb+em4cSqroAXVTw==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr11524174wrq.315.1559931203159;
        Fri, 07 Jun 2019 11:13:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775? ([2001:b07:6468:f312:d43d:6da3:9364:a775])
        by smtp.gmail.com with ESMTPSA id b2sm3323821wrp.72.2019.06.07.11.13.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:13:22 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: simplify vmx_prepare_switch_to_{guest,host}
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1559927301-8124-1-git-send-email-pbonzini@redhat.com>
 <20190607173710.GG9083@linux.intel.com>
 <20190607174753.GH9083@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11522be0-4d38-a8e5-e4cd-274c8e309b2f@redhat.com>
Date:   Fri, 7 Jun 2019 20:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607174753.GH9083@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/19 19:47, Sean Christopherson wrote:
>> This is the hiccup with naming it sregs_loaded.  The split bools is also
>> kinda wonky since the 32->64 case is a one-off scenario.  I think a
>> cleaner solution would be to remove guest_msrs_dirty and refresh the MSRs
>> directly from setup_msrs().  Then loaded_cpu_state -> loaded_guest_state
>> can be a straight conversion from loaded_vmcs -> bool.  I'll send patches.
> Actually, would it be easier on your end if I do a v2 of the series that
> would introduce vmx_sync_vmcs_host_state(), and splice these patch into it?

For now I'll just rename it to guest_state_loaded, let's do further
cleanups on top.  My plan is to post my version of everything after
testing so that you can do a "git range-diff" between my patches and
yours.  (For exposure I'll probably push that to kvm/queue, but I don't
intend to merge them to kvm/next without your review).

Paolo
