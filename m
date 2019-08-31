Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F015C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06422CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfHaKa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:30:28 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39086 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726498AbfHaKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:30:27 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7VAUQDa022012
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 06:30:26 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7VAULL2002913
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 06:30:26 -0400
Received: by mail-qk1-f199.google.com with SMTP id b143so10079321qkg.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 03:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=yS6lJBR0z5pXlUbR3vjtDfvuZ/ch4JHNsJdpqfM7yNY=;
        b=UdyIli+HWXCek6kJXzP+aBSeZyL+drjzJnmeaySkbaxBXyRG5udowl4NYqTiX2B0hr
         cOiE+bufDOXUlkw+Tud+o1SuxOBT7cBCVyWtqDZT1U0xe9inklD6ZQzTBptX7khJa9aW
         ES+xDCHpbtSh9xEuuxnZjI1aNPoMNHhM0HCCi67TFpJsWC/tndqBm7253QAmYhHJVEaj
         Wpc2lW3sVTxUz0Q69XJPQWJZl2Wq/CRZzFa2Mp9+hdomAV0nCSgxLZOTSy6Xt3dSykaz
         Ns4p2JdQFfI20hmQQS3UtCjndUMRdLtBoxMwTjrqJeSv6vhltoyK7k6BGZ4+dmrCgx5a
         4apg==
X-Gm-Message-State: APjAAAUP8SA7rm9Vmk9yzL8KXWuKqbF5GsgDFdukQ5sBQN5rHFY/g6yj
        vsGzF1C0bzTenkgz7kqeu6w9IWaCAL0mJjLZ8+Z4qX3R/sTEPtstxYl1gPtWmgD9e2FSNIhRRET
        vByWGuBfyFTVvFiLTyg7y8Rp7tbvc5QB4zSI=
X-Received: by 2002:a05:620a:1125:: with SMTP id p5mr4061530qkk.210.1567247421049;
        Sat, 31 Aug 2019 03:30:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuInrftSS9yb0sn0s1xQsaIUrlAnhCycOjV4outISe323Mo9dV6f7RRjcoGpIH/0dZSLvqtw==
X-Received: by 2002:a05:620a:1125:: with SMTP id p5mr4061511qkk.210.1567247420798;
        Sat, 31 Aug 2019 03:30:20 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id s17sm1979613qkm.54.2019.08.31.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 03:30:19 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: remove redundant goto
In-Reply-To: <20190830181523.13356-1-colin.king@canonical.com>
References: <20190830181523.13356-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567247418_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 31 Aug 2019 06:30:18 -0400
Message-ID: <295459.1567247418@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567247418_4251P
Content-Type: text/plain; charset=us-ascii

On Fri, 30 Aug 2019 19:15:23 +0100, Colin King said:
> From: Colin Ian King <colin.king@canonical.com>
>
> The goto after a return is never executed, so it is redundant and can
> be removed.
>
> Addresses-Coverity: ("Structurally dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch....

> -	if (dentry < -1) {
> +	if (dentry < -1)
>  		return FFS_NOTFOUND;
> -		goto out;
> -	}

But the wrong fix. The code *used* to have returns like this all over the
place, but that meant it returns with a lock held - whoops.  The *other* 287 or
so places I changed to 'ret = FFS_yaddayadda',  followed by a 'goto out' but I
apparently missed one.

And thanks a bunch for feeding it to Coverity :)



--==_Exmh_1567247418_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWpMOQdmEQWDXROgAQIm0w//aPU0Rv6gMxB2mP0p2L7LaEtmwIdoEwD9
ntgSn8am4fv/Zi99Y7BOBzCw5/KAyV8qo0V5LzIt4seIgXCa+I/gd12ngxmfRt1B
0HAjQQQZl5TX5l2gnAzTIlUasA6mnxkb27/9x+qSUZRwoCRSliQC4wsaNzHbDO0y
iSNdDeiRz9hqSHtim2p7OJG2DSMTzrahN5BYD58a78/ocgOGjokb4v1nSHkU2zIS
+3C1AhCU9K6o9RedPZ3aoLELlWfwXa6EWgtiMsNC28ay/b0LkJBiA8XelQkdlfmE
mXq+g51uNim/ZT5m2YZWx6znD/SjGbwBgmftA/oawZuw4REpvAHVihULK5SGVwNn
ClPsmzGIzLvlDeAE3NKnyMAZZ5/Ip49aLxjViJMAPKFhTOHpI8mKJFYjKja8DF/c
Bu16fZqvbm7Ux50iljUwc94NEVw1QDefd8PkTc3UgwInv54xpUvb5pckweHWe8bj
FANfoJKJWmYy2aDIHyww9Yj5obKJLazQTISnUZrpgP8b2HlvFolaLC/669sLd36v
Rdvz/nNh5bUL5vA8nojDQ+mSYMEy5zi38hRQdGnM45IW1K+GOquDRRTl3w82DNRF
TfuiZym2//hGZFaPD/tZuGLwmWcxN+5gvn6U5IPwaBHnDwYf4GgHmqh0G0PaOg5W
v4SY1xOsplg=
=O42f
-----END PGP SIGNATURE-----

--==_Exmh_1567247418_4251P--
