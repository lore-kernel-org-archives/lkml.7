Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF56C388F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87342190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUtfuaAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfI3IKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:10:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33759 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3IKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:10:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so5168336pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yfE6B4I1Ttuz0rktBjLXX/V0kpxZSolAZktw2X5hjU4=;
        b=dUtfuaAu6Ogn4b9bn7iT7vXi9w5kClQs8X7ZU1C3hQFp4WGpedqp5hzPISyRb/xesK
         fMezIZsRJstxPwgvZyUlhfYb4EWWD1pkzCSVNZVq28b+wO2Z08PEL69jkpFyucvzSon/
         BFiIxtx+LcapS+tNv3Q+qlmeJrFt0c5HdXgZA2sNuEf3RGCIP6acAPfmA09JlMr9lGJl
         8Q+VjP8mARjy/PGdF3ec68YyRTj4Wauixlu66ysKk2g74lxQJ+AzC+5GVu3yiXIXvYj9
         uI0mVkDP35cktpAPAybC98AphNqw5zkPTQr5jNEZLI375x+o5YygCJfs0OG0ak/2Oqoi
         uooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yfE6B4I1Ttuz0rktBjLXX/V0kpxZSolAZktw2X5hjU4=;
        b=ZqqTL5SDyHGLyfPwvvZnPcoa/l+FD1r90n1cTgVK3QeNEqF3P3/4cUJI0X3pst8q4n
         uRylP7TjxWAPnYYUZlpJqEeZOCJyRH9wsrbN6aKCpMtKXHODcme8Ighhihb+CShXl9rN
         V+ieUm7l5YIbMQAcWbTEZXCEdpNqsVLu+kVJI2gVerkHwhvSgL6J5rtlDpBW4YQlZgsT
         aFdKWtP3KEQQWQ/0W2wTrqP/H9XCppSvkYTawyn2pj47Vd41mL+z9WMm33VKl9bK4v2F
         CCo958406hSrWIDJaj5GHKdPXsg/8cPTr4OoDJo35y+zg+VFc6anlxXGs8nxYUcGmr/Y
         KyfA==
X-Gm-Message-State: APjAAAUYPLQSgT7SSr711q0CkbDcSQpxJsJpe/bTx8EYYNhQAjLcNIC8
        FadyMZ+y2Rk/eCiry7QzjbY=
X-Google-Smtp-Source: APXvYqwuKnvhirgfGCeA+DRO5hst8xbSTB+cz07SeIAykHObw+8rILfZWm1Dl7oS+Ktvn7bbMUknmw==
X-Received: by 2002:a63:1608:: with SMTP id w8mr23022721pgl.223.1569831053642;
        Mon, 30 Sep 2019 01:10:53 -0700 (PDT)
Received: from Slackware ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id m22sm1870033pgj.29.2019.09.30.01.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:10:52 -0700 (PDT)
Date:   Mon, 30 Sep 2019 13:40:41 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: [RFC] Makefiles in scripts dir needs to move  one place 
Message-ID: <20190930081041.GA11886@Slackware>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
 Hey Greg ,

 Absolute trivialities, but might break few scripts, but make things
 clean..=20

 We have so many *Makefile.* cluttering in the top level scripts dir.
 Can we please move those in one place, means create a dir and put all
 of them in it.=20

 And call those in the scripts with that dir preceded . Kindly , let me
 know how awful that would be.

 Thanks,
 Bhaskar

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2RuHkACgkQsjqdtxFL
KRWuuAf9GkXmt+9sEPYCoUPudpdBNbThtZf0deakqMrOBaAg5X8c3/BPEuGYjExK
x0n+Xv3mQm0X8Xj1py6oAf3rO9vQGcmdxogeP1uaUAgsf+H5/wHT4koIxJyVn8uK
BZzCvJp3+sL9uD0rH45qXcix57cIItlr/uIkyEXusHl1ogzCbOOTolmThaMRbB1m
1IecnFtVxhH63zZtUBQFkG65LI+0eYd5Yy/IT8JyyCanrYcBbRt8eLqbvckaXKq7
TRUKqU8qMJewlVjymMZ0pY0TGWkGmj5v4J2Cv7cL6hrNdcN15K/j+BfeX8A5FXbM
/UEgx2lemJ9biH1i7RRUuDQiwAHo8w==
=PZuo
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
