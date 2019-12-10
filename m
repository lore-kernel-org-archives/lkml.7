Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BAAC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139DB2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REh/G6RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLJJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:20:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39893 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbfLJJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575969605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bYiIJtudCWkuxmJ3U7uh+uE9YOFh6uPtLmRweTcPTI=;
        b=REh/G6RJzAVlizUUO6oZ/eOPkUafjZ57OFEvoE772l1zcGElS4DWFtwzEnvpjEdBWeDTHs
        skpVHx3vw07BKUnNNKIRFtAfMlPJN/ntcK+F9NX7lQ1iieAAn+Hh/VATAW2Q8LJKWOSkJM
        xBGzJdV8nnlScJtlRyUq5bPMY23Adf4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-3jpxheGdMx-PT6DNDgbP6w-1; Tue, 10 Dec 2019 04:19:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id o205so764796wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bYiIJtudCWkuxmJ3U7uh+uE9YOFh6uPtLmRweTcPTI=;
        b=SsllXlDkAF3uclbm09gbv0RFQOvzCQEWVldAfz5Yie1Um4RNGmHZSdqjf+5thstzF2
         +ZMPgFiztiVt2sbxxq6Jmdo7fntzsOFApBqOhJj7r1JdT0UL6F49zWAFWyYS7MBohMX4
         DJOcEra7k2MPivsor0lb6H17X88I6vgSZDzWd064Bl96Ij5kJPVAjITOpcEPhXIfFXpn
         IvkeU/EquFOL82+dVIc7jjZg6j+szCBzL3vFmKTBNNe1hAZDh1SUOycXLXwrVW0iq8vt
         Pz5XQN+nKGknQWhTr3Un7b/YcfwUUvOFSuRXz5JOYM5FRRpbJc1Q+mOaDQDbxKaPSBCm
         K/nQ==
X-Gm-Message-State: APjAAAVPZVhPRZlGnuUN/vstFF2kMlBLavXEqUZc3syJsTs82Vg+jJMG
        XrZTzlYRmwySI8lI1EK4sHTlu1L4eDBOpMqWDyBA7PkupzkYR3yrLrGA6cOL5gj8BWqF/FHUKKY
        KdVao/+ZKgXk3SxJzUxdjuHoU
X-Received: by 2002:adf:f803:: with SMTP id s3mr1955414wrp.7.1575969597795;
        Tue, 10 Dec 2019 01:19:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzDnyT2KZKAXq1IvkcmoircMXuSHIe+B7ZX1hbvwigcGPf4Y/msYzb6HapPfHPkh1RodEdyw==
X-Received: by 2002:adf:f803:: with SMTP id s3mr1955389wrp.7.1575969597600;
        Tue, 10 Dec 2019 01:19:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id m3sm2549644wrs.53.2019.12.10.01.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:19:57 -0800 (PST)
Subject: Re: [PATCH v2] KVM: x86: use CPUID to locate host page table reserved
 bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, stable@vger.kernel.org
References: <1575474037-7903-1-git-send-email-pbonzini@redhat.com>
 <20191204154806.GC6323@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9951afb8-8f91-2fe1-3893-04307fafa570@redhat.com>
Date:   Tue, 10 Dec 2019 10:19:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191204154806.GC6323@linux.intel.com>
Content-Language: en-US
X-MC-Unique: 3jpxheGdMx-PT6DNDgbP6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/19 16:48, Sean Christopherson wrote:
>> +	/*
>> +	 * Quite weird to have VMX or SVM but not MAXPHYADDR; probably a VM with
>> +	 * custom CPUID.  Proceed with whatever the kernel found since these features
>> +	 * aren't virtualizable (SME/SEV also require CPUIDs higher than 0x80000008).
> No love for MKTME?  :-D

I admit I didn't check, but does MKTME really require CPUID leaves in
the "AMD range"?  (My machines have 0x80000008 as the highest supported
leaf in that range).

Paolo

