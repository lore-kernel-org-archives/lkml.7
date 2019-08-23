Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD31C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66DA21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=softbankrobotics.com header.i=@softbankrobotics.com header.b="StVUbOT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392975AbfHWIfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:35:08 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33917 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbfHWIfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:35:08 -0400
Received: by mail-yw1-f68.google.com with SMTP id n126so3536767ywf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=softbankrobotics.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=284PWXHVGzRZZdT7XwDUs6v5UcNXYuTeKdqhJJBvCCU=;
        b=StVUbOT7p6i/lwOqImKMPdnepuGo+Mh3UHEAiTBF9v1mUNp1d7rI+fTaF3X+fXvPrk
         qf1cuy9/Ojs8I0XfYe4tZ3ttnEmLoV/GlKofwStnWQ6CblrmgRW8GTp6+uwObpyIUZod
         66xh54lHTkI3LhyRJG1Cf4viaCQ66JgHLT55NUgE96udJoyB6uVdeUT3NHRoNE8Lu33i
         GuWdnJCV8JHhTz+7CrPZ12ArVGvSHhdp8r8M/gJBUQ+9gimvIVCUDaHmgkrK1Bzcztwm
         r9zdNuwwVPzPgv+yG1to9VLoYmCN6Q5eMPah6ZKXDf9tQuMnlDKVLScWJzRLSpHEiGQP
         QDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=284PWXHVGzRZZdT7XwDUs6v5UcNXYuTeKdqhJJBvCCU=;
        b=Cx1krPAosAmXLABxzlAwjlOu9XwBQhHN3Y9m2AnjkoHakFFhVx9Qy9E9e7zQXA2vS/
         j4BBe9hTTnNyNXvBlHHAdSmnpKnKxoXyAkoJX+8U4Ydu1FlDFRqgS7Q3UfXRlHftTsJj
         5T9/mhbdHbUo4i0Vs5BsRczqFQujJOFNJYYHSbLY5ic3+w1bSMZ6y67/aRfRs88GcjpY
         Pyxj5CCX9kuhE5xsUpIYRuLq+zYkAYBAjpJKYARH6bjyVaFn3CuZExVRsdGWYPyUBCBF
         m2c9006gRrbUwcueeq99Wir0mgaz054ocBotZ4cGO4xXlYj7GXTgcdYiuaA4IqOZJRnY
         YQZg==
X-Gm-Message-State: APjAAAWLDOvhVQZWfMV6Yn13hrZ+3ocgH8b6Nnmt2TaOchda90Eo3QVG
        rgOKYjNfdRuvw+aSKBvRxVMmRK8coEdipsuytdRZ8r62leGvMfCP4Nmh/NnoHBZNPEF6f9i77gQ
        hfKHAgW4/kfMyZAZ+Dzu0O5DGOY5sZ5p8aSqi
X-Google-Smtp-Source: APXvYqwpejBzZmLqoKc/cfjdMoWPr24uqlXzkyV/NLLpnkswzwBJZN4amTV9/pauaMkDQNOO4iX6rtt7bxteS3sq9bY=
X-Received: by 2002:a81:4607:: with SMTP id t7mr2425605ywa.246.1566549307154;
 Fri, 23 Aug 2019 01:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190821125035.7616-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190821125035.7616-1-srinivas.kandagatla@linaro.org>
From:   Julien Massot <jmassot@softbankrobotics.com>
Date:   Fri, 23 Aug 2019 10:34:56 +0200
Message-ID: <CADGp=QcVCqnBLQPsd0ccNrT4+jzK3Shjki3xYsasi6wytYs_8w@mail.gmail.com>
Subject: Re: [PATCH] arm64: sdm845: add adsp and cdsp fastrpc nodes
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 2:50 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Add fastrpc compute context bank nodes to both cdsp and adsp.

Works for me, i'm able to run hexagon sdk example on DB845c.

Tested-by: Julien Massot <jmassot@softbankrobotics.com>
Reviewed-by: Julien Massot <jmassot@softbankrobotics.com>

--=20


*This email and any attachment thereto are confidential and intended=20
solely for the use of the individual or entity to whom they are addressed.

If you are not the intended recipient, please be advised that disclosing,=
=20
copying, distributing or taking any action in reliance on the contents of=
=20
this email is strictly prohibited. In such case, please immediately advise=
=20
the sender, and delete all copies and attachment from your system.
This=20
email shall not be construed and is not tantamount to an offer, an=20
acceptance of offer, or an agreement by SoftBank Robotics Europe on any=20
discussion or contractual document whatsoever. No employee or agent is=20
authorized to represent or bind SoftBank Robotics Europe to third parties=
=20
by email, or act on behalf of SoftBank Robotics Europe by email, without=20
express written confirmation by SoftBank Robotics Europe=E2=80=99 duly auth=
orized=20
representatives.
*



*Ce message =C3=A9lectronique et =C3=A9ventuelles pi=C3=A8ces=20
jointes sont confidentiels, et exclusivement destin=C3=A9s =C3=A0 la person=
ne ou=20
l'entit=C3=A9 =C3=A0 qui ils sont adress=C3=A9s.
Si vous n'=C3=AAtes pas le destinataire vis=C3=A9,=20
vous =C3=AAtes pri=C3=A9 de ne pas divulguer, copier, distribuer ou prendre=
 toute=20
d=C3=A9cision sur la foi de ce message =C3=A9lectronique. Merci d'en aviser=
=20
imm=C3=A9diatement l'exp=C3=A9diteur et de supprimer toutes les copies et =
=C3=A9ventuelles=20
pi=C3=A8ces jointes de votre syst=C3=A8me.
Ce message =C3=A9lectronique n'=C3=A9quivaut pas =C3=A0=20
une offre, =C3=A0 une acceptation d=E2=80=99offre, ou =C3=A0 un accord de S=
oftBank Robotics=20
Europe sur toute discussion ou document contractuel quel qu=E2=80=99il soit=
, et ne=20
peut =C3=AAtre interpr=C3=A9t=C3=A9 comme tel. Aucun employ=C3=A9 ou agent =
de SoftBank Robotics=20
Europe n'est autoris=C3=A9 =C3=A0 repr=C3=A9senter ou =C3=A0 engager la soc=
i=C3=A9t=C3=A9 par email, ou =C3=A0=20
agir au nom et pour le compte de la soci=C3=A9t=C3=A9 par email, sans qu=E2=
=80=99une=20
confirmation =C3=A9crite soit donn=C3=A9e par le repr=C3=A9sentant l=C3=A9g=
al de SoftBank=20
Robotics Europe ou par toute autre personne ayant re=C3=A7u d=C3=A9l=C3=A9g=
ation de=20
pouvoir appropri=C3=A9e.
*

**
