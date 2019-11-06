Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4136C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57192217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="am13BAx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfKFNAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:00:55 -0500
Received: from mout.web.de ([212.227.17.12]:60689 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbfKFNAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573045235;
        bh=07Bw2Tj3CUPiX3AUCgDENllQxMP88jdI1Qiol2W7qIk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=am13BAx/QmAMOS/aud2yIVix+ZoM470bz9dCSaEhTX8zXQ0ZMMNKCWDBPxGZTv2xi
         6ZTbcVv13urXWgyTmD4NCtGI/f4dX26hOZCuq8H2YUi1gIP/aJBBEv4ZD6fqD+EM8Q
         HHo8l83IeHakFK6Uns/IA0gS89LWxOZGNhF6qQdc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.91.235]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj2N-1iPqiu1UOx-00XrYU; Wed, 06
 Nov 2019 14:00:35 +0100
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4fa0e106-2565-8610-1356-4adfba08c0a0@web.de>
Date:   Wed, 6 Nov 2019 14:00:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1ilCJ6Cbh332hRucqhZwQJMJZ1RkL4NE8K00vlwYjTSd6ldwl8I
 V3NatMT2YiAVVPs3He0Hu1E+foQ40omhsdVhClDUKCXdkTzjGHzJq92aG6XTvddu+MSOzba
 WqtQ8r17SglWHNU3cUMlzukZOnm/A4P2iF2pTYdybrmSgExdqBlClJAXVtLA3rNgI5GMpCi
 mHFCdWwDakZeaWeYHZ+JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8ls4ncFDGk=:hpLja4oX+BBoj6jM6IvqDo
 /ouUZg0WeN8KRC2tfleuIBx7gqbqtJaGSpgLN9Bf7phkCmEcRvP9eLWceQWnkHZ9zlnEGLgtE
 BSE30MeV2cjlziLaNBNkopPrws/p0q3n/I+l6iKqsQnfgKuyiJ0Wxq2T+ctoR0BZxYixE+MYO
 mPT5j9V2ey5TNWjv6CMKnRcO+iNdV/VoQeRBmfMim19kzEq/rDdQgP4rbW4n5+Xj8n2WdjT94
 eWmWWVNjBxWcmna6tYhuJst11j8ajbJJ7mzuOyrjFXRN4ioZfXNANELBCzuDonr53XZUg4H4z
 wrglSykEHLNvNFO8xRTjj1ZjqhW5Zc9QBKXYZ6RDw9Ut9CVb3DyMHfXuJq4vQjK4fDsc5u4ST
 P+ZHM5YvGXcHZQO003FgoO3CghaSLFx+XO51QrwGWE4vlzzzGNznfXB2guWGg+dKS8VA/kXH0
 GVpY/ZbVegXvNkjRxbImaY4LLYpqk4QgKycujNqk/DfJi4Xpmpcg+RRBR516L8+bh+BZcP604
 veTAuIaHsGE1/Bh+oBrhMt+CI5YnoQ8cWfPwe9Qs9BJd7HILwrkkImII/YZvdOjgVTVSeEhA0
 0k3d/o4WINUDrr3LMZjDnpPZVnLB4K67LA6nK5JitIhDUCnioSIYU/L1flQ1+8UwdMPB2B38r
 8/7zpmoZGYfNeaDPcMjjdTzaLNlIXcsaLQvCG7iiOzvvZFORdIC/DUFyyD2te0F6e9pXT51tT
 n7f2TyTFlRucROgqsw6G/vY/WftE3/dH2LSP+ZpIMw52BwxEr2HRd4tQosPFFkWf12b+6lQ1b
 y656rQaw16uRl80ThVTeWZSKa9an38Gautmu5dFpM6e5AWVGTRO/3bZI05efDGBmsgK0R9kwM
 LdBBymQd7VFMyylATVTTUKEH/AdI1YQRq/brp0VRUjbbVntFh5SFKbtT61duGDFnBU97jaUeB
 7I5PBxehTbSaoSXIAvyEYyvy3Lj3WlOdGBuWgTFGwkvxin2rPoImYUvonHgEV+DWZmLma2Xs3
 BFuPJqOYZnNIawyJUZcZvDGHl5Kdo0Sh0bchh4wDMz/lPgt5LMPzbFxC9GdcvmFxTgeDlAYKo
 AAbHWXEA6E/zooeQPNQMUXLLiLdNSvXyt39fgS9jwrVPbhU6L0rqzkH2EhB7RhQOJkH2Hzynu
 uf3zunzLnDf4qUX+kfv8APrpizSs25OJolyyTnOJvgMbVRCt5QIP5J01ZcWZD4ziqJhfmwjum
 NgCgadZat2Mm3iArEkDCP8NHqlIrVxHoRU9nZUJw+Q+JCbOpSWCvq1rTtObk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Reuse existing functionality from memdup_user() instead of keeping
>> duplicate source code.
>>
>> Generated by: scripts/coccinelle/api/memdup_user.cocci
=E2=80=A6
>> Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AE=
S cipher key support")
>
> This doesn't fix anything

How would you categorise the proposed source code reduction and software r=
euse?


> and the Fixes: line is not appropriate.

Will the development opinions vary between contributors?


>> +	return !ukey || keylen < MINKEYBLOBSIZE || keylen > KEYBLOBBUFSIZE
>> +	       ? ERR_PTR(-EINVAL)
>> +	       : memdup_user(ukey, keylen);
>
> This is a very poor use of ternary ?: code.

The conditional operator is applied once more in the intended way,
isn't it?


> This is much more readable for humans.

Readability preferences can vary also for this code structure.


>> +	return uapqns && nr_apqns > 0
>> +	       ? memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn))
>> +	       : NULL;
>
> And here you reverse the form of the earlier block.

I kept the previous condition specification.


> Please be consistent and use this style:

Would further developers like to get a more verbose variant for this
software transformation?

Regards,
Markus
