Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7093C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE12147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYQXMd9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFTFZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:25:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43306 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:25:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so968670pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=zlU77qurwFBHY4ItXISiY+NZzcjBbiD22X4dtBHNWtU=;
        b=dYQXMd9pHNzHz6HK2pXYsrRhHBwvsP7wJdPtTqX4UcubHVwuffRExKOkpyrHJ5Qx4W
         0hktkH8dgpFWn35KG4U5iMQEvPgXirPaWCN2d5Cy5p8qgIOLY/B/74d+vx15hj0xrrzb
         7pwHLsqTe+G6XqRL7WNcQRXZZbZtn7chXkzPPvGIn5U4UfufxM+jI4dsNcixbgL/RLAe
         6Vei0LuwvqnqlaRTateNDpYgHiEIkd2FXZhysojioH/5uKAP/YIhOxVu62TyAeU2eiUr
         JBViTIvys1+cM3VFgaNXViIefNGz6PUDGXU+Mb5WTT+aaNT4RjS5yadFnG0/URWikP8R
         M6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=zlU77qurwFBHY4ItXISiY+NZzcjBbiD22X4dtBHNWtU=;
        b=iGa3c+xarRFL1pdVb8fin8vrOR/ratTuCNo7Dd0ir6tXRt4SISFkcdRLc1NHmpwxwy
         duuen6bglT8u8XImHD4j1lo1qFZ3CG+fuDbPOg86X/O6Ba8qC2svhErK1D0M1ZBej7Wb
         wnuuc7sNBXcH7J2JJ3PUlp264h2JFyjPouyW35eOJWCJmq8ckAhVrZNUCF5xdk/O6Rdb
         G85ve95AOxEe6I6wzqS8jrmZXpAHE4hPH30gmcOOc4vP1C+Lpv2v9d9pK3t4EdjxQuEd
         j0MZ1mFZAa9Kb/FVI80VAkKizM8X0AacqPqR/yBtEAyQHSsltZgXAMp/dvZcsSPlbhCQ
         ACcQ==
X-Gm-Message-State: APjAAAWUTEud/igT29jZvyoFRbQL8sul3PMlninaibYAofhgYguncn8n
        sfycNklrq6CqHdDrYzxxzxY=
X-Google-Smtp-Source: APXvYqwGlNIh3qGSCHGTDNRkebDfOHC9wPc4sz46s7V/6RQiPr6YS1ATNPfWQ2H4D+vJDveyDEuVjQ==
X-Received: by 2002:a63:c44f:: with SMTP id m15mr11085798pgg.34.1561008330349;
        Wed, 19 Jun 2019 22:25:30 -0700 (PDT)
Received: from localhost (193-116-72-140.tpgi.com.au. [193.116.72.140])
        by smtp.gmail.com with ESMTPSA id s24sm20437852pfh.133.2019.06.19.22.25.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 22:25:29 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:25:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] ocxl: Allow contexts to be attached with a NULL mm
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190620041203.12274-1-alastair@au1.ibm.com>
In-Reply-To: <20190620041203.12274-1-alastair@au1.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1561008239.9nxgz9ee3u.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair D'Silva's on June 20, 2019 2:12 pm:
> From: Alastair D'Silva <alastair@d-silva.org>
>=20
> If an OpenCAPI context is to be used directly by a kernel driver, there
> may not be a suitable mm to use.
>=20
> The patch makes the mm parameter to ocxl_context_attach optional.
>=20
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Yeah I don't think you need to manage a kernel context explicitly
because it will always be flushed with tlbie, comment helps. For
the powerpc/mm bit,

Acked-by: Nicholas Piggin <npiggin@gmail.com>

=
