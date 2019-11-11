Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F14C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E921D7F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8o/aEAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKKNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:53:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55464 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbfKKNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573480435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=KKS7ukaM3s+RcRPMeI0PJo9PV9ZqwXnsUCbsWMC+bQk=;
        b=C8o/aEAVw2oUTKghOMPYhpjBTbrbIomVpkO2v2iBvzECwuf0k50JQe8yDs3D2X7HlE8xar
        5jf8txoPKtg8dtA/Ukn/BSRcqFtJ0DWhfRlWyso9qO6vPRPjltKhTuCgwMDflJw8dS6rCy
        XSaJGOZkDT7g4YG3HcULUNn3UAzUR4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-a2Y47Ga1Mgu_IpjdQOaLpQ-1; Mon, 11 Nov 2019 08:53:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id w4so9987696wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDdR6HL2uqFXDuXRbpzrDYWDx7IlEFg5B/eQCvJy0rs=;
        b=EwHe59Pk2ireDrPZhg4qJDBExljebhngyaLoIhCytDslW4bHRE0KXvkWURbgSLRh93
         hyApmezaYhW2EKkJaFrReO3r8jhN0gI361L6gDCv1wtGRDgAZCMB3T8XkiJfhEB8tgIc
         n0USfsdm16kTLM5g8OTFklmWjl9OZX8YeGoKplOZsatb+m7Bd4mwigCL7sxdyNtGlKsY
         T+mQwPl2H/UitPvUBAz1McCOhIG2/apEMvMuTLRqJ5EDouMbtwMszZzjlx3V5ycSuD7p
         RumbiDEABywH8vVSvyIvZZ2tRQnEfbonBJSl+xvbLWGudPbejZj8J9K/VtVWqm/jOcVr
         npyA==
X-Gm-Message-State: APjAAAUjGlk/ZGTHkVurI/TNasQgKpfVdHMigW2Zjn/WD7yLZ3Y2AC1+
        eXfkCgNqbPV6SQ7eqDmfJuu4frjhrIqjpVIyOav98hCStumFQew74oiRe+qzEdk3s4FYTH0AM8L
        xuob9r762ZEmFdeWQyKX/z8c8
X-Received: by 2002:a1c:6885:: with SMTP id d127mr19691542wmc.64.1573480433140;
        Mon, 11 Nov 2019 05:53:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYGt7GZv5AYsab37ICD/qgIO6Wvt8jY5Hx81rPIZy+F4FRugWtB5EDFqrYsNHkWTw3dI7V1Q==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr19691522wmc.64.1573480432847;
        Mon, 11 Nov 2019 05:53:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id h124sm21529100wmf.30.2019.11.11.05.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 05:53:52 -0800 (PST)
Subject: Re: [PATCH 3/5] KVM: ensure pool time is longer than block_ns
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
 <1572060239-17401-4-git-send-email-zhenzhong.duan@oracle.com>
 <20191101211623.GB20061@amt.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <76044f07-0b76-cd91-dc87-82ed3fca061e@redhat.com>
Date:   Mon, 11 Nov 2019 14:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191101211623.GB20061@amt.cnet>
Content-Language: en-US
X-MC-Unique: a2Y47Ga1Mgu_IpjdQOaLpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/19 22:16, Marcelo Tosatti wrote:
>  =09=09if (!vcpu_valid_wakeup(vcpu)) {
>  =09=09=09shrink_halt_poll_ns(vcpu);
>  =09=09} else if (halt_poll_ns) {
> -=09=09=09if (block_ns <=3D vcpu->halt_poll_ns)
> +=09=09=09if (block_ns < vcpu->halt_poll_ns)
>  =09=09=09=09;
>  =09=09=09/* we had a short halt and our poll time is too small */
>  =09=09=09else if (block_ns < halt_poll_ns)

What about making this "if (!waited)"?  The result would be very readable:

                        if (!waited)
                                ;
                        /* we had a long block, shrink polling */
                        else if (block_ns > halt_poll_ns && vcpu->halt_poll=
_ns)
                                shrink_halt_poll_ns(vcpu);
                        /* we had a short halt and our poll time is too sma=
ll */
                        else if (block_ns < halt_poll_ns && vcpu->halt_poll=
_ns < halt_poll_ns)
                                grow_halt_poll_ns(vcpu);

Paolo

