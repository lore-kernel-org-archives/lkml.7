Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88078C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFEC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552515975;
	bh=mV9BsxTvOteaoJconYYYDeAORMsCSy6NbK2wxeTXpYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jr7qI+8v71kIjek7BjtHNivf1bORX7WlqOS/nxTUB/z10zccp+Q/gYsUNCNpC0UNm
	 XjMSuCL1DJhEyEtgqg+/PkBfxTHWZbc9COcQQnTMy33wjR0jugUsqJfAJGm370wsYf
	 rat3hSSbUyhmaMuqpqTcQgOwlOD7vmOk42+knAdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfCMW0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMW0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:26:13 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9101F20811;
        Wed, 13 Mar 2019 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552515972;
        bh=mV9BsxTvOteaoJconYYYDeAORMsCSy6NbK2wxeTXpYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HsJGORJd8eVptCV3Bgmi82YaibgCJ9IF7zb53Gc8Q9p2xXAJA7MQzifwvbQrOU0c
         lmLRGNgrHSbnSyDpC8XlVXon7LKKhNwLXhfWLTpZ5N3/Vk8QBVLoZIKO++98nGJFFS
         LVmd675NXbp+NCF/B6yWOAI4DOw++3KKRKVwBl94=
Date:   Wed, 13 Mar 2019 15:26:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313222610.GF10169@gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold>
 <4066872.KGdO14EQMx@blindfold>
 <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
 <15244624.W7e5yEypHC@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15244624.W7e5yEypHC@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:33:10PM +0100, Richard Weinberger wrote:
> Am Mittwoch, 13. März 2019, 15:26:54 CET schrieb Amir Goldstein:
> > IMO, the best thing for UBIFS to do would be to modify fscrypt to support
> > opting out of the revalidate behavior, IWO, sanitize your hack to an API.
> 
> Given the WTF/s rate this thread has, this might me a good option.
> Actually people already asked me how to disable this feature because
> they saw no use of it.
> Being able to delete encrypted files looks good on the feature list but in
> reality it has very few users but causes confusion, IMHO.
> 
> I propose a new fscrypt_operations flag, FS_CFLG_NO_CRYPT_FNAMES.
> If this flag is set, a) fscrypt_setup_filename() will return -EPERM if
> no key is found.
> And b) __fscrypt_prepare_lookup() will not attach fscrypt_d_ops to the dentry.
> 
> Eric, what do you think?
> 
> Thanks,
> //richard
> 

What specifically is wrong with supporting the ciphertext "view" of encrypted
directories, and why do you want to opt UBIFS out of it specifically but not
ext4 and f2fs?  (The fscrypt_operations are per-filesystem type, not
per-filesystem instance, so I assume that's what you had in mind.)  Note that we
can't unconditionally remove it because people need it to delete files without
the key.  We could add a mount option to disable it, but why exactly?

By the way, I suggest that people read Documentation/filesystems/fscrypt.rst for
more information about what fscrypt is supposed to do, as there seems to be a
lot of misconceptions.

- Eric
