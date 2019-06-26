Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98717214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Sj7THSRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfFZNTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:19:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33045 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFZNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:19:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so3369600edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uWimTsy2viMAlcQt3nQShnKVZxeJZ1kUgkedqDnILjw=;
        b=Sj7THSRqxrGnJqHJgt70gePvcrUdNhMDVP4KQK3sLtAWlkDbLD7V8T9bb4kmt4xTci
         5PvH4dqLAFqiC4+Xx7zt+/f3tpF9b7dmVsfp2jf2jo8lNZup2ypx6+xxpRgIJcdih07v
         RKLBg5Qk0ZRum0TpILqE5eBXUBVuXICqFK47AmfGsM/JndpN8LKU+QeMRN7K5iiRrsy0
         4SctX2giUONNVdh6XIVGBJhX82P+rCIyHNfwsEdjvH+HOLT9lp198DekskRybC7SS37M
         lHLlVdFUxEDyBU1z6Q2e14vgyUQIBEujx5ilY+l0ofzUREgYrVBvNRJfWgMUYdxMaEJD
         N/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uWimTsy2viMAlcQt3nQShnKVZxeJZ1kUgkedqDnILjw=;
        b=pT304AHDk0637SauSfq3nwMmbnig5WstKJ8GHt0/HVzRaU4QD8I393VLHf/oVPUWKM
         1MUSKVshDxf886KpJNIKZrnN3WwR0klsEoXX7/wGUtYfZFkwq82LBl5+fdTVOEuDC/5M
         7Uk0PnRO0fSc60emGggHgjBgCpsdaJ3RNm1m1h8z93GjBnWVYIDW45CjH/Beclkwg0x/
         bziky3UnWZMToNmqTP2yTw+yfO03aAnqCwQEtRbT8oLFzUHGCZwZxxEnsZcX1UvIKGYH
         lbbN7YPhbIg80rXUs7j/CD3deW4x+Sma5PUtAVuYVfdhgshD2EnQN/4UfmV//cK9ca3n
         yazg==
X-Gm-Message-State: APjAAAX0qVpYJ5LnxmJyGtPdFnHDQxt2Iht+EmLANwl1Spv8TO0NyGty
        0X0vkE+u/7GS02M5DybeEVxOjA==
X-Google-Smtp-Source: APXvYqyErzt0sjZ4m8QcefX7GiGvtMUQMfnb1axdznmSoz1mvR7CxWpJkmiTH88DBuuioxVm5QTy8A==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr4033712ejw.52.1561555146108;
        Wed, 26 Jun 2019 06:19:06 -0700 (PDT)
Received: from brauner.io (cable-89-16-153-196.cust.telecolumbus.net. [89.16.153.196])
        by smtp.gmail.com with ESMTPSA id n15sm5744325edd.49.2019.06.26.06.19.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:19:05 -0700 (PDT)
Date:   Wed, 26 Jun 2019 15:19:03 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
Message-ID: <20190626131902.6xat2ab65arc62td@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <20190626100525.irdehd24jowz5f75@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626100525.irdehd24jowz5f75@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 12:05:25PM +0200, Christian Brauner wrote:
> On Mon, Jun 24, 2019 at 03:08:45PM +0100, David Howells wrote:
> > 
> > Hi Al,
> > 
> > Here are a set of patches that adds a syscall, fsinfo(), that allows
> > attributes of a filesystem/superblock to be queried.  Attribute values are
> > of four basic types:
> > 
> >  (1) Version dependent-length structure (size defined by type).
> > 
> >  (2) Variable-length string (up to PAGE_SIZE).
> > 
> >  (3) Array of fixed-length structures (up to INT_MAX size).
> > 
> >  (4) Opaque blob (up to INT_MAX size).
> > 
> > Attributes can have multiple values in up to two dimensions and all the
> > values of a particular attribute must have the same type.
> > 
> > Note that the attribute values *are* allowed to vary between dentries
> > within a single superblock, depending on the specific dentry that you're
> > looking at.
> > 
> > I've tried to make the interface as light as possible, so integer/enum
> > attribute selector rather than string and the core does all the allocation
> > and extensibility support work rather than leaving that to the filesystems.
> > That means that for the first two attribute types, sb->s_op->fsinfo() may
> > assume that the provided buffer is always present and always big enough.
> > 
> > Further, this removes the possibility of the filesystem gaining access to the
> > userspace buffer.
> > 
> > 
> > fsinfo() allows a variety of information to be retrieved about a filesystem
> > and the mount topology:
> > 
> >  (1) General superblock attributes:
> > 
> >       - The amount of space/free space in a filesystem (as statfs()).
> >       - Filesystem identifiers (UUID, volume label, device numbers, ...)
> >       - The limits on a filesystem's capabilities
> >       - Information on supported statx fields and attributes and IOC flags.
> >       - A variety single-bit flags indicating supported capabilities.
> >       - Timestamp resolution and range.
> >       - Sources (as per mount(2), but fsconfig() allows multiple sources).
> >       - In-filesystem filename format information.
> >       - Filesystem parameters ("mount -o xxx"-type things).
> >       - LSM parameters (again "mount -o xxx"-type things).
> > 
> >  (2) Filesystem-specific superblock attributes:
> > 
> >       - Server names and addresses.
> >       - Cell name.
> > 
> >  (3) Filesystem configuration metadata attributes:
> > 
> >       - Filesystem parameter type descriptions.
> >       - Name -> parameter mappings.
> >       - Simple enumeration name -> value mappings.
> > 
> >  (4) Mount topology:
> > 
> >       - General information about a mount object.
> >       - Mount device name(s).
> >       - Children of a mount object and their relative paths.
> > 
> >  (5) Information about what the fsinfo() syscall itself supports, including
> >      the number of attibutes supported and the number of capability bits
> >      supported.
> 
> Phew, this patchset is a lot. It's good of course but can we please cut
> some of the more advanced features such as querying by mount id,
> submounts etc. pp. for now?
> I feel this would help with review and since your interface is
> extensible it's really not a big deal if we defer fancy features to
> later cycles after people had more time to review and the interface has
> seen some exposure.
> 
> The mount api changes over the last months have honestly been so huge
> that any chance to make the changes smaller and easier to digest we
> should take. (I'm really not complaining. Good that the work is done and
> it's entirely ok that it's a lot of code.)
> 
> It would also be great if after you have dropped some stuff from this
> patchset and gotten an Ack we could stuff it into linux-next for some
> time because it hasn't been so far...

And I also very much recommend to remove any potential cross-dependency
between the fsinfo() and the notification patchset.
Ideally, I'd like to see fsinfo() to be completely independent to not
block it on something way more controversial.
Furthermore, I can't possibly keep the context of another huge patchset
not yet merged in the back of my mind while reviewing this patchset. :)

Christian
