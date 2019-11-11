Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F62C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821512075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="V76qkrar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKJHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:07:02 -0500
Received: from mout.web.de ([212.227.15.14]:58685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573463209;
        bh=TedhGet5s+rR+w3ZzHwm5WogBbCfWmJR1+uJCv+ze6c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V76qkrarLg5FlJ2RE1xSYp/YRnGQINbuJH2eDseChuMDpz9Cm4d2y058uInw+DVPO
         VfhXGDfNUtNUNYJb2reXVCf15w1TD8aDEQLKH2Sto83n4sQjSCAXZB3AlUEiH2TK6H
         P+wbIDax0ZJD6Nq64A4WwVUr9hujbw/4PSnxqECk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.123.26]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3jsn-1hdE3U2cTp-00rFCh; Mon, 11
 Nov 2019 10:06:49 +0100
Subject: Re: [v3] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
 <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
 <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
 <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
 <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
 <c701adc9-dab2-46af-003f-d8a2c47bc0af@web.de>
 <ad1c533d-8e7f-b17e-d9cb-54dd9a7ed012@de.ibm.com>
 <a2dbda2a-1c2f-20f1-6b97-c59dbbcaa7a8@web.de>
 <6de4f605-6f74-a3b6-92d5-c5162cb54a6f@de.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ae4cb7b4-68e7-f989-be4b-1a9df8ce51ed@web.de>
Date:   Mon, 11 Nov 2019 10:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6de4f605-6f74-a3b6-92d5-c5162cb54a6f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ixQ/msTgP5cbcFz+0q0L7ie8tbys5UQsj0eLPdteEk5xPsieihv
 +9f3G0lxtS4PAIInyGb/i4yBJsTrNdbe6LRxNpabN+VyY8eS93LiMEo7K93CD2ujkVoutxo
 3kp21THUgLIGOBxzOU3AeKQUIJWBlVWGwVxWRebBWRuvv+O4n93ECW+s0JlNX8AiZD68e0x
 kZtWIroQ3EWoLj0JuEL4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9x3xXPjDbFI=:Qkw8kE44ASi/BJy0NrqJAI
 ppIBRHomwYoBmFAsBrg2t2i0UX7HffdK4fgM/0uiwohnK0aUzV22zUFqdEwKlTnI+Jx/av1SG
 QFC2y+Kw6p+a1VD4N7oofRKR4EwsxeJRg8EmRwhLo36a71pAYrmTc3n4juQ/FVuL9D8q96Byy
 g+zYHGbf8dd3CZadtEoeGb9MYO0Th2oTIRgW8bsOk+Pdq75r2133dk2D0AjCuOadrV6NF3Lak
 +nSF+CYlJNN9MzKg2iWQdRQuFpiTH1XT33FtWa4+WOLn2iSIfBHF0SmmrSqi1ZaEvgBccWz/f
 6ZRcBPWMDEZsvRgrEaU5KQHxhdZ78M0PvpM6KG+vOxVYfY5CPLDYgLPRA4JNrj6hMJ4GuKeVu
 WCWRbAq7/esEyLmFjauRMKfEUd87oS8O3fqFb4LvfiCFhPHJfXnAb0WQ+lnBOqrfZGynAIg8t
 /mW811f+ZMcuNuMbIR25kvEnMixLAI+FYG4HF+9iCwhKpQ/Npg29VdJGa80/48JUKRAq+ly2J
 IzkEUd7FC9Z6+2egAI/04sZkYuyHzD0Vq+4XseH5oBrrYhZ8+dkOqACpRjJAbFsgLFBzCPCr3
 +fo2KZfdJHP+m1U4Rpuo/PM1QG6wbPawX44pwvjJBImFZYI5QWdLEwxt/6UzFkVIrX5JIz/kg
 n4D4wFfIynpAR1AYg/OVbOnb8Ww6szNCOtuNDx4zh/cGAFai1cwirAHKbxoE/AOkKP86ViwYi
 GaR8SIXRehYcRwXh9ucMafnV0PmP20hxnZ6CpmNbhWgBZb//TXFMDT6mNOEDR2OCg98AsHCMo
 nQqAonGMn4m9IxL/KBEN5T++1dT5cSVfaXSWEUvYdRaibosG4ngkTab2TN94s/EBS1A4MHSVo
 xn5hlbXt9jKUSmSDwMBC/+XNqXhlxGKuisVc8RsooNRg9hK2MS1NbM0tEtIWhrx4rxNPVfn/I
 Pe4iqcZqnQ86z548Y9IweBg5RJraAlCumf6ZSXHS8Xwy1uZaZ3BmHB3cpH4y4R85/D34jGmns
 NrdDBYEJoVbehex+bd28Lp52cgNDUgsj4DbE/p9kiL7Pf2mvOM9c9SCJLbD7MIrekM4lL/Jci
 Mrf0B2lbvi1RnhbhiurvfFtLsnoO69pMWOn6feD2IwNONOLorsIoGx8sHND58twArkxcjkAJy
 9J6HHDroqt8v+ofiLCTHzDomIkGFDbZUFrEZ0ttJCiDKPGlti/3GETZjK47+6iYCgu1ghz8Ie
 dDceg1CTXb7X3mToMvwnp8K7b3526I+K+hQnzOjPaZi77B7NFCWEbyFlKwjw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does hinder you anything from continuing to use the previous known emai=
l address?
>
> Can you at least send a mail from sourceforge address with the Signed-of=
f-by?

Not any more (for a while).

Message filter systems got difficulties with email redirection services.


> The Sign-off is meant to keep track of flow.

I find the provided tag still fine.

Regards,
Markus
