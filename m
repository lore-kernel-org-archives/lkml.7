Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EAD20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiLzYav9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfEHWD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:03:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35826 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEHWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:03:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so57172lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGf/FC0g6p4ueu02ifcXTtTD7ZcvSmVmHb921qzsBjg=;
        b=SiLzYav9aW4ToUPViKxq1NLGFfY90ZvGWXwcVbsA6dciF73vyhyCsOROBTTVyxChMp
         9BjpkGreeqKWLjXp714tBzNHU22K1cyndOQkz57kpkGCOTenLpXO77E5k5wG7Yykvg0R
         ++LSspvitjeOxhnWBr1T4hvd7fGgTtXGXYY2PpB2OtPKdxXKJ81wg8vkt7BDTiILdNZ4
         RxnGcvpdIBgkgTFrz030t4vmeoO6IjuW+QrAPCMJ46EMf54cAw0Wud2bQbQV3bC6lwje
         S1utLL6flMV/6D2/y+wXClFLh+sMMihTCbN30y6NSVtgAK87PNSanE8kIClVBfXI+L3u
         eukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGf/FC0g6p4ueu02ifcXTtTD7ZcvSmVmHb921qzsBjg=;
        b=Em5VxtCbBBSMMSq/mjpnzYtNv/ms8oMMTn0Iov6Wg8h5wdusZgPLLhLLGzpftZ76dO
         g8RxLFDKeCfETnR5sGhiXkZwvZjAQk9VcxYLOBidD0z3+Q7QYJ5vqw45XqSN+qCK6kb7
         OlUfa4F0C2I1nq6A67qBFB0e8UBFkBG+b/xF8dIwtADd2FJCGBpK0C5hH4pTnmxDW6bu
         nPSgcNQdGsEZVSDkQhYwDggvrYZC5+B08w+9WY6dgtZMDbW9jNpiUgy1gKoLbqVKF518
         NQJZuIRyqOxjDmBNZQB9g8ITzK5ABq4I1oOhgjXsp1HQiIf1z2K5SXgAdx3mldS91Klw
         PWlQ==
X-Gm-Message-State: APjAAAUTSPX1R6biKbep3G8xlQG9pEhX3pn06xyySY29vwokiWpZCmAj
        0mIn7x3+zw3wL64YBqZoGyKgchY6xyVE/QtWTSo=
X-Google-Smtp-Source: APXvYqy9UYyUromDY7Y+uKEgH0rxzpbuRiSGkwdW1SG+nNWYxsrTe3Ua6FS/ajPCkbmopCpyT85ET3v+UArMf4gDH2Q=
X-Received: by 2002:a19:7411:: with SMTP id v17mr277816lfe.116.1557353034007;
 Wed, 08 May 2019 15:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190508174356.13952-1-borneo.antonio@gmail.com> <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Thu, 9 May 2019 00:03:32 +0200
Message-ID: <CAAj6DX0CQtB8y71bc-X36i4V36R5WjJ2199JiR4+717T1sDNqA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add command-line option for TAB size
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 11:14 PM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
...
> Checking for 0 before using the value in division and modulo
> operations would be prudent.

True!
From command line, $tabsize is parsed as integer so I should sort out
any non-positive value.
Will add a check after GetOptions(...)
die "Invalid TAB size: $tabsize\n" if ($tabsize <= 0);
