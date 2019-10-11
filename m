Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4A020679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gLmqucHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfJKONr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:13:47 -0400
Received: from mout.web.de ([212.227.17.12]:60281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfJKONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570803205;
        bh=rlRCiCZokfD2wpo9d9Y2iZdR/neJVbCHqZ/ZCSX/1/g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gLmqucHHK8uOPyuixXvLSTYuiJfJIbnwcuiWbz8/H2RF6VbMBxulsIePyFOYl3XFW
         TC7qvmcGbadnak3wTtccWt6vCdWvtWVDS85LxP3c1DmPtI2bHc1GgvWdhtkpGc+vZb
         kADfvIRSo5offTdhCevpM28mivNCTtFaue348Jvw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYjO-1hqkb10Hgg-00gb29; Fri, 11
 Oct 2019 16:13:25 +0200
Subject: Re: [v3] thunderbolt: Fix to check the return value of kmemdup
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        kernel-janitors@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190325212523.11799-1-pakki001@umn.edu>
 <f2960ada-7e06-33d1-1533-78989a3e1d2a@web.de>
 <20191011133557.GF2819@lahna.fi.intel.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c12d7c9c-8212-ba9b-252f-7dbb61698550@web.de>
Date:   Fri, 11 Oct 2019 16:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011133557.GF2819@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8Tl5aj/yoYC0ydwJjJdNkHEimxh4k9hVG1Pz4cyz2+F0Z5zlQl
 qvTsB9CWwSXFeyZwmmEhUXvraBsaIBldhoeCyoIEzOk+cY8AC9qXY09S8icA5VFEKeNDLaK
 drpt03UXneHDQUODmOBV+CVWLZ9GJfppG5kwfok10SWZV/JdODhO2UemlGjDa0sS3S4EYx+
 nhBBbQjNMT7SgYzona7lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JRop/8wFmVw=:MzZq73HHa1PZGPS7Ufc+Zf
 NE55Kfpemmw7CWv+bNmkgWejMJytkzkLb5h21Z6LaDy/KMErxT73d0s6QUwcaVuk16I+z0y9v
 Y3QxJjgytgCikaVmat5fIyFRADzNp5aK8EnpsW+E44C06PdifybZj00EdDZoHWTFnJbATFYIB
 eLntwLOwMwGE/nJ9wNw6rMMiB8rL8rLRrW3/PolPLRh6PiI8EVFR6CAfhe9t+1XvfzjQ4gTs4
 si3mikDbRa/ETewEgo6p3KaZSwklt8Kk/U+0lK3rCx0yU2bKKnnba5uUW3XCnD56EOIMuTUlQ
 HqMhhp3209G9qxbTDzm/BANAWaffKUQ6oPR/Hg5ZZl5Vk/0MDXiGvByRWrhwtzMyByvGEmVwB
 tszpNLW8iFNBRw5yc/PyMcKAPrVQDmL/ZD7gv1IIRhjXXM3DnAmDgI7Il1JUEu5OGAqgG0Rwh
 R5f2PZJ0diwMo08dHN1+b5GQ51Wpewq1du5cr9IFnQIHSj9Pjt0Knpsj2RlZwWmN2NvqzDr89
 xq/A6l4+f5dMQp3F6nZf1QCCQ7jieOASxWKFBUiT0msMTqpy0UEChvxlQtvrYqDC4ew8TuHuv
 J+dYQPG0JEzkUQ3QxBFSIC2twapFgVmGOIdFma6gvrt6om9w57dywufsuABPeNqd05hjpQxwW
 nAQWkQ30+bukPo5ruRK1HYf96sJH6DtLlv2bF4/qayZV5VWo397j6402DVfi4UmAUPXMFh9/0
 t0GQXJhinX+CuYl4twAwzCZPZuhCErFKU14o5AS3YWv5FT+mCWi0ulxkbVmEAWNA6chMyxdXd
 g+aXSMZcHuE8mamZFbG7mw0BGis5doCTv34fAk8OkHoWVlBBqkfkGnKKVuW6od/vnzRi4Z1xI
 uaKJRzvhEgEGSfVEhm6xrgcEjq77eKpw3nufCV1vQoS1Sc03BF0fyZn4IMboqeUhQR1QzBXSQ
 2sU6Mx5uy9t3dveXVIjfKBVDPtwVSFV9PheOqTDK0AmwswQfHU9U6nlySUnIWveHYQBaOr3b7
 B2aE6Ok5LENwBhbg4L01OIWiMU/mNVkvaPJKaZFEwSXnQTU0vWEKxJ3ydx+FJc0IDllWO9Rsl
 oU4X+2/K90jSU4oL/rc/tpmHJE5f0VhJt0q4+bq5cgIxO2EcoqLsV3FchxQKC/e3CPImE2Mll
 VgvgPRQbzm/Y2UYbPOZvAimnlKxDRhvVH32rakQHEjTpJo2t8TaG95ZkT4L/TGkhoPZr8glH6
 t+vMjezn7YX5LRrhobOU0dXShUyorrG+ZG+ZG0WcVYye8cUiVdyUwHZBdzMI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This source code analysis approach points out that the implementation
>> of the function =E2=80=9Cicm_handle_event=E2=80=9D contains still an un=
checked call
>> of the function =E2=80=9Ckmemdup=E2=80=9D.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/thunderbolt/icm.c?id=3D3cdb9446a117d5d63af823bde6fe6babc312e77b#n=
1627
>> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/thunderbolt/ic=
m.c#L1627
>
> Right it misses that.

Thanks for your quick feedback.


> Feel free to send a patch fixing it ;-) Or I can do that myself.

Would you like to reconsider also the addition of the function call
=E2=80=9Ctb_sw_warn(sw, "cannot allocate memory for switch\n")=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D9e208aa06c2109b45eec6be049a8e470=
34748c20#n878

Regards,
Markus
