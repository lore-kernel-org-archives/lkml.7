Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB18CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB021872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="p67MYo4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbfJVI1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:27:08 -0400
Received: from mout.web.de ([212.227.15.3]:47223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388155AbfJVI1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571732803;
        bh=VWx2rTrvpZC0RZaMaSTUbJuSZo63JMW4L0AYgqe9ONg=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=p67MYo4vDOx2iE7SXU5Nc7PaQHGeLrs29ySqs2vsy4M+1wv5fXWFn8IBz3eZH+vG/
         Zf52ZgkaY4F0o84g/U0abuIaTLo5Hkh04SfwgXn6fXJ04elrt7Kiwsvx/fZnY5cWND
         xq8pdsAKJSJfch4eFuR+DyBsmQ6PpRF4DGv0uJHM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.150.42]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFL64-1iHH4Z2JCG-00EJI7; Tue, 22
 Oct 2019 10:26:43 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191021201848.4231-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] clocksource/drivers: Fix memory leak in
 ttc_setup_clockevent
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fb5d5331-9a89-8370-1e61-396dd05f291a@web.de>
Date:   Tue, 22 Oct 2019 10:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191021201848.4231-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:77vlY4Vw7J5s2dUjjAW/OdxwC2PIkEjGDthypIiow25JGaqKBhe
 85x+/yAvM7C1nSAJgPT82JafPm4o/U9ZgS8u7Vh1Sml3ZjzlkxsgAJ28oZB5cz/BNe1dvht
 74wR0Kkw8cI/oEbDqcRgbeGnIq43n1f3odgRmEH2mUUj9pYlAFY2I3YCFAi6TWVRDhWjIAP
 G4vUmuLKLNLLVBmSimh3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zwP1lSrkeoc=:0a9XvDjX4WsXajoLmgIJ6r
 Y3aMNKL0C77+YLBRhjwPdHhYZ5Oj/EITbJhcEczNYFW4FHHj1WweCVzkl2qHLQZzFhjsxDMo2
 0sTkcJ1JajwCTjj6F2uoUnTbOcFXBJjFQ79C7ZMziTBocKiQnDiQ6ShLHy0PfhcgTfJC5KeFA
 gsNrEhepUSl6N4SYSCGK6CIxGIvypv3hQGhaaYzc+UFIXq5VdeU+mPQGPsO/PiZvKsBwirh7s
 z2aYZvv5J5LfuscOdpACJWo19vKfYb9ZtFJ5HHzIUhcxlI/fW/EywEkGdSRGX8//YYmVhE4H4
 evsznwReaBMswadQtZO6BPXCiX4OkQRoVmZs/sP+DB/UOWeBJZ78/wC3b4/aWVoBUQj83ObqL
 qHUhQHEuR3K2nAcEWrnQPz/ldnKd4+oKLlYyBu7CKo5iCUluIcdSDbGVCHA/OsaxrpM7g9HTs
 7ge1yNbymoeEBwXAhGtqC28t2fnOf3xQVxUDwhjSQmYE6AsJZhUgNXMKMt3SaT3F/kzmxbAUb
 PHNnNrsa/ba4Wf5NA7H/cIK4cTRNJkyZVdI1eMwlMk5zVhYvNWcjzgWChs+UdGmHKywxgoK86
 M3ZvmfYrws+ZBvRMIYNXtnr7IAZSDDMlsRRtR3tctApngS0x5TgCTtZTPyUitwGtpALjZsUcK
 IYwwKyjq+QE51AnjxQyUbD/INzyh103zPi2IW837b5MPfORdcjLD0CqlZo9JIRmYSJDTGq/qX
 QEPNLhDlZ7HojA6+vXHUiAqZOuCdVrV2dsWEEy71fW10q9Nxz4pPogFdP0lRSKEvQ98xqS/nM
 +8i0hpFQOo7dwIC2IM6QujE5u/PoGRYYbVllRvg3OA2ZQcWGlPdRvEKFiteo8oplKfbDoauKf
 dmUkuhSt1VsbINj1Tqwuuf+UABvZXjb8pxOjTIn+5/+jLhJJybnrtW+fFcrMQhzR7yijLYTwI
 07fIEo6yUT6z9jCbMnsD/sH2MMCI+f2BACu0BKsOcIPRNhPbbjUk6z06+SCbnHdFiS0irpcGW
 X+nH9k10kA0worXOsUqz7/PuLtdmI0H8CSermeau/AKIn2vDHIQBv8LkMghgHxqAJG89uEIe8
 X5lUqeQhGDRzeOH3QJnokiQ1jT670AIXZrdfSkkkG7rb9tYL7kNByAn7l0a62NnyinEcVnaBA
 kUywuRKs7KUh498baUlG6XfOV/wJ/CATOeZPPAIx5UnUB9J9PUtko20K/Rdig67NhS2sAbBLf
 JdofDEwhcvc6JIeH24uDIFb7Tg8qs5u/7qk/OVKL2XMnqJkVkmk6q34I5/0k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the impelementation of ttc_setup_clockevent() the allocated memory
> for ttcce should be released if clk_notifier_register() fails.

* Please avoid the copying of typos from previous change descriptions.

* Under which circumstances will an =E2=80=9Cimperative mood=E2=80=9D matt=
er for you here?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D7d194c2100ad2a6dded54588=
7d02754948ca5241#n151


> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -424,6 +424,7 @@ static int __init ttc_setup_clockevent(struct clk *c=
lk,
>  				    &ttcce->ttc.clk_rate_change_nb);
>  	if (err) {
>  		pr_warn("Unable to register clock notifier.\n");
> +		kfree(ttcce);
>  		return err;
>  	}

This addition looks correct.
But I would prefer to move such exception handling code to the end of
this function implementation so that duplicate source code will be reduced=
.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D7d194c2100ad2a6dded545887d027549=
48ca5241#n450

Regards,
Markus
