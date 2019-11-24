Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E7C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1260A20706
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 10:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d00CO9po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfKXKwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 05:52:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbfKXKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 05:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574592733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgrqyGrI4wz4JE0efwdw2KoDDevv1GGFzKxHMz7NT+E=;
        b=d00CO9poPDYL0TastioSu38GRz9KjeEaCYjubz3lR7KTttFw0a3oOM9XOHWxOmGGwVpXv+
        4ihcJaMF86bPjf4ItmEIJGO3NL2AoRv1RqJEAGTjwdnDUupa1R4HGsy5eiLx+t3g0OJNFu
        NpUTvVPIh1Ji6Jl+8zKbxfVN8tK31AE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-2SZFV0BEM0KygrZKdHkPkA-1; Sun, 24 Nov 2019 05:52:09 -0500
Received: by mail-qt1-f198.google.com with SMTP id 6so8190539qtu.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 02:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYTE+708WYU/v6e61/u6H0iTp+/IB5KOl36q0rPST20=;
        b=RCt9mBPtib5tywh2WwgPAwwQ8hc6xk8GuFa3CpBJMvJTwc+L3M3lS1IQSyrEhDyNdE
         adCYbAy6Zkg444u0sJDrbmFgQEPy5+DYkMb9CsQ793y3yy6sLAo4ysuBxiD9021hvMyP
         GTHk8kNX8k+FTogkoPO6LIFz8C5vY2lcyxiqaUjtk8eEEOnXS5buMIAH6SJ22K74o5ko
         7A7RpFKLodUJfiZT82BFfrdqTrEhtOXNsofUdb0QDH7Bueyw0u3syCMltFmuZVVeYr4i
         e0obcUFPIDEK/w3GZ90yMxJ+Fzgw6gTJ6E+VCKNguYtpQiKzWn0kwQ4SWMJB5BVxv/PI
         eHIg==
X-Gm-Message-State: APjAAAUtimxGfZcbeyVQ/tkSN5qVH2ugAjgWWmB1Zr+v8zkugx+wa7Q0
        e4cSndR60vu6yLTPL+d0BQzLKblwktIzsLkMD1sU0CDEivb3YmeqZj3IUqabMrgRieWNZDyuxvP
        YrgtppgDZzCN/HqbCccJcIwjy
X-Received: by 2002:a0c:fa05:: with SMTP id q5mr12215643qvn.182.1574592729398;
        Sun, 24 Nov 2019 02:52:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZ7wVd3gE/UE/n6wQWaImHjk1yL624O9bg+Y7VbNSDbwNBANSGUiP3UWpATNi251yCQNG6IQ==
X-Received: by 2002:a0c:fa05:: with SMTP id q5mr12215627qvn.182.1574592729167;
        Sun, 24 Nov 2019 02:52:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id x8sm1983132qtp.75.2019.11.24.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 02:52:08 -0800 (PST)
Date:   Sun, 24 Nov 2019 05:52:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Julio Faracco <jcfaracco@gmail.com>
Cc:     netdev@vger.kernel.org, Daiane Mendes <dnmendes76@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] drivers: net: virtio_net: Implement a
 dev_watchdog handler
Message-ID: <20191124054916-mutt-send-email-mst@kernel.org>
References: <20191122013636.1041-1-jcfaracco@gmail.com>
 <20191122052506-mutt-send-email-mst@kernel.org>
 <CAENf94KX1XR4_KXz9KLZQ09Ngeaq2qzYY5OE68xJMXMu13SuEg@mail.gmail.com>
 <20191122080233-mutt-send-email-mst@kernel.org>
 <CAENf94L7zU6JoM+19F+__b6W4mpe5Na=ayd+eYe4aZ+EBABmiA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAENf94L7zU6JoM+19F+__b6W4mpe5Na=ayd+eYe4aZ+EBABmiA@mail.gmail.com>
X-MC-Unique: 2SZFV0BEM0KygrZKdHkPkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 08:33:40PM -0200, Julio Faracco wrote:
> >
> > netdev: pass the stuck queue to the timeout handler
> >
> > This allows incrementing the correct timeout statistic without any mess=
.
> > Down the road, devices can learn to reset just the specific queue.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Warning: untested.
> >
>=20
> Question...
> Wouldn't be better to create a module parameter instead change the
> function scope?

Passing the value in a global variable? That fails to be reentrant ...

> I'm asking it because how many modules would effectively take advantage o=
f it?

The cost is effectively 0 though.

--=20
MST

