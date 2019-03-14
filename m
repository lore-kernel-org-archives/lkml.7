Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8406C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678B4218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Xom1t6C6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfCNXPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:15:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37694 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbfCNXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:15:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A6CF08EE1EC;
        Thu, 14 Mar 2019 16:15:13 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uUFEi_7wNkui; Thu, 14 Mar 2019 16:15:13 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 07CB58EE02B;
        Thu, 14 Mar 2019 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552605313;
        bh=+sNp9lHnPYGPJkjxRa5mzdQLDF//P9+5EqLB644Xm7o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xom1t6C66vnDHLIL3YMov7IPb1C/Fxwazo/uOtSLjEEaXmS0yD+uItG+am84AWZgb
         r1HTw896/ClCOmPeKPAsvoP30uPuccRkyxmxD8Pnd92F/B3WXdK0DG5XZ4kETvkpUJ
         LJI27Ct6ZWPu8/3AmANDzsM6oHk3Yofg0/HuuRdM=
Message-ID: <1552605311.2571.6.camel@HansenPartnership.com>
Subject: Re: [PATCH 4/4] ubifs: Implement new mount option,
 fscrypt_key_required
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org, tytso@mit.edu,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com
Date:   Thu, 14 Mar 2019 16:15:11 -0700
In-Reply-To: <20190314171559.27584-5-richard@nod.at>
References: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com>
         <20190314171559.27584-1-richard@nod.at>
         <20190314171559.27584-5-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 18:15 +0100, Richard Weinberger wrote:
> Usually fscrypt allows limited access to encrypted files even
> if no key is available.
> Encrypted filenames are shown and based on this names users
> can unlink and move files.

Shouldn't they be able to read/write and create as well (all with the
ciphertext name and contents, of course) ... otherwise how does backup
of encrypted files by admin without the key ever work?

James

