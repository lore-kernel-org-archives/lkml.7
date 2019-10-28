Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DECA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDD5208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YzCgp4VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbfJ1IUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:20:37 -0400
Received: from mout.web.de ([212.227.15.3]:38015 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbfJ1IUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572250776;
        bh=QtnCetD729xeNeitMUa344p4nNWm9LknsZvUvsKn3DY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=YzCgp4VWfIPsl/BqIGVcoOSIncJSwGrJ9tfwkvMClXzbn0mDVe3xM9WV5Vxuta09f
         VMj4JUXe+jDrwtpEYtU2+wYdBQmnOhXZVlnBYyIwD2d7BdP0n+l52VAJ8U3L/0CIUp
         1Rt/eIdLTpoC7T1xDbQWwF1xc419KyrfLUSZ22tc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.155.234]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfqC4-1ibBTY2pZU-00N7T4; Mon, 28
 Oct 2019 09:19:36 +0100
Subject: Re: ALSA: pci: Fix memory leak in snd_korg1212_create
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Richard Fontana <rfontana@redhat.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191027191206.30820-1-navid.emamdoost@gmail.com>
 <47c90b48-8706-7860-3b87-30a7bbb726c0@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <49777a3b-1fbf-06e4-b4b0-856105c86852@web.de>
Date:   Mon, 28 Oct 2019 09:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <47c90b48-8706-7860-3b87-30a7bbb726c0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EMbUgTQTVUTuX2M+l3nSZ1pKXOm265SWv4pSxyXfxdSNZsAHDyk
 Mw/9iP6ftBUtI/AC0vMLlNhNuff3GL95ubGkAlYmIZReI6I6ueKAcuf8qYo+E621y7Kh0H/
 ppeWSrZgYzlFW/OdcoXtpLNkf/KISIbg1eOQNndDCPtegIdj2UpTVNZ4cFr8fBV9e5ua9fX
 HIWWc71GW1vozeJrQupKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G/OxIW1A5Qs=:FLYggwabgPNNyYUqr9PfVu
 AmayUGjx9DQKfzaUJVHwfbq1rFUIYeoexWaeQ4H4M+9lk1FDSZQlFLKFsENR4WQZV/cxu0b8E
 Q2H//QJK+NjDJbJIc8oKpB6FEYZzid9LWGDwHPKmf+HLT3Gx37eN6vzRyIfS1AF8EkSxYSd5Z
 P33Vi0zB6HApUcPCKz6XjVz7EGPUmFdz7Uf4aRvXnAh8GeNGsoaPCdcNysOPAhW7/FqZvmFnC
 qDUo5oYPrjg8eNj9lAukxIwVreqghen3zGapS64DIfmLjhJoVv8pjEqBv1JpJBRk7/GdVBKcr
 5V2T2EHGOmUC8gdmAMuYwStTwRMSU58Rup/+/6JgFvfx26PmS5V847ADT+DnHr9ZCBlLhOLkl
 kmwe9HIwObFJcuzzeNJGWZn01KAdEYABTDcbhXocnjEqMUoOYTnl1Nn+ZllwdzEHy4JdPqzcM
 ohPObiMGFLJkhHe6BvVTxSg5zLG8dRoop4amcEmbtD3cf0zL9vzT7Z2ITr69JakDWaUCsgi++
 qzEql6vkQAb72p+z18FFLNGM8Az4ff2bvU/9HH9+pZmqVHA+FiJUarjxvbPFniXydwsr5Giy8
 zLVluJrw5/kQELClFrnhJn5NcabfRHe8dFHIQYaMXo8FXqkjtKiMWxwdZAb3DRprpfQw/ihIz
 rXHMtbBPapXwO4GQYwknEB0JgkBHMJZsr6en0uWJaSk0p5QZBQamcjxscCmVJXkFzhafTkIr/
 Sr8XeES0uDC5hS3STwnRtB/tkvSK0QzJX6oWhiU3SfXZSHaJQ5SXleGBXWKoT3+i35hdaGPxG
 3nAunCZ0j11uZVLoF7UIefg55RlI57Il77ZigZ9nZiL8fh7P1B8UCPM8JoV7gj/h9Kld1IJSZ
 LkZf0+SHTRHu96w93ZU/sad1lNBkcSbqCUvtaPRAVSKHK/OPNpUvmb4vSS/5dkKTRCxqCSjHq
 J9bR3KyLxEHYPTFgIROLOCgBLNVBrPq3bP3cRdpZyLZodIriNgmzReGPmYG2OFRORldbsmA2y
 SXRzZo9kpoOiLpIUczxqhstjw4Fb/dc6Qu3FRuX4dAkN4GxgRYEgckqsXkBbA5nujIt8QTs5J
 lPAGTYDMirUVbmvTUfSnQlGYOzOzFwUyQrwKGWmWFDdXEC+pcB8XD318RWM2MVn8PYEM4bGNl
 +ROQTk3r9FNaNTUicYYsKdw2ISC4La6Y4OoZFI+fGiHeKr6RyXwjbok1A1DbAHg6D/84Al6sC
 06ekspYSo8iy1fUrfAjr+/Tq2lTfo5um8sy7vmse2SCJsN/Uu3Xjqou10ar8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I suggest to add a jump target according to the Linux coding style
> so that duplicate exception handling code can be reduced.

Do you find any information interesting from the update suggestion
=E2=80=9CALSA: korg1212: Use common error handling code in two functions=
=E2=80=9D?
https://lore.kernel.org/alsa-devel/2165666c-69f9-c716-8ee8-f5071a41f37d@us=
ers.sourceforge.net/
https://lore.kernel.org/patchwork/patch/851723/
https://lkml.org/lkml/2017/11/16/193

Regards,
Markus
