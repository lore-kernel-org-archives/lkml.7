Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53BC606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C906216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lm08k5m6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfGHPpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:45:08 -0400
Received: from mout.web.de ([212.227.15.14]:43569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732408AbfGHPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562600662;
        bh=0pUynszGTiwe+CvTdyKDl8scMsMcbRIhObXKLVjYKj0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lm08k5m6E1V87wS1lT9p++06UNU0NIFevN5wpAJbbRmLpBzSs8ej+XO0Tc9AgF4uH
         wpe6TYxclWFJFqgbn5GsD7sc8LtVRG1/7/AmD8Qvz6vMxx2lsWwU9KOW2lgVd09CHO
         AzARvbOUe+BSSI55/PtQhfXAHHQ7OTLAEuoJc/RE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.165.233]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9dCJ-1heA2535g7-00CvSw; Mon, 08
 Jul 2019 17:44:22 +0200
Subject: Re: sched/topology: One function call less in
 build_group_from_child_sched_domain()
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        kernel-janitors@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <ad2e7dfb-3323-b214-716e-a6cae41b8bcc@web.de>
 <20190706172223.GA12680@linux.vnet.ibm.com>
 <20190708102312.GF3402@hirez.programming.kicks-ass.net>
 <20190708140751.GA10675@linux.vnet.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <e3ae5bd2-d963-2422-d4f0-131a5d2edbb4@web.de>
Date:   Mon, 8 Jul 2019 17:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708140751.GA10675@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:SmpCSCit4blAu54s1a/FftGyUr8QJeyydlBzzwUXy6tIEQ70Ks7
 9Sn0RSkfbs6T9GzKHm4H/raSqUsC2MlYyukWqLJcnDeMIVd3tr8ti3VYWmkfpa1NdFaCKdf
 zYqO8X69p977Ouxj60Wm5CRHJZCj9Dhf5uMK9CdgnQ4eWHTvMqXZFskv/zLLwFIQ8MvFu5p
 5pSrq4yngqO26DNHDmyXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JlB7OxZmBVU=:ZGmPyqPHb6pxzLzM2VL/Zf
 wpTzH/XAQ3VaLLvsyOgPx24Lxr0oyANGr0T/ZzSHYpkYxq4Ouwyd7lkUeKbUf7NVbbmqw1m0u
 BQR80IYBnx+ctKecJzN9crw4zwIRTKPPoFRbGLpR7vNrJwb8YEZoLsOzqpLzg80bMOmcEcw+k
 bbxqMKQcA/WN6f+nUlXguHVTQfjLhF/IMYkOPqRIMTTTEkdItE17ZfKudAz4V/Vz1+9dgnAQa
 qduOu2GY9Bp7Q75TaORMsq66eRswEd+5bEFg0YS4gbNitkoPLkrjCBjL1ZUzphDH+yGoMgD/s
 NiIGBbEw5vGy9gUjtxdjktklcy2B/yawHpVRpNR0LjivwU8PH8uAjFdwvt+SzkbqEYaCJUc5p
 2IEdBt7JeTNiemPq8XXlbb23GveEA4ICD0Te4Xbn3fV7LMbxrYRv3vlNJAD8PbQyxM8tYVDow
 KRS1lAEm1VSi/jqSGRwt5VuszSk4NoqtWau7Q9XygR2Vp2fPUaY6GKVy9+i4jtYAoHrDwXVcd
 lbBuap/9DMiZPyTLRtwyFhcbYxM4cKJKdxVwCLu6R5YWgCJ0v4+/dLzkE0ciPtQBFZT13J4OO
 UdaT0NIkd5hNecpFR3HjtecxCdAAPeYQ+x5oA36ZZV4T+iZx3rjKsqAUP6ea2fRllouZ2iKVj
 npEfta91kXnPcVIJ5hGeRbGeTVE41gX4yWWeedFUOVZfgbDc8flSufWVAY7h5phf2Ru01vhGJ
 M419c2cab0jDNDMNgLXZK078qQ9Slwkz0FuSsK/ElM/mQ99jsgxtca4bJfF786fgZWP1XJ7ki
 EzRPFCes3JT76ePQqMhkaWE27yb6U9hVQbczbKtADq9IU73SL3wvG0OpzzzF7Uy6EJXYHsro8
 VerU7u6ITyhV23VdGioLy7EQ6+vTNAdouMfS1R5IfmAPCMj1wta9Uslb2No/msAn2sn/fd2sT
 35kTgXHHXfxlIdO/25OfZULEIaBqgNQh8xv+fBcI4kYtokfdqi5mFcqp7FfuUjSQYNJgQ1AVM
 G4+WmQJfpbGBB7/aUsAm6UH2Y1cqDPu4w6aWjvKwfgyf+18f9OGNimgWg+ipYJxzp5OZtk5lu
 AAy8S1C8KuzFZMF6VI1HfAC7pQSaYLtJy+K
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it definitely makes code readable.

Some developers seem to get difficulties with this view.


> I was only commenting on the changelog/subject which says
> avoids a function call which I think it doesn't.

Do you prefer an other wording for calling functions only once
with a selected parameter value instead of calling them (unoptimised)
within two branches of an if statement?

Regards,
Markus
