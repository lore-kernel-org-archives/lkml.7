Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE5C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADD721E71
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyXCQBwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHGN6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:58:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43102 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbfHGN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:58:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so33959309pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBqnmjF3/h5TL17Is1SYHEENka1ilSHWyn6/XQ6N5+Q=;
        b=eyXCQBwhym8rDLUyWs5pJBT+GOIfRrw76YItAVvVp9dpedv/D7qcRr+ZbNj4F58oNg
         weqhneSNvAuQ2eje/NL0UtOhLWUjqx3aiwGN5hQ19pXX4ByxOM6noEy/SUcrsit5kJlF
         KluaCcqWxdEPS8KY7BnOggyYLoFO4aLow6N6MWS0zMYinn3EztDJ9dM/WSkKPKZPx+fs
         ZZxLguOUEfhYFQecemicONmC8jj87CjWZYPbPqmgnQxXxS1QcEuPh1YXq3/r3DjoDIb4
         ihAUe2qWuAcPpROc9WhhdjPG1lY38WHvDMWU/fGkhn9QesHr8e3IYhK6U0bfQqSaEPmO
         12ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBqnmjF3/h5TL17Is1SYHEENka1ilSHWyn6/XQ6N5+Q=;
        b=bIWB+/adn35gtHLaAh1vaMSrI0SGqH0tXniH0es6XBO2gMMiDL5Ox3C/0FZHNtSCZG
         yDWM5VJjj6xlirsqXyexipE8XTmzpN8g+CPCtvhBgelT6W13qdy5Rbkh5rG9v2aZfG/X
         ssKqlkr7zJuI2x5AXW0FjxEoiuD6gFmRCCt8Tcnl3xORZnrZj0NEnX8axFRm2I3wlIRx
         CfPLjNG1HgQPWrrm4mVeax/hcKXxXj1x1x6yE0d7zIhwhfTRs25Fdbgo3bxgyF76UBMq
         3UFN9M8FHB9WZCXtKx7MJO1ftvrGvfiFiA/XiEgGVvRqUMENriWNjdgFBmQCA8dheeD6
         lxGA==
X-Gm-Message-State: APjAAAVIgKTIjavX5bFDYiFd5EszmuD3HvPj/bMU5H/ED+NJbNqC6LS7
        eNQxQmlz51Ghcf0jMfhabkA=
X-Google-Smtp-Source: APXvYqx4842xCOXkfA0VdA5THpIp9SAEJ/j0gfAtc2d0mpqprvGiPhJ7JTGiVV5fwo/X1IuKKtXXxA==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr93026pjt.33.1565186315886;
        Wed, 07 Aug 2019 06:58:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j15sm103140872pfe.3.2019.08.07.06.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:58:35 -0700 (PDT)
Date:   Wed, 7 Aug 2019 06:58:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: google: update vpd_decode from upstream
Message-ID: <20190807135834.GA12853@roeck-us.net>
References: <20190802082035.79316-1-hungte@chromium.org>
 <5d44b8eb.1c69fb81.6d1c1.7d80@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d44b8eb.1c69fb81.6d1c1.7d80@mx.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:27:54PM -0700, Stephen Boyd wrote:
> Quoting Hung-Te Lin (2019-08-02 01:20:31)
> > The VPD implementation from Chromium Vital Product Data project has been
> > updated so vpd_decode be easily shared by kernel, firmware and the user
> > space utility programs. Also improved value range checks to prevent
> > kernel crash due to bad VPD data.
> 
> Please add a Fixes: tag here to fix the commit that introduces the
> problem. It would also be nice to get a description of the problem that
> this patch is fixing. For example, explaining why the types change from
> signed to unsigned.
> 
> > 
> > Signed-off-by: Hung-Te Lin <hungte@chromium.org>
> > ---
> >  drivers/firmware/google/vpd.c        | 38 +++++++++------
> >  drivers/firmware/google/vpd_decode.c | 69 +++++++++++++++-------------
> >  drivers/firmware/google/vpd_decode.h | 17 ++++---
> >  3 files changed, 71 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> > index 0739f3b70347..ecf217a7db39 100644
> > --- a/drivers/firmware/google/vpd.c
> > +++ b/drivers/firmware/google/vpd.c
> > @@ -73,7 +73,7 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
> >   * exporting them as sysfs attributes. These keys present in old firmwares are
> >   * ignored.
> >   *
> > - * Returns VPD_OK for a valid key name, VPD_FAIL otherwise.
> > + * Returns VPD_DECODE_OK for a valid key name, VPD_DECODE_FAIL otherwise.
> 
> Maybe we should convert these things to use linux conventions instead of
> VPD error codes?
> 
> >   *
> >   * @key: The key name to check
> >   * @key_len: key name length
> > @@ -86,14 +86,14 @@ static int vpd_section_check_key_name(const u8 *key, s32 key_len)
> >                 c = *key++;
> >  
> >                 if (!isalnum(c) && c != '_')
> > -                       return VPD_FAIL;
> > +                       return VPD_DECODE_FAIL;
> >         }
> >  
> > -       return VPD_OK;
> > +       return VPD_DECODE_OK;
> 
> Can you split this rename out into it's own patch. That way we can
> confirm that there are no changes due to the rename of the enum.
> 
> >  }
> >  
> > -static int vpd_section_attrib_add(const u8 *key, s32 key_len,
> > -                                 const u8 *value, s32 value_len,
> > +static int vpd_section_attrib_add(const u8 *key, u32 key_len,
> > +                                 const u8 *value, u32 value_len,
> >                                   void *arg)
> >  {
> >         int ret;
> > @@ -246,7 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
> >  
> >  static int vpd_sections_init(phys_addr_t physaddr)
> >  {
> > -       struct vpd_cbmem *temp;
> > +       struct vpd_cbmem __iomem *temp;

The change to __iomem should also be a separate patch.

Guenter
