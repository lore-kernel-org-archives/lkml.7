Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5B3206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552492310;
	bh=V/NJfk36W27qYIw42y564bE6MrQVbeuMo2qT6sB3VWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=keg+47EWFEMcJ6rEQD8aewcY9zYjJ25VMgwmRhlZ814WG9aq06lLHfyr3PTe+1urQ
	 9xnozMRO1Ic+UJwJq8Fr1LAAwMd8F+x3Pn3wPlLQhxWmZG1XRbHi9mdVbr3g+ISMmp
	 hmpC47eROXzOUn62rJSzQAiYFu7oBfxMIm0egpBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfCMPvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfCMPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:51:48 -0400
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BDA6206DF;
        Wed, 13 Mar 2019 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552492307;
        bh=V/NJfk36W27qYIw42y564bE6MrQVbeuMo2qT6sB3VWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePRMxzz0w3gIa8Vi+LEOlibLhY5aostdvMPfYzIrS3bCfIWpYNuJC/e6yrIp3td3U
         xJXgKhoAkixW1dfy9fNvN7II7Ao5VV+pug9q5CXsjoRZ0auBBHqznIpnJqAGCei/hB
         fI0Pr9kxEbYXrX/WoNJeoa4+ENPbSJ9MlWRc1yjE=
Date:   Wed, 13 Mar 2019 08:51:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313155144.GC703@sol.localdomain>
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
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

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
> 

What do you mean by "containment breaches by other tenants"?  Note that while
the key is added, fscrypt doesn't prevent access to the encrypted files.
fscrypt is orthogonal to OS-level access control (UNIX mode bits, ACLs, SELinux,
etc.), which can and should be used alongside fscrypt.  fscrypt is a storage
encryption mechanism, not an OS-level access control mechanism.

- Eric
