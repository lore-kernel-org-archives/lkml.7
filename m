Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED2DC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC8C20643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 18:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTTNo6f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLXSTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 13:19:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41395 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726322AbfLXSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 13:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577211575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=10oE3mcJxbSPeGAikLZZiyP7ObdJq49Q5FPmOfsO/dc=;
        b=PTTNo6f0N0oM84oibL1JmCjoMZ6oL4qF3OEtIlgPRrYCS9thofqO/iEuBUmBAfZkWor+Ts
        o6TnjTHppELGnwPItpT3RRxAkE75PUPZo3iO7PdGxWMRzlaPnnCcI0cLi8N+HuE9ML2jer
        08U8Q+TGpdcW2X/57A6qT556g/jISk8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-zQf77X2fPx6ox150dGbxvA-1; Tue, 24 Dec 2019 13:19:34 -0500
X-MC-Unique: zQf77X2fPx6ox150dGbxvA-1
Received: by mail-qv1-f72.google.com with SMTP id x22so12043053qvc.18
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 10:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10oE3mcJxbSPeGAikLZZiyP7ObdJq49Q5FPmOfsO/dc=;
        b=FBj4ixT9lWrKksvaydxIT4J3l5gwZO3hwTPOHFWBY+DkBxWVlkMVIajcSRFRkIStcn
         Dz4SXa66ic3AE7aAKERnhP8xsY2kf5CazYVynipXgWy7579MHAwyM+32R2uNtcWn/ROn
         MlAmYqguvVX7mBCyP/L21769YowlTa48vUWdbL+mZA1zTz9evS4py+5XdWecjxmkfQ5d
         +UOYppvuSkU2hMIqR+jjXMbaQWithpKWXWj4mA63Zd2NsJModD2TZwH0JkRFRgsSSL28
         QQGty72PT/nhh97AWSRmrwoGA4sSyoXZEfGQloWMBr+lwAVm5vUya2DE9P84XirDJn/q
         agEQ==
X-Gm-Message-State: APjAAAWccxhokUuXTtMG9NFBVy4yHYJG1MLIkLyUkFmt5LXqw3voASZT
        yJjqNtdBUn/vrO00DnC8WygLSQU+5+DEPGkm37Ef4zuaubHBrrBq8b5bcDDFTYy1lU92rHLyv9i
        KpH4GiQT3QGjDnPhqf+Kxko17
X-Received: by 2002:a37:de16:: with SMTP id h22mr32000509qkj.400.1577211573645;
        Tue, 24 Dec 2019 10:19:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPlDOvamAwfkQQCQ/yrbEZ/IdA8BxSZxEa3M38XxUFXj9DeSRjaR1EpPHTj42i4TNzDYXwVw==
X-Received: by 2002:a37:de16:: with SMTP id h22mr32000473qkj.400.1577211573294;
        Tue, 24 Dec 2019 10:19:33 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id 63sm7087025qki.57.2019.12.24.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 10:19:32 -0800 (PST)
Date:   Tue, 24 Dec 2019 13:19:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v4 16/19] KVM: Ensure validity of memslot with respect to
 kvm_get_dirty_log()
Message-ID: <20191224181930.GC17176@xz-x1>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
 <20191217204041.10815-17-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217204041.10815-17-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:40:38PM -0800, Sean Christopherson wrote:
> +int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
> +		      int *is_dirty, struct kvm_memory_slot **memslot)
>  {
>  	struct kvm_memslots *slots;
> -	struct kvm_memory_slot *memslot;
>  	int i, as_id, id;
>  	unsigned long n;
>  	unsigned long any = 0;
>  
> +	*memslot = NULL;
> +	*is_dirty = 0;
> +
>  	as_id = log->slot >> 16;
>  	id = (u16)log->slot;
>  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
>  		return -EINVAL;
>  
>  	slots = __kvm_memslots(kvm, as_id);
> -	memslot = id_to_memslot(slots, id);
> -	if (!memslot->dirty_bitmap)
> +	*memslot = id_to_memslot(slots, id);
> +	if (!(*memslot)->dirty_bitmap)
>  		return -ENOENT;
>  
> -	n = kvm_dirty_bitmap_bytes(memslot);
> +	kvm_arch_sync_dirty_log(kvm, *memslot);

Should this line belong to previous patch?

> +
> +	n = kvm_dirty_bitmap_bytes(*memslot);
>  
>  	for (i = 0; !any && i < n/sizeof(long); ++i)
> -		any = memslot->dirty_bitmap[i];
> +		any = (*memslot)->dirty_bitmap[i];
>  
> -	if (copy_to_user(log->dirty_bitmap, memslot->dirty_bitmap, n))
> +	if (copy_to_user(log->dirty_bitmap, (*memslot)->dirty_bitmap, n))
>  		return -EFAULT;
>  
>  	if (any)
> -- 
> 2.24.1

-- 
Peter Xu

