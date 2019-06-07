Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2465F2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfFGPRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:17:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFGPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:17:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so2549518wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sX/pioxuVMxljt5xFEWz/xGKhecKIEm1tNEtt9DHln0=;
        b=aNa3lDNG5HNcY7rSr84L6AOAnY6+8zlPqcZpyht0C9fBh6kUaGPcG2dvlUeaFW8+bW
         95IdrrPJsSYzKg+6mGabxlxAb1NF4e2mkFosyf3KfzFCx5wLbq7jld5T2pN3KxgrTfag
         DLOHERQQof/RPSiIjDTr42fhfgPuMTltphWabrq4cYI/sBvMJA37k0ZTObosghYakBKi
         k6q0KABxVD78WK9X+yM1PUrldUVxEihrMThw3JRTVUvErHjd4OhKff7s0Rh//lZcM2+I
         y1yc4z2t5TFMLDCC9PKo2bP5X1Ni0fcjoc856EOc3gfXaQcNJVz70lzrCorQbwqpTv9l
         YuVg==
X-Gm-Message-State: APjAAAUUqCV5F7wzVv4EGITloHr6ilIcC4TmlHZy/VB8r5hen+HtItb9
        X2oyPFIal686L8AqEG9YnFK0bQ==
X-Google-Smtp-Source: APXvYqzAXTGUk9Z0sa4D/SLHGUJd6uodo7ETHrJjF2Inh/QnYCsHcWJybb0atPguJ+rdSbEb6HG83Q==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr5512703wrs.210.1559920630411;
        Fri, 07 Jun 2019 08:17:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617? ([2001:b07:6468:f312:657f:501:149f:5617])
        by smtp.gmail.com with ESMTPSA id o185sm984015wmo.45.2019.06.07.08.17.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:17:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Rename prepare_vmcs02_*_full to
 prepare_vmcs02_*_extra
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1559834652-105872-1-git-send-email-pbonzini@redhat.com>
 <20190606184117.GJ23169@linux.intel.com>
 <8382fd94-aed1-51b4-007e-7579a0f35ece@redhat.com>
 <20190607141847.GA9083@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5762005d-1504-bb41-9583-ec549e107ce5@redhat.com>
Date:   Fri, 7 Jun 2019 17:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607141847.GA9083@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/19 16:18, Sean Christopherson wrote:
> On Fri, Jun 07, 2019 at 02:19:20PM +0200, Paolo Bonzini wrote:
>> On 06/06/19 20:41, Sean Christopherson wrote:
>>>> +static void prepare_vmcs02_early_extra(struct vcpu_vmx *vmx,
>>> Or maybe 'uncommon', 'rare' or 'ext'?  I don't I particularly love any of
>>> the names, but they're all better than 'full'.
>>
>> I thought 'ext' was short for 'extra'? :)
> 
> Ha, I (obviously) didn't make that connection.  ext == extended in my mind.

That's what came to mind first, but then "extended" had the same issue
as "full" (i.e. encompassing the "basic" set as well) so I decided you
knew better!

Paolo
