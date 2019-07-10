Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC8C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3DF2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562721363;
	bh=eogznzTSxy6CyZp1JpaUVTvTuXrGK9gAt1Q2cMEy44c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVg+DIf72fk/Z8tZRdL/gvYdwaq2/B7M2G7L286OK1CR5elCiCqUCYvTgWWm+BPMv
	 4t7FBsv06GP5T0OFXKx++oP4lTz6Rob3Tc6fX+uPHzd6LEo1FDGFOP8RTBTHqnHtKg
	 fpkeg6hOAYwz1lPjhQyXXgL2AYpYgP9VvinO8lpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfGJBQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGJBQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:16:02 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0632064B;
        Wed, 10 Jul 2019 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562721361;
        bh=eogznzTSxy6CyZp1JpaUVTvTuXrGK9gAt1Q2cMEy44c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBuXsGKLKC8SMp29C71v/SC7oWt7QPjdzvH4mIXnpeNU4h+NfddiDCQJODzdz1GtM
         WVzxERZ7WMkULxCpfMYLRGRiz37LwiIreTUlf58WYGSzOI+CDp7vNVlJh+9hea7AGF
         7YgMNRx/rKgoLES1V76O7mBum87Jb0G/FgmTguFM=
Date:   Tue, 9 Jul 2019 18:15:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KEYS: Replace uid/gid/perm permissions checking with
 an ACL
Message-ID: <20190710011559.GA7973@sol.localdomain>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 04:58:27PM +0100, David Howells wrote:
> Replace the uid/gid/perm permissions checking on a key with an ACL to allow
> the SETATTR and SEARCH permissions to be split.  This will also allow a
> greater range of subjects to represented.
> 

This patch broke 'keyctl new_session', and hence broke all the fscrypt tests:

$ keyctl new_session
keyctl_session_to_parent: Permission denied

Output of 'keyctl show' is

$ keyctl show
Session Keyring
 605894913 --alswrv      0     0  keyring: _ses
 189223103 ----s-rv      0     0   \_ user: invocation_id

- Eric
