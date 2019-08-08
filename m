Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C6C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5BF2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbfHHUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:24:53 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58762 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404761AbfHHUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:24:53 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78KOqho012459
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 16:24:52 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78KOk6f005220
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 16:24:51 -0400
Received: by mail-qt1-f200.google.com with SMTP id x10so86486048qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=U3+R9bB+9Zkug9cRZj/lHrIBH929vSDaU4xgx/w26sA=;
        b=tpirVNUBCoZmsYz0eq5Kq4+26BJyywWhamXLJxIhd803Wist4vva7IUcNTzjqjpuds
         qt86ykDtU0FEwSpOABw45arIRNRzVMpZg3JCPidWliqDOSsd+hiuNiH2J7JLMmlrhH3K
         ymrtosSfXpRB2nD0TK3O8qAf2Rz5T1bxr96tiSj8XjaB6krbX3V4E4ZZh0j525ypK48/
         hEMCZFF33ldqtZUng4HeJezImOpKC/lE7rdX4Ztb5A2SgBaVt6VGmbBoUVW8Fhd2wfVY
         qkqmHzXV0ZsR7DF0f80aRCelMs1uCqDT8YzdsOf/8PfT3trP7oWN4D8AT7r8v3LIt7ax
         UbLw==
X-Gm-Message-State: APjAAAWS9C49atIpdRIGC9t3vHTM+RP/PPwumlM6VXwxfFEFUohPNy5o
        Drgs0sKskt5X3+sOYnIft43OdQF3BS0dE9/qyDUb56h1i6oiNhrPf691m5d9l44IMwPnQULxE5P
        z+skz8Q40YChMr9APuT1pxQ48M3HpHBk/ia4=
X-Received: by 2002:aed:2a33:: with SMTP id c48mr14997302qtd.240.1565295886775;
        Thu, 08 Aug 2019 13:24:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHweu14drM9tQ9Pm1ykGFWcrOM2nq4fW7851BW9r7vJKG3u4x2nX2G+ycA7DcEhPA1n9h20Q==
X-Received: by 2002:aed:2a33:: with SMTP id c48mr14997293qtd.240.1565295886514;
        Thu, 08 Aug 2019 13:24:46 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id e125sm39643337qkd.120.2019.08.08.13.24.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:24:45 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
In-Reply-To: <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de>
References: <79734.1565272329@turing-police>
 <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1565295884_4269P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 16:24:44 -0400
Message-ID: <141835.1565295884@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1565295884_4269P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Aug 2019 22:04:03 +0200, Thomas Gleixner said:

> I really appreciate your work, but can you please refrain from using file
> names as prefixes?

OK, will do so going forward..

> > We get a warning when building with W=1:
>
> Please avoid 'We/I' in changelogs.

OK..

> >   CC      arch/x86/kernel/cpu/umwait.o
> > arch/x86/kernel/cpu/umwait.c: In function 'umwait_init':
> > arch/x86/kernel/cpu/umwait.c:183:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
> >   183 |  int ret;
> >       |      ^~~
> >
> > And indeed, we don't do anything with it, so clean it  up.
>
> Well, the question is whether removing the variable is the right thing to
> do.

> If that fails then umwait is broken. So instead of removing it, this should
> actually check the return code and act accordingly. Fenghua?

[/usr/src/linux-next] git grep umwait_init
arch/x86/kernel/cpu/umwait.c:static int __init umwait_init(void)
arch/x86/kernel/cpu/umwait.c:device_initcall(umwait_init);

It isn't clear that whatever is doing the device_initcall()s will be able to do
any reasonable recovery if we return an error, so any error recovery is going
to have to happen before the function returns. It might make sense to do an
'if (ret) return;' before going further in the function, but given the comment a
few lines further down about ignoring errors,  it was apparently considered
more important to struggle through and register stuff in sysfs even if umwait
was broken....


--==_Exmh_1565295884_4269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUyFCwdmEQWDXROgAQKw1Q/+MAX6DFCyV/0hkDxC3oTT08gxrQmWR8c7
Y6J/LXp9OS0eqV/aZM1dX7FUKUhbjQkVAD4FK+gXsncTMl0hArX2oNREiGmMYEr8
8VJSVC9iq7NF4BxfXhkRACwJ1vB18MnTV9VBOjneMNPyV7YxPv2LPiDxdL+JMDWf
eM7X+mELoX5NZyrHTF1d4zMPlDTffSk8zCjvpggM/ly/aa6+GqJZ7DWpyZK0vgUf
qRY3KHMSoL2GNis7PXcho84yOIkJetuZedzsIspHQvrXfRM/uccISGS88aLnFgI7
j+LAy6jfiXKvyHMlqmnJNMDaQ7ZrD5DmLYwHoKEI1CkgbweIvb/1NLPA+bqI8bwh
xvmKWx/1bEJUiCWG46GxF3vTLqBUahqnuqu76siRjnwqtpxPE6ng0sk0lqBYxDgj
3TZnXnZPkarvOXPc0uys7XrpyHs1lqxNy+0kyeF78dSF2g838emPJ+uWGtPMPG/o
myq5ZZWzI8GZBgDPk6ttN07YiZ65OuCdMKBHJNbcOuQxySa0ZaZb7WMFGBG9f0U/
RbjceuMahGu89hwIT32x2ocnO0qEk5zsWY6TKLYZMGg0UlN8aDRymbJSbiG5nywG
pAVdut39YGA7UgyOOx1vfcoN4CcSBKkEbumzemy9hWW09v10l8UFnWhDjt+2ZbVG
OIqUqNEid7k=
=yZkF
-----END PGP SIGNATURE-----

--==_Exmh_1565295884_4269P--
