Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD2C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DDA2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbfFKLKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:10:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37651 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbfFKLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:09:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so12535870wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 04:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ewq00r0CEEYLXioP30O1q2BeCLR2SfDQByxI3ASmz30=;
        b=ar+FsVde5zUpYyHd+9ZM/eClx91VKz1DWgmNCdJLYqlf2HBGgM6bCM2vSPLruvU6aE
         FpxjYWElgMwV45K0uI06QS/HPlVd/ol+Rig4piJv/wC1OJztSX9NA8qo8vTnPBN5RvZ4
         CBKV9P6WWKW3dPuumYfzzQdx35L/9ULYNuTIQ+AvHEMgjOywtrHThgmV8N5nzN/7Lup7
         MXoyd/3WvD9/hv0rGismCeextTwUDHwt/vKss60cCb1BgOe8r51hIiSCYA7k6PmJRVo+
         EzdJilP6k+L5DSHlKLrtxmbw3wFqEUgSlRBVYqMVEgQ0T2voVxAcx/I1sRjDuL1FmE3g
         Pj1Q==
X-Gm-Message-State: APjAAAXPANpfY27FrGx83dekYlROdvW2WsILJ71s6bt43RHOEpUwHr1y
        aKX9UFTAQGonfzZ+MveY2vWnsg==
X-Google-Smtp-Source: APXvYqzN/haxCNxgeICKR52OC0EvsGr/RwWKjb1vCrA8a/DvAOMqDb3jb86+FmbFRNs7K9cItb7HhA==
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr33023295wrw.170.1560251398314;
        Tue, 11 Jun 2019 04:09:58 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id c16sm11726088wrr.53.2019.06.11.04.09.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 04:09:57 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] KVM: X86: Provide a capability to disable cstate
 msr read intercepts
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1558418814-6822-1-git-send-email-wanpengli@tencent.com>
 <1558418814-6822-2-git-send-email-wanpengli@tencent.com>
 <627e4189-3709-1fb2-a9bc-f1a577712fe0@redhat.com>
 <CANRm+CyqH5ojNTcX3zfVjB8rayGHAW0Ex+fiGPnrO7bkmvr_4w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b30067df-2929-9ce9-221f-0f1a84dd1228@redhat.com>
Date:   Tue, 11 Jun 2019 13:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CyqH5ojNTcX3zfVjB8rayGHAW0Ex+fiGPnrO7bkmvr_4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/19 09:38, Wanpeng Li wrote:
> MSR_CORE_C1_RES is unreadable except for ATOM platform, so I think we
> can avoid the complex logic to handle C1 now. :)

I disagree.  Linux uses it on all platforms is available, and virtual
machines that don't pass mwait through _only_ have C1, so it would be
less useful to have deep C-state residency MSRs and not C1 residency.

But turbostat can get the information from sysfs, so what are these MSRs
used for?

Paolo
