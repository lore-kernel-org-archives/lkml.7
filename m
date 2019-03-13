Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA122171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCMMro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:47:44 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41950 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:47:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B1A7C609186C;
        Wed, 13 Mar 2019 13:47:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MT2xNyXoIwxw; Wed, 13 Mar 2019 13:47:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 50C39609187E;
        Wed, 13 Mar 2019 13:47:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8e52FewGmFx8; Wed, 13 Mar 2019 13:47:41 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id ECFD6609186C;
        Wed, 13 Mar 2019 13:47:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 13:47:40 +0100
Message-ID: <1852545.qrIQg0rEWx@blindfold>
In-Reply-To: <CAJfpegsy31D+=VJ+By2a9TLCvZJwvAUpb+_bJ5JVTsmsbZJTKQ@mail.gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold> <CAJfpegsy31D+=VJ+By2a9TLCvZJwvAUpb+_bJ5JVTsmsbZJTKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 13:36:02 CET schrieb Miklos Szeredi: 
> I don't get it.  Does fscrypt try to check permissions via
> ->d_revalidate?  Why is it not doing that via ->permission()?

Please let me explain. Suppose we have a fscrypto directory /mnt and
I *don't* have the key.

When reading the directory contents of /mnt will return an encrypted filename.
e.g.
# ls /mnt
+mcQ46ne5Y8U6JMV9Wdq2C

As soon I load my key the real name is shown and I can read the file contents too.
That's why fscrypt has ->d_revalidate(). It checks for the key, if the key is
still not here -> stay with the old encrypted name. If the key is present
-> reveal the real name.

Same happens on the other direction if I unlink my key from the keyring.

> >
> > 2. Teach overlayfs to deal with a upper that has ->d_revalidate().
> > Given the complexity of overlayfs I'm not sure how feasible this is.
> > But I'm no overlayfs expert, maybe I miss something.
> 
> I don't think it would be too complex.  But first I'd like to
> understand exactly why fscrypt is (ab) using d_revalidate().

I hope my answer makes things more clear.

Thanks,
//richard


