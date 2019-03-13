Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC6C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7656E214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCMNcH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:32:07 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42590 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:32:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0F0E8609184E;
        Wed, 13 Mar 2019 14:32:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tA1jAXsCSzwY; Wed, 13 Mar 2019 14:32:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B3C7E609186C;
        Wed, 13 Mar 2019 14:32:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lDlepYWN4fLJ; Wed, 13 Mar 2019 14:32:03 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 56435609184E;
        Wed, 13 Mar 2019 14:32:03 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 14:32:02 +0100
Message-ID: <4066872.KGdO14EQMx@blindfold>
In-Reply-To: <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold> <1854703.ve7plDhYWt@blindfold> <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 14:24:47 CET schrieb Miklos Szeredi:
> > The use case is that you can delete these files if the DAC/MAC permissions allow it.
> > Just like on NTFS. If a user encrypts files, the admin cannot read them but can
> > remove them if the user is gone or loses the key.
> 
> There's the underlying filesystem view where admin can delete files,
> etc.   And there's the fscrypt layer stacked on top of the underlying
> fs, which en/decrypts files *in case the user has the key*.  What if
> one user has a key, but the other one doesn't?  Will d_revalidate
> constantly switch the set of dentries between the encrypted filenames
> and the decrypted ones?  Sounds crazy.  And the fact that NTFS does
> this doesn't make it any less crazy...

Well, I didn't come up with this feature. :-)

If one user has the key and the other not, a classic multi-user
system, then you need to make sure that the affected fscrypt instances
are not visible by both.
For example by using mount namespaces to make sure that user a can only
see /home/foo and user b only /home/bar.
Or removing the search permission on /home/foo and /home/bar.

I know, I know, but that's how it is...
Maybe Ted or Eric can give more details on why they chose this approach.

Thanks,
//richard





