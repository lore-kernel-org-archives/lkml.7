Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3FEC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7B21BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a63NWzUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfHGO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:59:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46603 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfHGO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:59:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so41196835plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=8WLWJq84STxGrw4serwcqmwgcbPEKhELnCmT4aklZ+s=;
        b=a63NWzUQ+gkdhhylEU+VeXJxiM2WuXJy04nDthrB/FBxHhJp9JZ3FQKJK0f1ZuNrcF
         ofN9FaH27DSv2Vn299XYQjSYqCAET6a0c5bnVLFIuZL/aIZ+uTOW4ie6bFJn05XZErH5
         1xJAqEq0n0bm7tVpnZuoaA60CAYVWbOEL3B20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=8WLWJq84STxGrw4serwcqmwgcbPEKhELnCmT4aklZ+s=;
        b=Ax7RimQFu7Vj3FioJXcY1UsWAJSm1gq2ddukxi2z85JWl05hq7NTqKL7AP9jfAqZXN
         C0qzz0MgwGhn5l4yjxZdNkQWVJHRpi88feB9ievSTd9Cp0pOzoxhxI153pxhHph53f6D
         IzBHRM9GhapOYqCByofCdS0diDk72qu6HnCISp6qpL8KiUQLCI6rVtV7ilMaJztJiMDE
         yaDMq/+U9Pqg+7SA2IlowFBtiq04AZXaV6YqR4Fol9y2r/NwO3TELkOiKKR0Ym4UBa6A
         +qdv+2ujpAzFqL51L/7UcXhsabL/K68RrUB9u8M4cHqQpt9RuJRL2anjsk6oIIIcgQ3O
         mEPw==
X-Gm-Message-State: APjAAAXyyY52AEOGO0Kl9flYQ4Rmqq4KPG8tEhC9PvMXDlLoOpz9Lhgv
        u28QgZUKmcCA+daupRbv9KbZIw==
X-Google-Smtp-Source: APXvYqwwrg8k/Y33DMoIYlP22lEb2tuvodIpRzz/VvDisrpKRY5mci4Rzko/aVrGyypMzwwgUZjQgA==
X-Received: by 2002:a63:ff03:: with SMTP id k3mr8263827pgi.40.1565189989189;
        Wed, 07 Aug 2019 07:59:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u7sm82635351pgr.94.2019.08.07.07.59.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:59:48 -0700 (PDT)
Message-ID: <5d4ae764.1c69fb81.f81f8.054c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190807135834.GA12853@roeck-us.net>
References: <20190802082035.79316-1-hungte@chromium.org> <5d44b8eb.1c69fb81.6d1c1.7d80@mx.google.com> <20190807135834.GA12853@roeck-us.net>
Subject: Re: [PATCH] firmware: google: update vpd_decode from upstream
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
To:     Guenter Roeck <linux@roeck-us.net>
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 07:59:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2019-08-07 06:58:34)
> On Fri, Aug 02, 2019 at 03:27:54PM -0700, Stephen Boyd wrote:
> > Quoting Hung-Te Lin (2019-08-02 01:20:31)
> > > =20
> > > -static int vpd_section_attrib_add(const u8 *key, s32 key_len,
> > > -                                 const u8 *value, s32 value_len,
> > > +static int vpd_section_attrib_add(const u8 *key, u32 key_len,
> > > +                                 const u8 *value, u32 value_len,
> > >                                   void *arg)
> > >  {
> > >         int ret;
> > > @@ -246,7 +246,7 @@ static int vpd_section_destroy(struct vpd_section=
 *sec)
> > > =20
> > >  static int vpd_sections_init(phys_addr_t physaddr)
> > >  {
> > > -       struct vpd_cbmem *temp;
> > > +       struct vpd_cbmem __iomem *temp;
>=20
> The change to __iomem should also be a separate patch.
>=20

Please don't change it back to __iomem. See commit ae21f41e1f56
("firmware: vpd: Drop __iomem usage for memremap() memory") for why.

