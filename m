Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F370208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfH1TaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:30:10 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50858 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbfH1TaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:30:10 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7SJU8D8032035
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:30:08 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7SJU311014487
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:30:08 -0400
Received: by mail-qt1-f200.google.com with SMTP id k47so812573qtc.16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=WWW7WkQ7EM9h2Nw/XK0xhQGrzY4/gIDQbxY5oyv/Mws=;
        b=mEIBCv7M61gCErnxANDe6Zlxk8qwSlzbnsIQ+uum/wWirseX7CrU8BXm73IOPP5C8i
         PJ2ihUgLIIoms+N17Cszy2Deh03ivVLQHckzWaB5ZrFwDM/02dyb6I2jLXHhjH08/+wC
         cINA9TScnTiwwCGfru5bL3Ns3aGIbO/CuB1q7pB0PHSSVkPnLs+NrCKLVMWEbhCJxHYH
         pFmFB+AtR3y08+DNl5mbL8WyHXs/g8aNfbdENnQiI8j412gmIxExC/JHCYq/UJNp9vs/
         6eL4uFad85sitjJdLQkuErlcCy5j9Mhfw5vvzUHDR8+l+lNCIaXIoPjYXHvo4A+WeZfI
         HdRQ==
X-Gm-Message-State: APjAAAUfgqiFinrIRU9jFEFIZmze7QNqkDhC2UhtaAuKb8skur2Z0yTu
        QJSmUmvZK/V7uuGmy8lFzMJuJdQXWBSe2nZNnaBfDgu8eiyowY3a05ESWdj1GHpNqB/djw1f7oB
        GmhC2K62PBXCCRG0hj4rJabo3lHGYtutqoqc=
X-Received: by 2002:ac8:2c5c:: with SMTP id e28mr6257958qta.159.1567020603153;
        Wed, 28 Aug 2019 12:30:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzimlreE7q4z4u6OLfGtwoudD0qGMHFO4+Ipo+SEHkkQj5YeFnjYv0q5nl0Y8iNK5fXi8B4aQ==
X-Received: by 2002:ac8:2c5c:: with SMTP id e28mr6257930qta.159.1567020602873;
        Wed, 28 Aug 2019 12:30:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id o18sm86309qtb.53.2019.08.28.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:30:01 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: next-20190826 - objtool fails to build.
In-Reply-To: <20190828151003.3px5plk4tp2s5s5c@treble>
References: <133250.1566965715@turing-police>
 <20190828151003.3px5plk4tp2s5s5c@treble>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567020600_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Aug 2019 15:30:00 -0400
Message-ID: <23345.1567020600@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567020600_4251P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Aug 2019 10:10:04 -0500, Josh Poimboeuf said:

> But I don't see how those warnings could get enabled: -Wsign-compare
> -Wunused-parameter.
>
> Can you "make clean" and do "make V=1 tools/objtool" to show the actual
> flags?

And that tells me those warnings in fact don't get specifically enabled.
(I've added some line breaks for sanity)

  gcc -Wp,-MD,/usr/src/linux-next/tools/objtool/.special.o.d -Wp,-MT,/usr/src/linux-next/tools/objtool/special.o -O2 -D_FORTIFY_SOURCE=2 -Wall -Wextra -Wbad-function-cast

Found the cause of the mystery - I changed something in a bash profile, and
as a result...

export CFLAGS="-O2 -D_FORTIFY_SOURCE=2 -Wall -Wextra"

And -Wextra pulls in the things that cause problems. So this is mostly
self-inflicted.

The real question then becomes - should the Makefile sanitize CFLAGS or just
append to whatever the user supplied as it does currently? The rest of the tree
sanitizes CFLAG, because I don't get deluged in -Wsign-compare warnings all
over the place...


--==_Exmh_1567020600_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWbWNwdmEQWDXROgAQLpHBAAsvfurUruTCbQcjtDzRBtVO67OqU69uoN
274Tlz95DjQjMyZONImT3QYaMo16f65MSmkNoxjsyBHAgSANhU/ZG4dsmFkKn3fR
You9kBjuSIVinxvdbrSqVJ/r5kBPItbbDVq4PaS/X4hv6bF1kjb5q+pkTWUqlUUS
XQG5FnwC/040j8CmC/dFo+49NTCbpT7f2rytF2H3i58DPDbhonsnv16ii++MSAZh
Ba0Tqdn6Ay6sCgd2WSPkge7/RV1ChZm/UhoR9Tb/1USp3ZWSW7365BcxAJksoNvY
78fpVa56jz4thtK/7oeZsWrCbRr+oYxiLLHWKMF8o7tc9orh0iF61DAzusA4Eine
EIi8mZFaMtmGWsJ9o9p5Z1ZM0fUgTlyatmnqb/jp8saSqag3TwoMp39OgzzdNMm+
QNohp4XMN47jdHuKB5qRBw7Ebqwvn34+rC39nWJmlaM1xggDVYuLrNrVWCMSOe8N
Jrnxz5IL6lWiFpcZCbPljLvPN0hTkpuyD0hyyaggrcrdwUGqXTBPVF49se2UR8bO
GTL8KSidHnZ3+oD9hKI4bSKa+TiXjJUbjUW0AYzQ8ws0zWcyhjMWgUQAPO1rJ0Du
4PX5AY528uqoJnfp7Q31K+JDb4wUwZhDaWa+bzxoP8JvFfmCgdH/oz8rTUqsgFcj
p18xqip4Xqs=
=nPp4
-----END PGP SIGNATURE-----

--==_Exmh_1567020600_4251P--
