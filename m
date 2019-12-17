Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F619C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591612082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1T7K9qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfLQJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:01:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726571AbfLQJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576573304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2Gw8yJPvN6G2s5E4vuYfGxJ1d6qJ2xM+8wxF2HTMMM=;
        b=P1T7K9qfW6kO7y5uERLrLTrv/bX89HzHxEcmQxJXzy3S/hZ+67Z0YMrZ6FR+Dn7pRCi/qy
        Fpv4F+FA0fhg9JzjvnIPel0Txhz2GpdY/6iSo/NwIhcOy8hp7QP4pwbdI001nyMRKS7PlF
        X6El8OX5ZAcgchPrxEPxapQgBBNuaPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-4TDNWrgQNM29VTY8BasAQA-1; Tue, 17 Dec 2019 04:01:42 -0500
X-MC-Unique: 4TDNWrgQNM29VTY8BasAQA-1
Received: by mail-wm1-f72.google.com with SMTP id w205so655260wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 01:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m2Gw8yJPvN6G2s5E4vuYfGxJ1d6qJ2xM+8wxF2HTMMM=;
        b=IrCB/GZ9/EaCNQgj3k7xpjtUGTorbRsZFha+dm9mWBbcR2F94+WNuqmwudqyLVEqUL
         ebJTsF0kee9zFUezy9FQSMhF97B17J1tP5bdY33lOWyIwGgk90HZin6PDsXL+x+HBvVm
         epzp7HDFWoX1QJG22TmqhA1ZrVdNIBLzZ5Ux91hqZNxiMRAi+OKi74Hw5WPe57dhE5u+
         TXjE1Mau39Y6altLJnnvesj6qWtT12MlNPuEUy5h6YkIBCNUiXCrWtLYfUGWXZaQUFzm
         Z2SLsDVaWZ0FzZCwxVw2uEo94giNLqFrWo1A1c3YVUbhSZ6LOpL2KdvTKnA5AgKWLbca
         JtJQ==
X-Gm-Message-State: APjAAAXWjXczql5gP7khrSnwv9FLYdO6chrj0FehCXoMK8psIWSJzTbU
        Fde1O5CwGN1whx6+323BE8id+3QRPGIRgx8C+r6jPfBPlW8ZFiyVe2lZ7K3RPbk52mUFKM77UIY
        gqkpGx9wMbT9kSHAEtEwPf5oa
X-Received: by 2002:a7b:c051:: with SMTP id u17mr4070968wmc.174.1576573301582;
        Tue, 17 Dec 2019 01:01:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXqRjBZ9BGLvdG/PUBz25iLfh1NUwnKV2Gj1ZmcRrsJ2IEpKThoiGKbzSdEyRSooHRDmfI5w==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr4070924wmc.174.1576573301256;
        Tue, 17 Dec 2019 01:01:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a? ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
        by smtp.gmail.com with ESMTPSA id x11sm2182298wmg.46.2019.12.17.01.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 01:01:40 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
 <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
 <20191216185454.GG83861@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <815923d9-2d48-2915-4acb-97eb90996403@redhat.com>
Date:   Tue, 17 Dec 2019 10:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191216185454.GG83861@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/19 19:54, Peter Xu wrote:
> On Mon, Dec 16, 2019 at 11:08:15AM +0100, Paolo Bonzini wrote:
>>> Although now because we have kvm_get_running_vcpu() all cases for [&]
>>> should be fine without changing anything, but I tend to add another
>>> patch in the next post to convert all the [&] cases explicitly to pass
>>> vcpu pointer instead of kvm pointer to be clear if no one disagrees,
>>> then we verify that against kvm_get_running_vcpu().
>>
>> This is a good idea but remember not to convert those to
>> kvm_vcpu_write_guest, because you _don't_ want these writes to touch
>> SMRAM (most of the addresses are OS-controlled rather than
>> firmware-controlled).
> 
> OK.  I think I only need to pass in vcpu* instead of kvm* in
> kvm_write_guest_page() just like kvm_vcpu_write_guest(), however we
> still keep to only write to address space id==0 for that.

No, please pass it all the way down to the [&] functions but not to
kvm_write_guest_page.  Those should keep using vcpu->kvm.

>>> init_rmode_tss or init_rmode_identity_map.  But I've marked them as
>>> unimportant because they should only happen once at boot.
>>
>> We need to check if userspace can add an arbitrary number of entries by
>> calling KVM_SET_TSS_ADDR repeatedly.  I think it can; we'd have to
>> forbid multiple calls to KVM_SET_TSS_ADDR which is not a problem in general.
> 
> Will do that altogether with the series.  I can further change both of
> these calls to not track dirty at all, which shouldn't be hard, after
> all userspace didn't even know them, as you mentioned below.
> 
> Is there anything to explain what KVM_SET_TSS_ADDR is used for?  This
> is the thing I found that is closest to useful (from api.txt):

The best description is probably at https://lwn.net/Articles/658883/:

They are needed for unrestricted_guest=0. Remember that, in that case,
the VM always runs in protected mode and with paging enabled. In order
to emulate real mode you put the guest in a vm86 task, so you need some
place for a TSS and for a page table, and they must be in guest RAM
because the guest's TR and CR3 points to it. They are invisible to the
guest, because the STR and MOV-from-CR instructions are invalid in vm86
mode, but it must be there.

If you don't call KVM_SET_TSS_ADDR you actually get a complaint in
dmesg, and the TR stays at 0. I am not really sure what kind of bad
things can happen with unrestricted_guest=0, probably you just get a VM
Entry failure. The TSS takes 3 pages of memory. An interesting point is
that you actually don't need to set the TR selector to a valid value (as
you would do when running in "normal" vm86 mode), you can simply set the
base and limit registers that are hidden in the processor, and generally
inaccessible except through VMREAD/VMWRITE or system management mode. So
KVM needs to set up a TSS but not a GDT.

For paging, instead, 1 page is enough because we have only 4GB of memory
to address. KVM disables CR4.PAE (page address extensions, aka 8-byte
entries in each page directory or page table) and enables CR4.PSE (page
size extensions, aka 4MB huge pages support with 4-byte page directory
entries). One page then fits 1024 4-byte page directory entries, each
for a 4MB huge pages, totaling exactly 4GB. Here if you don't set it the
page table is at address 0xFFFBC000. QEMU changes it to 0xFEFFC000 so
that the BIOS can be up to 16MB in size (the default only allows 256k
between 0xFFFC0000 and 0xFFFFFFFF).

The different handling, where only the page table has a default, is
unfortunate, but so goes life...

> So... has it really popped into existance somewhere?  It would be good
> at least to know why it does not need to be migrated.

It does not need to be migrated just because the contents are constant.

Paolo

