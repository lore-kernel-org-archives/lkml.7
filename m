Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D96BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC30218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfCOHsQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:48:16 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52616 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfCOHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:48:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B1B2660B6295;
        Fri, 15 Mar 2019 08:48:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xBV_RisgZVGt; Fri, 15 Mar 2019 08:48:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5E0B460ED8C8;
        Fri, 15 Mar 2019 08:48:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l45P225PbTaX; Fri, 15 Mar 2019 08:48:12 +0100 (CET)
Received: from blindfold.localnet (089144193070.atnat0002.highway.a1.net [89.144.193.70])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 2783A60B6295;
        Fri, 15 Mar 2019 08:48:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-mtd@lists.infradead.org,
        linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com
Subject: Re: [PATCH 4/4] ubifs: Implement new mount option, fscrypt_key_required
Date:   Fri, 15 Mar 2019 08:48:10 +0100
Message-ID: <3651600.xvQHXhhOD0@blindfold>
In-Reply-To: <20190314230702.GE6482@mit.edu>
References: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com> <1957441.Hty6t2mpXG@blindfold> <20190314230702.GE6482@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

Am Freitag, 15. März 2019, 00:07:02 CET schrieb Theodore Ts'o:
> Richard --- stepping back for a moment, in your use case, are you
> assuming that the encryption key is always going to be present while
> the system is running?

it is not a hard requirement, it is something what is common on embedded
systems that utilize UBIFS and fscrypt.

> Ubifs can't use dm-crypt, since it doesn't have a block device, but if
> you could, is much more like dm-crypt, in that you have the key
> *before* the file system is mounted, and you don't really expect the
> key to ever be expunged from the system while it is mounted?
> 
> If that's true, maybe the real mismatch is in using fscrypt in the
> first place --- and in fact, something where you encrypt everything,
> including the file system metadata (ala dm-crypt), would actually give
> you much better security properties.

Well, fscrypt was chosen as UBIFS encryption backend because per-file encryption
with derived keys makes a lot of sense.
Also the implementation was not super hard, David and I weren't keen to reinvent
dm-crypt für UBI/MTD.

That said, I'm happy with fscrypt, it works well in production.
But being not able to use UBIFS as lower dir on overlayfs hurts.
On embedded systems where the key is always present the proposed hack works
fine. If we can get overlayfs work without that I'll be more than happy.

Thanks,
//richard


