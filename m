Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60482C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E82C2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paGyFWN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfEWFxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:53:45 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:42669 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfEWFxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:53:45 -0400
Received: by mail-pg1-f175.google.com with SMTP id e17so2382103pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 22:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vsdU5h/JC9pv4aYPKeA7tyb+gDcuPa26p02OCnzHaD8=;
        b=paGyFWN24bYRxA6znxnHSznLozAL0ut2UZKWJjip4oiEtIBrrBPud+5tV2O+XZytmR
         WgIQ8HZs7T3ur4UYNxNojeyzZDHjeO3RUqXGGJh9WnZ2BoXPIcCAExPfmPO1zX7jrvXU
         LMmCiFt6pbQln7tvn9WL3ntLwqbZfVe2IAMrAQ1I9agjpDazRtNKwh2OJ6Wak1JNxS+S
         PzwphHmmC8pxRC3NmYIMTXQ5IdjARjE/QF7moYX6S9+fdpNVOp7f7ZoX5loIQqGyi6OM
         YLo2oixcY+shyCNgCOHjhQrtr2qmFkhyfJbVx0gCJGyZTeKx7PHNISiNXwYkgGRUQBPh
         SyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsdU5h/JC9pv4aYPKeA7tyb+gDcuPa26p02OCnzHaD8=;
        b=LiOiTyOfq854JzJGvq+iBpTwY7XKTEl85OOy7qJ5HOaZchAt/U2HQp0sVOylDNHTmv
         w7oFheX51r8PcX4AUbNsleo7fdLYpFI5mxGzz0QqHvZZAnzSWbsdwRPPDjz33VmYSz6g
         b/KnI5xWbH9tZqdYULt39JTqLq0iFq4Pf4lRk6KWJ982jYG0TSu7QPgagvIn8TYtiejM
         cy0hvBHDacKPrS3SlyfPg1njZaROSYEtz8kdaL4sONfptMbKQzWKZWEV/o9VgqvSwsFW
         x45bDRvAHzxnzpKAAkAGH0ju+MgF8msU9GLQ93aVS9rxltjzP7iHJwIIUD3qi76JKKqd
         sEDg==
X-Gm-Message-State: APjAAAUNuyrDAkzt4aBU5og5NXkpOOETa1YfyYsaNXBhP0lmNlEA8DZm
        lrbVeuUPEQolWH0rxXTqyFz2DE2z7BZT8Q==
X-Google-Smtp-Source: APXvYqyeDaZz9YUJQTVSBO9ROnlxKQdVPA1g1kS+N9W6BG20wZ5ZmgKLHN+CNRrwocvLh7N2zw8USg==
X-Received: by 2002:a63:b00e:: with SMTP id h14mr91601278pgf.321.1558590824444;
        Wed, 22 May 2019 22:53:44 -0700 (PDT)
Received: from Gentoo ([103.231.90.171])
        by smtp.gmail.com with ESMTPSA id i12sm32241040pfd.33.2019.05.22.22.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 22:53:43 -0700 (PDT)
Date:   Thu, 23 May 2019 11:23:31 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
Message-ID: <20190523055331.GA16577@Gentoo>
References: <20190522193011.GB21412@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20190522193011.GB21412@chatter.i7.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Make sense Kai!

On 15:30 Wed 22 May , Konstantin Ryabitsev wrote:
>Hello, all:
>
>It is common courtesy to include this tagline when submitting patches:
>
>Reported-By: J. Doe <jdoe@example.com>
>
>Please ask the reporter's permission before doing so (even if they'd
>submitted a public bugzilla report or sent a report to the mailing
>list). They need to understand and agree that:
>
>- their name and email address will become a permanent, non-excisable
>  part of the Linux Kernel git history
>- their name and email address will be stored on multiple public
>  archival copies of the linux kernel mailing list, collected and
>  managed by different legal entities
>
>With or without GDPR laws, this is something the reporter needs to be
>aware of and they need to be okay with it, as a matter of courtesy.
>
>-K

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAlzmNVcACgkQsjqdtxFL
KRWA6Qf+Oxwa6kXBNelJ+GAEnOseXyo6i53MlFHJaBHqImluJFfkxCbOBCtZ1gaF
Tc6dt9+ZYpatCkx+UuTigC1shcqqULieWFz/Olf/JWfdLvvtLudzDDmyfcOF20QV
YCGOTjTLhxp8EQ4zJqi/fq8/JGrmcHT4JRDifo1Gjhf9fVWaYS7hX8Vjg7qxyupS
F+4Az5t0nbJQaiRbTlWTuRo2jOUIE+mAMQR9jGIz9bS1uylmSPwIXN/m6tKMf07J
K4ayzD9Jc1wOMqfDPxD7EScOzZQYkj2sph20LFuiTBnb/bGUdd9QHLlouT/3B+fJ
/NRwzaM3NmJ0OdoBpgR4DmVxxlsoFg==
=otcg
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
