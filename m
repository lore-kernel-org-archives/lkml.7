Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B05C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5160B204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCMQYO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:24:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:45320 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCMQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:24:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 18FEF608A387;
        Wed, 13 Mar 2019 17:24:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5Sfc75WrmWux; Wed, 13 Mar 2019 17:24:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6C83608A396;
        Wed, 13 Mar 2019 17:24:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k0pV2p1lbdBX; Wed, 13 Mar 2019 17:24:11 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 393C8608A387;
        Wed, 13 Mar 2019 17:24:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 17:24:10 +0100
Message-ID: <2287057.GpIlh1E3ca@blindfold>
In-Reply-To: <1552493632.3022.17.camel@HansenPartnership.com>
References: <4603533.ZIfxmiEf7K@blindfold> <20190313155144.GC703@sol.localdomain> <1552493632.3022.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 17:13:52 CET schrieb James Bottomley:
> > What do you mean by "containment breaches by other tenants"?  Note
> > that while the key is added, fscrypt doesn't prevent access to the
> > encrypted files.
> 
> You mean it's not multiuser safe?  Even if user a owns the key they add
> user b can still see the decrypted contents?

If user a reads the file before, yes. Then user b sees it because the contents
got cached.
That's why you need still make sure that your access control is sane.

Thanks,
//richard


