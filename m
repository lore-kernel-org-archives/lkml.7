Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981EECA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671BF21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axFcfUgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436852AbfJYO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:27:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31470 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436771AbfJYO1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572013628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSGPuJMLYfDMnAmpDMOZktcz7mBfnLm8edFjjutXhg8=;
        b=axFcfUgqHGkXrFMjIw7Wa/JtCSwtsvq9+LfA6SY7douMhyRfRi93+nkML6Jmxkt5xTZxc+
        a+VzS4nEmF3TKQnlGQEgjhbhHM1oWnP6xsYnkQSmclevpdDPQFn+NcpoC2fL8N2el+dfaW
        xYGOu21ZAQTvSnaCo0b4CGVqVUtzUYg=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-cyvzJasVMjevxU9Coe2YZQ-1; Fri, 25 Oct 2019 10:27:00 -0400
Received: by mail-yw1-f70.google.com with SMTP id b184so953993ywa.15
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lSGPuJMLYfDMnAmpDMOZktcz7mBfnLm8edFjjutXhg8=;
        b=Lk3jkGnFZGn0qn7V7HcUCUbkRmAcdGmH6LrCGNAV1w46G9oji7gRroZXTwmGZ//PYO
         Hh6x2OXCQIzSmranopbPZTmdtp6qQqJdxkmSEJV3J+j7l2fLsg8Nr6LDgQ7HFh0NF9FQ
         RlygTAJwC1b1jYbupVDeDeLKEcpqAlNOb9wL+bUX9oXXf/Bhb595WkprFyylsi/7lqYJ
         Ub6/4HCpQuREv3t1yAZAZOQqTPv0g69YybKfYjbKgphuRfKZGiBYuoW3sEtivamBoVhK
         bIJNYvFYH/tQs8uSjb/zq7vXLdUHTP7gLG3+Q2mqwQP8G1TTuGSkc9Q6+fCtdmi3UntN
         DxGQ==
X-Gm-Message-State: APjAAAX4oGIw1mKzi6AVLUVszowb6viaCkUUBVyd/yaeMFl+lxMijSI0
        tGgMvsNH3onRxR97Cn2QgFOFIPtN6+rilS9WtkzURdtfpFpEjAwq7HvwWJrSHOqxMjILzgC/pXt
        1Ct6OLYn/CPKHqWs76snzgu+CbAdSFY142kixIdNZ
X-Received: by 2002:a81:4784:: with SMTP id u126mr2442202ywa.349.1572013620404;
        Fri, 25 Oct 2019 07:27:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxeLjnpJ8r6rblunofS7P6SYHd9DzfXkk/G7kqmKj6vgbeu2w6G6vCf29CxNnFugrVbxQIIC4KgRjCNmMCaKyA=
X-Received: by 2002:a81:4784:: with SMTP id u126mr2442178ywa.349.1572013620104;
 Fri, 25 Oct 2019 07:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACVy4SUkfn4642Vne=c1yuWhne=2cutPZQ5XeXz_QBz1g67CrA@mail.gmail.com>
 <20191024103134.GD13225@gauss3.secunet.de> <ad094bfc-ebb3-012b-275b-05fb5a8f86e5@jv-coder.de>
 <20191025094758.pchz4wupvo3qs6hy@linutronix.de> <202da67b-95c7-3355-1abc-f67a40a554e9@jv-coder.de>
 <20191025102203.zmkqvvg5tofaqfw6@linutronix.de>
In-Reply-To: <20191025102203.zmkqvvg5tofaqfw6@linutronix.de>
From:   Tom Rix <trix@redhat.com>
Date:   Fri, 25 Oct 2019 07:26:49 -0700
Message-ID: <CACVy4SVAsG37n7q6jrRPSr-WV2QxSympuNQC2j+GJzBXqfwvtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] xfrm : lock input tasklet skb queue
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joerg Vehlow <lkml@jv-coder.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-MC-Unique: cyvzJasVMjevxU9Coe2YZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will work on refactoring the patch to v5.2-rt.
trix

On Fri, Oct 25, 2019 at 3:22 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-10-25 12:14:59 [+0200], Joerg Vehlow wrote:
> > Here is one of the oops logs I still have:
> >
> > [  139.717273] CPU: 2 PID: 11987 Comm: netstress Not tainted
> > 4.19.59-rt24-preemt-rt #1
>
> could you retry with the latest v5.2-RT, please? qemu should boot fine=E2=
=80=A6
>
> Sebastian

