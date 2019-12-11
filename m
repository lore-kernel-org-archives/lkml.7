Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B97205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLKXeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:34:04 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48826 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726890AbfLKXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:34:04 -0500
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xBBNY2AW005245
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 18:34:02 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xBBNXv13022083
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 18:34:02 -0500
Received: by mail-qk1-f198.google.com with SMTP id 65so210741qkl.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 15:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=GgZ9/WpY1EsIJA67hkylnyuMc7NSV/uYSW4CmhK2QVw=;
        b=FMNdQV+fO2LPqt46+s3+bUblv9A/M1vbqiR5BW391tdl69jQOzvIvRy4wHUdMzlQ/Y
         kj9gf20qqHPe4LwT1hFA9kdafac8YVN8vakpSbuY/NraDzrlfcNJ4hO39FyxAxr56XhY
         xwuLBFWnWtGLx3hzq0ce2ir/MtT5EVsWuRRNPd2ObVXt+DA8+UR/VBJX7GgL9xUiMCM5
         2OvqIbe9H3pWPp6fEe7lJsifF8MHe66nj4LOYYHh1EuLLZSIfZDlkbLNpNTzu/hI3lTJ
         /z19Hn82lYhxPAb3c7movMkC70TCNalO5VlJ+bYmZkqte+wpGI2mWq6GuRhW+P1P0vlL
         +gaA==
X-Gm-Message-State: APjAAAXBQTLb1wtlHrp7UtgcA5xIqHnu2IhdtnVCnTg8tKqeulLM+T5K
        t+nEotdF05v3/JCPYo272G+Thn+veqrHQWw+3vcdRpNAZxc6eDtIxf/hQAKF1pOvAj0HzKW0kcv
        albcABVYJPOTcGHuv2EqAcGWBGDBTZmKkT+k=
X-Received: by 2002:a05:620a:150e:: with SMTP id i14mr5477034qkk.273.1576107236949;
        Wed, 11 Dec 2019 15:33:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwY/0mRUELWpMt3oMyBVeNocs7du8dHd52oVA/lJtho6ZDV6dWQCgj8MBc3kq7XKlpfxFrx+Q==
X-Received: by 2002:a05:620a:150e:: with SMTP id i14mr5477016qkk.273.1576107236616;
        Wed, 11 Dec 2019 15:33:56 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id b35sm1474026qtc.9.2019.12.11.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:33:54 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: make stub function static inline
In-Reply-To: <20191211213819.GG14821@zn.tnic>
References: <52170.1575603873@turing-police>
 <20191211213819.GG14821@zn.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1576107233_8204P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Dec 2019 18:33:53 -0500
Message-ID: <186227.1576107233@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1576107233_8204P
Content-Type: text/plain; charset=us-ascii

On Wed, 11 Dec 2019 22:38:19 +0100, Borislav Petkov said:

> >   CHECK   arch/x86/kernel/cpu/microcode/core.c
> > ./arch/x86/include/asm/microcode_amd.h:56:6: warning: symbol 'reload_ucode_amd' was not declared. Should it be static?
> >   CC      arch/x86/kernel/cpu/microcode/core.o
> > In file included from arch/x86/kernel/cpu/microcode/core.c:36:
> > ./arch/x86/include/asm/microcode_amd.h:56:6: warning: no previous prototype for 'reload_ucode_amd' [-Wmissing-prototypes
> > ]
>
> Hmm, I don't see this with gcc 9.2 and sparse 0.6.1 here.

Were you building with W=1 (so gcc issues extra warnings) and C=1 or 2 so sparse is run?


--==_Exmh_1576107233_8204P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXfF84QdmEQWDXROgAQKUpg/+NTNpAh6zErZe45ojdsox9vnOC1/M9TZM
6CVYQ9dbqonzSM6lLDHhaARA+V39Cn5oz1qGIUdmniIl0B2IurlM/Pfrz/dJCB54
cBuXt61lJl9MqJ6iQFSUMnnpsetvP39eB4J8k1z3yioKfmqH9u88DVSYe5P5vGHb
LwojUodDjQ4VfCT/Aaq2DR8hrCeH25UurXWqrSYBpHIUftqTAY3B5zN2gx04GswM
M1lApQ2KxEx4Vi0CMmIcr2i3jW1aGaSF0aEvgndKQlyWZ6WWauvt6496hbRF4UR8
oHGua7E3Z4TzAzWCmNyL8XpBPX7YmMRyFb1FjT7lFgEyXCpxzL0CalMK6tSVd6+D
sHwl5lbZgJpfxfv27uZC10SmqBqV3qqrEzra0FW8X98TYSnQUptaO7LGOClCbN7h
zg6xr92cAJRzF5HbFciiThXNNw0WtpbaJYu7qMvRNr/+XWT5RO6dZnjVJ5gywtMi
3MJaLdhra2NVmUTWB2n52DbIRJ4JvqHmkMNfBEUtmzEKOmM9AO2f7lhLgc4uNu8r
xnwEQqIQ6dpWPwS3jGyhOXN8d6MekkSrqqwWLzil+ePoWqs3e8wBpQmOQDEmx/7m
/admhkKC+4Jd76dwA0LaKBtjR0donYl3/tpig+1J4AkR34K91NkqIBHZ/9aTVm0j
aVhJ2iZ0ljQ=
=yITO
-----END PGP SIGNATURE-----

--==_Exmh_1576107233_8204P--
