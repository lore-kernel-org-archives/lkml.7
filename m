Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B6ACA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A530820679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZBKWLblh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKBKdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:33:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:38313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKBKdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572690783;
        bh=M4R8iDUyZCi3NlP2LyUvR49oJ78t0lYHUP9msbxWyu0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZBKWLblhNl9vREiDgfhtXMih9z0nUrKlz/QOXKNoTVispFbWdceOa2KBRYVa0v7+E
         ps6DJGMhhVl9owO8C7ybVu/FtDaBU21UGIIxaaxZQndn8cyScItRGSq6MbL6LIDEm+
         5mOAQ6RGIGq8hs7Ng+SLfAtachDdnJeEcOXBqKzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1iHXK51vYE-00AXH6; Sat, 02
 Nov 2019 11:33:03 +0100
Subject: Re: [PATCH resend] staging: vc04_services: replace
 g_free_fragments_mutex with spinlock
To:     Davidlohr Bueso <dave@stgolabs.net>, eric@anholt.net
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
References: <20191028165909.GA469472@kroah.com>
 <20191101182949.21225-1-dave@stgolabs.net>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <394141ee-24c0-0acd-11bf-9b675ee01ae6@gmx.net>
Date:   Sat, 2 Nov 2019 11:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101182949.21225-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:9De/p69L21MsDMU7KGo+H1lP+znQ6F/3jnj2ig844Z3ma32l2FX
 wMKNpkcIhoLlLolWb1z1TyKqiOn2Egq1BJuR3Xs+G2oReA4uLOExlXs5AfoWOgzkOAxBIwC
 WaN4LxEvpXlarAzDaaJZiEe8C2j/At6WFOgaug9lL0xxtn9Sk150gWCZB5Eys+hUSoewEtO
 y3QwDOaG22wBTRHVnV2JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jstjtpsgYL8=:Af2ptEp+NSmbG52DWBszaj
 otpiW046nyB+N1F+n3I0TgOZ9V0hcZvRQvMN6FwSpVRKhJLC486jeL/PH9LzTJL/XYQYCb42Q
 L/8L0KGZIDbjWnb98j9jCIL2iNVVd5y+TgUw3y2JNjWPinnC5PipwLChMDLylts2Tecz0Z44h
 SI0QeKoa/EjJlXFDW+GuI2gp+yiTC0XAq0TKs7uWmmMOzrQuJYRQWqN7y6xRwTW0FPklA9GvP
 eCBKS0BaT/SQ70wSgJAnNDiTdQQimX5vyrYwYRvkN3Y+UI5zg/ZVrFaqXkBFjMkScIwTKKAJu
 3j2CmdbnXDJJ9ciZwO9jwrxICiLV0w2j/tQ2MNrSeija8uXP8H187PfBxnaRY9tkETsX47PQn
 2Cf1h41vQGDUNOwMlLRzhauNJey8RCIXbBm0V/kg6mgYQG9a1Lcok9CyOTl6tldMQ18+m8H+F
 B9TFo7RBsY0eC3o9OF80NYs2ykDTE2eiF9OdwReMKjvu80feMp3Oirt+3qS8aAR5r1dsv7h+F
 kGwCcynMeK8xBgJqSapuRMLADgidnRSm1GD0Lm4Q19LqvmoMkOTj4hteu8G4MBI3JA3SqqQl3
 FdYNwvrnmiJCTBEbnUkJ3/M2fJjooouF/j9/ksScAZKpFQ7XGNVjybUtfOXwWhI9gjs0YuaXu
 hYLAObzXc15by7he0iANas8+Ghsli4TnnTnDQXQT8rm9RFACspxbRokynpObtBJydmci7Pb7X
 x3YHrJEW4T6AYnvUcET4b5e+9h1bEYBb0zhjYi9Y3Cj8UIok46crTonxu7oGZ7eF+qHBQX8O6
 2s7zC1vcii8J5Gc/rx/Djntq4iszspiFb/wgTxzbJZD8oTbjkO7r1AE2G3YzGI0vU5lBcm/Pn
 r9XbHcLRILlvULJrAyJfOSbDFKQDjZzyfxzfZ8ZY6CD33Lt9pyStXgqjnXMoylPPylVxnmFnk
 0iVidhmOEyG5oOd7uXTWU0n498OywXOKtvbW1nv5RXdo4yixfb5iD9p62VqgPgfb8pylKcsTy
 gRKLsvAOy/swZfZL6vJgAdxCYVMg2mme66d4hHaGqjY92aZ5jYg7L+2Z6yssFQY6MF5o9acJP
 tlWr4eUcKknzIksPiJUCvEAarZ6TIcNXoThxjoqs2gFqWj8P3RPGDvR5XCQ5YsYLsURGRzfuy
 yuGxOBh+BybDg4yAN27aGRB98liujvPsQ7hjDgD65yrizhh99WepWdfJRcXdlQ6/Cfp9d23RH
 hT4L7H3XC3hnsEAUKTiaoP1W+bEtBt9MW5VhuR2KBsX2+0JHFrGJftC43dFg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

Am 01.11.19 um 19:29 schrieb Davidlohr Bueso:
> There is no need to be using a semaphore, or a sleeping lock
> in the first place: critical region is extremely short, does not
> call into any blocking calls and furthermore lock and unlocking
> operations occur in the same context.
>
> Get rid of another semaphore user by replacing it with a spinlock.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> This is in an effort to further reduce semaphore users in the kernel.
>
> This is a resend, which just seems simpler given the confusions.
>
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 +++=
++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_283=
5_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm=
.c
> index 8dc730cfe7a6..710d21654128 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -63,7 +63,7 @@ static char *g_free_fragments;
>  static struct semaphore g_free_fragments_sema;
>  static struct device *g_dev;
>
> -static DEFINE_SEMAPHORE(g_free_fragments_mutex);
> +static DEFINE_SPINLOCK(g_free_fragments_lock);
>
>  static irqreturn_t
>  vchiq_doorbell_irq(int irq, void *dev_id);
> @@ -528,11 +528,11 @@ create_pagelist(char __user *buf, size_t count, un=
signed short type)
>
>  		WARN_ON(g_free_fragments =3D=3D NULL);
>
> -		down(&g_free_fragments_mutex);
> +		spin_lock(&g_free_fragments_lock);
>  		fragments =3D g_free_fragments;
>  		WARN_ON(fragments =3D=3D NULL);
>  		g_free_fragments =3D *(char **) g_free_fragments;
> -		up(&g_free_fragments_mutex);
> +		spin_unlock(&g_free_fragments_lock);
>

the reason why Greg cannot apply this patch is that you are using an old
or the wrong git tree.

Please make sure you use the following one (or a mirror):

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

and operate on the branch staging-next

Please fix this up and send a new version.

Regards
Stefan


