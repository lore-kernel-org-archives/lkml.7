Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476EC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D397206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG5VpbAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLCMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:52:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45028 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbfLCMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575377571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTqB+4QR8u3g4v2ElB77IyAVy/qzh6SU7ndV5uNvdN4=;
        b=aG5VpbAJFVVBaVuJvg5SoOFJEpEAcjt6eVk2lA9IdP1bwGYBfY8Gp6YGxytzqm8jSvqX5y
        I5xcfdjn7aNe46Ddx9zRtxRAzr1ta4nUiXIZY25h8jElmIY/vIvPuqPspLq8dCQmien7CG
        ufQwJEJ8IpICwAZp4u42h8eMjjN3n+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-NzPDtvhsPnq8ohNwGWW4vg-1; Tue, 03 Dec 2019 07:52:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so1725444wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 04:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTqB+4QR8u3g4v2ElB77IyAVy/qzh6SU7ndV5uNvdN4=;
        b=L8jnJVvCB+GseUW2Hh0yKOOrjX5IPGDmnglXDHSnd560irE7J48SIuEAm3vs7Y/KE2
         T8LX8GIz4hjhPw3tfoGqBJVwoF3sYr/4mYmwEzBpexoW9XX7u/OofKrlSQSeMEPgqGji
         JtVXMV0vwipPAbHEXkCsGWqVDLN/RiL80EQA6OHUANq4s90Y45def/c+pYVgXGKz8EJH
         y02FV7gEEn/xx92kEM46fBLhaNN+isgFCRZNIJGhkM3fEYazMwuxVK6BeEP8YmQNIH7t
         pUJb7/2Cue2Ax/t9rNtK1sNFh/GYjLEsLxqF6lxUYWNbd6LRjre2VhCDtsNzG3GBwVSL
         EF8w==
X-Gm-Message-State: APjAAAXCTr37AESeN5bLiUn5MRJJcCDD1xQzDZ3TuHnw4RBM0M+8LUf8
        Rmm7eb+7NeyN6TzSK6WHYrGLMDSqLecdOhd752D/XDoEN7/6d+gaPB/KAtB/ori3kGOXDLfwMlc
        fN/xoHRhiBDZj1BvOT8AJbDrQ
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr35371969wmh.81.1575377569325;
        Tue, 03 Dec 2019 04:52:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuG/MzWGc0GLmRFw8mZJqm66Z6M/JIS/M9I4FOTLfG1kHTMo+mfnl2not3mYUB0iyaWmnhXQ==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr35371943wmh.81.1575377569095;
        Tue, 03 Dec 2019 04:52:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id l7sm3438356wrq.61.2019.12.03.04.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 04:52:48 -0800 (PST)
Subject: Re: [PATCH 4.19 067/306] KVM: nVMX: move check_vmentry_postreqs()
 call to nested_vmx_enter_non_root_mode()
To:     Jack Wang <jack.wang.usish@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Sasha Levin <sashal@kernel.org>
References: <20191127203114.766709977@linuxfoundation.org>
 <20191127203119.676489279@linuxfoundation.org>
 <CA+res+QKCAn8PsSgbkqXNAF0Ov5pOkj=732=M5seWj+-JFQOwQ@mail.gmail.com>
 <20191202145105.GA571975@kroah.com>
 <bccbfccd-0e96-29c3-b2ba-2b1800364b08@redhat.com>
 <CA+res+SffBsmmeEBYfoDwyLHvL8nqW+O=ZKedWCxccmQ9X6itA@mail.gmail.com>
 <828cf8b7-11ac-e707-57b6-cb598cc37f1b@redhat.com>
 <CA+res+Qo1mX_UFEqDD+sm80PZeW4bRN8VZeNudMDaQ=5-Ss=0g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1387d9b8-0e08-a22e-6dd1-4b7ea58567b3@redhat.com>
Date:   Tue, 3 Dec 2019 13:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CA+res+Qo1mX_UFEqDD+sm80PZeW4bRN8VZeNudMDaQ=5-Ss=0g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: NzPDtvhsPnq8ohNwGWW4vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 13:27, Jack Wang wrote:
>>> Should we simply revert the patch, maybe also
>>> 9fe573d539a8 ("KVM: nVMX: reset cache/shadows when switching loaded VMCS")
>>>
>>> Both of them are from one big patchset:
>>> https://patchwork.kernel.org/cover/10616179/
>>>
>>> Revert both patches recover the regression I see on kvm-unit-tests.
>> Greg already included the patches that the bot missed, so it's okay.
>>
>> Paolo
>>
> Sorry, I think I gave wrong information initially, it's 9fe573d539a8
> ("KVM: nVMX: reset cache/shadows when switching loaded VMCS")
> which caused regression.
> 
> Should we revert or there's following up fix we should backport?

Hmm, let's revert all four.  This one, the two follow-ups and 9fe573d539a8.

Paolo

