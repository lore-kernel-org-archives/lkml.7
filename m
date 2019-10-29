Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47900CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CCF20659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJFXwM5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfJ2Tp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:45:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728686AbfJ2Tp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572378356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7Ti3+3tmv66owZ7qBKTGP/26K30M0oQKayUEbDIa+Y=;
        b=KJFXwM5JwAOn6np+DvwZHauSVNqZTi/WJ/89N60s7C1axG7ydquLTcK+GC0RjKBnuR0nn8
        HNlpjVYHprOdjqZ/4yQ0I9U4fi3AYt93rswOpzy41/CbI1MUfjC1plCA7ZtDkMsZnZuKmC
        2CTNItSQH7CjFGs8Argk819nVamZPOg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-oKvREsjXOR6byGRQFufPIA-1; Tue, 29 Oct 2019 15:45:55 -0400
Received: by mail-lj1-f197.google.com with SMTP id g28so3469196ljl.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+ECcjymISpeDMuJTnhQofeU33ZNJr8YyX1nUeLIK0Y=;
        b=AcR1gZGcFU3OwCH1JLFeXjDx8V/sOWT7pgy2YGBByHgMPY0sLTfFB6W76r+XW61n8a
         XYBmTLtxSdEAZxiY5xwkhVrYz2lG90mLqFRu6eGxrOftrfZYFSZBy8PO3a1DMtsE1TLf
         5KGqDnhmyYYiTMavnZ60K0QqcsznhUE+k7oU1JWgePj/AUgGojsgQRFPuOiwv8Qvuh70
         rYD8NXJDJgIt51COalCQ0oYByPpiDMRO9+kXnHRxgcpzAQfBazgeaj6G6nCCopoZdCy7
         QN5jEocu8ja+T8+PV90NquPdMoYUyvjY2+NJ18cNg7po1jebiEP+Fu13XE5n0ZfWTJOh
         FS4Q==
X-Gm-Message-State: APjAAAXkKiguX4Rtre9hAMo1/CvcOZz8LHmam3ddFxHc4tT3gkmpxDW1
        0Zt5yhIUvblpD9BHm8OwpzCF4rKW+Rt9srxmePiqeiXpdIDfGl73j29mNkMuGEo5trdUo892+Lu
        hazzqIxfF3/ubjjOsCkMv1T/1NOOHggsBPGrO6tSj
X-Received: by 2002:a2e:481:: with SMTP id a1mr3892365ljf.209.1572378352478;
        Tue, 29 Oct 2019 12:45:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0vA9DfJ4UoIS98gFY0o8jyjcdNbcKPd8o0vVtUvZDPBVcqW0aVI4B6nUf/A4G5JzO82y+msUUiOXZaG2Tfgw=
X-Received: by 2002:a2e:481:: with SMTP id a1mr3892351ljf.209.1572378352307;
 Tue, 29 Oct 2019 12:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191029135053.10055-1-mcroce@redhat.com> <20191029135053.10055-5-mcroce@redhat.com>
 <5be14e4e-807f-486d-d11a-3113901e72fe@cumulusnetworks.com> <a7ef0f1b-e7f5-229c-3087-6eaed9652185@cumulusnetworks.com>
In-Reply-To: <a7ef0f1b-e7f5-229c-3087-6eaed9652185@cumulusnetworks.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 29 Oct 2019 20:45:16 +0100
Message-ID: <CAGnkfhwmPxFhhEawxgTp9qt_Uw=HiN3kDVk9f33mr7wEJyp1NA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] bonding: balance ICMP echoes in layer3+4 mode
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>
X-MC-Unique: oKvREsjXOR6byGRQFufPIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 7:41 PM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> On 29/10/2019 20:35, Nikolay Aleksandrov wrote:
> > Hi Matteo,
> > Wouldn't it be more useful and simpler to use some field to choose the =
slave (override the hash
> > completely) in a deterministic way from user-space ?
> > For example the mark can be interpreted as a slave id in the bonding (s=
hould be
> > optional, to avoid breaking existing setups). ping already supports -m =
and
> > anything else can set it, this way it can be used to do monitoring for =
a specific
> > slave with any protocol and would be a much simpler change.
> > User-space can then implement any logic for the monitoring case and as =
a minor bonus
> > can monitor the slaves in parallel. And the opposite as well - if peopl=
e don't want
> > these balanced for some reason, they wouldn't enable it.
> >
>
> Ooh I just noticed you'd like to balance replies as well. Nevermind
>

Also, the bonding could be in a router in the middle so no way to read the =
mark.

--=20
Matteo Croce
per aspera ad upstream

