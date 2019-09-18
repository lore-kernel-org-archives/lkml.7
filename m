Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68259C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B81C218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNIxg56/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfIROLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:11:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729301AbfIROLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568815898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=eYfolJm2ctgBFFzn1+Uof+Aznt2DY6/Wj6EoPA4iY/8=;
        b=VNIxg56/J01TI5FBfLcMlLZEgmJ76faD0zu7xfSlGAXTJ0xwCfi/9cxfqwm0jxlvWvzTtx
        NLMVNuMjFpqSXaA94y4abF9tB9hIcSa5+xbgdHeSZX+bvrbjvxsO4iMdmyVqpwFRciGhEa
        cndN8vWSm/jFZ3DUz6JwqsBlFXEdzU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-AGTjRJn5PGOHWlh4FqOzkA-1; Wed, 18 Sep 2019 10:11:37 -0400
Received: by mail-wm1-f69.google.com with SMTP id d10so84309wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 07:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gU04MhQdP4BkI/L+RLwBCZzg4I06FO6JtiKrPkqToDk=;
        b=B6F8mDFFKNgIg8po+7d29gC0S91wSD+Vl3hkoiJI5MF0b3FmrdTlYASsG40Z4P65fo
         Gsrr5CdpHnUTaT8VdFTcHv6Dq2R6mKBuzfFLe2IyG3NTYR2OHbpIAn926BBZDBnqPvX5
         wRXACRe8kWRO7zA5lsoMl6+HFT+6pWw7yz1yenuH51WlpWkP9yBwuzq6gMXC2R1shMk3
         xU2Doov23sWLitYCFcS7Y3P/q7Z4OKFvTlC7LTcqyJ+/okL2ZTFK219Cj0744HBjiqIq
         u2NuCmUsKP1wc3YEeXILjzf4NzYWE/y7UOXBGeIuXROVbIquhV0VI+3U7M/GUhVfn0ld
         I/ag==
X-Gm-Message-State: APjAAAW5FyY7dwRUFM+EnKxZMoYG4ARR4BdYg3c3SnUOlGdrGUfPcfFz
        UCP+Om/tMzSScvbPUDe8mLjFjpxg4aLBW5hlszz/LNU718GS4cyL7OiYMcAdRbECr7w4++Oh40O
        1HrK99SUOkDbffcBXAKVTfumw
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr2919684wmj.110.1568815895841;
        Wed, 18 Sep 2019 07:11:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQ7SmyPYoi9WAyE6yYB72cOtIdytEHLz51MBDl9qoydpi05HPbf1c9N+yvJBiOtjRJNGI5XQ==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr2919664wmj.110.1568815895603;
        Wed, 18 Sep 2019 07:11:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id q25sm2592045wmq.27.2019.09.18.07.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:11:35 -0700 (PDT)
Subject: Re: [PATCH] kvm: Ensure writes to the coalesced MMIO ring are within
 bounds
To:     Will Deacon <will@kernel.org>
Cc:     kvm@vger.kernel.org, kernellwp@gmail.com,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "# 5 . 2 . y" <stable@kernel.org>
References: <20190918131545.6405-1-will@kernel.org>
 <9d993b71-4f2d-4d6e-39c9-f2ef849f5e5f@redhat.com>
 <20190918135932.aitmvncwujmjnwyr@willie-the-truck>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <281758dd-e400-f99c-b2e2-d32bca9f371e@redhat.com>
Date:   Wed, 18 Sep 2019 16:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918135932.aitmvncwujmjnwyr@willie-the-truck>
Content-Language: en-US
X-MC-Unique: AGTjRJn5PGOHWlh4FqOzkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/19 15:59, Will Deacon wrote:
> Okey doke, as long as it gets fixed! My minor concerns with the error-che=
cking
> variant are:
>=20
>   * Whether or not you need a READ_ONCE to prevent the compiler potential=
ly
>     reloading 'ring->last' after validation

Yes, it certainly needs READ_ONCE.  I had already added it locally, indeed.

>   * Whether or not this could be part of a spectre-v1 gadget

I think not, the spectrev1 gadget require a load that is indexed from
the contents of ring->coalesced_mmio[insert], but there's none.

Paolo

> so, given that I don't think the malicious host deserves an error code if=
 it
> starts writing the 'last' index, I went with the "obviously safe" version=
.
> But up to you.
>=20
> Will
>=20

