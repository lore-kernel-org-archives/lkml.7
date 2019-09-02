Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A0721883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfIBTA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:00:26 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45818 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726865AbfIBTA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:00:26 -0400
Received: from mr5.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x82J0PSq000665
        for <linux-kernel@vger.kernel.org>; Mon, 2 Sep 2019 15:00:25 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x82J0Ks4022539
        for <linux-kernel@vger.kernel.org>; Mon, 2 Sep 2019 15:00:25 -0400
Received: by mail-qk1-f199.google.com with SMTP id o4so16662610qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 12:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=X/y07lbPGXH7bB6jZdP7Y7cEHaqxYqjbURRNMPG/Hrw=;
        b=imUAcJnlr9Ztm1OZF7Ipyz+jS5B0+An99i30P8SdTH4H9LlnXJgTjnziB63CS13WMg
         D85/GQzTD8oMFN+1DLrnd5xQ23ckLtQUSzwIAqQkiad2y5GJwIPfPAjI9Qtr48oBud++
         YDr/5j1YlADK+HyjXd8i7ugxbPjt0tSxuDlYL1Paz750LveWNNQZKQZyivIiBE5KVah3
         uH9dHTft+rCt1vNOXxdaIv7hSAYfTcDyv0WM0cdvgz+c4xhaEci42ZGB4Z02DNTQqZDK
         +3wiL/T+lI+x3GPcBy8OPivV+8ANXBChKUi6xHBIvQ7hpC0mcQA8vK1ENUkxCZ5d2pDb
         dDyg==
X-Gm-Message-State: APjAAAXBy7CYq8GZNOdYmWAjDEaXO097FwwvITOtFFZbNUn+E/XdoUfE
        /3e6/Qeya65TwdmPwTraH/x96O2hakcaXhh3G8/dKLFCLnSyjGaHbe+qh09SS5ee1wIWD2Sv3Ao
        P4v0B+K4l5a92AnpDicw2+DCAAtEp5GvzDUY=
X-Received: by 2002:a37:d2c6:: with SMTP id f189mr30717558qkj.231.1567450819925;
        Mon, 02 Sep 2019 12:00:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxma30y8CeByk3061faiFLcZAV2GhZK20oPOHS8T7CDWivXwHYnbWqBBq2P0PNalvAPJoaD+Q==
X-Received: by 2002:a37:d2c6:: with SMTP id f189mr30717531qkj.231.1567450819691;
        Mon, 02 Sep 2019 12:00:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id 22sm7364247qkc.90.2019.09.02.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 12:00:18 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <20190902152524.GA4964@kroah.com>
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org> <267691.1567212516@turing-police> <20190831064616.GA13286@infradead.org> <295233.1567247121@turing-police> <20190902073525.GA18988@infradead.org>
 <20190902152524.GA4964@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567450817_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Sep 2019 15:00:17 -0400
Message-ID: <501797.1567450817@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567450817_4251P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Sep 2019 17:25:24 +0200, Greg Kroah-Hartman said:

> I dug up my old discussion with the current vfat maintainer and he said
> something to the affect of, "leave the existing code alone, make a new
> filesystem, I don't want anything to do with exfat".
>
> And I don't blame them, vfat is fine as-is and stable and shouldn't be
> touched for new things.
>
> We can keep non-vfat filesystems from being mounted with the exfat
> codebase, and make things simpler for everyone involved.

Ogawa:

Is this still your position, that you want exfat to be a separate module?

--==_Exmh_1567450817_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXW1mvwdmEQWDXROgAQIl4RAAo/gmznohIGbnQoiSqQRal12lVpZlEja5
QV7GuSKa9gPe0jd8ewra5/5HhEQINbocmI36jJeRxbkDWgBRvvxU7USO1FQRIDUE
aSkUC2kylgyQiq8guFyZTm8sgELLpDuJ2mOHK1FvaOdP4zIjfopiLWRPAhfyr1tw
vmB/AKDm9ze7wS+mu6dI8JROdOpNu0LoYGmD0TQtOIa+y8lJHmVNu7vRFo2+KeXi
LOLb1LDm9BaipSnco+apeGqEPx0AtlRbW7MHG03XOkQwgaq2lsGViBCpMkq5Nrmd
s/YIa/E6Z3YwLFEjzR2hCXZWZBrCk/waTUDS3psqkblP6K8MiBpCanSdutDw5/qD
33uxYgyGYWuTJYyLX2ziXby4/dPYoDU33m3ihu9e3jfcM/48a21r4LtDC2uTgKEw
O8bDWkpkZS1Sm5UiwpOps9cuNlmm+ES15rGFKId2hroxe8eGhswL5xkm3U9JGAGY
81qoAOm4Nisj+F19JlYtH84iHD4ZN0ic/TOXxjiB0tvitiilp+lAQyF4bE+7rzd9
J8zXqYCJF1JBB/dWF+N24E68ClU/A0CLtg6k3SVD0bNHt5Vn600xd7WqsGjDGUww
Da09AkmdVeNc+lX+pTYzDDe53bGqgJ4/g6XhoRsZijJWcH90+fpKODQeGdydqL71
ZJLR8r8Chhk=
=CHbf
-----END PGP SIGNATURE-----

--==_Exmh_1567450817_4251P--
