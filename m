Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D4320715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pa2Xxbmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfKTRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:43:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22180 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbfKTRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574271792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=ei2j9pcZbx3d1j0CtKByFB03xBBGoihrjw0BBTcm0X4=;
        b=Pa2XxbmgfOlEloIjhGagAjaijVVhaxDPr07EU4iNZnoyYCL4M2vDtbtfqNzCwYgJLyEeOM
        Blkb+tsBIPrQ8pTyKL6cyjWdQV6RWm8wKAflAygLj53UmTn4/9ETNU40mLWJFjNm3T6FUl
        9yNFl/jC02CnMQtK79RN6qRcyejx4Ao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-LpkkxECtP6qcmbngeSJWqQ-1; Wed, 20 Nov 2019 12:43:09 -0500
Received: by mail-wm1-f70.google.com with SMTP id y133so22339wmd.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nLIxPj7yq9atMLNEK/9ztrIlmkBLqwoJhmt0Png8OD4=;
        b=Po/iZCTCQDPQJVCWg7IDNSv9nkXj+sF+sOJggyQx7CvKotnvgR56YSirzMaWupMong
         ZGMI21wYjWAl5U4q2KN9T4u2W9rR6IXOYZNvPRrFBqHnMlKvDJD2M3z0s6Ofx85EEDsU
         V8FU0q8+zDHGj4em6WgYdxwycXAk462TWt1wh2sArS7qm8+EDx2WqYfyC/fkyHJ8CEFL
         yW+Xv81AYASppjtimo31NK2WGpMnGUdQgNBdlM6RuIhpC5tvMigKmkfItfcms8c5oq8/
         JlqzoQnTTjR7yncLPaNIHVhpc5lRRd2vezbE6YDWJjs2yVhRm/v5qVqq+b1bzDro2p9T
         llzg==
X-Gm-Message-State: APjAAAU4z4JAJBl2g4MlgJcFQkLjbAjoDfOqvwaFOV8FexYn/LV1OdGL
        fRQsfJ79mbcBRgaeu+rJMSOSKiHs08vKQA7HOD+MnOypI8sdwgE9jGlMAyb6OJX8C3egyMYqqJo
        ekA55GUbSqQsOQDexriV3N9Ii
X-Received: by 2002:a1c:9e10:: with SMTP id h16mr4667614wme.91.1574271787990;
        Wed, 20 Nov 2019 09:43:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqypL94NSqM7vsTdufH8pYYlerT4XH52xDr/GZ9SjjnraF3oQSDmxm/dAI68MX0mc/nT8wmsdA==
X-Received: by 2002:a1c:9e10:: with SMTP id h16mr4667586wme.91.1574271787710;
        Wed, 20 Nov 2019 09:43:07 -0800 (PST)
Received: from [192.168.178.40] ([151.48.115.61])
        by smtp.gmail.com with ESMTPSA id t185sm8025318wmf.45.2019.11.20.09.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:43:07 -0800 (PST)
Subject: Re: [PATCH v2 1/2] KVM: VMX: FIXED+PHYSICAL mode single target IPI
 fastpath
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1574145389-12149-1-git-send-email-wanpengli@tencent.com>
 <87r224gjyt.fsf@vitty.brq.redhat.com>
 <CANRm+CzcWDvRA0+iaQZ6hd2HGRKyZpRnurghQXdagDCffKaSPg@mail.gmail.com>
 <87lfscgigk.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f13b9873-5187-1558-2599-453041beed4a@redhat.com>
Date:   Wed, 20 Nov 2019 18:43:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfscgigk.fsf@vitty.brq.redhat.com>
Content-Language: en-US
X-MC-Unique: LpkkxECtP6qcmbngeSJWqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 13:26, Vitaly Kuznetsov wrote:
> What about ' << 4', don't we still need it? :-) And better APIC_ICR
> instead of 0x300...
>=20
> Personally, I'd write something like
>=20
> if (index > APIC_BASE_MSR && (index - APIC_BASE_MSR) =3D=3D APIC_ICR >> 4=
)
>=20
> and let compiler optimize this, I bet it's going to be equally good.

Or "index =3D=3D APIC_BASE_MSR + (APIC_ICR >> 4)".

Paolo

