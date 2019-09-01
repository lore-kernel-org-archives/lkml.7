Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFE6C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 03:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E3023426
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 03:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfIADhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 23:37:37 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51050 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727538AbfIADhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 23:37:37 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x813bZgE000957
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 23:37:35 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x813bU43009565
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 23:37:35 -0400
Received: by mail-qk1-f200.google.com with SMTP id m2so12018777qkk.10
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 20:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=ydhN3Zp44Nu3CzxHTEXAf4iY4jzb23b8YjDdP2BxiiM=;
        b=A0u0LBTmVlFp7mM+wVGs9szuM11r2Y5Vr69RIsluUcCCOmwunJ3K+14Bur7m6WPVD0
         kFqYLnSQOBS0tKYk9P6ITJO7l7zLxJuMQimkQCd3OBZ8vZHlMJOTa3Tl7Re7flduT4EH
         3cQHIV0QHe9BXqtGlVMUomoFzGwZcg6jem29l4eX9O+ZvTlgKMPwWYGDQKmBZgCpXZtc
         WyU0u3znB//0udTFYEUU5/DWqKxFaVRS5YIkW8BE9iETS8q2JEP0uc0qJhWZmeFivmFk
         5HuRRTRzWLkZ+aLlkENmkDULIczjHZvKJiiTjqFG+M/aH7UoZJ/0htVicKcwFtqnkoMP
         JHfA==
X-Gm-Message-State: APjAAAUFcT8pQoy6HrA0h8U35pQfDJk+zVY0qNToKvokvz4NPygOndXv
        B+i3kmD4PcO277/hBg+bdqPmwuerpW2+E8G//veSb4wHvoyEJDqaZHL7vqZlK+tVlcjPu7fD6S7
        uD3aCQTD17QOViJefIu4RikpyIFDu2qlUba8=
X-Received: by 2002:ac8:42c4:: with SMTP id g4mr23192825qtm.228.1567309050454;
        Sat, 31 Aug 2019 20:37:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdbEq5WvB8OWvM4ln+gCz5eDg2qSDFppv92WU5CgIKxhPekUVxbz1sJQpBcWAbWCMyHaActg==
X-Received: by 2002:ac8:42c4:: with SMTP id g4mr23192811qtm.228.1567309050186;
        Sat, 31 Aug 2019 20:37:30 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id n187sm5288044qkc.98.2019.08.31.20.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 20:37:28 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <20190901010721.GG7777@dread.disaster.area>
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org> <267691.1567212516@turing-police> <20190831064616.GA13286@infradead.org> <295233.1567247121@turing-police>
 <20190901010721.GG7777@dread.disaster.area>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567309047_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 31 Aug 2019 23:37:27 -0400
Message-ID: <339527.1567309047@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567309047_4251P
Content-Type: text/plain; charset=us-ascii

On Sun, 01 Sep 2019 11:07:21 +1000, Dave Chinner said:
> Totally irrelevant to the issue at hand. You can easily co-ordinate
> out of tree contributions through a github tree, or a tree on
> kernel.org, etc.

Well.. I'm not personally wedded to the staging tree.  I'm just interested in
getting a driver done and upstreamed with as little pain as possible. :)

Is there any preference for github versus kernel.org?  I can set up a github
tree on my own, no idea who needs to do what for a kernel.org tree.

Also, this (from another email of yours) was (at least to me) the most useful
thing said so far:

> look at what other people have raised w.r.t. to that filesystem -
> on-disk format validation, re-implementation of largely generic
> code, lack of namespacing of functions leading to conflicts with
> generic/VFS functionality, etc.

All of which are now on the to-do list, thanks.

Now one big question:

Should I heave all the vfat stuff overboard and make a module that
*only* does exfat, or is there enough interest in an extended FAT module
that does vfat and extfat, in which case the direction should be to re-align
this module's code with vfat?

> That's the choice you have to make now: listen to the reviewers
> saying "resolve the fundamental issues before goign any further",

Well... *getting* a laundry list of what the reviewers see as the fundamental
issues is the first step in resolving them ;)



--==_Exmh_1567309047_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWs89gdmEQWDXROgAQKZYA//VanZme910x03PXbB6eZJIFNkl0Ii0sHW
AGGKa0skVNf+/uwf0kL25WoaCFjgEFrZmEP+w1yU+rv3aQ8zzconLLsxwEX0V0PT
t7KzGcGHewKMv+56bMSpDE1CIHwwlOIARcz9SpoQ669CuudQbfILkrOW19DqxBYQ
OBBZgdPPd3+jcoYb8EcYl3HIAfoAYn6EWpyo8qjP70xrfl/iICA2AUyZUnSIEHPT
LLyBbDeb0tFNYNHk4/+82OIOh1BglgmHZmTmM8jKUSAAYEINHHRUpoyuOWWXSBY0
3gvjmsooCFUQxsCfVXLjXCwvYZqU/9IlNsWvfGLK+rfwS9Huzx1mSvqsBLp78vN/
63gGH5eR7yvq1f1hPl2l33QTvJCjCnT58OLZU9TlwAleqkSsyDCHj+vtVF8jyB91
r/80bJyfG0CklcVPOsVXF1UkoVdty4V+EHVb3rK9D/UM4z8a8I43xjR1NJf8F5Jm
W8lht0MkT8I+Y6ibapQTg9ZfBpzcyH0edZ0cTbX/4u92EaMVcvx0n8O2uhAxT2GV
WPQJAj/b46xLW39OSbZAxSdLxTth908x49EhzIa5bMMFKFOfCg7Mzu6a4e5elQjP
dTPvjTgNQLBML8I8B8+ZE581WOzRGusKzq7v2//dpKg0NbxEhThVgPG9aoWUmrgX
6wdwmWFjcQQ=
=zNgs
-----END PGP SIGNATURE-----

--==_Exmh_1567309047_4251P--
