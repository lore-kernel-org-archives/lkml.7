Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB88D20862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKBRMD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfKBRMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:12:03 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30B2BC04BE1B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2019 17:12:03 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id f17so7971881otp.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 10:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zl9fDks+mlVguzbhaExkNR5P4dBXCVz91rnRw1qkYoM=;
        b=bMHK0Fhd7ExIhxx0tSmQAwuU5Y+dy1WNNPmhXv0VuscxxjK4M7RRCifvDyaN9pn8dT
         RkUJ7+8oolTPhytnK7HdmoASrhCv5H2YK6CyJkWv9VAnfGnMgDze/1frgrHqp2zZq0D0
         XCYRukavmG1Z7cn2m2is1lVvhGkx4zpVykuPrUA3iz0U1GyvzuJ68WnmyDKCUvaEzCux
         cOCYnpxMoWLVNlGT7aiPt7/ghshwNf9NmE+bUuV4zrl/ogHQwRp2r5rbuQ4dcVVFBiSa
         oL9hQjgL27zACC2ZbuCIz0IITC/vwIHS9CMGFIBE4bqemAseF+5qJ1P+2+cTGzBUqpMo
         QrYw==
X-Gm-Message-State: APjAAAWg+vyGA7xTRipqWJ4jjE09l1WWfOEOzWfaaTVDkwmqXaJKvkdU
        mjiFV7oWETrTO3AE9qj9i9kxdcThH3V8lFy6uIN/v+QsvvHTD/3Qt7YQFPH6y8lB619IdheZ1di
        6HKCakYoMFkoZOuQLJwNPnFu2+5O5TMwwr3eC5OmL
X-Received: by 2002:aca:b03:: with SMTP id 3mr8429427oil.24.1572714722655;
        Sat, 02 Nov 2019 10:12:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBeIHHDezjGUM47ip6RrosGeU264dgnNDsmFABP4CYUabIN4mVl/m2b8xL3KrISyeUZ+KMCTs+c2qfLxq5oBI=
X-Received: by 2002:aca:b03:: with SMTP id 3mr8429400oil.24.1572714722376;
 Sat, 02 Nov 2019 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191031064741.4567-1-christophe.jaillet@wanadoo.fr>
 <c7a0b6b0-96cd-1fd3-3d98-94a3692bda38@cogentembedded.com> <1b33ca33-a02b-1923-cbee-814e520b9700@wanadoo.fr>
In-Reply-To: <1b33ca33-a02b-1923-cbee-814e520b9700@wanadoo.fr>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Sat, 2 Nov 2019 18:11:50 +0100
Message-ID: <CAGxU2F5wS9VnNu5ETFbbFcyaCx+UPD9jqjBPVp_rKKZ0-am1tQ@mail.gmail.com>
Subject: Re: [PATCH] vsock: Simplify '__vsock_release()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>, sunilmut@microsoft.com,
        Willem de Bruijn <willemb@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, ytht.net@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de,
        Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:49 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 31/10/2019 à 10:36, Sergei Shtylyov a écrit :
> > Hello!
> >
> > On 31.10.2019 9:47, Christophe JAILLET wrote:
> >
> >> Use '__skb_queue_purge()' instead of re-implementing it.
> >
> >    In don't see that double underscore below...
> This is a typo in the commit message.
>
> There is no need for __ because skb_dequeue was used.
>
> Could you fix it directly in the commit message (preferred solution for
> me) or should I send a V2?
>

I think is better if you send a v2 fixing this and including the R-b tags.
My R-b stays with that fixed :-)

Thanks,
Stefano
