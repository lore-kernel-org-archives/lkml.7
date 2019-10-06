Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A1ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF93B2173B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqXTcFTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfJFQPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:15:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbfJFQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570378545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=lg/L4laSYBgn56jpgnIalr4DbesZh37mDelXP/b99M8=;
        b=iqXTcFThQicukDKWy+ldp43yfm20rWew/ZgTt9UqNkkpsBPiYU3Bn3Am16iqC3OP5m+Ano
        VLAtb4w9i1uaAq6Qkc4nNwrPo0aunHHuz+jBP6h/WC2b/yID/WhJXcYBHEh5sFM3fQGvK+
        hdCmAv57Az1jL1f+IANKoPDaZxNcmNo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Y9SOhPgTPF-XXqqJ66h8_g-1; Sun, 06 Oct 2019 12:15:41 -0400
Received: by mail-wr1-f71.google.com with SMTP id n3so5794463wrt.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 09:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSabhuo9kaFmFYjPX/sZannVbv6ltNxrU4vHa5iavb4=;
        b=STlLHfvg4q27JjN20tNj3nzUbsieP1iHpLUUqJ6f6o1Gth995RwJ4du73zhMzMI7D3
         WYy2t1OyRvSEhjbGCYtgRwl39ENm3UV1JbeV25l/rufqPpN5uClQ0fnqCCZ5oGNuJMTF
         npNnBZ3ZYT04m1OK3yLJcB7UzQrynftas26aNPnzryryk+Ur0KyHYWL6QgEvh40L8ZjM
         hXHWisljHmw5W0UTnDxWGTd4LGaxvVlkjgNjLhff8K70qrnuUMPthwK5DYD+xF9nJf+g
         BQVcdQkRcN1s4uzJh3dPuuUfISDsS013n34aEAmn56TsHETLz6268dRQ+cd8fc7HZW3K
         h2jg==
X-Gm-Message-State: APjAAAVl97J/EUvHKZGcP8nEg0o2FGxMie/UajCbebzQDcEQJKRDBwBg
        +nuC5Y09EN9x9Bw9UFLkebTSGP//6oOltzLPZsCvtkBrZKGpNSlkQETQ5bpZaUTsuCaNuCmB8a4
        aZ60k71F/RFAsHQ2HvZb42nmy
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr12968309wrq.322.1570378540331;
        Sun, 06 Oct 2019 09:15:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvzrU+IMTZGu3nozR8V5nr53z8D0g5+my60K97mvMSKYkYzbKZF246Mhkyzo6mVd/AG2JaoA==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr12968297wrq.322.1570378540063;
        Sun, 06 Oct 2019 09:15:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e876:e214:dc8e:2846? ([2001:b07:6468:f312:e876:e214:dc8e:2846])
        by smtp.gmail.com with ESMTPSA id a10sm13273923wrm.52.2019.10.06.09.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 09:15:36 -0700 (PDT)
Subject: Re: [RFC PATCH 03/13] kvm: Add XO memslot type
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
 <20191003212400.31130-4-rick.p.edgecombe@intel.com>
 <5201724e-bded-1af1-7f46-0f3e1763c797@redhat.com>
 <9b885e65c3ec0ab8b4de0d38f2f20686a7afe0d0.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dc9ea270-489a-cd7c-fd68-26f22b5e49c6@redhat.com>
Date:   Sun, 6 Oct 2019 18:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9b885e65c3ec0ab8b4de0d38f2f20686a7afe0d0.camel@intel.com>
Content-Language: en-US
X-MC-Unique: Y9SOhPgTPF-XXqqJ66h8_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/19 21:06, Edgecombe, Rick P wrote:
> The reasoning was that it seems like KVM leaves it to userspace to contro=
l the
> physical address space layout since userspace decides the supported physi=
cal
> address bits and lays out memory in the physical address space. So duplic=
ation
> with XO memslots was an attempt was to keep the logic around that togethe=
r.
>=20
> I'll take another look at doing it this way though. I think userspace may=
 still
> need to adjust the MAXPHYADDR and be aware it can't layout memory in the =
XO
> range.

Right, you would have to use KVM_ENABLE_CAP passing the desired X bit
(which must be < MAXPHYADDR) as the argument.  Userspace needs to know
that it must then make MAXPHYADDR in the guest CPUID equal to the
argument.  When the MSR is written to 1, bit "MAXPHYADDR-1" in the page
table entries becomes an XO bit.

Paolo

