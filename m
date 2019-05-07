Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CAC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8A206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hFP5CqEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEGP1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:27:45 -0400
Received: from mout.web.de ([212.227.17.12]:46105 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfEGP1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557242837;
        bh=0Ljdbi5lhNfckXCBJRgdp57Qvtd+BNpbJiPLRAF4hOQ=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=hFP5CqEPpAOaAj+Hml9VCIxLW9g1lPb36e3Eo71ntoMxDWVj94MuFyGUugNlKJaaL
         YPJ/uD2Llx1Ee4m8r/SVlkfMgeKZVcLybnMNWdJp63BpLCSCSpCMnw04Xubotkp2TF
         sfph/463S6mvnBiWvz+qZ/F8j83dPrgEEPiJHhs0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.89.208]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1gYXbe1nvz-00sysp; Tue, 07
 May 2019 17:27:17 +0200
To:     Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1557216744-25339-1-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH] coccinelle: semantic patch for missing of_node_put
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3a3ad66c-833a-b35d-7d75-32189ca67436@web.de>
Date:   Tue, 7 May 2019 17:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557216744-25339-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KCFvLHl/xjCsY+dNcdbAdPEGbHl1e7I8aslKpFO/A7u8szlMByh
 4p4GVXFP4y1qbOyeYUZ3s0VlSbsoFC4lC/ulSSPaNZ3nfhqx0X6ufsZQpiMHioWSqgwCZPU
 9/ExGDZsycd3jXS1e9kEd1jEwNzSjN0lbuO8ws9fdj+ZxeYQD/bssoAshYOsxI4voBwkaMZ
 pjSAJ2fTPpRlZ4ZQiqkGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:65YM14ctuUw=:RlzYbtRwsknbhFOo6WENNS
 3YkDVbXC3GfNGr7N2/ewGCote/hyUeSC6dkxPODXyCdCiY133bUNOFLrGXX7TQXyMI/rF18LH
 Mwsd67v5+eOgi44q95J3YvbNOOpFMPQKpRwi0k2x9hBDluSoIq59D5MN12zSiEukuc0ZNsfga
 a6a2SbOXfbUlB96EJ2nNt5+tBRFqBpE+WfnNofIxObevBPddDOWjLwaY6uh3157y2qvXWhlRe
 iCpTLZR5LDTP+O/4sexz5NHzhlxqqaf4VJt3f5QEoEkelZ/Hh+42ZKENm91ehJoqLBpLkw810
 hW3Pgyu5pxwarQsbFnXp45jasfN4zgWCvFxpB7EYyXWPjry6kgE1EDCCNCP/tWGe1C8QW0P9h
 L5XVS7lcdHJUiBblXQuY4f4cCjE/NQagY+Jk3KIe4tMVulZq/qcnerhAfz3KrNwCjiKe3eYAj
 VGj5MoisicaDljC7VXxpP6zJA6aLNeuyMefHnt964oJHfq4FGEqVVKdRPvUonyJb5ZtFrbqns
 CHv/hpjuFc3fJ1GD3YgkVSlDnNzJAe6ZIdM8gYEjuZi3nL/Ew1aD+CO2Zl/DUTHlx40gWn02G
 qninFqs5u3aV8hKPnZ574I0fCXX9EcxoR0B5W5cNgLBgNm6Phe0NzMpUouKkS6Vu3XOJ3AvMy
 tpTohK/H1iC8yeomJO4w5/RLbVQXWnudZEvJO1T8pFI0Y54M5frJXlc5w53Tgxh4H2OrMJIHz
 hZi46Tfrj87Ugrk2TSwDWC9vq/De7oIr5KERIdI15I1scf5DY1M04y2/o3dSYQwj3dTcZV8KX
 B3XbMGarE5TIG/5hkMKASEyjde6cdK3Wrx2slpervUUnTBLFVU0Jj/XZLU2xpMMvFetLd+5Zi
 1xZEaKxY86QhADNXSt4jP1hkyxH9EG4vq4SXb01Zp3j+nfIx8UIq8YhrFKNGUwjjuyjhZlswe
 POCVDMUkDug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The call to of_parse_phandle()/of_find_node_by_name() ... returns a node
> pointer with refcount incremented thus it must be explicitly decremented
> after the last usage.
>
> This SmPL is also looking for places where there is an of_node_put on
> some path but not on others.

I suggest to improve this commit description.

* Possible wording:
  There are functions which increment a reference counter for a device nod=
e.
  These functions belong to a programming interface for the management
  of information from device trees.
  The counter must be decremented after the last usage of a device node.

  This SmPL script looks also for places where a of_node_put() call is on
  some paths but not on others.

* Will the word =E2=80=9Cpatch=E2=80=9D be replaced by =E2=80=9Ccode searc=
h=E2=80=9D in the commit subject
  because the operation modes =E2=80=9Creport=E2=80=9D and =E2=80=9Corg=E2=
=80=9D are supported here?


> +@initialize:python@
> +@@

Such a SmPL rule would apply to every possible operation mode.
I have noticed then that the two Python variables from here will be needed
only in two SmPL rules which depend on the mode =E2=80=9Creport=E2=80=9D.

* Thus I would prefer to adjust the dependency specification accordingly.

* Please replace these variables by a separate function like
  the following.
  def display1(p1 ,p2):
     if add_if_not_present(p1[0].line, p2[0].line):
        coccilib.report.print_report(p2[0],
                                     "prefix"
                                     + p1[0].line
                                     + "suffix")


* Please move another bit of duplicate code to a separate function like
  the following.
  def display2(p1 ,p2):
     cocci.print_main("Choose info 1", p1)
     cocci.print_secs("Choose info 2", p2)


> +x =3D @p1\(of_find_compatible_node\|of_find_node_by_name\|of_parse_phan=
dle\|

If you would like to insist to use such a SmPL disjunction, I would prefer
an other code formatting here.
How do you think about to put each function name on a separate line?

Can such a name list be ever automatically determined from an other
information source?
(Are there circumstances to consider under which the application of
a detailed regular expression would become interesting for a SmPL constrai=
nt?)

Will it be influenced by any sort criteria?


> +    when !=3D of_node_put(x)
=E2=80=A6
> +    when !=3D if (x) { ... of_node_put(x) ... }

I find the second when constraint specification unnecessary because
the previous one should be sufficient to exclude such a function call.


Can the specification =E2=80=9Cwhen !=3D \( of_node_put \| of_get_next_par=
ent \) (x)=E2=80=9D
be useful?


> +return x;
> +|
> +return of_fwnode_handle(x);

Can it be nicer to merge this bit of code into another SmPL disjunction?

+return \( x \| of_fwnode_handle(x) \);


Regards,
Markus
