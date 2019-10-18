Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429B21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571421631;
	bh=L3zozLzhMTxvIKQ6d0Wn7/JusBBkzGSGTcWZxCpUwVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ELtnVqmesY91llVfji5Kl2FwBZCwr32NsUgoPpTeQDUKNIWu7ISNwwRwDTO9FddE6
	 cNOQqTZIxF6rRRqEg2mSuwrLksg/CEb0izdVUKimOzhOkQTGluaPlGOH+E5pBHRMQI
	 Pkgl3EqmsDixnbo6/LInseqpHyDWIR1H4IAHrhIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410710AbfJRSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:00:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46779 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405272AbfJRSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:00:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so10272413qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3zozLzhMTxvIKQ6d0Wn7/JusBBkzGSGTcWZxCpUwVk=;
        b=EdfMCu4RwaiqCEbwvJ0pe9pZ6LyrloV5VEgKK/Vy8rewVB0KG9Z6eqrMknhSFqCZ1z
         S1SVdHi7ZgTviuWDYQwcQU+KlXbpgM48rK+7NUWJFdIvk+8hFir1VYI8erByGR22+Xaf
         5CVFc8Q53zWmwxfaMRaQ2eDrVfluP+2RV048M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=L3zozLzhMTxvIKQ6d0Wn7/JusBBkzGSGTcWZxCpUwVk=;
        b=uktCQ9YSvx4EB5xMjtcMv1p/2k2672+EsCd0Z5XQq+nQ5LWC4HkTTfeyECxnvqj+dp
         D+PR/V1pVFxXUGgVQJtCbhh7MblDRWA5f0PS2NyMuda1SUUAZQU/c4B6/RPwHGG3cEzs
         NZufqsLb9zX2uWk8tzGx0QW+EsqN8oGDx+EgIYgI4DVD94VoObVDEinPy0/sC6FqRLJS
         7CqqtczjZTPfHJaJ+NZ33RTFOKqj3li+IV/LZpQihCm5Vrw1R4QnYqoBvZI+HMtAjYZ7
         ISRmMowiC8+uOcYRXAzly2dXVB3Zn7JK/rEpvCHnUCxwm6Oi1SQvr5wqTcvGL6eO96TO
         a6Mg==
X-Gm-Message-State: APjAAAU/kd5JD6GDKjZELBhYIbu4E9+iyPCkISinT8M6sv34JymBdTwZ
        5Mm2KclTbgfJiWhqyLcAuCXcOA==
X-Google-Smtp-Source: APXvYqwSjD5sAuLmxmdsh7lJNhjxTrfSDeUnm3NNAHEFVroKyFbsLT9IljlOGdm4f6qN21YIF1d1qQ==
X-Received: by 2002:ac8:38e3:: with SMTP id g32mr11302377qtc.304.1571421628789;
        Fri, 18 Oct 2019 11:00:28 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id x33sm3556947qtd.79.2019.10.18.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:00:27 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:00:26 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018180026.GD25456@chatter.i7.local>
Mail-Followup-To: Santiago Torres Arias <santiago@nyu.edu>,
        Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
 <20191018160343.GB25456@chatter.i7.local>
 <20191018161121.6qe5kkweh4u77gvn@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20191018161121.6qe5kkweh4u77gvn@LykOS.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 12:11:22PM -0400, Santiago Torres Arias wrote:
>> It's smaller, but it's not a one-liner. Here's a comparison using=20
>> ED25519
>> keys of the same length:
>>
>> minisign:
>>
>> RWQ4kF9UdFgeSt3LqnS3WnrLlx2EnuIFW7euw5JnLUHY/79ipftmj7A2ug7FiR2WmnFNoSac=
Wr7llBuyInVmRL/VRovj1LFtvA0=3D
>>
>> pgp:
>>
>> -----BEGIN PGP SIGNATURE-----
>>
>> iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXaniFAAKCRC2xBzjVmSZ
>> bHA5AP46sSPFJfL2tbXwswvj0v2DjLAQ9doxl9bfj9iPZu+3qwEAw5qAMbjw9teL
>> L7+NbJ0WVniDWTgt+5ruQ2V9vyfYxAc=3D
>> =3DB/St
>
>Yeah, the discrepancy mostly comes from pgp embedding a timestamp and a
>longer keyid (+a full keyid fingerprint in pgp 2.1+). Minisign keyids
>are 8 random bytes, apparently.
>
>It doesn't seem like an amazing win in terms of succintness, imvho...

There isn't, but ED25519 subkeys are still very rare among developers. =20
Many have 4096-bit RSA subkeys, and you can imagine how large the sigs=20
=66rom those are.

I want to underline that my use of minisign was specifically for patches=20
sent via email, without the intent of preserving them in git history=20
(which is why in my proposal they are put under the `---` cutoff). Git=20
itself would continue to use PGP signing.

(This also means that we don't necessarily need to make this a native=20
part of git -- it can be accomplished by a combination of wrappers,=20
git-format-patch parameters, and a pre-applypatch hook. However, the=20
likelihood of adoption in this case would be very low.)

-K

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXan9twAKCRC2xBzjVmSZ
bHKSAQCBn6MNi5Y8+QZHCPiGG36Omh8KTlRDxzx2Kbvf/KvM2QEAtcIHs267maE9
dgxYwuJWb17NdZtD7fvmhGvITT7MIQs=
=h6t6
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
