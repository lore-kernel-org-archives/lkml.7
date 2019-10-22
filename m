Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430ACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162E521872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXRtanUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfJVOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:09:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59504 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727582AbfJVOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571753347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=uSxGqEuW52lrWz/8potOYyUverZyGRXQnr3ONuzw9lw=;
        b=WXRtanUd45HLLJffFxnO2L8OIwb636oOtefPsq/Ag/F7bDeFeEZk/u3ezydCAxnapi6wW3
        EaVbpaz/hcejDPkf7dpPr864xU9Gxjl84ymDZB6Vzp8J4nSG6LDUOaj674e4KK2yBodBay
        6OG+9DGFK1JQTcazgEn9tQnOPdDIizE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-NnB6b5-iOEOm0i45E50IwQ-1; Tue, 22 Oct 2019 10:09:04 -0400
Received: by mail-wr1-f72.google.com with SMTP id 4so5072970wrf.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=makMNuKu1ppWLAvCA/QyEUL2D+FfE16R1xUwog6fpcY=;
        b=Bdw6DYU6/aMDymbbqNeiA7bnnxv0leq0SIpZIWO9Pv2tqWOxhqdmXSETfSsqADbpMH
         U++alYvFVRtEvk1s7ntQK7knlElJPUYFvMfyKJnUmnSLxtnyudkJDXMtYZkH4N9xINUe
         Sql6MsLGZjGBgVdKgLAQx4lZj1Cm2qh3KsyFkQlA16reIxcNND9HVKqHs6ChIOXxOGja
         XM3AInnoKFCRJUE3b4vi0/PPVrTIppbZgMPs/nc31HTIznQUHEH4Wnlo1o2GZQE3FFZT
         JT08cXDvi8QpIqE5BnJLBcPXJ0dqj9mVjxtX7jDU+zeoqqU1aXqwuEr5BVEbiGmXOw7E
         BUUg==
X-Gm-Message-State: APjAAAU68uIET1HENOWcuUduFs+17YRI1ZRREe5IWvOjdMqPP/dfitS1
        uRqCAVuqMFoEBenmWJkpXoRlotmvhO2Ziit60H3WKID+XXIjMgDpzbeVt1+MJzP8735r4HwppaV
        qm864xmQIjvzHgs3Db1aWs2C2
X-Received: by 2002:a1c:64d4:: with SMTP id y203mr3274025wmb.27.1571753343663;
        Tue, 22 Oct 2019 07:09:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkJgcR6x3vTLahX+BVgNWIDW6o7sVahp6sEE316gNwH/lVfCALUNph0Wv1M5z5/y2k/6tSsQ==
X-Received: by 2002:a1c:64d4:: with SMTP id y203mr3273996wmb.27.1571753343407;
        Tue, 22 Oct 2019 07:09:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id z125sm25633535wme.37.2019.10.22.07.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:09:02 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] KVM: x86/vPMU: Add lazy mechanism to release
 perf_event per vPMC
To:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org
Cc:     peterz@infradead.org, like.xu@intel.com,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com, wei.w.wang@intel.com,
        kan.liang@intel.com
References: <20191021160651.49508-1-like.xu@linux.intel.com>
 <20191021160651.49508-7-like.xu@linux.intel.com>
 <c17a9d77-2c30-b3c0-4652-57f0b9252f3b@redhat.com>
 <7d46a902-43eb-4693-f481-1c2efd397fbd@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d3434a16-07ed-7070-f316-9a2fa072ace0@redhat.com>
Date:   Tue, 22 Oct 2019 16:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7d46a902-43eb-4693-f481-1c2efd397fbd@linux.intel.com>
Content-Language: en-US
X-MC-Unique: NnB6b5-iOEOm0i45E50IwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/19 14:00, Like Xu wrote:
>=20
> Second, the structure of pmu->pmc_in_use is in the following format:
>=20
> =C2=A0 Intel: [0 .. INTEL_PMC_MAX_GENERIC-1] <=3D> gp counters
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [INTEL=
_PMC_IDX_FIXED .. INTEL_PMC_IDX_FIXED + 2] <=3D> fixed
> =C2=A0 AMD:=C2=A0=C2=A0 [0 .. AMD64_NUM_COUNTERS-1] <=3D> gp counters

Sorry---I confused INTEL_PMC_MAX_FIXED and INTEL_PMC_IDX_FIXED.

The patches look good, I'll give them another look since I obviously
wasn't very much awake when reviewing them.

Paolo

