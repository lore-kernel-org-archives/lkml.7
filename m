Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B85C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C839720854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCMUdO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:33:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:49404 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCMUdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:33:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0F53E60A550B;
        Wed, 13 Mar 2019 21:33:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mTIRpAuXTIia; Wed, 13 Mar 2019 21:33:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B32826091877;
        Wed, 13 Mar 2019 21:33:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cc97TOqdL_qM; Wed, 13 Mar 2019 21:33:11 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4F48E609B26F;
        Wed, 13 Mar 2019 21:33:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 21:33:10 +0100
Message-ID: <15244624.W7e5yEypHC@blindfold>
In-Reply-To: <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold> <4066872.KGdO14EQMx@blindfold> <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 15:26:54 CET schrieb Amir Goldstein:
> IMO, the best thing for UBIFS to do would be to modify fscrypt to support
> opting out of the revalidate behavior, IWO, sanitize your hack to an API.

Given the WTF/s rate this thread has, this might me a good option.
Actually people already asked me how to disable this feature because
they saw no use of it.
Being able to delete encrypted files looks good on the feature list but in
reality it has very few users but causes confusion, IMHO.

I propose a new fscrypt_operations flag, FS_CFLG_NO_CRYPT_FNAMES.
If this flag is set, a) fscrypt_setup_filename() will return -EPERM if
no key is found.
And b) __fscrypt_prepare_lookup() will not attach fscrypt_d_ops to the dentry.

Eric, what do you think?

Thanks,
//richard


