Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4924218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfJBTE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:04:27 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54258 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfJBTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:04:26 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x92J4Pdn021099
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 15:04:25 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x92J4K4F018888
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 15:04:25 -0400
Received: by mail-qk1-f200.google.com with SMTP id x77so28847qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=dobeNOp3H7EgZ2CD0/RvF0nXbG/3YQqE1zu1Q3zAY9E=;
        b=T37bc3bReuWzh61WTqMCLT2JxGjb4WdRdVd+3mTlx6R30uzRa7AbL513O77Pdz7QYg
         TpKQfUtM4rm5fgJlQe2Ud7MM/KdXyUaAfOQcWhKncZHgjbASaQQATDcVvoqXivrPKzt+
         zF9FbnSqwsb1Y2V52GCbPUdxMX4S0il0/EO7Q+WmaDAUDnKlJza0QfHCwQkOtq0GLHDq
         tbs2K980aOzGGA8mM2Mk1LX8CTutq/B2FoUBKWF4RDHB5QEGJkzBQrsf1Gckfes7AXsS
         gu5JoNMEijNk7CAQEH51qHax57RbxjsX70qH2yyD7wEyP2TYwSJNKq7hJZXRqPGz4l+c
         PGpQ==
X-Gm-Message-State: APjAAAUyIGHL0NJj7P2x993jxkKhoZ/2trg6th+wOLXpFM0GWRPeLugo
        5Qk7t6D+hQ6zXCvoXJ/s9oLnIFZ8BQ1RDReb3OExH9DAKkyZJ+S3Th5Kvz4s4FqnPheHURcvdNd
        4M1Hjq/AAOTqjRveycTD9aIaJHFLdzy1DjIM=
X-Received: by 2002:a37:5f47:: with SMTP id t68mr275518qkb.497.1570043060001;
        Wed, 02 Oct 2019 12:04:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfdEnd5F+47KVCHpyvKRTi+Y0IF9ayDTCSW4G25pB3tGXL/763JGRm19HdEr+JSJ2z/oBuDw==
X-Received: by 2002:a37:5f47:: with SMTP id t68mr275488qkb.497.1570043059705;
        Wed, 02 Oct 2019 12:04:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id t40sm131106qta.36.2019.10.02.12.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:04:16 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: use bdev_sync function directly where needed
In-Reply-To: <20191002151703.GA6594@SD>
References: <20191002151703.GA6594@SD>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1570043055_7127P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Oct 2019 15:04:15 -0400
Message-ID: <9938.1570043055@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1570043055_7127P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Oct 2019 20:47:03 +0530, Saiyam Doshi said:
> fs_sync() is wrapper to bdev_sync(). When fs_sync is called with
> non-zero argument, bdev_sync gets called.
>
> Most instances of fs_sync is called with false and very few with
> true. Refactor this and makes direct call to bdev_sync() where
> needed and removes fs_sync definition.

Did you do an actual analysis of where bdev_sync() *should*
be called?

The note in the TODO was intended to point out that many of the calls
are called with 'false' and probably should not be.

 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif

Consider - with this patch, we are now setting the volume state to clean - but
we've not actually flushed the filesystem to disk, which means it's almost
guaranteed that the file system is *NOT* in fact clean.

Changing all the 'false' that happen before a VOL_CLEAN to 'true' is
probably more correct - but still totally wrong if DELAYED_SYNC isn't defined
because then we *aren't* syncing to disk at all.



--==_Exmh_1570043055_7127P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXZT0rgdmEQWDXROgAQIBKg//X9lHdUpw66i/cHOTZ7lqpmV2mkPQ5/+p
fG58bja0kg2YSZrHSWHzvD93HZmV228K1vBOitP2kjsU1IUFJ0qicx5irJzZzjdk
qZ3G5e3o6on3BuyP7b5uF+rI/+v+4HMZ3xLwCSEH9rRk1u5vPwH8BT7AXGp3YXNw
zZI65DtJB6nNnqSITc5tIXluDeSo11AjJ6E9nINYJWyL053UcV3ScsABZUJdCUQE
RsaFDhNv7pM8FwMdYMXT8aapB8BG4aUT/RiSHboa3dQ9AcQSlmBKs8w9lTSt2I1Y
aPCfkY2+VrGvv9Hn6EiiZKsPf3dBnHbVa/jEthcB+sfQwUqvQMZXZ1ketqhC4Do3
QJ+n3Blj1tAoN/ibXAEBx/PLzbzMxVfw6dOXCetx34cpb1waQ79kGZtcte/sWEAD
zQWKQUJLbCtHJwder/DX5TjbESmX3U7twxgSTTFhxyl0IQ2gRB4ZUN9NcRWJFDQV
thldWb65CcJP1rHfC/lembJIvIB6TGaaI2GCFvEqAHjUmWBzgBGhNfpDakTDekwU
zLTljhXFyEh/VgTxh3Cv4JMB1gqiAZPzlEiJn/oolBok3OeAjhXzJIj3Pkvp7tVs
+Jv4NBNxl3B4xEpay5lDK7VhcQAa5/Gah5HhJIxG+9QMNGDFqD638XpIxoN6MN0I
OOGl4QJUGIE=
=eIW1
-----END PGP SIGNATURE-----

--==_Exmh_1570043055_7127P--
