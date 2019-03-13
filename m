Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B0C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55196206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCMQou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:44:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52632 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbfCMQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:44:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x2DGidZW006648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 12:44:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3075142080E; Wed, 13 Mar 2019 12:44:39 -0400 (EDT)
Date:   Wed, 13 Mar 2019 12:44:39 -0400
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
Message-ID: <20190313164439.GF672@mit.edu>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552491394.3022.8.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 08:36:34AM -0700, James Bottomley wrote:
> On Wed, 2019-03-13 at 11:16 -0400, Theodore Ts'o wrote:
> > So before we talk about how to make things work from a technical
> > perspective, we should consider what the use case happens to be, and
> > what are the security requirements.  *Why* are we trying to use the
> > combination of overlayfs and fscrypt, and what are the security
> > properties we are trying to provide to someone who is relying on this
> > combination?
> 
> I can give one: encrypted containers:
> 
> https://github.com/opencontainers/image-spec/issues/747
> 
> The current proposal imagines that the key would be delivered to the
> physical node and the physical node containerd would decrypt all the
> layers before handing them off to to the kubelet.  However, one could
> imagine a slightly more secure use case where the layers were
> constructed as an encrypted filesystem tar and so the key would go into
> the kernel and the layers would be constructed with encryption in place
> using fscrypt.
> 
> Most of the desired security properties are in image at rest but one
> can imagine that the running image wants some protection against
> containment breaches by other tenants and using fscrypt could provide
> that.

What kind of containment breaches?  If they can break root, it's all
over no matter what sort of encryption you are using.  If they can't
break root, then the OS's user-id based access control checks (or
SELinux checks if you are using SELinux) will still protect you.

	       	      	  		      - Ted
