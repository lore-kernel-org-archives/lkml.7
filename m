Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168EFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB51D20838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 11:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UjTPZC8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfL1LbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 06:31:05 -0500
Received: from mout.web.de ([217.72.192.78]:57905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1LbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 06:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577532655;
        bh=E1BK6vUQv8ZXc/sK0REslLgkOUzrVdpqSTNQg6koqQQ=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=UjTPZC8KcCV+s6gGvXvzfxUCexm++CBfLyYma9JqdFojErZs56KN6dzzpCjGKrz/F
         OzqlFtdapZlgaXhAcPYGTR0vqikXhl3RZ9OKRsu9mI2q2gRvO1tWBmOpyRQdm8aKof
         NGcs2wqgIR78x9YcHoM3Ae6FXZQPQdju/xPOTeN8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.3.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MORiL-1ioAaA0NFN-005p0X; Sat, 28
 Dec 2019 12:30:55 +0100
To:     Xu Wang <vulab@iscas.ac.cn>, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <1577438434-9945-1-git-send-email-vulab@iscas.ac.cn>
Subject: Re: [PATCH] nvmem: core: Fix a potential use after free
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <278a19c4-c794-8de7-7cb4-1e1da3b80e83@web.de>
Date:   Sat, 28 Dec 2019 12:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577438434-9945-1-git-send-email-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:0rRpjfdE+4rKlZIO7CdeBK6THX4fbmIoBTpoLDvVsj6JZQbg843
 hENwhCvM2jVCKYUQ/QbRh2GlviFKZzfndmBASTel4GOzRo7v/PWowNksJlfaVbpCB9qgFTN
 UynPqBY3zpjiZaEfxEQhbSCNapHywamS19fXZVpWi3NhYvqYaQo6u1eiG4pUTeRV+SQMInb
 6VhyTKBwG1agFeB/hJkhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YA6wQjWsMPY=:uZiTmNTviztqNBolF0wc52
 t/1i+0j9D1/dIlhW08EbqSXJ1WyZ5ZG7yJ6avL6o17vlx5O0/+oSAm5iYXi4QCQK4yLfXVnjU
 FH8tG+63GBA+PbjXdRz4rSlW78Doo+qvVyjZzN3JTTz5/g97PpNV+TT1QgoBqIKkTbfcl6v7/
 FK0YJobFF/a6ChmSJ+qxAidYVMB9hcjaU3WU8rGwvhcx4H6mMYfhEVxzzEAGto8CUgb8op6JV
 gEpiUQtPs2d1J8uvYVwaQIy8LNOUL0mk3opKKsoyriYKuY1uqyxv3cxn/R6q69kNnYWGYnYk6
 fKU8a5FuzBc8Uwv5hbJ/F5O1dot+JamGWXxiXD6/Z1H6+mNymtl1oRnmT+KDKJS4qZJc6zkvW
 8Bcqec/Kkh9iJANGrO5wltZwne91uDhVZ1/yLTxeQXjipdetMw0RRw0oY0iKX67Ks1PiQUpEQ
 FPb5oOLyhT2rSfOlT+BlVBLV8bU4v8MFAWjJokVkx+Ic2UcdLRyVIpT99COc8rmvA3s2cq6s2
 uSG2LRwLDSuH0KSqvnmj004K51m1v+98sJwKfZMJb9/LLPYOf+5oixvziVvJu/AJE2TWLvspx
 jUUUlELEQt6e9Pf8eMh0Lc60yX9bymq9WQU5+JQ+BB47Npt2P4Rf5HBJ4IpZsl2y7zUSMFqRW
 KnMxCRZZ6Pt9QLzek6ZMZnBslVZzY93F4mFlmkVUljtS8tvnsUN4RtO2mICNb14foUebeuf2h
 Gsi6Z6CjQMO+4ifarBfdKVq34A+UQyKJLxjO9QX+mgcYTFCQZMxm7AY9B/4j7LbDWevpOuCuk
 wEfzRMCFT50xlG3pktuOw2vO3oNCmaROriBgdkpkxA9+FIACaS+otl5qYEfcVlMjblfqJPUav
 by5zUCL0MXBFycGg0Dwkb3Ew3wDEQfYMw+GjF80TaH0yVttBkWr+J3ZVwr7uUGhM8ggSwm5Xq
 Cz0wThc0kwSLOcrltcvpCbUnTLGRgbWYY6j3MA2hbBwF9cqW38tdb3kFKcKlOjDYQX2JMpUU+
 rS4xEKh2Z2CCLkrV/GcIuCu65jB7Gd+J0Xs0MI/KFcs3yeaVpZyp2zeGYnO2iggm1UJdQ2JS4
 kbPQCz9IZMw8RsXqS4yhjfsQbQDu9ZZuYXeBUX6tgjC8bkFxXbdegUvo9OhtkoFN/NfVoj832
 4BunjPF1evTBW9GpY2TYx+Mu3AoTi8CBdND6UYUTmkd7EnWJ2WbvZDTD0QXS67rOoKiiYPlJv
 iiwYZslzGvatdK6EOHzfEL2f0KCJO8WliZEBxFf9Oawz9Nh1+UjMiBe/LQRw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Free the nvmem structure only after we are done using it.

This information can be reasonable.


> This patch just moves the put_device() down a bit to avoid the
> use after free.

I suggest to reconsider such a change because a device reference count
should eventually be decremented before decrementing the reference count
for the module which is managed by this programming interface.
Are you also looking for better software documentation for such an use case?

Regards,
Markus
