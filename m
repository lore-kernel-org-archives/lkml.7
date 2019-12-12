Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF5D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKGtPQFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfLLP5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:57:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35579 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729557AbfLLP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576166243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=eKGtPQFUT0VBuUCexDwHiwsQrTlAnT5/gYDHwF+eydduyyF0vYDlw4iigBGNI8mwyby9UA
        WRhOtDoW0deEh+6l4c2QC5DVAoB6GTWANrb5raXHOKd5TXeGtQ0bRHb4CjnPELAiK8vDav
        8/jAIm+ukJf5TlaMvWi6PcQwgLRzYpE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-dQJico3HN1WsHV7UBQ8DOg-1; Thu, 12 Dec 2019 10:57:16 -0500
X-MC-Unique: dQJico3HN1WsHV7UBQ8DOg-1
Received: by mail-wr1-f70.google.com with SMTP id u12so1196699wrt.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=NR1IXo+pPTh871+f4oJ4CzZ2PCKKc4KSUXnHaIBTil6SCJbsq58ZgXHzkBAKnlq9jw
         jSR8IPv7Qfy6TME0TfHX31Ev5akt530rZAUBtdTYS0u3xmYVhthFMB7qtjiWeA65HjT4
         EP6yK39a6gxDTGw6M2ASMjvluQsI1mifUEGLtwnIfF2kiT7vGrHsuhViliv+UpZvL9vf
         WZj44gxhcOCKR31lbumZuiX+AONF13f6zFI3PCexckhgXoszoeGmaVNV1IHTaDF1CFq1
         r5VZpVOtvmpaDk5xnLa+cM5xUmWNdSq5iWtCmeHIn9BV9+ibamhg9x5Zt2lLncuqFAuk
         uKRQ==
X-Gm-Message-State: APjAAAXvP9bdl0LlBeG9S0VEUo9cPv+0VzFQ4mkhWQz/lVi7aFLD8ITw
        PYU9EFuzSjrDe7UHtK4nKATwobYEn+y2npQszxixQjWhnKhL1gXTdyF6vH0Wt0n4PGRcBRgf7BY
        Je4jlV27ldq0XfXD40RO4WbiO
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226941wrm.284.1576166235413;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCcJblbdBpu6fVRmTMMxd9YCps91vlO3a/KrWqDMJ5D1GjIwC7bcnVpKVuMe+qGktQ2LnvbA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226922wrm.284.1576166235182;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id s10sm6451431wrw.12.2019.12.12.07.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:57:14 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
Date:   Thu, 12 Dec 2019 16:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 16:52, Liran Alon wrote:
>>> virt_apic_accesses	-> vapic
>> apicv
> Frankly, I dislike APICv terminology. I prefer to enumerate the
> various VMX features which are collectively called APICv by KVM. 
> APICv currently represents in KVM terminology the combination of
> APIC-register virtualization, virtual-interrupt-delivery and
> posted-interrupts (See cpu_has_vmx_apicv()).
> 
> In fact, the coupling of “enable_apicv” module parameter have made me
> multiple times to need to disable entire APICv features when there
> for example was only a bug in posted-interrupts.
> 
> Even you got confused as virtualize-apic-access is not part of KVM’s
> APICv terminology but rather it’s enablement depend on
> flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e.
> It can be used for faster intercept handling of accesses to guest
> xAPIC MMIO page.

Right, I got confused with APIC-register virtualization.  Virtualize
APIC accesses is another one I wouldn't bother putting in /proc/cpuinfo,
since it's usually present together with flexpriority.

Paolo

