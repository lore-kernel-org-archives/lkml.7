Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB828C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850C62083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfFXIOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:14:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFXIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:14:20 -0400
Received: from [192.168.178.70] ([109.104.35.135]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYvoW-1i1RTc0Q4G-00UvOE; Mon, 24 Jun 2019 10:13:52 +0200
Subject: Re: [PATCH] staging: bcm2835-camera: Avoid apotential sleep while
 holding a spin_lock
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        eric@anholt.net, gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tuomas.tynkkynen@iki.fi,
        inf.braun@fau.de, tobias.buettner@fau.de, hofrat@osadl.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
References: <20190624053351.5217-1-christophe.jaillet@wanadoo.fr>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <c8e5abba-7441-b201-1618-c92dfdfc7b1c@i2se.com>
Date:   Mon, 24 Jun 2019 10:13:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190624053351.5217-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:vvqf8FlBVKwdp6cZb6vSQAVE2D3lZnSKipS/eVDH9d3PZ020dMo
 6h2/VXzfCkh/Uy/E/8fUwSV+PQovkrLoOjpeR2r0WXSiFkznkl+e5kwkp5t5uY2iezT6+sG
 D7gejc2XKkjPlW39HneI77Jx0GRdY8YdR4PHlOiCfTyoujJbgK7Y0nokIBuUL9a8xnyltUx
 WJ4knFYuNX4FHuFqyq9Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Obk7D5rplk=:qRjazcfX39WGiDmelrFWDQ
 /n2XvgMMiyNF7JsOrAePp8mx575muX0KrJ5rnbzuSk/By3VrsUCr8or4+6Ekm6O7DTd1xRe0S
 sNIcUq6mmeQGgvryk53G9xnzwF9KHzKUNrGGp3dD26EyOqo4dajKElbZOiyfQLqTgDH2k8uVe
 67vCdqzDcDtRRvcrC02XH1Nbi+gbjAyq0Aa4+BJIH8+0eRWzRezKoN4em3LbTi+nY2HTakjT0
 ZBf5sNWTVb2TTxdAnNwBEJ6l046vZqgKKBKrdIUXavqhinVfagdR0uKTKOaM/UitwTPdZTuxZ
 13JesgH7Fb9iPFbJ1D/PufKAcse1rBl7IBqa+rq5B2B5G3k3WoBuk+hRzQKCtNkeFmS750JND
 tiQA8FQ7gbu67B1JPvj0N/ZTmRLKWv+LVMvoTaZ6v47xuUmo1+TXeqeOw7l5vADp/kmyjdW5r
 ZkUB+ScbhID7cgNb1aPY5DFvPJtTj4C926Adc+JiBv+FsD1Rrb9U3FYVmL2oC7G6Vg+c0bRnY
 6NFjbUJsqaxboVyFrej91uXI+fOWfsa9lf033vpKiMhUT+RsuE0z4zSXdUUYGANLJY3QN9WkM
 LDEhKsLgwJh57VTy7/6/oDinLY4gmRWKLFDgVkvr+jD3yTvxmAqpz8g2uCR4tuKWbUTbtZm81
 hLg6fXTBkMvVGNAtR6OY0A+D22avSDrJclOfR+7+LzxI0UeG8awFfZXZJfC6iyY7L7nQZYSzq
 p8SYYvr135wQliP+6jYDk0qogj3ObTK6W1/2SV+yPFZ54iPNjNJSctjYfgk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Am 24.06.2019 um 07:33 schrieb Christophe JAILLET:
> Do not allocate memory with GFP_KERNEL when holding a spin_lock, it may
> sleep. Use GFP_NOWAIT instead.
>
> Fixes: 950fd867c635 ("staging: bcm2835-camera: Replace open-coded idr with a struct idr.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

there has been a fix for this, which isn't upstreamed yet. The preferred 
solution is to replace the spin_lock with a mutex. Since i'm currently 
working on this i would take care of this.

Sorry about this.

Stefan

