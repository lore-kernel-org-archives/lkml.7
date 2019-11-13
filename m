Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC96C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5E222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjisUTBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfKMOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:44:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40015 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726982AbfKMOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573656249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=bC4T8pgydI4B01e4W+simxuv/TyXNcqyN4ZGiE+0SQI=;
        b=PjisUTBr2+Sctzo9PP7oZYht1HZw5aw1N/MvUJTPFtZXRzJyys2lmtGCe/gH4E/39bnLq9
        ukbanKVK3J4gmY9bf3Dq+MUJ4e6SnZjkLfErrZv3+dUtHfflSlO6Lc68IidUd86E1UZL7z
        w4F8dTOaV79oiGKTZ1GMLvi/y/4Z/Ek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-g9gnedinPU6ELS5pwSrRbg-1; Wed, 13 Nov 2019 09:44:08 -0500
Received: by mail-wr1-f70.google.com with SMTP id m17so1675498wrn.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dbS92pVYxEVofFiDK5lk0fDOG1KrLCQFjLUxVrpNKPI=;
        b=Qp+pJYoJHMRa0ex0+V8tb7zmk+IJ2+lujRflWuKMR9iM2R8o7Vd7Y18mV9gi8Ue9Ud
         C4QCzj4QP87gy/K7dcl09zdrUry8sgdUCHVziSZ6sYro6OLMe2/+NT0S47QALH89QnyX
         o4xzvWPV8H0nZOU1LGnaSQf6QDB6eyMu7VRpRIJqxgTSlexP6kc/HFRXnmESfN3uK6We
         1152PNyXrUS+hnOdABGJrfTo5ZldWioWDlc0TEJiHrGLkraUPugB/wbhuLhrOKJIk/QC
         jvIllY90OdiSQKOJHT+/pQLQVU0K99HTm/qXwBh+PnzxObMawA3kA/nJ87erLHbttcky
         dJgA==
X-Gm-Message-State: APjAAAWkKXuGt35/0toR5LlxCjosbje/W+gOfMByerfhXgmYg/x11G9o
        NOtye5TzRIPk7jBCZJVOGx0FRPEmcp5hLWh7eB4QhHNWGwsAX3fiIvgoIr7ybOSfkke+EhuV9R1
        dOgzqUVU89a1M7FnFFYCPdZoW
X-Received: by 2002:a5d:4684:: with SMTP id u4mr3038386wrq.352.1573656246884;
        Wed, 13 Nov 2019 06:44:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgYu792LkrL3kJQUYwsfx60pDoHSkEQj1tWw2Eb5IvKv9j8sSGe43esVkYau0g05Bjzzz9UQ==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr3038366wrq.352.1573656246598;
        Wed, 13 Nov 2019 06:44:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:64a1:540d:6391:74a9? ([2001:b07:6468:f312:64a1:540d:6391:74a9])
        by smtp.gmail.com with ESMTPSA id z4sm2704216wmf.36.2019.11.13.06.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 06:44:06 -0800 (PST)
Subject: Re: [FYI PATCH 0/7] Mitigation for CVE-2018-12207
To:     Jinpu Wang <jinpuwang@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "KVM-ML (kvm@vger.kernel.org)" <kvm@vger.kernel.org>
References: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
 <CAD9gYJ+9sDYh+8RkbaaRrMEbJ1EJrkMdJFCa6HVPUE4_FA13ag@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6cb5e680-86f1-108d-92db-62e904dccb7c@redhat.com>
Date:   Wed, 13 Nov 2019 15:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD9gYJ+9sDYh+8RkbaaRrMEbJ1EJrkMdJFCa6HVPUE4_FA13ag@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: g9gnedinPU6ELS5pwSrRbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 14:00, Jinpu Wang wrote:
> Hi Paolo, hi list,
>=20
> Thanks for info, do we need qemu patch for full mitigation?
> Debian mentioned:
> https://linuxsecurity.com/advisories/debian/debian-dsa-4566-1-qemu-securi=
ty-update-17-10-10
> "
>     A qemu update adding support for the PSCHANGE_MC_NO feature, which
>     allows to disable iTLB Multihit mitigations in nested hypervisors
>     will be provided via DSA 4566-1.
>=20
> "
> But It's not yet available  publicly.

I will send it today, but it's not needed for full mitigation.  It just
provides a knob to turn it on and off in nested hypervisors.

> About the performance hit, do you know any number? probably the answer
> is workload dependent.

We generally measured 0-4%.  There can be latency spikes for RT, which I
will send a patch for soon.

Paolo

