Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5DA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCMS6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:58:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56087 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726272AbfCMS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:58:38 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x2DIwRLl031027
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 14:58:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0460D42080E; Wed, 13 Mar 2019 14:58:26 -0400 (EDT)
Date:   Wed, 13 Mar 2019 14:58:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313185826.GA4685@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
References: <4603533.ZIfxmiEf7K@blindfold>
 <1854703.ve7plDhYWt@blindfold>
 <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
 <4066872.KGdO14EQMx@blindfold>
 <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
 <20190313151633.GA672@mit.edu>
 <1552491394.3022.8.camel@HansenPartnership.com>
 <20190313164439.GF672@mit.edu>
 <1552499104.3022.44.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552499104.3022.44.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:45:04AM -0700, James Bottomley wrote:
> >   If they can't break root, then the OS's user-id based access
> > control checks (or SELinux checks if you are using SELinux) will
> > still protect you.
> 
> Well, that's what one would think about the recent runc exploit as
> well.  The thing I was looking to do was reduce the chances that
> unencrypted data would be lying around to be discovered.  I suppose the
> potentially biggest problem is leaking the image after it's decrypted
> by admin means like a badly configured backup, but unencryped data is
> potentially discoverable by breakouts as well.

But while the container is running, the key is available and
instantiated in the kernel, and the kernel is free to decrypt any
encrypted file/block.  The reason why the kernel won't do this is
because of its access control checks.

And we're talking about this within the context of the overlayfs.
When in the container world will we have persistent data that lasts
beyond the lifetime of the running container that will be using
overlayfs?  I didn't think that existed; if you are using, say, a
Docker storage volume, does overlayfs ever get into the act?  And if
so, how, and what are the desired security properties?

    	     	      	  	  - Ted
