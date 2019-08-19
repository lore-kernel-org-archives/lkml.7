Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F107C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706DC2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYFXZFFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfHSNmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:42:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41570 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfHSNmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:42:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so1195839pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=RjbLMcxR301rQtXMpcTgwA0dW/K8YBmt5+fW+awk5+E=;
        b=tYFXZFFlCozav7Vs9/mMpjspNezP2YD/DBroefG0UIAcNPFVG9JQQQ7Rxqj/Zqby86
         ldGz6i23RyjklvekeUwHOk3PHKT/kEfffzORWCBTrKLm7yrr+YTzsYpABEraWMIMhYI+
         +eHAc7kuoP5C2YDEQMsPhbl+UL21IEyWyYB8YtEBg3LKrTkSzXO7s+ZmHpwa8P+/76Dj
         U049W6xuNbvAOe6NDpeVnvEUbwoHpnHq/yh0DCDpS62aqeyFiKWIMpeXrgMrAuwr4Pmf
         XisguPW0xxY8ZfQRMu/kYGoIEGN1wROyWbGBRricaiYnRc+VKLxUooyfalIfIRMhd48H
         IClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=RjbLMcxR301rQtXMpcTgwA0dW/K8YBmt5+fW+awk5+E=;
        b=YmNxShw4F3VMFYXmOCAYS/eqX33xDpkf53heMeNMQcIoxk1HcWLoa5SBYU8sWG6zUJ
         3Qgq3IJei+Q5KOoPNDSWN9SHWx0dfl/dupKdLUgSkqe30uLpqvBc8oqCSW/tze1b9ww2
         7eXYQWYtlVlQK2mtfQ7qn5KZSiPUyAyXoutMmoVCnk/O29fNRxdObXlvukiXVzNuP8lw
         Nn8K1sGYZ2gTRsge5GozoiLd57bn/4/kHU1tA14TKoLH/KrSS7co+UF5gkww+v2uejDx
         oBExvkufCWK3ZMclrjFIW20Isu70JJhhFYgmbpV0HNKHQEkkYOZAc9jq0wUELrDs834m
         SYNg==
X-Gm-Message-State: APjAAAVxOFrmTZXbRlcZuNxXH4ZqHYfP8EXUAN9Q/UshUf08PcvK4wys
        J9WjXKcNve83EoRZMx30C9Y=
X-Google-Smtp-Source: APXvYqyatnsZKZ+5EQfsnms5KbYq265xLWw8O++dMuVzDWl78HSBpjjn//fYUYM0KZVsiHE3eJmmhw==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr19901841pgk.431.1566222170475;
        Mon, 19 Aug 2019 06:42:50 -0700 (PDT)
Received: from localhost (193-116-95-121.tpgi.com.au. [193.116.95.121])
        by smtp.gmail.com with ESMTPSA id v12sm13863260pgr.86.2019.08.19.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 06:42:49 -0700 (PDT)
Date:   Mon, 19 Aug 2019 23:42:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 05/10] powerpc/mm: Do early ioremaps from top to bottom
 on PPC64 too.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
        <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566221500.6f5zxv68dm.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on August 14, 2019 6:11 am:
> Until vmalloc system is up and running, ioremap basically
> allocates addresses at the border of the IOREMAP area.
>=20
> On PPC32, addresses are allocated down from the top of the area
> while on PPC64, addresses are allocated up from the base of the
> area.
=20
This series looks pretty good to me, but I'm not sure about this patch.

It seems like quite a small divergence in terms of code, and it looks
like the final result still has some ifdefs in these functions. Maybe
you could just keep existing behaviour for this cleanup series so it
does not risk triggering some obscure regression? Merging behaviour
could be proposed at the end.

Thanks,
Nick

=
