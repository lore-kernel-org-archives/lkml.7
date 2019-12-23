Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D7DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1DC20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt7RRLzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLWR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:59:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20809 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726783AbfLWR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577123939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STtzNyT0+MBoIozU3+6g5UpNJ/WCnDF9rLCyPLhJAF4=;
        b=gt7RRLzoM7G1hGzhXQU1MGEgLsj6fy/ZceNhzt/PhmcfPAQwFqyhOX3bJH1z+K3VQeqhtk
        x+iqjOfWk0qwXnCFOwfvO/iWbgyn4Gfpqo4E4S7+IXpnaNd6MhPNkYdRIs70mGWL5ZXLxo
        BzY0wEGVw5jsOdoT2BOV5OLEqxaVzUw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-bE00KfB7Mfi_bMMFl9I_Gw-1; Mon, 23 Dec 2019 12:58:57 -0500
X-MC-Unique: bE00KfB7Mfi_bMMFl9I_Gw-1
Received: by mail-wr1-f71.google.com with SMTP id d8so1882131wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=STtzNyT0+MBoIozU3+6g5UpNJ/WCnDF9rLCyPLhJAF4=;
        b=DLYjOSXKQzWCnRG5K7XcGS0Ir+o49JaWZPXL4dGQTsFQQc9HCRnybkO1uShTUFBkOH
         Spdob8sXjVkCKCFEw/d3noL6No8zuf3fgrcNRFDbidlevUTyZvFnlCaNx+ARq8lgDetB
         vGDBsirUkTJcLV3h83o8pDYOFfMttIlGYCKe30UDxWCSFYdE6WQNwHxO3G44dPMQPzIg
         7DCmX3INH7jtfMT3yfqnZbjGkDixBdiGVdPd+Yh1SP5qK4bAzbwBoBwDD7R2Mlfcyv0/
         /aUJladKhyILSm0B8329D1vGNEzm2lY53cseWfZCDnssAtNzneFTDYScs6h7cPFR2jxJ
         Np/A==
X-Gm-Message-State: APjAAAW4Bmi8DuLjm4Ltvzon0UZZJzVPS0rKkjV5RrLzaIQ0GmsH5YzC
        W5XaAaB4aNGSL3GNykARYo8R53iYfb5yOgvZ3jRnDZViRFv+l2+Iiji4omIfyH7qNwFtRGAcqmY
        y2CEWDMabaXMEmjvNe1ue2agR
X-Received: by 2002:a7b:c342:: with SMTP id l2mr152096wmj.159.1577123936649;
        Mon, 23 Dec 2019 09:58:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqykiqSXU2vl/R+wx6gf5ATr2f0hU8N+owgQTSrl/A5u9oYsJ4rRsDFfA7QvqN0uWBs9340ziw==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr152075wmj.159.1577123936420;
        Mon, 23 Dec 2019 09:58:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c? ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
        by smtp.gmail.com with ESMTPSA id n1sm20832083wrw.52.2019.12.23.09.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 09:58:55 -0800 (PST)
Subject: Re: [PATCH RESEND v2 03/17] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-4-peterx@redhat.com>
 <cf232ce8-bc07-0192-580f-d08736980273@redhat.com>
 <20191223172737.GA81196@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <851bd9ed-3ff3-6aef-725c-b586d819211c@redhat.com>
Date:   Mon, 23 Dec 2019 18:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191223172737.GA81196@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/19 18:27, Peter Xu wrote:
> Yes.  Though it is a bit tricky in that then we'll also need to make
> sure to take slots_lock or srcu to protect that hva (say, we must drop
> that hva reference before we release the locks, otherwise the hva
> could gone under us, iiuc).

Yes, kvm->slots_lock is taken by x86_set_memory_region.  We need to move
that to the callers, of which several are already taking the lock (all
except vmx_set_tss_addr and kvm_arch_destroy_vm).

Paolo

> So if we want to do that we'd better
> comment on that hva value very explicitly, just in case some future
> callers of __x86_set_memory_region could cache it somewhere.

