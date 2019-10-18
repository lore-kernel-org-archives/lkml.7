Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3ECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E368921897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571414629;
	bh=L4Rhk1txuMllxJGJBcl7nwjt2jmQPELN19+vNBe4yyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AtoTrh7A1SUelfhg46nGTxLSxG4kDQbju9Awp0bOpqwlao3FZX1287ax0+hsMYDfH
	 9pfw/4FKZuKY47QezGrM3p6ruDPMMvXyArh4dJH3qUQg2hiGtF9LmibaojyTW3vZn2
	 XVuiMXLvtkc92eJHIJndW6dKshd+nGwex5Ifb3BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502371AbfJRQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:03:47 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:33929 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389793AbfJRQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:03:47 -0400
Received: by mail-qk1-f175.google.com with SMTP id f18so5162594qkm.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLp1+uce/82spUwz58lSU9bq+f/LyVwG+zR5ofSPevQ=;
        b=MT7j6VuXBKW/1H3pnSmpNBezwuw1A1g0KfcJDbq4dCocf/Cyf8WYpn4uYIeG7sWAil
         o3jHr3UpG1mEBwip0Ums+C4OSVhlsJHzMgsy2tVFXN949jG7td009fg0pZi19Jl30Lac
         +PtPwdfcXsLohUSjTqcbAezqomPiE3Wjf8AL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zLp1+uce/82spUwz58lSU9bq+f/LyVwG+zR5ofSPevQ=;
        b=Y8zvehyQItIXwHrYW0jzQBtuR0birXpxVFuWi/qeKFxHcoGggIlyzxPUgQxPCVgJtj
         uMJbu3yD9IBiV9+gCkkxBJtGqOL+V3wlicfyBH3tAK2+9oZbbfSKt4bq4CzJL2Ot+uVj
         VfGFE1tdLwJJlBInSy2Ck+TTrgM8k2xfjCSx1vGHEGzxKtHWU99CgscFBM770GHWt+mg
         2ZY/sWTzrrlPptiZ99iXxGO5kfSuPZKnCyaC64jnx43tFGoZyO4wqspPppJBfhMsFvJk
         86IyPNVUWx35LAQ69expjbUQw5sah5GAqNo5l6YKejIHwAUSvhm8fhqL0FYgRW7bIDsK
         jHlg==
X-Gm-Message-State: APjAAAX1tv7ksxHx8NmwZ4GgjOnsyWQp2sOyJxaDXXgTv3rx7mwJRncv
        N+y9T986dmXowi0JMzybMmQdgQ==
X-Google-Smtp-Source: APXvYqxaSFFnCUWDXGSs/4g30alrIcbHoxKHK9VsIwer424Fky63UM5YEWt1Eu3QeIBy1+SXbU8W8w==
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr8948996qke.405.1571414626275;
        Fri, 18 Oct 2019 09:03:46 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id g33sm2747388qtd.12.2019.10.18.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:03:45 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:03:43 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018160343.GB25456@chatter.i7.local>
Mail-Followup-To: Santiago Torres Arias <santiago@nyu.edu>,
        Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:54:09AM -0400, Santiago Torres Arias wrote:
>> Seeing how large this signature is, I have to admit that I am partial to
>> Konstantin's suggestion of using minisign. This seems like something
>> that could be added to git as an alternative to gpg without too much
>> trouble, I think.
>
>I wonder how big the pgp payload would be with ed25519 as the underlying
>algorithm. AFAICT, the payload of a minisign signature vs a signature
>packet have almost the same fields...

It's smaller, but it's not a one-liner. Here's a comparison using 
ED25519 keys of the same length:

minisign:

RWQ4kF9UdFgeSt3LqnS3WnrLlx2EnuIFW7euw5JnLUHY/79ipftmj7A2ug7FiR2WmnFNoSacWr7llBuyInVmRL/VRovj1LFtvA0=

pgp:

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXaniFAAKCRC2xBzjVmSZ
bHA5AP46sSPFJfL2tbXwswvj0v2DjLAQ9doxl9bfj9iPZu+3qwEAw5qAMbjw9teL
L7+NbJ0WVniDWTgt+5ruQ2V9vyfYxAc=
=B/St
-----END PGP SIGNATURE-----

-K
