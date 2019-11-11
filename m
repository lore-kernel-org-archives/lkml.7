Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE75C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1608214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDRFeT00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKKWnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:43:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726912AbfKKWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573512202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=+3E68Um6Tt8y9CXkua7izwyEPRiZxPLXIv8+dZ2zBd8=;
        b=LDRFeT0057J4I2jXvpcWbWMx0UY6Xvyev/bamh7cmJAm5LpOO5ZOz1tbqK7veK1p++4Qdx
        d2SdhhQTpMrGdTLjFuAn2kSFzx5hxrOkv+L/Ve8feWfTBnr/cG+CkPxP5XxztZ2UOqv31z
        vHEhs6AcgiN5vuWt+JGyuOthFmQ6Li4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-3KpnrJG2MLOtcbMxFTvYJg-1; Mon, 11 Nov 2019 17:43:21 -0500
Received: by mail-wr1-f70.google.com with SMTP id m17so10768413wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 14:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0imOcBZtHzOC2GY9nm8Jh6eW98nYnDyTJ620lFBF2zY=;
        b=F2PRG2iX8JVTDTGlfmQydqM+plyZ41YVp0yKFTwEklsTpun2JIYhDx8hxUyDNsl2QC
         NDvhLPQ/IBPa9LfzO+GIORBwHBqwpX+3IlyMXJzAFjvWUQlCsyd3r1nzl6ytv7OYL0N5
         VPBhGSIGoJva4egG250PJHgL+tDK8zhWwDhUUX+NZXyHvoRRTblom63N7Usc3YKe0R93
         VluXGNw9x/rxBuy6WC6DYLG21sYXUzqqHCi2OQA5FapWl6QvshytVzcpthcRGUTvYCbz
         FyE/wZNEVkMLJ702xhtSiwKDZ+6ue5fYhOXDGtE1cgyrQM0ow6TV6fE5cP/xjIsNuFaT
         QTTA==
X-Gm-Message-State: APjAAAV7ccG2qZloDLfL5C96piMuvvbOKGKeTsJpqIHewl0KMrQ4jwOH
        /KJOEovV7nt1kzSykEdPrfccePamTsfaEr1Nb740k33y/A+NxDJLgv+3WlozFbihe8/i3drblbW
        OsXFqgjfchXrC/HVTmdBLphIB
X-Received: by 2002:a5d:4982:: with SMTP id r2mr23000775wrq.254.1573512200153;
        Mon, 11 Nov 2019 14:43:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxQSI41mJobzK6Insrsq0qbtd7QRgNmgRi09jVXFAoyeD8/PfQM1mPq+1MQCPHtR592LQpMw==
X-Received: by 2002:a5d:4982:: with SMTP id r2mr23000749wrq.254.1573512199844;
        Mon, 11 Nov 2019 14:43:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id j7sm7755986wro.54.2019.11.11.14.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 14:43:19 -0800 (PST)
Subject: Re: [PATCH v2 1/3] KVM: MMU: Do not treat ZONE_DEVICE pages as being
 reserved
To:     Dan Williams <dan.j.williams@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
References: <20191111221229.24732-1-sean.j.christopherson@intel.com>
 <20191111221229.24732-2-sean.j.christopherson@intel.com>
 <CAPcyv4hyPWv0OpZVBJ-Vq8pGny1B59EkvykZ0RKZAgHB0tq2og@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4d5a1f52-ca25-bbf9-fb3c-d7cec90caafc@redhat.com>
Date:   Mon, 11 Nov 2019 23:43:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hyPWv0OpZVBJ-Vq8pGny1B59EkvykZ0RKZAgHB0tq2og@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 3KpnrJG2MLOtcbMxFTvYJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 23:39, Dan Williams wrote:
>> [*] http://lkml.kernel.org/r/20190919115547.GA17963@angband.pl
>>
>> Reported-by: Adam Borowski <kilobyte@angband.pl>
>> Debugged-by: David Hildenbrand <david@redhat.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>=20
>> Cc: stable@vger.kernel.org
> Perhaps add:
>=20
> Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
>=20
> ...since that was the first kernel that broke KVM's assumption about
> which pfn types needed to have the reference count managed.
>=20

Done, thanks!

Paolo

