Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0975AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02022190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZs1HUK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKKNyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:54:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29600 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726928AbfKKNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573480488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=Kdxnyo+p6t0JdZhsLc2EdVrHnYFkAr4aia07OARRAyk=;
        b=ZZs1HUK2Mn8lDBCAE8iSdkLx1yAUG/FibdjEP6QCxLB8OcUWKhWqeQwE3JvOuAdGR3Q/xL
        inbuCTYlLXcuxRVMiCKgTwzS8glOVeWo7TX7YKOfO89Khn7JhERCs/XYvjo3vf4/trYFmt
        HZX50Fjo5fYdMWsLj2H6LVJI0aElk48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-xfu9xFBdOUGSEJCcrNvAPg-1; Mon, 11 Nov 2019 08:54:47 -0500
Received: by mail-wr1-f72.google.com with SMTP id b4so9974432wrn.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BxHVyZ+cnRCYzkQSXGK/lCaiu55fYily773XUj4dT5s=;
        b=O+aI6wpv3HTUYzPcIqhBVK9vW0LsiqHF8dD5rlNyRT4ztoxVx7Iubko40y6Wx678jc
         tnpN/mjPn/p9Bc9AmM8jF5plN06FoVjF5vYmxlkMBzVumhLxM4cqXIbqmsL2769WCSn7
         h7alxaGBKTxqO21LOmrSfOdDOin0m27BGJVteBIaKlz3V3TItqqPttGhbb5MPIY26GFZ
         i66OxRizPTL3+lN6+r9rPPidFX9in3RsmulL8CIHWNJhIKfROPW4OxD+nEFgF0fwOsM6
         91qhTKP2hZVe1SXfgAtZg2sbUuOl1U6BPjBTqLbmFbgaD/QsO7XLffvFowqyTN+OkE7U
         Tx0A==
X-Gm-Message-State: APjAAAWFTC4OYDjvLjNBsFEGOg1HAUzKH0mJKkw5fisA8DOeQjVT8Qjo
        YoI1yg63p5yxA474kYX8MKuPZlWiASX1wyDkb1moiSaoaMdnOqI0JYJjuCZAXS+prktp6pzHc9p
        yJU1sNi2z+4CYBrNt+chMOaJ1
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr9404567wmc.37.1573480486540;
        Mon, 11 Nov 2019 05:54:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPKbfaui1XILL/LXgyrl/T67qcN/cQ/bVUBjzaNiprDnW/V8fSSn81rsVJlkmK1d+EG5JIBg==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr9404546wmc.37.1573480486289;
        Mon, 11 Nov 2019 05:54:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id 200sm27687037wme.32.2019.11.11.05.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 05:54:45 -0800 (PST)
Subject: Re: [PATCH 4/5] cpuidle-haltpoll: add a check to ensure grow start
 value is nonzero
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
 <1572060239-17401-5-git-send-email-zhenzhong.duan@oracle.com>
 <20191101211908.GA20672@amt.cnet>
 <7245089f-788e-03d6-9833-6ce4d313f4ce@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <57679389-6e4a-b7ad-559f-3128a608c28a@redhat.com>
Date:   Mon, 11 Nov 2019 14:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7245089f-788e-03d6-9833-6ce4d313f4ce@oracle.com>
Content-Language: en-US
X-MC-Unique: xfu9xFBdOUGSEJCcrNvAPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 03:56, Zhenzhong Duan wrote:
>=20
> On 2019/11/2 5:19, Marcelo Tosatti wrote:
>> On Sat, Oct 26, 2019 at 11:23:58AM +0800, Zhenzhong Duan wrote:
>>> dev->poll_limit_ns could be zeroed in certain cases (e.g. by
>>> guest_halt_poll_shrink). If guest_halt_poll_grow_start is zero,
>>> dev->poll_limit_ns will never be larger than zero.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>>> ---
>>> =A0 drivers/cpuidle/governors/haltpoll.c | 15 ++++++++++++---
>>> =A0 1 file changed, 12 insertions(+), 3 deletions(-)
>> I would rather disallow setting grow_start to zero rather
>> than silently setting it to one on the back of the user.
>=20
> Ok, will do.

Similar to patch 2, I think disabling halt polling is a good behavior if
grow_start =3D 0.

Paolo

