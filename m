Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01662082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhrwXrym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfLQMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:16:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbfLQMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576584995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eA9cywrEHDbWRbwjH2I9YMr5mKq56yt7dElxC/Ko4cE=;
        b=ZhrwXrymHlSjsJfi1hFOK97Uom8cJytNBNxvxtIpL63NQpoh3i6IzqFxG27S/S2J7rtnRf
        1oEFWw0P240xFb/vBCG9wORaj8wcYt/YwhmIg+RfGSA7pGiWlb0XISszPVZ9or5UZh9Ycb
        e+U6Km8CEcbrRbam2FwPl48qTOziYxM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-At3ycamsN2GKXC38UdHDZA-1; Tue, 17 Dec 2019 07:16:34 -0500
X-MC-Unique: At3ycamsN2GKXC38UdHDZA-1
Received: by mail-wm1-f71.google.com with SMTP id g26so513032wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eA9cywrEHDbWRbwjH2I9YMr5mKq56yt7dElxC/Ko4cE=;
        b=UjZuGplVSqqi5urjXd9Q9sOH+KYA3DL4OEj8z0vdMdOQBtHD9ZdacP6FwqGJRfj2s7
         ogVr9oHbZ+N/erOfSkNTHRSEpFWQpSMRNyNzVdA37PV8Hd3LPLQra3tI865MqKkFMdR5
         WdOlE6e5cCWOTLTzy95rS2hzJgyz+1VRDFdI9IcJgia9PCTwPn1QWUobebkK0+PubTxo
         fsli02EHBB9RMEe0818hjoNeKFpiRSo3qIXydz9M/y5lZ6rwACFAiAkchptpocEsKyIO
         9BqlGdENeWMN5rXwQYhdUdEptQl8qJvEzp6dvqZrZf4PxPdd6TGMXK3/OqRvHOtU+nWv
         TQAw==
X-Gm-Message-State: APjAAAW0hyDpykoezNRvXREFlLsss8pTv1ZWzCVgR0I1JEG6sxP4CHmB
        Vy6omEd4vOh8sFl7TGeC7zkA7ALc7S/KavZJ1EIsmdXIPLi9L6ughtYy8FKs33Gw+yY70GUF1kq
        McBN3icQFQ/cWD7H1TTTNpeiz
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr37639349wrp.182.1576584992756;
        Tue, 17 Dec 2019 04:16:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxWL8dD6dQVsaIoKdm9DusWguRhjNW6D90fK9ygyz/qJ0RxmKHJAr+6737sYsXEYzYZkoekw==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr37639314wrp.182.1576584992501;
        Tue, 17 Dec 2019 04:16:32 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1c42:ed63:2256:4add? ([2a01:e0a:466:71c0:1c42:ed63:2256:4add])
        by smtp.gmail.com with ESMTPSA id z83sm2863437wmg.2.2019.12.17.04.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 04:16:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
From:   Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
Date:   Tue, 17 Dec 2019 13:16:31 +0100
Cc:     Peter Xu <peterx@redhat.com>,
        Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E167A793-B42A-422D-8D46-B992CB6EBE69@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com> <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 14 Dec 2019, at 08:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 13/12/19 21:23, Peter Xu wrote:
>>> What is the benefit of using u16 for that? That means with 4K pages, =
you
>>> can share at most 256M of dirty memory each time? That seems low to =
me,
>>> especially since it's sufficient to touch one byte in a page to =
dirty it.
>>>=20
>>> Actually, this is not consistent with the definition in the code ;-)
>>> So I'll assume it's actually u32.
>> Yes it's u32 now.  Actually I believe at least Paolo would prefer u16
>> more. :)
>=20
> It has to be u16, because it overlaps the padding of the first entry.

Wow, now that=E2=80=99s subtle.

That definitely needs a union with the padding to make this explicit.

(My guess is you do that to page-align the whole thing and avoid adding =
a
page just for the counters)

>=20
> Paolo
>=20
>> I think even u16 would be mostly enough (if you see, the maximum
>> allowed value currently is 64K entries only, not a big one).  Again,
>> the thing is that the userspace should be collecting the dirty bits,
>> so the ring shouldn't reach full easily.  Even if it does, we should
>> probably let it stop for a while as explained above.  It'll be
>> inefficient only if we set it to a too-small value, imho.
>>=20
>=20

