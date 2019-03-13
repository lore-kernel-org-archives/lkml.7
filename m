Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465A12054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Z/XLfabz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCMRpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:45:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38136 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfCMRpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:45:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DC7B08EE20E;
        Wed, 13 Mar 2019 10:45:07 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ulLIldqhNckc; Wed, 13 Mar 2019 10:45:07 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 397668EE0D2;
        Wed, 13 Mar 2019 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552499107;
        bh=LmtfLYAn+59FHlpuRFRBSu8OCz1zXslGcFf8/7qLQKM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z/XLfabzFJ9KHNLavr3JPlQPDJVgP7vYTmNlKQCwaHO7PWWjmMT1rWhOeMHCbRWf+
         aROVbOjkDqzc4KA9XIFxLkhfZ4gRiAQh6iZ/IB+sWNXQwY/dMX+kvCFEWzyPYSuFbG
         aDsrsu1/2g3Ypz7Eapxc3R9tP+pc8uQX0xI+7qXk=
Message-ID: <1552499104.3022.44.camel@HansenPartnership.com>
Subject: Re: overlayfs vs. fscrypt
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Date:   Wed, 13 Mar 2019 10:45:04 -0700
In-Reply-To: <20190313164439.GF672@mit.edu>
References: <4603533.ZIfxmiEf7K@blindfold> <1854703.ve7plDhYWt@blindfold>
         <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
         <4066872.KGdO14EQMx@blindfold>
         <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
         <20190313151633.GA672@mit.edu>
         <1552491394.3022.8.camel@HansenPartnership.com>
         <20190313164439.GF672@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 12:44 -0400, Theodore Ts'o wrote:
> On Wed, Mar 13, 2019 at 08:36:34AM -0700, James Bottomley wrote:
> > On Wed, 2019-03-13 at 11:16 -0400, Theodore Ts'o wrote:
> > > So before we talk about how to make things work from a technical
> > > perspective, we should consider what the use case happens to be,
> > > and what are the security requirements.  *Why* are we trying to
> > > use the combination of overlayfs and fscrypt, and what are the
> > > security properties we are trying to provide to someone who is
> > > relying on this combination?
> > 
> > I can give one: encrypted containers:
> > 
> > https://github.com/opencontainers/image-spec/issues/747
> > 
> > The current proposal imagines that the key would be delivered to
> > the physical node and the physical node containerd would decrypt
> > all the layers before handing them off to to the kubelet.  However,
> > one could imagine a slightly more secure use case where the layers
> > were constructed as an encrypted filesystem tar and so the key
> > would go into the kernel and the layers would be constructed with
> > encryption in place using fscrypt.
> > 
> > Most of the desired security properties are in image at rest but
> > one can imagine that the running image wants some protection
> > against containment breaches by other tenants and using fscrypt
> > could provide that.
> 
> What kind of containment breaches?  If they can break root, it's all
> over no matter what sort of encryption you are using.

With me it's always unprivileged containers inside a user_ns, so
containment breach means non-root.  I hope eventually this will be the
norm for the container industry as well.

>   If they can't break root, then the OS's user-id based access
> control checks (or SELinux checks if you are using SELinux) will
> still protect you.

Well, that's what one would think about the recent runc exploit as
well.  The thing I was looking to do was reduce the chances that
unencrypted data would be lying around to be discovered.  I suppose the
potentially biggest problem is leaking the image after it's decrypted
by admin means like a badly configured backup, but unencryped data is
potentially discoverable by breakouts as well.

James

