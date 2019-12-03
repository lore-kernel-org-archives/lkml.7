Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9752073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUR3x9sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfLCNmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:42:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49938 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbfLCNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575380523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xzap45JLjeZ78JLpvPgT+gvGDZN08qheFC1tLsQcmU=;
        b=bUR3x9sHOAuCTpzKnehYmpFIjkOzrWvNYtYgXl9JwV7M8LH9wxHziE+DPNF9cAstQK+GMA
        sIhqqISsjGTTtJC7cgmub60qDwEl5uZA3tTRfRUWJZ4oA5GdqKxLOsMeqqt/Fm5Vz8wAGo
        63tAnSD7azOV1l/Ao2Um3rz5eYJhVEY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-XopdOHTSOHWTpP_rcoe71A-1; Tue, 03 Dec 2019 08:42:02 -0500
Received: by mail-wr1-f72.google.com with SMTP id i9so1812123wru.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xzap45JLjeZ78JLpvPgT+gvGDZN08qheFC1tLsQcmU=;
        b=O9zb/hXqBZWexQdUo8AV+vgCTySgK0QiHZNW5j9IFyjY4x7he1jJDKCkmby95rmvjA
         Q3hUTtFbsdMw0iph5YkNDQgRo3ZFrZlQj6gOA8601Kj+h/xXYC6a9Kthz8OvjBe3khAe
         IsN0HU5q1cHBR7F1y34KYMTqPL1jdUG8BfdT0UnI2/qlyt0i0zvpRL4KUybnvVClQRxL
         1XVEh5fuWagdQd3vyOwIxTRWWl85SQbHwgDkarSnfFVkWhzQJvEjoP9qv0uaxVdYE/sc
         zyS0h2ypSaSBzykETr0bMT7MFRJtXS6dgqV1cwTvIsdbCd2DB3zLNYez5SJBXWdpbDwF
         RU8Q==
X-Gm-Message-State: APjAAAUttf1jTZbdbaykz9HgHDvlj5AfT7xS4IDKiAXdDygIGwhf5PEQ
        2oMuA3Lkso4+n+Evr+/CHh7ULTkWcJ/yDJZttESA2mhKxF/jWRttn9ANVN/R1RK/hdxR9sufADA
        JyYV+/k6NSUw64/KvBLR/y96v
X-Received: by 2002:a5d:480f:: with SMTP id l15mr5233582wrq.305.1575380520889;
        Tue, 03 Dec 2019 05:42:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZGQ0X905/nMt28Wo/glM8NDen/TnIsTfqR7y4USxYbfGbNsMCOfB7UzNevd2TfRXI6WacQg==
X-Received: by 2002:a5d:480f:: with SMTP id l15mr5233557wrq.305.1575380520706;
        Tue, 03 Dec 2019 05:42:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id w12sm3057323wmi.17.2019.12.03.05.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 05:41:59 -0800 (PST)
Subject: Re: [PATCH RFC 03/15] KVM: Add build-time error check on kvm_run size
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-4-peterx@redhat.com>
 <20191202193027.GH4063@linux.intel.com> <20191202205315.GD31681@xz-x1>
 <20191202221949.GD8120@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee107756-12d2-2de0-bb05-a23616346b6d@redhat.com>
Date:   Tue, 3 Dec 2019 14:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202221949.GD8120@linux.intel.com>
Content-Language: en-US
X-MC-Unique: XopdOHTSOHWTpP_rcoe71A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/19 23:19, Sean Christopherson wrote:
>>> e.g. in a mostly hypothetical case where the allocation of vcpu->run
>>> were changed to something else.
>> And that's why I added BUILD_BUG_ON right beneath that allocation. :)

It's not exactly beneath it (it's out of the patch context at least).  I
think a comment is not strictly necessary, but a better commit message
is and, since you are at it, I would put the BUILD_BUG_ON *before* the
allocation.  That makes it more obvious that you are checking the
invariant before allocating.

Paolo

