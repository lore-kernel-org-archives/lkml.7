Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D9221925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBdviS96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLVdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:33:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39042 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbfKLVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573594394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=apvF/+PBT99p/+GngvqMt0gongEPRLUHJbqLkax5zKk=;
        b=JBdviS96ce5BmY3OnWVVTOJi3/0OmgKj14tLFXXXVMBXcPkIRN/g5uZMGnpPoBrV8u6a1x
        cBSEY2Ugu/DUeaqglG/1W1+J/5e7+pYM33sAxkpb0E71WiL88w4NJLyMb6ZdVdNStlkx2j
        5iWHKxaXvEztAH10JHZecXB5l2N+eEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-R4Yoak1tNP6UDcBQnVVCOw-1; Tue, 12 Nov 2019 16:33:13 -0500
Received: by mail-wr1-f70.google.com with SMTP id b4so52109wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apvF/+PBT99p/+GngvqMt0gongEPRLUHJbqLkax5zKk=;
        b=HuJOd3LZstQAiYyuBkjdw64enYdjIm8/YW8IB3Bn4Dtc/tt7I34Hgm4uTgQ4hwQvs7
         9u515EmI/w5O/Y8V4J4rOTCsoWwY7/gwTiVQlDlpcC1Xw90rFpDXwpJ6udtS+LlwajYN
         MPNC/yI/zaNmRx9Od/8tfDW2xLo61Q2nd9K7ypERAoHlfZftvJkg4FVUYCpwqCi7hXE/
         if3GIQE8LCx44+QpwxTtU9JKeA48Z7Qj5EsCDnzm0jVNGF2kt38UKkRh0eESxGpANcD8
         GuqcZbzIMU4ZxgwLPMdDneTbkiLhXJRIo3onP6+LvO2C8ybr6NT5UWZ64oE/7yu1bztO
         rvIQ==
X-Gm-Message-State: APjAAAV2CejEI5crOPJyfQ8PiPPUR+zkwWypIQbXtxl9w41rs+x6VFWd
        0zwDmM0PUu/OYKSqMeicH0L7A1kKjuRWxLwmkmjCiZr6Cl9BNC0k/FlhQUibkpjBzn5ouZ9z/lk
        aJS/1Q2U1kLwKow7b4xz1Xtwj
X-Received: by 2002:a1c:9601:: with SMTP id y1mr5674884wmd.157.1573594391837;
        Tue, 12 Nov 2019 13:33:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1I8PJlwVaiQe0THPl1xlemvb30kE4eh6T1y8r6NmBDFnNIb5EVpHyc6RGbobIWt7/n+/AKg==
X-Received: by 2002:a1c:9601:: with SMTP id y1mr5674868wmd.157.1573594391554;
        Tue, 12 Nov 2019 13:33:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id o187sm4558524wmo.20.2019.11.12.13.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 13:33:11 -0800 (PST)
Subject: Re: [GIT PULL] KVM patches for Linux 5.4-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
References: <1573593036-23271-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wibywR7ySaBD=H9Q0cc1d86+Z1Sg3OWUsDjUvj21dZAKQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b21e7ce6-6151-87dd-9d20-e39b788d523e@redhat.com>
Date:   Tue, 12 Nov 2019 22:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wibywR7ySaBD=H9Q0cc1d86+Z1Sg3OWUsDjUvj21dZAKQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: R4Yoak1tNP6UDcBQnVVCOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 22:26, Linus Torvalds wrote:
>> It's not a particularly hard conflict, but I'm including anyway a
>> resolution at the end of this email.
> Hmm. My resolution has a slightly different conflict diff, that shows
> another earlier part (that git ended up sorting out itself - maybe you
> edited it out for that reason).

Yes, I edited it out to point out the one that matters.  Sorry for the
confusion.

Paolo

> I think I did the right conflict resolution, but the difference in
> diffs makes me just slightly nervous. Mind checking it?

