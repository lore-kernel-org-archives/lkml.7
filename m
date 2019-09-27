Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF696C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8405F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SUVgohEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfI0QpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:45:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:33005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0QpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569602654;
        bh=DnxB2XCmGvJObcSaLlopxB4cyyh+MAVL8+GfZb+jQNw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=SUVgohEG8JLFdtNXYaIPDgzKzJlLO7xSeWO4tdda4nErIJVkfzVuXo9Bn8jT3THlU
         QGH60qfzmCPgSQzcnJJVnAJbODakR2q8tmC8jwWxZAQN67uYU2Vi8eMwAX0FEvbSV4
         aG1xekL/psx7EJFPyCM747e/BZngadqDGpJX/hmI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.130]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1huZDI3TtR-00tQDk; Fri, 27
 Sep 2019 18:44:13 +0200
Subject: Re: [PATCH v5 0/4] Raspberry Pi 4 DMA addressing support
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
 <5a8af6e9-6b90-ce26-ebd7-9ee626c9fa0e@gmx.net>
 <3f9af46e-2e1a-771f-57f2-86a53caaf94a@suse.com>
 <09f82f88-a13a-b441-b723-7bb061a2f1e3@gmail.com>
 <2c3e1ef3-0dba-9f79-52e2-314b6b500e14@gmx.net>
 <4a6f965b-c988-5839-169f-9f24a0e7a567@suse.com>
 <48a6b72d-d554-b563-5ed6-9a79db5fb4ab@gmx.net>
 <2fcc5ad6-fa90-6565-e75c-d20b46965733@suse.com>
 <3163f80b-72e5-5da8-0909-a8950d3669f7@gmx.net>
 <a5073e16-c017-216c-72b4-0e861102c4e8@gmail.com>
 <c7e6ab89-aaae-debc-5f63-2e091efcf76f@gmx.net>
 <197ebc29-2e4d-fa2c-7ad4-1a83ce3f3eb4@gmail.com>
 <5870dc40-331b-d4f1-3eef-e7c08d5326c5@i2se.com>
Message-ID: <714dd32c-1478-ccbb-217b-c6928b94f685@gmx.net>
Date:   Fri, 27 Sep 2019 18:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5870dc40-331b-d4f1-3eef-e7c08d5326c5@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:RmdvOSnEvTVNKHrJdG2Y78+fqqnATlPjmRNHT4KrdANZJeyEa+x
 Awv0OQ+sBgJ8RVjUtemu2zZl/E+lBYF4B8GhETWGCLdt+D7Rzjd+URyTECKkbd7dcOFQFo4
 /cGL4ZC75knf8TeOK9qpRvXc8FxykUKnZAMzgonV6surMlgXaKI/EkViTvQLp8YnfMhy9FL
 M9mqSFpLdMHWszWrk8BTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2R8wyBsDYM=:3zmsBCn9kFPX6ny7AHdHYy
 aXhLcyrnpSCXmXDIFCKxsdX2RcqQ/refDjvzMYyGQBwzWbCioILlPHu6MKFYwUi/QxOpyisOp
 bv2d5YAyWvDE0zU99oXTwJUSMFCGVWIJqVDNdTq2jMQ0whSeVy2yA06QkTBv1wGcd2CtMC+i3
 VSvuMvIWRPJvW1ZN7nb6oo6Fg3lU6OuBVKgeQj8wUz8iNcA8j9klftBGjc+4sSdrSDcjIQ/y2
 teWfwY9T68bq4W+Cn2GX9TaAfo7HPrp/LAK3v0RQjdnQFddbLM0sqbTmd9Ndztpg3CZijn/74
 NAJtt6V/n+UfydjvZye8r/132UhHmrFl/Xc/+pzVRNIVHCzOdCQ0awzzqT1ehIQmhBzPzPSZX
 dVP0L91be/2PeTMbHv1505Y22T8VF1g/bMLIWoxbQmbpAxrARyhzurYQz7SXq9gbxsSC7W7lm
 0cmQV5M6dY8a4KkPLx64bkhgDuqolgpVxqV4kHGKb0MOP2gyoTbDHkegbSPkYkF1JEeW/cQzu
 eOJ5ahyinfcGYM0H3y02xRLONIEmO0YZgB18H8RZO4GF5vDl97TeDDsYuES8hD2bfNM6cqknF
 jVL1lt2lMk6I1QgwnK7+SyHXM9pdLe7+HmOQU08JP+FjiaEHf9Vwb1RIie2bCHnkdfhBIuX8R
 +ondMH2iTivtUVdEimSBbKtnUST9Sh09i5Xgktli4/jhwcorthmU+MtONLJpyWSLAzhMH3R/+
 ZVyFBJg9LtbdCTYVy59htxsydpxgbLhLkVDtApkFxY7c/gHOmymN3VW/C87Gixu8OZE023RE3
 S5R23BNL4cgvUz2rSq4hhGpyk1tO9dVyl2e2OuV1Zyo0gbLgCNE3HyMfOOmllOELfzz04i9U1
 bmwiprFdDFwjsMkIc+9iYgBOSlhyTMFgqfKHNAZA24ST7T2RDcsxAAR4mk/3JvW7RrhTxdqln
 2I5m5lQoRWfteMrQQUAe9QPa1dBQ4l+cXKMiWIbPLoozs81/Ut/GtvzQzg8il0izM6ibz4WEO
 uvkE9LLtDfp3k0eN+In4DjRnl18KxxsUf9g0cahvQI1PEmDqHYqQFyahRyFrZJgncFotV9Zl8
 vo2HqrndOlHR85296DIt+opLm/0+URC3UfOjgx/nsqJbr+PgPyfcHxsipBwPkQ3Qp2iVUsyl8
 q8LoutolkOLWh841jz+TIYA5S7y9yBpNt9ulYlXUlQ9NfJ6haLE2UsJ4y+y9kJAJJenIyXAVO
 7EbytgDnKN54eHJ77/fWkAR+3zNt15pviwEvc1Qr/PaYIwuHWbEJ8Ogv/hn8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Am 17.09.19 um 20:03 schrieb Stefan Wahren:
> Hi Matthias,
>
> Am 17.09.19 um 11:04 schrieb Matthias Brugger:
>> On 16/09/2019 21:19, Stefan Wahren wrote:
>>> Hi Matthias,
>>>
>>> [drop uninvolved receiver]
>>>
>>> Am 13.09.19 um 12:39 schrieb Matthias Brugger:
>>>
>>> So my suggestion is to add bcm2711 compatibles in the downstream tree.
>>>
>> Ok, can you take care of it, or shall I send a pull request/open a bug?
> I'll send a send a pull request and hope the RPi guys are happy with it.

the pull request is prepared [1], but didn't had the time to test
against U-Boot.

Stefan

[1] - https://github.com/raspberrypi/linux/pull/3244

>
> Btw the clk changes has been applied.
>
> Stefan
>
>
