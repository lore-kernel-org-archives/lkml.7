Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7747322C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VyJfNmae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbfGYNqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:46:00 -0400
Received: from mout.web.de ([217.72.192.78]:42731 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390322AbfGYNqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564062349;
        bh=HS2CegOvxlPgJ5vXFkqseabejjCcZR/TjDMmIPRn+gM=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=VyJfNmaePf4utHlaKWIY1h7ATlLgnZJcTcG+f6WS4iccOWRwhpsm6/pz07meANl3B
         WXv4vwgCSvD0U+DOKkf2SWzhNObaa1XYv5Nz+ccWdayIzQbdur6Qw6rLLuDbREkK1v
         UiOqyJxY6PibOaOD/qMWYHdks3iPs8+dquKyJbPI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.39.22]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2uj4-1ij1bO3jLK-00scQ6; Thu, 25
 Jul 2019 15:45:49 +0200
Cc:     linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Joe Perches <joe@perches.com>
References: <alpine.DEB.2.21.1907242040490.10108@hadrien>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7e489aa8-95ea-b3b0-9023-ba284212977f@web.de>
Date:   Thu, 25 Jul 2019 15:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907242040490.10108@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ndfrH5CqMIoq3zy1DzunVAspWk0eO8ALJ2w/7vFHXVLxVjrWb/D
 04tDzGk4/U4jHjmAH6zOuBxDQSRLM1VIL2+H+VCHzQpUC2LDUU/oKypCUpnR1MGUE86OP4t
 rBfKn1CvSwj+OkXrWWuq9baxlytv5oy/MebjC5Ht09lT+Iu1hme2CPdO5tzNGs9ngIYX0aJ
 KHrG5J5vn05UYOEvVY3vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a06CFJwBmpY=:xhYN6JaFETn2JWDBRzA/J6
 7QWR8XOwnxi1wH8ydRUaG4pH93EV0KW7ThKuupS+y7hl8lPJqKpHnJHCjSmdhX4Hp8d+JGxbF
 9pwry7UYaZmLp6Yh3fZd3jaCDxWS7hiES2z5BaknBoO1Eb8sd6k9l3h449Ias4OAroMWO8klP
 4lLx7RCnVojtP6F8BmYJK6MP3rI1LsvLQfZdMrj1cm+3AYC8sd7OzrDOM6Bo/ERzkERfGFjEd
 RrkZjhd1RXERfzdyDWZKezK4siwhgk0HplJ6XXO+yFgFQ8RyN1MV7Ta56RuFbGDtsMOMqTpwt
 2YRp2RyusdWVVSmzXaqQXHl63Qu3mPVA4msxZnEUMWSuve2OJSTJxYrv662L/lVOYdIVX7xbo
 IqY2bXiAWOqcbRIpwuxTc7C/c/5bkn9sJpufVscIvmCtc2mSEMigmNJBXVSkal9ZnFeFZ8/pm
 VaYZ9PP8NveZvVCUZrlMeR0W0BKuC5U5CdowQ/2hgUyOssIPt3HwRzboPwDtAKT62+2Jl69wz
 5QTs4bb6AoFHPgBLNe7OXnYm8/5I0aoknLnQ1YlblniTDkVJpokl/NjL5bg0rLaSVxjiHUhhh
 F/FcjIwBB1auew3YbYsVKHVrrc6AzjEvs67Dbrb1+XFkxZI4X43ldclpI56sQCkAYbTAvoSlk
 PqwDDRUHYGxRcVuhEeig+bsgTtQI3bJEysw3hSK4wlTRI66ZxrC+4R89S3to6ieBVnQ2a1Hlv
 Q8uYl08rX+YPAo3bfZYIkz+1QwcF1AXhQDjad2Zw7/p/LxNXljDiZFrRMIH30a4EQak5MDZBY
 SeV2+Jx33xmPFivytRhuZ6vI5HTfs2bfpGLFmPOutvQsy+aA0ukdKTaTJiFOJ4Ey1LrLw0K3t
 ems1fd+4e67sV/oknrKrB2Tls0476hfoSOoiMP+jjriAZhO5A/FxZIZeHKwTR/igXniiSR6md
 OlYlomawS8JSDZPRWP6OX3wir/7UHtjhufYH4PCkT88j5Y/6rUiQlzXgkLTX3lQplVMs/jTp3
 LyfPuKAQs2RGJ+4ZnBeF2qtLso9gXYa6MwUWE89ch9RdV+0UpfiSMDB8y5umK6pOANeDTjhCR
 N+BH16vpmYrvWf532KUzTYQ6N11aT5iQQn/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @r@
> identifier f,i1,i2;
> struct i1 e1;
> expression e2;
> position p;
> @@
> \(strscpy\|strlcpy\)(e1.f, e2, i2)@p

I have got the impression that the replacement can work also
without an inherited position variable at the end.
How do you think about to omit this SmPL rule then?

Can it be nicer to reduce duplicate SmPL code a bit?

Regards,
Markus
