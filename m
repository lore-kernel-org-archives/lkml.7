Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689F3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFD02190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RUsW1Yl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfJTOQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 10:16:44 -0400
Received: from mout.web.de ([212.227.17.11]:34333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfJTOQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 10:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571580983;
        bh=neiNXpq2gExAgXOAcUsnHmBM+tC0ymwFnq2XSxyqe7c=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=RUsW1Yl+UUiSOtwQtIuYRD7KrgJhrGS/yKSkmalXSDv7tFdT3SDKnyAtEx6Xn4561
         E0kcd/y0Evxdyg6VbdgGpTsqPAY7mMXzWFQgjjd8F3FLANAHWhNEUkXbYgyYUnx7Jg
         0TC4Mfoo9UjNlNTN7Yqme4eQ8idfxQDZWtGmWfTA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.112.181]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBDG-1ifNZx2f3G-00Puqv; Sun, 20
 Oct 2019 16:16:23 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@canonical.com>
References: <20191017014619.26708-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] apparmor: Fix use-after-free in aa_audit_rule_init
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-security-module@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <83dcacc2-a820-fe63-a1b9-1809e8f14f2f@web.de>
Date:   Sun, 20 Oct 2019 16:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191017014619.26708-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NKPjIAHdAWmE7ymm724jjg8Fh/+QqRUENKgKBemUKxV/mgFbB2C
 c+LbIcr9wWY8vB+2AomoVpNJktj9QQ+65fBFbNIlkfp59SsB9RhgSp942OhzX6Y8hTxZ9AU
 TT1WWSyV2iRf/MswEL4hohNpiRVjG+knnvrc1umH6oSIsT1clGgGtF5EI1EgWZEhm3xrEjZ
 Bu0v2IStBptbQ9AdVrOOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0/XNbgdHIc0=:IMI/5WKmhUbGOA3Q2UUnNC
 fGqyzQxwx+nOlU7yuwSjQt6X1DYYPqbpRDG+bRHl5Q9l+4xIifittfEU03gfUBGgbdnTGqvBE
 QVKHFdaPRl5CWGWdqQrc2RUjoiDdQELiPuPfF7Oiz25LF/XfO1ys8iOvZdQBNWnAPYE9f2a1U
 ZbIG4UjrF0bfr3K7+cr0+xTPtOyfkEvEcoR65bysVy+aqgpi113xcMNvCCJjbkoVZqSyKCygx
 5UD54UvSsB6X3znxeSTeY6l9C8eqLoE0gRO8p986zVzQCb7y2Fba+U46TeMG4z4XDwP+c3eu4
 5av/Sk2Wnv+Gpd5qCLPDmkHdr1lk8J2G8z3tMrdv1bNx6iOIVc5NNhXylGWo9UlvQ0tj53ab2
 guo9pp49FJM5UK7E5aPjjBTa+lYr/nY7x8hAcVj1MRtDoAp7BcLEi4FXFCAnfeknLPe/B6Dv7
 eejSq8R+p/HkNbsDvRITfFf/lPBpuAshRZTECGrErCGTfsW0hVD3M6lSEYHq/TP3OkmPdjn7R
 foImBOr5gIpXOqmg4dcQ8UhjGr/nCxeNUZRY1E305fHn/UZkteHLVlbQq5rr8ApWL6uDK00up
 pZdXh12dRo7Tz4RkchbqrZwnlEEpzorg1lUBiNqqZYGGe5myjXLhwDRukDLMoEG6Yn3HxDyeo
 J/ntOh4YbJcFX4G1WVkkFZ8BNR1Fh52ckZ67hZN7Cjma1wLDeMNdYQB6FRj6qq867dvlxQprb
 h5wi83XnEnlgXCD2GUo5t2+1TxyOj6obkjTascy8Kg2VuIcGBCvHqS6ZThSNPb76/mY9n8O0w
 sjsdKr5yAh29lwf1OWOsmTHlU8ooh4fhW79S0+LCf041gCLM98jBWPH4h2FUbqL8jvIKJa7g8
 QGzNzI5vl6mubB2q+sJLtuPMiBlvi9T/ixVbMJo9q1wK4LZ6cGgpwBOnT7Bka8n5401T6k2S7
 WZsUGNLCIj+FkOVPIGbx/uM5Si0qjEZj+Rluwd4pvaIjmGO6rluajcKY+8h+SQ+1H0xmXPEwf
 pjNRTr4iUaLOhkJ20CLqHi71HoFribs7TmldrvI3YhXdEZFiVqN4GZ1bqlHyuAANj8m7spz3F
 PVvDrj1nB+SI201h7avnPKdiEUa0IYzZ8eR3Qdo3pXwqbt6jPZ9NHKXhfMvB++RBP9BQPx8Zn
 8wPQSj17Sjs77TFHq1PNaMuq2AMz9uZK/XXJrLCLwl7UDSpDHlfufmAk2uRF4jKDm3YKYGrpK
 ck/gBokfLmzbvxVZEiwMHermMaq1mJn9AyBuJXJGjK7KCw9oIN/9c20tVuAI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 But after this release the the return statement
> tries to access the label field of the rule which results in
> use-after-free. Before releaseing the rule, copy errNo and return it
> after releasing rule.

Please avoid a duplicate word and a typo in this change description.


=E2=80=A6
> +++ b/security/apparmor/audit.c
=E2=80=A6
> @@ -197,8 +198,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rule=
str, void **vrule)
>  	rule->label =3D aa_label_parse(&root_ns->unconfined->label, rulestr,
>  				     GFP_KERNEL, true, false);
>  	if (IS_ERR(rule->label)) {
> +		err =3D rule->label;

How do you think about to define the added local variable in this if branc=
h directly?

+		int err =3D rule->label;

>  		aa_audit_rule_free(rule);
> -		return PTR_ERR(rule->label);
> +		return PTR_ERR(err);
>  	}
>
>  	*vrule =3D rule;


Regards,
Markus
