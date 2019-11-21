Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A21BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417442071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJnAqhYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:05:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfKUJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574327110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=0QtQuu09o5QNKgYtWCF+4b0Y6CbLhNjyGhj4YvgNl5k=;
        b=OJnAqhYRZAgV/ppGS+1ACxj/6dInmTD857a8iklxnodgUxxbjNXSmAqghxqCSjKlbHscaX
        RXFPrl0+tJX7t7cANcaUSB8/XQogl4ld+MEoA4+bVoYzegrUUmgnqkbHfojQtmTcAqMAoV
        wX9T75Px2AG0xK6gYz/DWiMmdKon5xo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-rs6XNs8QOViJ4pcymJRC8w-1; Thu, 21 Nov 2019 04:05:07 -0500
Received: by mail-wm1-f71.google.com with SMTP id 199so1514495wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XBm+z3cdzTP7CNbhssHneXhkoTVhQCWR4VgNKD6J1z0=;
        b=ryhPP87ukZDrZiKx37x+8oXCnbi3Rp7EUyWVJtIS8vovSBCsVTWo6HV9Toen6v3T9m
         ksL52yLMWRNQSQlHNayC2ykC82k4PXMTUMvVU9RpyUjC5Ik8z2/2isK797jM0wCGQZYj
         ZSB8I9c4uIkIBvCJbUYRv9URtiKMsrFN7oEXhI7SpROB3zkazMxs0vYNFkMKQU7X/TQs
         vtM4iMUa+FM5y3lFjpnNvF1huszJPc7wNy/jYyUj/StDAzSdDl0BjEV5NHKPDIOMp4Bz
         +tC/fn9G94RjUEu2ze+mYAdtBNLaM6JyYfMJXTVEHG6VT5jJaMaw2buMc/QzW9uu1GeJ
         TE9A==
X-Gm-Message-State: APjAAAXn6cERepOtzkzku/Xmk+9gxkeyqXrAjKNDuYsUtq3A50HENwd+
        IcbkPIttl7OezRxO6wY1UBu4vXlEL7Q1r6Eaz6T2K3nmkywmsxlmXlUzbk0JBJb/HwfDGfTfzRn
        s4zefAuoJ5QV5fLK7bu5z3dkN
X-Received: by 2002:a5d:670a:: with SMTP id o10mr9449029wru.312.1574327106023;
        Thu, 21 Nov 2019 01:05:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJ6SdvqrxGlL+G5qHGtGh5pIp54sLOBUVVTvRXry36/euw4epCRoQtato4BdyE8ww3umRS3g==
X-Received: by 2002:a5d:670a:: with SMTP id o10mr9448981wru.312.1574327105645;
        Thu, 21 Nov 2019 01:05:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id h15sm2660920wrb.44.2019.11.21.01.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 01:05:05 -0800 (PST)
Subject: Re: [PATCH 5/5] KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable TSX
 on guest that lack it
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com>
 <1574101067-5638-6-git-send-email-pbonzini@redhat.com>
 <20191121022252.GX3812@habkost.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a820b71-79eb-7d71-9cd2-93954cefcdd2@redhat.com>
Date:   Thu, 21 Nov 2019 10:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191121022252.GX3812@habkost.net>
Content-Language: en-US
X-MC-Unique: rs6XNs8QOViJ4pcymJRC8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/19 03:22, Eduardo Habkost wrote:
> On Mon, Nov 18, 2019 at 07:17:47PM +0100, Paolo Bonzini wrote:
>> If X86_FEATURE_RTM is disabled, the guest should not be able to access
>> MSR_IA32_TSX_CTRL.  We can therefore use it in KVM to force all
>> transactions from the guest to abort.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> So, without this patch guest OSes will incorrectly report "Not
> affected" at /sys/devices/system/cpu/vulnerabilities/tsx_async_abort
> if RTM is disabled in the VM configuration.
>=20
> Is there anything host userspace can do to detect this situation
> and issue a warning on that case?
>=20
> Is there anything the guest kernel can do to detect this and not
> report a false negative at /sys/.../tsx_async_abort?

Unfortunately not.  The hypervisor needs to know about TAA in order to
mitigate it on behalf of the guest.  At least this doesn't require an
updated userspace and VM configuration!

Paolo

