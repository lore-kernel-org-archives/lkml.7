Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC424214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKc0Wyrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfLLIML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:12:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbfLLIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576138329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vbKumHRhYv4hi2VaZ7lUNT3xifUzCtPM0UHF+6l3NA=;
        b=RKc0WyrgCu87JJ6B2k6WKHdDUJtltniPy+8EuVvBgTbjq6DSG0OGzD9Sc+/AC9meLkWa/4
        9//MUBhSAvhIdzudevdODc2av492nKnzSxQCP3D46nG9/2OZ6m0YQQ4+oL1fMw1HC6Bjm0
        KyqmNRReKrCfEq8hVpTU3S5tca+BCYw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-KpY90oDPP9W1BkH8xwpGdg-1; Thu, 12 Dec 2019 03:12:08 -0500
X-MC-Unique: KpY90oDPP9W1BkH8xwpGdg-1
Received: by mail-wr1-f72.google.com with SMTP id z14so731031wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 00:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vbKumHRhYv4hi2VaZ7lUNT3xifUzCtPM0UHF+6l3NA=;
        b=lkY2NDLOTEVZT6EsZozehOcyww8jz4L+E42oKTKPwHB3XK4DlHK5AEOzttEFO7Ljb5
         Ysh8lEiniK2jm4ZJRVrmCi1D5P7mlUL+jDOK8fyq3lgZqt0UR94Yutuyuk/x6T5ywg7d
         oe8KMH5Mjr9/gyF164H70WJswtk7Aus4F5SD5YbC4+zImxVtHhVXErE+wdrJH0pGpP2w
         OCCC/pY4DGdnZhqGVVGF/lHv/wxxI2pKs013xeEI37LMKuJU3jmOWjq0oGc0L0QK9MCv
         kwNapmcyDNyEoUS+0AtRHW+zuvzKKxgNtaN8PJ0ggExsVcW6qV5/6RzAKG3SX/Y0H8xL
         T9bQ==
X-Gm-Message-State: APjAAAWN/PRD58RtxCEq3J8Er8NBOiAnP7I4gAzpq5Y4nDX4QFGq0RiJ
        75OVuLf0q5P6NEaCpIHnzobItzCuPlhlisH4a6Z7z3hTxv7ZeELgq6ABGvkMkWwfQzq6ANKHXr0
        d7FVqTMSZjEJYYCB3kIhCxtx9
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr4916142wrs.20.1576138326656;
        Thu, 12 Dec 2019 00:12:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxhPY9tb9EraSB3/G5RixEIryJ8sYFEuzvoUZhFyLUeSxfGbn39kUpvyoDawp63DhfWRplrA==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr4916109wrs.20.1576138326388;
        Thu, 12 Dec 2019 00:12:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id g9sm5198355wro.67.2019.12.12.00.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 00:12:05 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org> <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
 <20191212023154-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74edef57-c1c7-53cb-4b93-291d9f816688@redhat.com>
Date:   Thu, 12 Dec 2019 09:12:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212023154-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 08:36, Michael S. Tsirkin wrote:
> On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
>>>> I'd say it won't be a big issue on locking 1/2M of host mem for a
>>>> vm...
>>>> Also note that if dirty ring is enabled, I plan to evaporate the
>>>> dirty_bitmap in the next post. The old kvm->dirty_bitmap takes
>>>> $GUEST_MEM/32K*2 mem.  E.g., for 64G guest it's 64G/32K*2=4M.  If with
>>>> dirty ring of 8 vcpus, that could be 64K*8=0.5M, which could be even
>>>> less memory used.
>>>
>>> Right - I think Avi described the bitmap in kernel memory as one of
>>> design mistakes. Why repeat that with the new design?
>>
>> Do you have a source for that?
> 
> Nope, it was a private talk.
> 
>> At least the dirty bitmap has to be
>> accessed from atomic context so it seems unlikely that it can be moved
>> to user memory.
> 
> Why is that? We could surely do it from VCPU context?

Spinlock is taken.

>> The dirty ring could use user memory indeed, but it would be much harder
>> to set up (multiple ioctls for each ring?  what to do if userspace
>> forgets one? etc.).
> 
> Why multiple ioctls? If you do like virtio packed ring you just need the
> base and the size.

You have multiple rings, so multiple invocations of one ioctl.

Paolo

