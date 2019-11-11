Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8B021872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORDXZUoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKKV7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:59:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbfKKV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573509560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=5JMGc6ZNt3Kt87cTt6dbWaP1bAXTKUa7TPW46Nj75J0=;
        b=ORDXZUooyGBo2nhzVIVJDq/ouENVi0NFHFMkdMHNnouUffy90R8thDymqwOAla8zY9g0Ig
        w3C7/+dCTkBvcudEu8gKH9l4SYRGm/hmJpC6+kpajHKl8BaxRw6rK4AwJL6x4B5kdsjLJT
        VFaRs/O9harQFLk4qMyoBD+F7EZEPHk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-kaTE4whwPeebLX5Z03K9mw-1; Mon, 11 Nov 2019 16:59:16 -0500
Received: by mail-wr1-f71.google.com with SMTP id q12so2932464wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2KX+tENMt/6R+J+74Qa4Dthv4cuV76s4hBzTDosBdo=;
        b=h5WWc5x9eY/2SLKbvcDPXEchiiOs/YC6s4M5zJHETZdEgvq7gACSrG++gbqNVDMN4d
         CWN+8QdNY9J0LYNTchAjoAV1DlcwUaHNQX892GiKXqITZjQ1zVUqtaGqjC+Iqx7Axpt6
         hZZ0jOcnFtfmivFmwz2w22Koa1nqC4AFy104EosKlURHbO+vbJ5r+FGvsF6p9h93jpSb
         5dkx/KXYHLSPX79sROx/8HtfECbrOsmxSjFVq1K2EAw/oYDVv9QvB1Ojk3cbKj2QqxFC
         NYs/dDkxIjUh3GjAeOT8QrwVKMBHdoeTuy+urq/iM91XFYWwH45OXsSflUzkoM0dwi7u
         5lYA==
X-Gm-Message-State: APjAAAUGdnHz4CZ+vrKElUdLxy7ZDtudS+y2wQnBlocCGt2pBLetLMyi
        BkDvDA7iQD7Q+zmh/bQhIJIlhCCveQORrObJpV2oliddrpbPnJbPTJQVvVTkJubnb66Bpj6LyRr
        vCjZMYLn4K6GH/cZ1UdRgQAV6
X-Received: by 2002:adf:de86:: with SMTP id w6mr22575217wrl.220.1573509555614;
        Mon, 11 Nov 2019 13:59:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFH81eJPsJFWm6/v9HDiXiBPV2gYCw4cA0ZvscuxcTs7YdwXTZJmbkmW8OAhesOnXybRQw5g==
X-Received: by 2002:adf:de86:: with SMTP id w6mr22575197wrl.220.1573509555313;
        Mon, 11 Nov 2019 13:59:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id n23sm960755wmc.18.2019.11.11.13.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:59:14 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: X86: Single target IPI fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1573283135-5502-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4418c734-68e1-edaf-c939-f24d041acf2e@redhat.com>
Date:   Mon, 11 Nov 2019 22:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1573283135-5502-1-git-send-email-wanpengli@tencent.com>
Content-Language: en-US
X-MC-Unique: kaTE4whwPeebLX5Z03K9mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/19 08:05, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
>=20
> This patch tries to optimize x2apic physical destination mode, fixed deli=
very
> mode single target IPI by delivering IPI to receiver immediately after se=
nder
> writes ICR vmexit to avoid various checks when possible.
>=20
> Testing on Xeon Skylake server:
>=20
> The virtual IPI latency from sender send to receiver receive reduces more=
 than
> 330+ cpu cycles.
>=20
> Running hackbench(reschedule ipi) in the guest, the avg handle time of MS=
R_WRITE
> caused vmexit reduces more than 1000+ cpu cycles:
>=20
> Before patch:
>=20
>   VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time   Avg ti=
me
> MSR_WRITE    5417390    90.01%    16.31%      0.69us    159.60us    1.08u=
s
>=20
> After patch:
>=20
>   VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time   Avg ti=
me
> MSR_WRITE    6726109    90.73%    62.18%      0.48us    191.27us    0.58u=
s

Do you have retpolines enabled?  The bulk of the speedup might come just
from the indirect jump.

Paolo

