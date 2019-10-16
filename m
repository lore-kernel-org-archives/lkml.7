Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FB3FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DF62168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="eeOw7gMd";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="FZtT2DgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404904AbfJPPTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:19:52 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:2162 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731530AbfJPPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:19:52 -0400
X-Greylist: delayed 2068 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 11:19:51 EDT
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GEfsdp126517
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=Z4cb3+GRXA9EqnJmXpWc8AtTCxFf8v08NwzkNafzhnA=;
 b=eeOw7gMdwRVxg7ksrGYu1MBX1C/Vo3u8vJ2ROJyF28UNw2PX/IH5BId1U/XQguclm758
 YEh7I1Ah5Q2JuVhVMv+bCi/Twd1U4kowlclW1PvPiBTM+kBTnDVKg3tMGI/b22Mgluc5
 ZR8/xqgl0VSCDkSO5FrD0DCRHanRloFvEqwlbZhcE9PQUktWryRem1+XasSUd/XrSJMr
 KZKqlgP+W+kIe8ts/SxT0/mmysr6atlLtFcxwCX8EeWvIbssCAqB87o/GjM+wFD9y4/x
 KxHW/GVnNYM6oNIsfCLd8lCoR+3dcDsRhUYfImkg1EoFxxEki1shOY6Jam26qZqlqJJl QQ== 
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2vnp4w3ur1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:45:22 -0400
Received: by mail-qk1-f198.google.com with SMTP id b29so2927250qka.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z4cb3+GRXA9EqnJmXpWc8AtTCxFf8v08NwzkNafzhnA=;
        b=FZtT2DgPvEk1dkdNAE/kX2k6ChkotaFixMGtcRbkpI1FXXd4CdCa7q82FdboZMcjus
         4tQO6+ls9zVGEfZZEdhmiTKa8FKKfZ0euojGxBQ4ywgmccynSf55I0PrvObiXBoKSN0O
         OcGsSuTN/8FNOTzndxikMia8wWCu8TmstMExVTXTdIFG11cAZQB0I5hZyQn411CUyjFb
         i/e1z52/FXzPWFjcq/2vP1+zymZRCzTYtA3mPzXi1sjY//dFmh6U50ynfuPvMxTgYDQk
         Vopum7uId5rLepOnzqpiYDmyJRrFQOzTtxXqkdxHaMpXOKm6FC2Y4p4rd4YnAtvEXb9i
         LRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z4cb3+GRXA9EqnJmXpWc8AtTCxFf8v08NwzkNafzhnA=;
        b=VEKef6Rs6V35lX58vVnXIyZx/zNJle86tkl2rIE+Yzssxvs2SQk9rK+tgDb1la0hBl
         bXcR6sCM2oZCzEaWLCUCYgdUxd2Mj7D1TlvmNXRhbbQl/pwyVdEoPMxQhVIlN9axGKnc
         yYurcTsAQLRiK5LmJfVAUEu/7TMdNPNP4UlLUSS7euCwK2ujjFGrz+Aia/du9/LN7oLh
         NeXR4Ad0ZtbV9F3UZj1kCk2tw7HxZxFSt2ODnSBgqopTtdjiE3+vzyJ+a49KvXQBVepB
         5CquGbcq0hAX+P9VX7ZrcvOc7bw7+bEuIOs5cuBr8X5UJey/Pqezx3CPwX3xpHSa1Jkd
         euOA==
X-Gm-Message-State: APjAAAWvraC8bnUh50t8N9ZR6B1El5p7HhcsebXYOM62YjBEM/TqdXLa
        b7KWql7GEJquLCcJiXmJLTKYfeLw9gnsMuR0Hc0jMhYQJ6d/wdnkF5F3Pnn9jgKnc73R3o6vvsz
        akNQN1o5j2k4PC+Maoad4QQs=
X-Received: by 2002:a0c:eda2:: with SMTP id h2mr41542109qvr.190.1571237121331;
        Wed, 16 Oct 2019 07:45:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwthW6i4sYOEjqqa1DXH6trpqn8KkEK3rR31znEaiBCZutvDbhx1JX7Db1PsHhjbjJyGnuUmw==
X-Received: by 2002:a0c:eda2:: with SMTP id h2mr41542092qvr.190.1571237121103;
        Wed, 16 Oct 2019 07:45:21 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-148.natpool.nyu.edu. [216.165.95.148])
        by smtp.gmail.com with ESMTPSA id d127sm11208279qke.54.2019.10.16.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:45:20 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:45:19 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mrjm34jdre4iu7ux"
Content-Disposition: inline
In-Reply-To: <20191016111009.GE13154@1wt.eu>
X-Orig-IP: 209.85.222.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=7 mlxlogscore=853 impostorscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrjm34jdre4iu7ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Willy, Vegard.

On Wed, Oct 16, 2019 at 01:10:09PM +0200, Willy Tarreau wrote:
> Hi Vegard,
>=20
> On Wed, Oct 16, 2019 at 12:22:54PM +0200, Vegard Nossum wrote:
> > (cross-posted to git, LKML, and the kernel workflows mailing lists.)
> >=20
> > Hi all,
> >=20
> > I've been following Konstantin Ryabitsev's quest for better development
> > and communication tools for the kernel [1][2][3], and I would like to
> > propose a relatively straightforward idea which I think could bring a
> > lot to the table.
> >=20
> > Step 1:
> >=20
> > * git send-email needs to include parent SHA1s and generally all the
> >   information needed to perfectly recreate the commit when applied so
> >   that all the SHA1s remain the same
> >=20
> > * git am (or an alternative command) needs to recreate the commit
> >   perfectly when applied, including applying it to the correct parent
> >=20
> > Having these two will allow a perfect mapping between email and git;
> > essentially email just becomes a transport for git. There are a lot of
> > advantages to this, particularly that you have a stable way to refer to
> > a patch or commit (despite it appearing on a mailing list), and there
> > is no need for "changeset IDs" or whatever, since you can just use the
> > git SHA1 which is unique, unambiguous, and stable.

I wonder if it'd be also possible to then embed gpg signatures over
send-mail payloads so as they can be transparently transferred to the
commit.

-Santiago

--mrjm34jdre4iu7ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl2nLP0ACgkQRo8SLOgW
IpUWCQ//UFA5stuXzMxzWIKHQD+H0TuHkdaljhkWkD/PJkKg38VK0qyxCwqszoVd
wRfV3HZa/hoPkY6pnoqIm+VfqbuEnZ5K93I7mGvsKnY9lAOh7GXYjETV62XN0sT7
goQPqxoBM+a9hEBYSccYARaq2EGmDHojhEYJjLIR2br4XXMn+Mrd0VQ90Kph2ozn
WwwoBeqNQaA2gH2fBeYmWKfpuY+0yIRxQfX2gflOx7IDVQAm9NiPqV2FakfZ5Kq8
W8QhGRIpDvIIzmqpGpuETPBtXt/eABENOyoa+E8iFviEM471N6ww3PVQAD6ZJ9k+
LofGz4XhiNOgAHWRKIh4v6zYZgxXfXtIojAZLDR2TGSrfWDj4l9EJ0nNNI2pYspV
1xFkCYEUwoLORs1BLo1Zn2mO4XhiAcsQvrJwRdHvT6MFDDOl59SpQQkCJ77udupr
oCwHoJ4Ew/zHn8y+H7PRoNc9cIqhIUbBTqSJ9lNczOjOaliSBGDQ46CsEfEoT2eT
hxtkOiZQBpLKifJ9oPxGKqD1yPRFI+mNYCkye/yx7BN8Mgo/wqei4ypu+pmdpai8
LF41nXT1flRHt/ffTJSUP4JqpJXH96Kkz+PCUsBQ3x6zf0eMQNaVY59lXdXN44Wy
TYRbjZx4va+x+wkmRl6Z+7WefkAqrL3H2l6XjBvTkXYfZneLuGg=
=LpIO
-----END PGP SIGNATURE-----

--mrjm34jdre4iu7ux--
