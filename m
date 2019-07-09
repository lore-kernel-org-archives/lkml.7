Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E858C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D30E21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGIQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:50:53 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58284 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbfGIQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:50:52 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x69Gopvh010246
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 12:50:51 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x69GokGD021516
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 12:50:51 -0400
Received: by mail-qt1-f198.google.com with SMTP id d26so19919092qte.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 09:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=pYyupce07jX+WDxPtqdtXk3hG5t417BkTzPivM8p47w=;
        b=Onh7dxeY9WRVkBqFCDDt8ukh1hs5Ng/U7NfSk0SKvytS/G8A5LHx4yBmPyrb6kXY6B
         7IpJfGKq5MkbG8XowxfzC2fuszS+5B3aGqYA4tTYd1TdI+6sNbjP/eBgJHjOydb8ShD6
         wFSzmZF/CzJvTL3FBUUrfSHIPB2LhdSQdHa13yiFGKQm9615vAeCCidoqTvgUHhbaqZi
         Q9Rj0olKZVfLPTDYAAh6X4lV2Gy8KWsFCBRllB6AICipUcumEpuGkF5iB7AuRYWirouh
         JA8rhw3UsvH7ht7mQkUWcnpdYZW64pT/dsl2/+BPrWRQ16G5xDgXlUT3Rs5JplEqtTT8
         COOA==
X-Gm-Message-State: APjAAAVELn44eCn4PEtVapf7u5ygNszqEG0LPWuR18cZOTp764agM6MZ
        J/KtSWyij1GdUijGnekCEgegI02N0RbgPbmM/noDYZ7fN97NQGJd1Rx80s6BxVXcmkbaNBnxplQ
        b05CnvqFd9DrRMA3+uCVKAnSC8FhAj6T/FtU=
X-Received: by 2002:a37:4b46:: with SMTP id y67mr19205098qka.66.1562691046236;
        Tue, 09 Jul 2019 09:50:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxgaCF5Vy7+up/DCAY/qBFZBrxFfhiU0tMqaxFR0G0zFt+i3kSSn4l5D4I+4TFTR5M97RMWjg==
X-Received: by 2002:a37:4b46:: with SMTP id y67mr19205078qka.66.1562691046042;
        Tue, 09 Jul 2019 09:50:46 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id x10sm12844861qtc.34.2019.07.09.09.50.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:50:44 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     KY Srinivasan <kys@microsoft.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: exfat filesystem
In-Reply-To: <SN6PR2101MB10726033399AEA1D0BD22067A0F10@SN6PR2101MB1072.namprd21.prod.outlook.com>
References: <21080.1562632662@turing-police> <20190709045020.GB23646@mit.edu> <20190709112136.GI32320@bombadil.infradead.org> <20190709153039.GA3200@mit.edu> <20190709154834.GJ32320@bombadil.infradead.org>
 <SN6PR2101MB10726033399AEA1D0BD22067A0F10@SN6PR2101MB1072.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562691043_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jul 2019 12:50:43 -0400
Message-ID: <24605.1562691043@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1562691043_2389P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jul 2019 16:39:31 -0000, KY Srinivasan said:

> Let me dig up the details here.

In case this helps clarify the chain of events, the code in question
is the Samsung code mentioned here, updated to 5.2 kernel....

=22We know that Microsoft has done patent troll shakedowns in the past on=
 Linux
products related to the exfat filesystem. While we at Conservancy were
successful in getting the code that implements exfat for Linux released u=
nder
GPL (by Samsung), that code has not been upstreamed into Linux. So, Micro=
soft
has not included any patents they might hold on exfat into the patent
non-aggression pact.=22

https://sfconservancy.org/blog/2018/oct/10/microsoft-oin-exfat/
=20
(Link in that para points here):
https://sfconservancy.org/news/2013/aug/16/exfat-samsung/



--==_Exmh_1562691043_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSTF4gdmEQWDXROgAQL54Q/9Hlj0gpg86LJ/QMJSgnF2F4/8RSnWxUX8
XORTc3xuKuh0usDDWrb00semHxVT8dQfISpM7bvfiTGB1p5RO522PA/QI2bU9vTk
tIZzLLDmqk/ambCGDF6SdKaPtTTw2Yx4KSkhzjUc3i1CBg2R9YUfpST/Y93NAtwr
Vx64TgufPWmNtU7/sUiEKSFV2T6EIdv3gHoog+/JoPioRwmdVH0DhxgVWy7lki3s
vMkJg3XJYsPDHe+P8F30RRSTQAwq/5HmtbF4nmFAASBYuD2vyAAraVtOxkkcyLKb
DMhFbw7LyScyYVv9C1W2GfCjySjmacHDr7E0tZqfZFqj0/JiA+/McjxEWydrZLae
80LU3QBR0jIM9TX2y/IWOA+A+YAlzaYE+HY1JrnqqmsuS0ygF2CU093F1ebYmEFM
XvdjkVWZRocxZW/RAE0PurJKAJvqoNm7PjJEzOqdgZsP9a2g39OxoXdA8OoMNsgv
0dRH92veXFLgbyMbAjwNYgfmUyJi1n6AEtflZW4tdBCo5yTs2qyQNgzpZ8/9nxzM
YzfKeGSIomxWvPPmi3Ku9JY5y6MHaaNNo/DshPKYjZflZYBdVA5OBsEXhHKf1ANt
aWUe43IU19mQm0zIHSQaTgKcXbpzhEEvNZqnEzBwyULgOETjg5Nda5VZbFziukup
qBtKuW2QIiQ=
=x5Ci
-----END PGP SIGNATURE-----

--==_Exmh_1562691043_2389P--
