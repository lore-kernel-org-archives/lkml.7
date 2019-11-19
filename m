Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC1C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C91222AB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWBjYsQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfKSPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:34:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28875 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727505AbfKSPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574177650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=vsdYTJdmpDHbVtC2zk2nGSmOi1xZDU6iXkwC9cjzFi4=;
        b=gWBjYsQMMVab+x/IGkbmjdZK7CCfRt8Zo9gBdfxgMQXhPzALRE0wwlIGV62yvuFINdBCC1
        oendoslQBQF9UhmYXqAdTwyG1+uNPmYPzeg4IHri/EzZSH/al6a48F1rZO5xHTpRBcYLsX
        5nTlxVudZj08MwtqfsYB5nXRTOoyq+0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-mpCgHDiHMe6I16uu6w5Pig-1; Tue, 19 Nov 2019 10:34:09 -0500
Received: by mail-wm1-f70.google.com with SMTP id b10so2440731wmh.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 07:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsdYTJdmpDHbVtC2zk2nGSmOi1xZDU6iXkwC9cjzFi4=;
        b=YGTppJ/ShwVSRQJzgmVjMjBhSkGZtRbZTD4Bzv0TcCZXet83E9XXuzxy8DNgI3ZXiF
         6pOn85cPQNDhmeV7BvK8DipTYTKNUv1gQk2uc1FbTtQOiALs0oA3I/QsKKbrx/QIPgS0
         1TXZaOzrwqVOzyHpmcO4CiXKVD6hf9UVq6WGZyVRq1FqyEsyrMO+ifboTiQXfmA3chTH
         pDG9kRQFotmsSj1hKz1kOwcLCNMlzUHMWHzSGRMy01zMW94DklpL7VVBmiaden5qO/+n
         1n/ULXZtaWRJAH/9q39oA2mqWKfvyTF6X6I7COlFeak0AgfXv4FuNeYKZHZ7KGktulKf
         X10Q==
X-Gm-Message-State: APjAAAW8aHVBWxzudQYIjjXBQKWyngEm0YSGKdoazQ7O1bHcpcV3mIHE
        MD3sNP2OGVjPG27fFAFVVZKAuCt+OAL/H5zMJvCtT0MsDjyaO+5qHu027SUYEAxMglONCnbLrTC
        s/7MsTQYvOhXKV96QZ2xCGEsU
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr40433391wrw.385.1574177647547;
        Tue, 19 Nov 2019 07:34:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVjuaWaSzK+Xt0uthz4GESPeUTp9jQ83f6FN4gk/aBwTbkqxZ64EyharajI6xyCW8Fc3EQvA==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr40433346wrw.385.1574177647261;
        Tue, 19 Nov 2019 07:34:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:dc24:9a59:da87:5724? ([2001:b07:6468:f312:dc24:9a59:da87:5724])
        by smtp.gmail.com with ESMTPSA id w18sm27314242wrl.2.2019.11.19.07.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:34:06 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: add CR4_LA57 bit to nested CR4_FIXED1
To:     Liran Alon <liran.alon@oracle.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191119083359.15319-1-chenyi.qiang@intel.com>
 <348B5C47-7AA0-4DAC-91A7-8FB0D0205EF6@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3a5cc588-50b7-8ce1-bb66-19b45c50dee6@redhat.com>
Date:   Tue, 19 Nov 2019 16:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <348B5C47-7AA0-4DAC-91A7-8FB0D0205EF6@oracle.com>
Content-Language: en-US
X-MC-Unique: mpCgHDiHMe6I16uu6w5Pig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 12:09, Liran Alon wrote:
> Reviewed-by: Liran Alon <liran.alon@oracle.com>

Queued, thanks.

Paolo

